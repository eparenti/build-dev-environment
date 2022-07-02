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


for c2 in ch2:
    print(c2)
    os.system("lab start " + c2)

for c3 in ch3:
    print(c3)
    os.system("lab start " + c3)

for c4 in ch4:
    print(c4)
    os.system("lab start " + c4)

for c5 in ch5:
    print(c5)
    os.system("lab start " + c5)

for c6 in ch6:
    print(c6)
    os.system("lab start " + c6)

for c7 in ch7:
    print(c7)
    os.system("lab start " + c7)

for c8 in ch8:
    print(c8)
    os.system("lab start " + c8)

for c9 in ch9:
    print(c9)
    os.system("lab-start " + c9)


# with open("lab-scripts.yml", 'r') as stream:
#    out = yaml.load(stream)
#    print(out["scripts"]["chapter"])

