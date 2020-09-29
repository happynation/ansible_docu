# Setting Up Github Webhooks, Jenkins, and Ngrok for Local Development
![Ansible](/images/power.jpeg)

___


This tutorial will take you through the step by step process of setting up Jenkins, Ngrok, and Github Webhooks for building and testing project(s) that you have hosted on your own personal github. The environment I am using is an Ubuntu 18.04 Virtual Machine hosted on Virtual Box.

___

 ### Installing and Running Ngrok
 Ngrok is a reverse proxy that allows traffic to be redirected from the generated url to wherever your local server is running. It is fantastic for cases like this, where you don’t want to host a webserver and just want to try out different technologies without paying for a VPS. And there is a free tier! So head on over to https://ngrok.com/ and signup for an account, using whichever method you choose. 
 ___
 
 Download package
 ```
 curl -O https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
 ```
 Unzip to install
 ```
 unzip /path/to/ngrok.zip
```
Move ngrok to /bin
```
mv ngrok /bin/
```
Connect your account (see your token on yur ngrok webpage)
```
ngrok authtoken <MY TOKEN>
```
Now run the following 
```
ngrok http 8080
```
After running the command this screen should appear, take note of the http(s) address it generates.

![Ansible](/images/ngrok.png)
___

### Adding GitHub credentials inside Jenkins
In order to make Jenkins communicate with GitHub, we need to add GitHub account credentials inside Jenkins. We will do this using the Jenkins Credentials Plugin.
Follow the given steps to add the GitHub credentials inside Jenkins:
1. From the Jenkins dashboard, click on Credentials | System | Global credentials(unrestricted).
2. On the Global credentials (unrestricted) page, from the left-hand side menu, click on the Add Credentials link.
3. You will be presented with a bunch of fields to configure (see the following screenshot):
    1. Choose Username with password for the Kind field.
    2. Choose Global (Jenkins, nodes, items, all child items, etc) for the Scope field.
    3. Add your GitHub username to the Username field.
    4. Add your GitHub password to the Password field.
    5. Give a unique ID to your credentials by typing a string in the ID field.
    6. Add some meaningful description to the Description field.
    7. Click on the Save button once done:
    ![Ansible](/images/webhooks/1.png)
4. And that's how you save credentials inside Jenkins. We will use these GitHub credentials shortly.
___
### Configuring Webhooks on GitHub from Jenkins
Now that we have saved GitHub account credentials inside Jenkins, let's configure Jenkins to talk to GitHub. We will do this by configuring the GitHub settings inside the Jenkins configuration.
Carefully follow the given steps to configure GitHub settings inside Jenkins:
1. From the Jenkins dashboard, click on Manage Jenkins | Configure System.
2. On the resultant Jenkins configuration page, scroll all the way down to the GitHub section.
3. Under the GitHub section, click on the Add GitHub Server button and choose GitHub Servers from the available drop-down list. Doing so will display a bunch of options for you to configure.
4. Let us configure them one by one, as follows:
    1. Give your GitHub server a name by adding a string to the Name field.
    2. Under the API URL field, add https://api.github.com (default value) if you are using a public GitHub account. Otherwise, if you are using GitHub Enterprise, then specify its respective API endpoint.
    3. Make sure the Manage hooks option is checked:
    ![Ansible](/images/webhooks/2.png)
    4. Click on the Advanced... button (you will see two of them; click on the second one). Doing so will display a few more fields to configure.
    5. Under the Additional actions field, click on Manage additional GitHub actions and choose Convert login and password to token from the available list (you will see only one option to choose).
    6. This will further disclose new fields to configure.
    7. Select the From credentials option (active by default). Using the Credentials field, choose the GitHub credentials that we created in the previous section (ID: github_credentials).
    8. Next, click on the Create token credentials button. This will generate a new personal access token on your GitHub account:  ![Ansible](/images/webhooks/3.png)
    9. To view your personal access token on GitHub, log in to your GitHub account and navigate to Settings | Developer settings | Personal access tokens: ![Ansible](/images/webhooks/4.png)
    10. Once done, click on the Save button at the bottom of the Jenkins configuration page.
    11. An entry of the respective personal access token will also be added inside the Jenkins credentials. To view it, navigate to Jenkins dashboard | Credentials | System | api.github.com, and you should see a credential entry of the Kind secret text.
5. We are not yet done with our GitHub configuration inside Jenkins. Follow the remaining steps as follows: 
    1. From the Jenkins dashboard, click on Manage Jenkins | Configure System.
    2. Scroll all the way down to the GitHub section.
    3. Using the Credentials field, choose the newly generated credentials of the Kind secret text (the personal access token entry inside Jenkins).
    4. Now, click on the Test connection button to test our connection between Jenkins and GitHub.
    5. Once done, click on the Save button at the bottom of your Jenkins configuration page: ![Ansible](/images/webhooks/5.png)
    6. We are now done with configuring GitHub settings inside Jenkins.
___
### Re-register the Webhooks
Before we proceed, let us re-register the Webhooks for all our Jenkins pipelines:
1. To do so, from the Jenkins dashboard, click on Manage Jenkins | Configure System.
2. On the Jenkins configuration page, scroll all the way down to the GitHub section.
3. Under the GitHub section, click on the Advanced... button (you will see two of them; click on the second one).
4. This will display a few more fields and options. Click on the Re-register hooks for all jobs button.
5. The preceding action will create new Webhooks for our pipeline on the respective repository inside your GitHub account. Do the following to view the Webhooks on GitHub:
    1. Log in to your GitHub account.
    2. Go to your GitHub repository, simple-maven-project-with-tests in our case.
    3. Click on the repository Settings, as shown in the following screenshot: ![Ansible](/images/webhooks/6.png)
    4. On the Repository Settings page, click on Webhooks from the left- hand side menu. You should see the Webhooks for your Jenkins server, as shown in the following screenshot:
    ![Ansible](/images/webhooks/7.png)
    5. Modify your webhook with ngrok http(s) address. (****** is your ngrok address) 
    ![Ansible](/images/webhooks/8.png)
    ___

### Adding a Deploy Key for Github

In order for Github and Jenkins to communicate with one another, a deploy key is needed in order to do so. To create a deploy key go into your terminal and run sudo su -s /bin/bash jenkins this will switch the user to the Jenkins service. This step is needed or else the authentication with Github will not succeed. In order to generate a key for Github run the following:
```
ssh-keygen
```
Then keep pressing enter for the defaults and the key should be generated at
```
/var/lib/jenkins/.ssh/id_rsa.pub
```
run ```cat``` against this file and make sure to copy the entire key. Then navigate to your Github repository Settings > Deploy Keys and Add deploy key. Give it a name and paste in the copied key.
Then back to the terminal (so much back and forth), and make sure you are still the jenkins user (run whoami to verify this), run
```
ssh git@github.com
```
___

### Sample Project to Use
After this setup is all done, you will now be able to add a new pipeline in Jenkins and have it automatically poll you Github repository for remote pushes to your branch. When creating the pipeline make sure that the Build Trigger is set to GitHub hook trigger for GITScm polling. As well as having these settings for the Pipeline portion.
- Please change Credentials from  -none- to credentials which we created earlier.
- Change name of your branch
![Ansible](/images/pipeline.png)
___

Also please Check this setting in Global Security Settings - CSRF Protection

![Ansible](/images/proxy.png)

If that is setup correctly, whenever you push to origin master on Git it should trigger a build within Jenkins.