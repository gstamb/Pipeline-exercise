#!/bin/bash

# 
# Add Jenkins slave node
# 
java -jar /opt/jenkins-cli.jar -s http://localhost:8080  -auth admin:admin create-node < /vagrant/node.xml

