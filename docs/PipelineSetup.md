# Setup of the entire pipeline. 
This file contains step by step all instructions on how to setup up this pipeline. The main components needed are:

- AWS: Amazon Elastic Compute Cloud (EC2) is a web service from Amazon Web Services (AWS) that provides cloud-based compute capacity that can be resized. EC2 allows users to run applications on the public cloud by provisioning virtual servers, or EC2 instances, within the AWS cloud.
- GitHub: GitHub is a web-based platform that allows users to store, share, and collaborate on code
- Jenkins: Jenkins is a popular open-source tool used for continuous integration (CI) and continuous delivery (CD)
- Maven: Maven is an open-source build automation and project management tool that is primarily used for Java development.
- Nexus: Nexus is a tool that stores, organizes, and distributes artifacts for development. It's built by Sonatype and is commonly used to host Apache Maven. Developers can use Nexus to control access to and deploy artifacts from a single location.
- SonarQube: SonarQube is an open-source platform that helps developers and teams improve the quality of their code by analyzing it for bugs, vulnerabilities, and other issues
- Docker: Docker is used by jenkins to built the images using the dockerfiles present in the java source application repository. 
- AWS ECR: Elastic Container Registry is used to store the images made by the docker. 
- AWS ECS: ECS is used to deploy the images made

## AWS setup
### Security Groups
- Jenkins: 
Give it all traffic 
- SonarQube: 
Give it custom tcp in the port 9000
- Nexus: 
Give it custom tcp in the port 8081

### ECR repository
Create a ECR repository with the name of cicd-repo and the copy the URL of the repository and use it in the Jenkinsfile. 

### ECS cluster and Task definitions
Create a ECS service with the name of cicd-cluster1 and a task definition with the name of cicd-service1. if possible create this right before the execution of the service since this is the most costly service here. 

### EC2 instances 
Create 3 EC2 linux ubuntu instances with the names of Jenkins, Nexus and SonarQube. Use t2.medium on all of them and the security groups accordingly. Use the .sh files in the scripts to setups the servers. 

## Nexus Instance 
Login to nexus and create a new repository with the option of maven2 hosted. Make sure the name of the repository is First-repo and make the sure to remember the username and password you setup of the nexus account. Use that username and password in the jenkins server and make a new credentials with the name of nexuslogin. Besure to use the name nexuslogin word to word. 

## SonarQube Instance
Login to SonarQube with the username= admin, password = admin. Make a new Quality Gate with the condition of your choice. Go to account and then security and make a new webhook copy the secret text and use it to make a new credentials in the Jenkins server. 

## Jenkins Instance 
If you use the install_jenkins.sh file then the jenkins will already be installed on the instance but there are more installations need to be done. First install docker and aws cli 
Configure AWS CLI with the command 
```
aws configure 
``` 
Enter the access key, secret access key, and the region of the IAM user. Make sure the IAM user has the right permissions for this. Just to be sure for now give him the admin previleges. 
Give jenkins the permission to create images using docker. Use these commands for that.
``` 
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```
Go to jenkins application and install the following plugins. 
- Nexus artifact uploader,
- Sonarqube scanner,
- Pipeline maven Integration,
- pipeline utility step 
- Build Timestamp
- pipeline stage view 
- Docker Pipeline
- Docker Commons
- AWS Credentials
- Pipeline: AWS Steps

Now go to jenkins manage and then tools and configure the maven, jdk, sonarqube and docker. 
In jenkins manage go to environment and select environment variables and enter the sonarqube private ip address and the port. Use the sonarqube credentials made with the secret text. 

Create a new pipeline style job and copy the Jenkins file from this repo and paste it there and the press build. 