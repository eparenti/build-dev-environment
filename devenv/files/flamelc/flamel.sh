#!/bin/bash

# This script was tested under RHEL8 CSB. You may require changes for other distros.

tag=latest
#tag=0.4
#image=localhost/flamel
image=quay.io/redhattraining/flamel
container=flamel
rootless=true

# DNS options for Red Hat VPN using RDU2
#DNSOPTS="--dns-search redhat.com --dns 10.11.5.19 --dns 10.5.30.160"

# Usage message

if [ "$1" = "--help" -o "$1" = "-h" ]
then
  echo "Wrapper script to run the containerized flamel."
  echo
  echo "Usage: $0 {options|target}"
  echo
  echo "'target' is a target to flamel such as 'adoc', 'sg', 'ig', 'rolesg', 'slides', and 'clean'"
  echo "'options' can be:"
  echo "  --tag arg: Uses tag 'arg' instead of 'latest' for the container image."
  echo "  --check: Checks if the main packages inside the container image, such as redhat-training-xsl, are on their latest releases. Also checks if the hash of the local image matches the hash of the remote image."
  echo "  --purge: Removes the local container images, allowing the next run to pull an updated image."
  echo "  --update: Replaces the local image if it looks older than the current remote image."
  echo
  echo "The beggining of this script also defines a few variables that you may change as your local configuration."
  exit
fi

# pick unique container names for Jenkins
if [ "${BRANCH_NAME}" != "" -a "${BUILD_NUMBER}" != "" ]
then
  container="flamel-${BRANCH_NAME}-${BUILD_NUMBER}"
fi

# Rootless tested under RHEL 8.0 CSB but should work on any RHEL 8+ and Fedora 30+.
# Hint: there should be no need to configure uid and gid maps anymore.

if ! ${rootless}
then
  if [ "$(id -u)" != "0" ]
  then
    sudo $0 "$(id -u)" "$(id -g)" "$@"
    exit $?
  fi
fi

# Non-rootless: Saving the uid and gid to change file ownership after running the container

if [ "$(id -u)" = "0" ]
then
  SAVED_UID=$1
  SAVED_GID=$2
  shift ; shift
fi

export LANG=en_US.utf-8

# Allow overriding the image tag

if [ "$1" = "--tag" ]
then
  if [ "$2" = "" ]
  then
    echo "Missing tag argument" 1>&2
    exit 127
  fi
  tag="$2"
  shift ; shift
fi

# Remove local container image (to later pull an updated image)

function purge_image {
  echo -n "Removing local container image ${image}:${tag}..."
  if podman rmi --force ${image}:${tag} >/dev/null
  then
    echo "Done."
  else
    echo "Failed!" 1>&2
    exit 127
  fi
}

if [ "$1" = "--purge" ]
then
  purge_image
  exit
fi

# Verify if a log in on Quay.io is required

localhash=$(podman inspect --type image --format '{{.Digest}}' ${image}:${tag} 2>/dev/null)

if [ -z "${localhash}" -o "$1" = "--check" -o "$1" = "--update" ]
then
  if ! podman login --get-login quay.io &>/dev/null
  then
    echo "Please provide your credentials for Quay.io."
    podman login quay.io
  fi
  if ! podman login --get-login quay.io &>/dev/null
  then
    echo "You have to log in to Quay.io using an account that is authorized by the Red Hat Training team to access the podman container." 1>&2
    exit 127
  fi
fi

# Pull the container image if not available locally

function pull_image {
  echo -n "Downloading container image ${image}:${tag}..."
  if podman pull ${image}:${tag} &>/dev/null
  then
    echo "Done."   
  else
    echo "Failed!" 1>&2
    echo "Are you using a Quay.io account that is authorized to access to the flamel container?" 1>&2
    exit 127
  fi
}

if [ -z "${localhash}" ]
then
  pull_image
  localhash=$(podman inspect --type image --format '{{.Digest}}' ${image}:${tag} 2>/dev/null)
fi

# Check if the local image is up-to-date

function error {
    echo -en "\e[1m\e[31m" 1>&2
    echo -n "$*" 1>&2
    echo -en "\e[0m" 1>&2
    echo 1>&2
}

function ok {
    echo -en "\e[1m\e[32m"
    echo -n "$*"
    echo -en "\e[0m"
    echo
}

oldimage=0

if [ "$1" = "--check" -o "$1" = "--update" ]
then
    echo
    if [ -n "$(echo "${image}" | grep 'localhost/')" ]
    then
      echo "Not checking remote hash of locally built image."
    else
      echo -n "Comparing your local image with the current remote image for tag '${tag}' "
      remotehash=$(skopeo inspect docker://${image}:${tag} | jq -r '.Digest')
      if [ "${localhash}" = "${remotehash}" ]
      then
        ok "OK"
        echo "Your local image is the same as the remote image."
        if [ "$1" = "--check" ]
        then
          echo "If it contains the latest packages, it should be fine for building GLS books."
        else # --update
          echo "There is no need of updating. Use --purge if you wish to force an update."
          exit
        fi
      else
        error "OUTDATED"
        oldimage=1
        if [ "$1" = "--check" ]
        then
          echo "Your local image is different than the remote image and is probably outdated."
          echo " · Local hash: ${localhash}"
          echo " · Remote hash: ${remotehash}"
          echo "You are adivised to use --purge to remove the local image and download a new one."
        else # --update
          purge_image
          pull_image
          exit
        fi
      fi
    fi
  fi

  # Also check that packages inside the container are the latest from the GLS Yum repository

  if [ "$1" = "--check" ]
  then
    # Override ENTRYPOINT to not run flamel and run instead the check for package updates

    podman run ${DNSOPTS} --name ${container} -q --rm --entrypoint /tmp/check-gls-packages.sh ${image}:${tag} 
    status=$?
    let status=status+outdated
    exit ${status}
fi

# Have to expose the project root to the container, not just the guides folder, to be able to fetch the git commit id

book=$(pwd)
if [ -r ${book}/publican-sg.cfg ]
then
  cd ..
  book=$(pwd)
fi

echo "Running containerized flamel with arguments '$@'..."
podman run --name ${container} -q --rm -v ${book}:/tmp/coursebook:z ${image}:${tag} "$@"
status=$?

# non-rootless; Do not leave root files hanging around

if [ "$(id -u)" = "0" ] && [ -d ./guides/tmp ]
then
  echo "Changing owner of tmp files to $(id -un ${SAVED_UID}):$(id -gn ${SAVED_GID})..."
  chown -R ${SAVED_UID}:${SAVED_GID} ./guides/tmp
fi

exit "${status}"
