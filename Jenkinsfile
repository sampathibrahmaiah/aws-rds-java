pipeline {
    agent any
      environment {
        DATE = new Date().format('yy.M')
        TAG = "${DATE}.${BUILD_NUMBER}"
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
                    docker.build("deepika2chebolu/aws-rds:${TAG}")
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
                    sh 'ssh -T -o StrictHostKeyChecking=no centos@3.83.247.21'
                sh 'docker container run -dt --name myapp -p 8090:8080 deepika2chebolu/aws-rds:${TAG}'
                }
            }
        }
    }
}    
