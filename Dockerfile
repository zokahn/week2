
FROM centos:7
COPY . /var/week2
RUN yum install -y python epel-release &&         yum -y install python-pip &&         pip install flask bson pymongo &&         sed -i "s/localhost/week2-mongo/" /var/week2/test.py
ENTRYPOINT python /var/week2/test.py
