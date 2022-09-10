import os
import yaml

chapters = ["ch2", "ch3", "ch4", "ch5", "ch6", "ch7", "ch8", "ch9"]

ch1 = ['develop-navigator', 'develop-git', 'develop-practices', 'develop-review']
ch2 = ['manage-reusing', 'manage-finding', 'manage-selecting', 'lab start manage-review']
ch3 = ['controller-playbooks', 'controller-review']
ch4 = ['config-ansible', 'config-navigator', 'config-review']
ch5 = ['inventory-dynamic', 'inventory-yaml', 'inventory-variables', 'inventory-review']
ch6 = ['task-escalation', 'task-execution', 'task-tagging', 'task-speed', 'task-review']
ch7 = ['data-filters', 'data-lookups', 'data-loops', 'data-netfilters', 'data-review']
ch8 = ['update-delegation', 'update-parallelism', 'update-management', 'update-review']
ch9 = ['create-writing', '', 'builder-custom', 'builder-validate', 'builder-use', 'builder-review']
ch10 = ['review-cr1', 'review-cr2', 'review-cr3']

for c2 in ch2:
    print(c2)
    os.system("lab start " + c2)
    os.system("lab finish " + c2)

for c3 in ch3:
    print(c3)
    os.system("lab start " + c3)
    os.system("lab finish " + c3)

for c4 in ch4:
    print(c4)
    os.system("lab start " + c4)
    os.system("lab finish " + c4)

for c5 in ch5:
    print(c5)
    os.system("lab start " + c5)
    os.system("lab finish " + c5)

for c6 in ch6:
    print(c6)
    os.system("lab start " + c6)
    os.system("lab finish " + c6)

for c7 in ch7:
    print(c7)
    os.system("lab start " + c7)
    os.system("lab finish " + c7)

for c8 in ch8:
    print(c8)
    os.system("lab start " + c8)
    os.system("lab finish " + c8)

for c9 in ch9:
    print(c9)
    os.system("lab start " + c9)
    os.system("lab finish " + c9)

for c11 in ch11:
    print(c11)
    os.system("lab start " + c11)
    os.system("lab finish " + c11)

for c12 in ch12:
    print(c12)
    os.system("lab start " + c12)
    os.system("lab finish " + c12)

# with open("lab-scripts.yml", 'r') as stream:
#    out = yaml.load(stream)
#    print(out["scripts"]["chapter"])
