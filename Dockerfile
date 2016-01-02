#Builds Ubuntu MySQL image

FROM mrlesmithjr/ubuntu-ansible:14.04

MAINTAINER mrlesmithjr@gmail.com

#Install packages
RUN apt-get update && apt-get install -y git

#Create Ansible Folder
RUN mkdir -p /opt/ansible-playbooks/roles

#Clone GitHub Repo
RUN git clone --depth=50 --branch=ubuntu-14.04 https://github.com/mrlesmithjr/ansible-mysql.git /opt/ansible-playbooks/roles/ansible-mysql

#Copy Ansible playbooks
COPY playbook.yml /opt/ansible-playbooks/

#Run Ansible playbook to install mysql
RUN ansible-playbook -i "localhost," -c local /opt/ansible-playbooks/playbook.yml

# Cleanup
RUN apt-get clean -y && \
    apt-get autoremove -y

# Cleanup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Expose ports
EXPOSE 3306

CMD ["/usr/bin/mysqld_safe"]
