# Bart has choosing this code to do some testing

# To-Do-List

To-Do-List is mini-project made with Flask and MongoDB.
As it is now it has been dockerized. Springloaded with a Dockerfile and a dockercompose file to run this app anywhere in containers.

## Built using :

	Flask : Python Based mini-Webframework
	MongoDB : Database Server
	Pymongo : Database Connector ( For creating connectiong between MongoDB and Flask )
	HTML5 (jinja2) : For Form and Table



## Docker project by Bart van den Heuvel
Using the code of this project to 'Dockerize' an application. Just picked this project as a simple flask-mongo project to put in a container. Then run it on Docker, in a Docker Swarm via a Dockerfile. Also running it Kubernetes in different. All while showcasing different options and features of the container platforms.

This containerization containts two containers
- Application container (this code)
- MongoDB container

The Dockerfile and Kubernetes yaml files will take care of everything. However action need to be taken to activate the containers and to use the running application. These actions and steps are listed below on each platform.


### Kubernetes single pod

To run the application in a single pod with two containers. The database and the webapplication, seamlessly together in a single pod.
```
kubectl create -f week2-pod.yaml
```

To have a local networkport forward to the webserver running in the pod (connect your browser to http://localhost:8081 after)
```
kubectl port-forward week2 8081:5000
```


### Kubernetes multi pod

To run the application in a more production style deployment. Two services pointing to a deployment of the app and a replicationcontroller running the database. These are now seperate allowing us to manage the deployment of the app by running two versions in a canary test or just add more running instances. 

```
kubectl create -f k8s-deployment/k8s-multi-pod/week2-db.yaml
kubectl create -f k8s-deployment/k8s-multi-pod/week2-db-service.yaml
kubectl create -f k8s-deployment/k8s-multi-pod/week2-app.yaml
kubectl create -f k8s-deployment/k8s-multi-pod/week2-app-service.yaml
```
So now we have a running application that is accessible via the public ip address of a K8s master node. How to get to it? Via the portnumber you find out here:

1. Find out the NodePort, the tcp port on which the service is published. It will forward traffic to the right containers
2. You should know your public ip of your management node, this is in your bundle or known when you install
3. Add the port behind this public ip: you'll get http://10.0.0.44:33982 or something simular
main things to remember, public ip of your management node (or nodes) port of the service you just created

```
kubectl describe service/week2 | grep NodePort
```

You'll see the tasklist application running, it runs on two webservers and one db server. Want to know for sure? This application as it is running now uses week2 image version: 1.2. The next version includes a new index.html where it shows the hostname of the webserver. So, lets do a running upgrade of the application with  --- no downtime ---.

1. first we check the deployement
2. we associate a new image version with the deploument
3. $profit$

```
kubectl rollout status deployment week2-deployment
kubectl set image deployment/week2-deployment week2=bartvandenheuvel/week2:v1.3
kubectl describe deployment week2-deployment
```
In the described deployment on the last line you can see the movements in the last part, the new image is also listed!
You could revert back if needed. Using the command above but also using undo functionality

```
kubectl rollout history deployment/week2-deployment
kubectl rollout undo deployment/week2-deployment 

```

you could check to make sure that your revision does what you think by checking:

```
kubectl rollout history deployment/week2-deployment
kubectl rollout history deployment/week2-deployment --revision=5
kubectl rollout undo deployment/week2-deployment append --to-revision=5
```
Rolled back and rolled forward again. Life is good!


Now our application is going viral and we need more power to the application server. We need scale our deployment with more application servers:

```
kubectl get deployments
kubectl scale deployment/week2-deployment --replicas=10
watch -n 0.1 kubectl get deployments
```
There are more goodies listed here such as autoscaling based on cpu pressure, pausing and resuming
https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

Clean up! what we have created!
```
kubectl delete services week2 week2-mongo
kubectl delete deployments week2-deployment
kubectl delete replicationcontroller week2-mongo
```

### simply run stuff

You can also simply run stuff, just to get'r done. In this case you need to install the dependencies as listed below, including mongo. If you want mongo to run in a container to make sure you can run the application and the application only on the host os you can run:
```
docker run -d -p 27017:27017 -v ~/data:/data/db mongo
```

after that start the code by:
```
python test.py
```

Maybe you want to run it as a daemon, starting it as a background process:
```
python test.py &
```
The steps above will allow you to code, run and debug without the confines of a container. Dirty but it works.



## How the containers were loaded using this repo:

This is the classic deploy method:
	Install Python ( If you don't have already )
		`sudo apt-get install python`
		
	Install Flask ( Web Framework ) and Import Request, Redirect and  Render_Template(Jinja)
		`pip install flask`
		
	Install MongoDB ( Make sure you install it properly )
		`sudo apt-get install -y mongodb-org`
			
	Import bson for handling ObjectId and Pymongo for database connector
		`pip install bson`
		`pip install pymongo'
		
The new method is:

	download this code via git
	install docker
	docker-compose up -d
	$profit
	

##  How it would Run if it were'nt for container :

	See above for the Docker method, for the old manual method see:

	Run MongoDB
		1) Start MongoDB
			`sudo service mongod start`
		2) Stop MongoDB
			`sudo service mongod stop`
	
	Run the Flask file(test.py)
		`python test.py`

	Browse with any Browser to the following link and DONE !
		`http://localhost:5000'

### Screenshot :

![Screenshot of the Output](https://github.com/CoolBoi567/To-Do-List---Flask-MongoDB-Example/blob/master/static/images/screenshot.png?raw=true "Screenshot of Output")


### Thanks to Twitter for emoji support with Twemoji :
	Twitter Open Source : https://github.com/twitter/twemoji



Made with ❤️ from Karnali, Nepal
