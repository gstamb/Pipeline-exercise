# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.ssh.insert_key = false

  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box="shekeriev/centos-7-64-minimal"
    jenkins.vm.hostname = "jenkins.sulab.local"
    jenkins.vm.network "private_network", ip: "192.168.99.101"
    jenkins.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
    jenkins.vm.synced_folder "vagrant/jenkins/", "/vagrant"
  end
  
  config.vm.define "nagios" do |nagios|
    nagios.vm.box="shekeriev/centos-7-64-minimal"
    nagios.vm.hostname = "nagios.sulab.local"
    nagios.vm.network "private_network", ip: "192.168.99.102"
    nagios.vm.network "forwarded_port", guest: 80, host: 8081, auto_correct: true
    nagios.vm.synced_folder "vagrant/nagios/", "/vagrant"
  end
  
  config.vm.define "docker" do |docker|
    docker.vm.box="shekeriev/centos-7-64-minimal"
    docker.vm.hostname = "docker.sulab.local"
    docker.vm.network "private_network", ip: "192.168.99.103"
    docker.vm.network "forwarded_port", guest: 80, host: 8082, auto_correct: true
    docker.vm.synced_folder "vagrant/docker/", "/vagrant"
  end

  config.vm.define "ansible" do |ansible|
    ansible.vm.box="shekeriev/centos-7-64-minimal"
    ansible.vm.hostname = "ansible.sulab.local"
    ansible.vm.network "private_network", ip: "192.168.99.100"
    ansible.vm.synced_folder "vagrant/ansible/", "/vagrant"
    ansible.vm.provision "shell", inline: <<EOS
echo "* Add hosts ..."
echo "192.168.99.100 ansible.sulab.local ansible" >> /etc/hosts
echo "192.168.99.101 jenkins.sulab.local jenkins" >> /etc/hosts
echo "192.168.99.102 nagios.sulab.local nagios" >> /etc/hosts
echo "192.168.99.103 docker.sulab.local docker" >> /etc/hosts

echo "* Install Ansible ..."
sudo yum update
sudo yum install -y ansible python-passlib

echo "* Set Ansible configuration in /etc/ansible/ansible.cfg ..."
cp /vagrant/ansible.cfg /etc/ansible/ansible.cfg

echo "* Set Ansible global inventory in /etc/ansible/hosts ..."
cp /vagrant/hosts /etc/ansible/hosts

echo "* Copy Ansible playbooks in /playbooks/ ..."
cp -R /vagrant/playbooks /playbooks

echo "* Prepare /playbooks/roles folder ..."
cp -R /vagrant/roles /playbooks

echo "* Install Ansible role(s) for jenkins and docker in /playbooks/roles/ ..."
ansible-galaxy install geerlingguy.jenkins -p /playbooks/roles/
ansible-galaxy install geerlingguy.docker -p /playbooks/roles/

echo "* Execute Ansible Playbooks ..."
ansible-playbook /playbooks/install-all.yml
EOS
  end
end
 
