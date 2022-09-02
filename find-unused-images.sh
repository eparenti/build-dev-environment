#!/bin/bash
#	= ^ . ^ =

set -u
set -o pipefail

AVAILABLE=/tmp/available-images.txt
USED=/tmp/used-images.txt
DIFF=/tmp/diff-images.txt
UNUSED=/tmp/unused-images.txt
MISSING=/tmp/missing-images.txt

GUIDES_PREFIX=guides/en-US
IMAGES_DIR=${GUIDES_PREFIX}/images/
TOPICS_DIR=${GUIDES_PREFIX}/sg-chapters/topics/

if [ ! -d "${GUIDES_PREFIX}" ]
then
  echo "#	Please run this script in the course repo root directory"
  exit -1
fi

echo "#	Finding available images…"
find ${IMAGES_DIR} -type f | \
  sed -e 's|guides/en-US/||g' | sort -u > ${AVAILABLE}

echo "#	Finding used images…"
grep -nr --include '*.adoc' "^image::" ${TOPICS_DIR} | \
  tr '[' ' ' | tr ']' ' ' | \
  awk -F '[:= ]' '{print $5}' | sort -u > ${USED}

echo "#	Detecting unused or missing images…"
diff -dU0 ${AVAILABLE} ${USED} | egrep -v '^@|^[-\+]{3}' > ${DIFF}
egrep '^-[^-]' ${DIFF} | sed -e 's|^-||g' | sort -u > ${UNUSED}
egrep '^\+[^\+]' ${DIFF} | sed -e 's|^+||g' | sort -u > ${MISSING}

# Print results

if [ -s ${UNUSED} ]
then
  echo ""
  echo "#	List of unused images:	${UNUSED}"
  echo ""
  cat ${UNUSED}
else
  echo ""
  echo "#	No unused images found"
  echo ""
fi

if [ -s ${MISSING} ]
then
  echo ""
  echo "#	List of missing images:	${MISSING}"
  echo ""
  cat ${MISSING}
else
  echo ""
  echo "#	No missing images found"
  echo ""
fi
