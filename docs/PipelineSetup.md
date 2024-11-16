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

## AWS setup: 
### Security Groups: 
- Jenkins: 
    ![Alt text](<q2.png>)

- SonarQube: 
    ![Alt text](<image (23).png>)

- Nexus: 
    ![Alt text](<image (25).png>)


### ECS: 
Create a ECS service with the name of 