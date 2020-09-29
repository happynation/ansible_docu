# Ansible
![Ansible](/images/Ansible-Logo-720x210.png)

___

 ### What is ansible?

Ansible is an orchestration tool that automates configuration managment, application deployment and other IT needs.

Official Documentation: https://www.ansible.com

___

 ### Setup Dev Environment
 1. Create VMs (master and worker)
 2. Connect to master node from your local machine
 3. Install ansible on control node.
 ```
 yum install epel-release -y
 yum install ansible -y
 ansible --version
 ```
 4. Add managed nodes to inventory.
 ```
 vi /etc/ansible/hosts
 ```
 5. Generate key and add it to managed nodes authorized_keys (ansible uses ssh to connect)
 ```
 ssh-keygen
 cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
 ssh-copy-id <IP-addr>
 ```
___
 ### Ansible Ad-hoc commands
The Ad-Hoc command is the one-liner ansible command that performs one task on the target host. It allows you to execute simple one-line task against one or group of hosts defined on the inventory file configuration.




 ### Examples:
1. Check disk usage of managed servers (linux)
```
ansible dev -m shell -a "df -h"
```
2. Check top processes running in managed servers (linux)
```
ansible dev -m shell -a "ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head"
```
3. Check OS Release of managed servers (Linux)
```
ansible dev -m shell -a "cat /etc/os-release"
```
4. Check Kernel Version of managed servers (Linux)
```
ansible dev -m shell -a "uname -a"
```
5. To get destribution
```
ansible dev -m setup -a 'filter=ansible_distribution' -i devhosts
```
6. Install elink
```
ansible dev -i inventory -b -m yum -a "name=elinks state=latest""
```
7. add file
```
ansible dev -i inventory -m file -a "path=/home/centos/newfile  state=touch"
```
8. add file & spec permission
```
ansible dev -i inventory -m file -a "path=/home/centos/newfile mode=0400 "
```
9. add file & spec owner
```
ansible dev -i inventory -b -m file -a "path=/home/centos/newfile owner=root "
```
10. add user
```
ansible dev -i inventory -b -m user -a "name=vova"
```
11. add user to group
```
ansible dev -i inventory -b -m user -a "name=vova append=yes groups=wheel"
```




---
 ### Ansible Playbooks
 
 An Ansible playbook is an organized unit of scripts that defines work for a server configuration managed by the automation tool Ansible. ... An Ansible playbook contains one or multiple plays, each of which define the work to be done for a configuration on a managed server.



 
 

