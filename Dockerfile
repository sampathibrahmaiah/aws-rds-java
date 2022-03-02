From tomcat:latest
COPY /var/lib/jenkins/workspace/PROJECT/target/*.war /usr/local/tomcat/webapps/
