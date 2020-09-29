# Jenkins Installation on Ubuntu 18.04
![Ansible](/images/logo-title-opengraph.png)

___

 ### What is Jenkins?

Jenkins is an open-source automation server that automates the repetitive technical tasks involved in the continuous integration and delivery of software. Jenkins is Java-based and can be installed from Ubuntu packages or by downloading and running its web application archive (WAR) file — a collection of files that make up a complete web application to run on a server.

___

 ### Installing the Default JRE/JDK
 You need the Java Development Kit (JDK) in addition to the JRE in order to compile and run some specific Java-based software. To install the JDK, execute the following command, which will also install the JRE:
 ```
 sudo apt install default-jdk
 ```
 The version of Jenkins included with the default Ubuntu packages is often behind the latest available version from the project itself. To take advantage of the latest fixes and features, you can use the project-maintained packages to install Jenkins. First, add the repository key to the system:
 ```
 wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
```
When the key is added, the system will return OK. Next, append the Debian package repository address to the server’s sources.list:
```
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
```
When both of these are in place, run update so that apt will use the new repository:
```
sudo apt update
```
Finally, install Jenkins and its dependencies:
```
sudo apt install jenkins
```
Now that Jenkins and its dependencies are in place, we’ll start the Jenkins server.
```
sudo systemctl start jenkins
```
Since systemctl doesn’t display output, you can use its status command to verify that Jenkins started successfully:
```
sudo systemctl status jenkins
```