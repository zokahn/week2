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


### Kubernetes

To run the application
'''
kubectl create -f week2-pod.yaml
'''

To have a local networkport forward to the webserver running in the pod (connect your browser to http://localhost:8081 after)
'''
kubectl port-forward week2 8081:5000
'''





## Set up environment for using this repo:

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
	

## Run :

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
