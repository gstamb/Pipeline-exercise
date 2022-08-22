#!/bin/bash

# 
# Create Jenkins credentials
# 

java -jar /opt/jenkins-cli.jar -s http://localhost:8080 -auth admin:admin import-credentials-as-xml system::system::jenkins < /vagrant/credentials.xml
