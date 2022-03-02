pipeline {
    agent any
    environment {
        dockerImage =''
        registry = 'deepika2chebolu/aws-rds'
    }
    stages{
        stage('build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    dockerImage = docker.build registry
                }
            }
        }
        stage('Pushing Docker Image to Dockerhub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com','docker_credential') {
                        docker.image("deepika2chebolu/aws-rds:${TAG}").push()
                        docker.image("deepika2chebolu/aws-rds:${TAG}").push("latest")
                    }
                }
            }
        }
        stage('deploy') {
            steps {
                sshagent(credentials:['n1']) {
                    sh 'ssh -T -o StrictHostKeyChecking=no centos@52.87.15.178'
                sh 'docker container run -dt --name myapp -p 8090:8080 deepika2chebolu/aws-rds:${TAG}'
                }
            }
        }
    }
}    
