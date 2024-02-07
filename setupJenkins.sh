## setup jenkins using docker image
## Prerequisite 
## Docker must me installed
mkdir test
cd test
docker pull jenkins
sudo docker pull jenkins/jenkins
sudo docker run -d -p 8080:8080 jenkins/jenkins:latest
sudo docker ps

