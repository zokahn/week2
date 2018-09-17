FROM centos:7
COPY . /var/week2
RUN yum install -y python vim git epel-release && \
	yum -y install python-pip && \
	pip install flask bson pymongo && \
	sed -i "s/localhost/172.17.0.2/" /var/week2/test.py
ENTRYPOINT python /var/week2/test.py
