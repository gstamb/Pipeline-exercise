#!/bin/bash

# 
# Create Jenkins create job
# 

java -jar /opt/jenkins-cli.jar -s http://localhost:8080 -auth admin:admin create-job New-Job < /vagrant/job.xml