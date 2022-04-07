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
                    docker.build("brahmaiahsampathi /aws-rds:${TAG}")
                }
            }
        }
        stage('Pushing Docker Image to Dockerhub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com','docker_credential') {
                        docker.image("brahmaiahsampathi/aws-rds:${TAG}").push()
                        docker.image("brahmaiahsampathi/aws-rds:${TAG}").push("latest")
                    }
                }
            }
        }
        stage('deploy') {
            steps {
                node('n2') {
                    sh 'docker stop aws-rds |true'
                    sh 'docker rm aws-rds | true'
                    sh 'docker container run -dt -p 9092:8080 brahmaiahsampathi/aws-rds:${TAG}'
                }
            }
        }
    }
}    
