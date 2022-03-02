pipeline {
    agent any
    stages{
        stage('build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    sh 'docker build -t deepika2chebolu .'
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
