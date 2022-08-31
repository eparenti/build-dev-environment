import os
import yaml

chapters = ["ch2", "ch3", "ch4", "ch5", "ch6", "ch7", "ch8", "ch9"]

ch2 = ["org-user", "org-team", "org-hub", "org-review"]
ch3 = ["host-inventory", "host-credential", "host-review"]
ch4 = ["provision-project", "provision-job", "provision-review"]
ch5 = ["job-facts", "job-survey", "job-notification", "job-review"]
ch6 = ["workflow-template", "workflow-approval", "workflow-review"]
ch7 = ["advinventory-static", "advinventory-smart", "advinventory-review"]
ch8 = ["code-collection"]  # ,'','']
ch9 = ["admin-troubleshoot", "", ""]
ch10 = ["", "", ""]
ch11 = ["mesh-deploy-solve", "mesh-manage", ""]

special = [
    "host-inventory",
    "host-review",
    "job-facts",
    "job-review",
    "workflow-review",
    "advinventory-smart",
    "advinventory-review",
    "code-api",
    "code-review",
    "admin-troubleshoot",
]


def run_lab():
    for run in special:
        print(run)
        os.system("lab start " + run)
        os.system("lab finish " + run)


def start_lab():
    for start in special:
        print(start)
        os.system("lab start " + start)


def finish_lab():
    for finish in special:
        print(finish)
        os.system("lab finish " + finish)
#

run_lab()
start_lab()
finish_lab()
