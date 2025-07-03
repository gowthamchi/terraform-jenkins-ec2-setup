#!/bin/bash
apt update -y
apt install -y docker.io git curl
systemctl start docker
systemctl enable docker
mkdir -p /opt/jenkins_home/init.groovy.d
curl -o /opt/jenkins_home/init.groovy.d/create-pipeline.groovy https://raw.githubusercontent.com/YOUR_USERNAME/nodejs-deployment-automation/main/jenkins/create-pipeline.groovy
docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -v /opt/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/jenkins:lts
