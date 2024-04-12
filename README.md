Event Ticket Booking System :-
    This Ruby on Rails application provides a platform for event organizers to create events and for users to book tickets for these events. The backend leverages Docker, Kubernetes, Redis, and PostgreSQL to handle data storage and processing efficiently.

Prerequisites:- 
    Docker
    Kubernetes
    Minikube
    Ruby 3.1.2
    Rails 7.0.8.1
    PostgreSQL
    Redis

Getting Started
To get the application running on your local machine, follow these steps:

1. Clone the repository
  Clone & go to the project directory

2. Setup docker and kubernetes
  >> install docker 
    Docker can be installed from the Docker website. Follow the official guide specific to your operating system.
    
    and the run 

    * docker-compose build

    * docker-compose run app bundle install

    * docker-compose up
    
  
  >> Install kubectl to interact with your Kubernetes cluster.

  >> Install Minikube
      Download and install Minikube.

      * curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

      * chmod +x minikube

      * sudo mv minikube /usr/local/bin/

      * minikube start

      And then run these command - 
        * kubectl apply -f metrics-server-deployment.yaml
        * kubectl apply -f rails-app-deployment.yaml
        * kubectl apply -f rails-app-hpa.yaml

3. Database Setup
  To set up the initial database and include all necessary tables:
    * docker-compose run app rails db:create db:migrate

    * docker-compose run app rails db:seed
  
4. Access the Application
   After starting the containers, the Rails application should be accessible via:
    
    * http://0.0.0.0:3000


