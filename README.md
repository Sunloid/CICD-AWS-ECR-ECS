# CI/CD Pipeline AWS CLI, ECR, ECS orchestrated by Jenkins
This repository provides a comprehensive guide to setting up a CI/CD pipeline with Jenkins, Maven, SonarQube, Nexus and AWS. The pipeline is designed to automate the build, test and deployment processes for projects, ensuring streamline workflows and consistent high-quality code releases 

## Overview 
This CI/CD pipeline configuration leverages popular DevOps tools to automate the complete software delivery lifecycle. Jenkins as the orchestrator, managing the flow through each stage of the pipeline. The setup includes continuous integration with Maven for build management, SonarQube for static code analysis, Nexus for artifact repository management and AWS for scalabled deployment. The source file of the java application is in the repository "https://github.com/Sunloid/CICD_Java_Source". This repository is just the documentation of the setup and the working of the pipeline. 

## Pipeline Workflow 
1. **Build**: Jenkins initiates the build process, using Maven to compile the code to handle project dependencies. 
2. **Code Quality Analysis**: SonarQube assesses the code for quality, security, and maintainability standards.
3. **Artifact Management**: Nexus securely stores versioned artifacts, ensuring they are readily available for deployments.
4. **Deployment**: Jenkins deploys artifacts to AWS, utilizing ECS to run applications in a scalable, managed environment.

## Prerequisites 
To successfully set up and run this pipeline, you will need the following:

1. **AWS CLI**: Configured on the Jenkins instance for integration with AWS services.
2. **Docker**: Required for Jenkins container builds and deployments.
3. **Jenkins**: Orchestrates the pipeline.
4. **SonarQube**: Code Quality analysis.
5. **Nexus**: Artifact storage management.
6. **AWS ECS**: Used to deploy the and run the applications in a scalable, managed environment. 
7. **AWS ECR**: Used for the storage of images of the application made by the docker. 

## Repository structure
```
.
├── Jenkinsfile                         # Defines the pipeline stages and steps
├── README.md                           # This README file
├── scripts/                            # Scripts for setup, configuration, or deployment
│   ├── install_Jenkins.sh              # Script for building the Jenkins application on ubuntu
│   ├── install_Nexus.sh                # Script for building the Nexus application on ubuntu
│   └── install_SonarQube.sh            # Script for building the SonarQube application on ubuntu
└── docs/                               # Detailed Documentation of the 
    ├── GroovySyntax.md                 # Explains the Groovy Syntax in the Jenkins file
    ├── Infrastructure.md               # Explains the Infrastructure of the pipeline
    └── PipelineSetup.md                # The setup of the complete pipeline is documented here

```


