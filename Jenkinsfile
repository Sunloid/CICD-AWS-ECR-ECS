// Visit the GroovySyntax.md for the explanation of this pipeline
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWScred')
        AWS_SECRET_ACCESS_KEY = credentials('AWScred')
    }
    tools {
	    maven "MAVEN3"
	    jdk "OracleJDK8"
	}
    stages{
        stage('Fetch code') {
          steps{
                git branch: 'main', url:'https://github.com/Sunloid/CICD_Java_Source'
          }  
        }

        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
            post {
                success {
                    echo "Now Archiving."
                    archiveArtifacts artifacts: '**/*.war'
                }
            }
        }
        stage('Test'){
            steps {
                sh 'mvn test'
            }

        }

        stage('Checkstyle Analysis'){
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
        }

        stage('Sonar Analysis') {
            environment {
                scannerHome = tool 'sonar4.7'
            }
            steps {
               withSonarQubeEnv('sonar') {
                   sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                   -Dsonar.projectName=FirstTest \
                   -Dsonar.projectVersion=1.0 \
                   -Dsonar.sources=src/ \
                   -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                   -Dsonar.junit.reportsPath=target/surefire-reports/ \
                   -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                   -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
              }
            }
        }

        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage("UploadArtifact"){
            steps{
                nexusArtifactUploader(
                  nexusVersion: 'nexus3',
                  protocol: 'http',
                  nexusUrl: '172.31.46.5:8081',
                  groupId: 'QA',
                  version: "${env.BUILD_ID}-${env.BUILD_TIMESTAMP}",
                  repository: 'First-repo',
                  credentialsId: 'nexuslogin',
                  artifacts: [
                    [artifactId: 'vprofile',
                     classifier: '',
                     file: 'target/vprofile-v2.war',
                     type: 'war']
                  ]
                )
            }
        }    

        stage("Build image and deploy it to ecr"){
            steps{
                script{
                     sh """
                        aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 533267397460.dkr.ecr.ap-south-1.amazonaws.com
                        
                        docker build -t app:${BUILD_NUMBER} ./app_dockerfile/.
                        
                        docker build -t web:${BUILD_NUMBER} ./web_dockerfile/.
                        
                        docker build -t db:${BUILD_NUMBER}  ./db_dockerfile/.
                        
                        docker tag app:${BUILD_NUMBER} 533267397460.dkr.ecr.ap-south-1.amazonaws.com/cicd-repo:app${BUILD_NUMBER}
                        
                        docker tag web:${BUILD_NUMBER} 533267397460.dkr.ecr.ap-south-1.amazonaws.com/cicd-repo:web${BUILD_NUMBER}
                        
                        docker tag db:${BUILD_NUMBER} 533267397460.dkr.ecr.ap-south-1.amazonaws.com/cicd-repo:db${BUILD_NUMBER}
                        
                        docker push 533267397460.dkr.ecr.ap-south-1.amazonaws.com/cicd-repo:app${BUILD_NUMBER}
                        
                        docker push 533267397460.dkr.ecr.ap-south-1.amazonaws.com/cicd-repo:web${BUILD_NUMBER}
                        
                        docker push 533267397460.dkr.ecr.ap-south-1.amazonaws.com/cicd-repo:db${BUILD_NUMBER}

                    """
                }
            }
        }

        stage("Deploy to EC2"){
            steps {
		        script {
		            def ecsCluster = "cicd-cluster1"
		            def appServiceName = "cicd-service1" 
		            sh "aws ecs update-service --cluster ${ecsCluster} --region ap-south-1 --service ${appServiceName}  --force-new-deployment"
		    }
		 }
        }


    }
}

