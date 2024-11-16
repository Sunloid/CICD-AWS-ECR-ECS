# Groovy Syntax 
Stage by stage explanation of the Jenkinsfile in this repo. 

## 1. Stage('Fetch code'): 
**git branch: 'main', url:'https://github.com/Sunloid/CICD_Java_Source'**: 

This stage is responsible for fetching the code from the GitHub repository. The GitHub repository where the main java application is stored in mentioned up there. 
          
## 2. Stage('Build')
**sh 'mvn clean install -DskipTests'**: 

This stage is reponsible for compiling the code in the a .war file and storing it in the target repository. 
The code sh 'mvn clean install -DskipTests' does the following:
1. sh: Executes the command in a shell.
2. mvn clean install:
    - clean: Deletes the target directory (build artifacts).
    - install: Compiles the code, packages it (e.g., into a JAR or WAR), and installs it into the local Maven repository.
3. -DskipTests: Skips the execution of tests during the build process.

## 3. Stage('Test')
**sh 'mvn test'**:

As you can deduce from the code above this stage only responsible for testing the .war file made by the previous stage. This command is commonly used to verify that the code behaves as expected by running the unit and integration tests.

## 4.  Stage('Checkstyle Analysis')
**sh 'mvn checkstyle:checkstyle'**:

This stage is used to enforce the coding standards and improve code quality. 
The command sh 'mvn checkstyle:checkstyle' in a Jenkins pipeline does the following:
1. sh: Executes the command in a shell.
2. mvn checkstyle:checkstyle:
    - Runs the Checkstyle plugin.
    - The plugin analyzes the source code to ensure it adheres to coding standards (e.g., naming conventions, formatting).
    - Generates a report (target/site/checkstyle.html) with details of any violations.

## 5.  Stage('Sonar Analysis')
This stage is used to send the .war file to the SonarQube for code quality analysis. 

- **scannerHome = tool 'sonar4.7'**:
This defines the name of the SonarQube scanner in the tools section of the Jenkins server. 

- **withSonarQubeEnv('sonar') { ..... }**: 
This gives the  configuration of the SonarQube server. For example the project name, the directory of the .war file etc 

## 6. Stage('Quality Gate')

Responsible for taking the project through the quality gate in the SonarQube server which needs to manually created and setup first.

## 7. Stage('UploadArtifact')
Responsible for configuring and uploading a artifact to the Nexus repository

- **nexusVersion**: 'nexus3': Mentions the Nexus version to the Jenkins server.

- **nexusUrl**: '172.31.4.32:8081': This mentions the URL of the nexus server. This needs to be changed to the private IP address of the Nexus instance on EC2.

- **repository**: 'First-repo': Mentions the repository where the artifact will be stores in Nexus. This repository needs to be manually made and named in the Nexus server. Keep in mind that the repository in the nexus server needs to be the same as the one mentioned here.

- **credentialsId**: 'nexuslogin': This mentions the ID of the nexus login credentials which are to be made manually in the Jenkins server. Again the ID needs to have the same name here as the one in the Jenkins server.

- **artifacts**: [.....]: Mentions the name of the artifact which needs to be stored and also the directory where its present.

