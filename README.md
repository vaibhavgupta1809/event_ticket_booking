# Event Ticket Booking System

This Ruby on Rails application serves as a platform for event organizers to create events and for users to book tickets for these events. It leverages technologies like Docker, Kubernetes, Redis, and PostgreSQL to efficiently handle data storage and processing.

## Prerequisites

- Docker
- Kubernetes
- Minikube
- Ruby 3.1.2
- Rails 7.0.8.1
- PostgreSQL
- Redis

## Getting Started

To get the application running on your local machine, follow these steps:

### 1. Clone the repository
Clone the repository and navigate to the project directory.

### 2. Setup Docker and Kubernetes
#### Install Docker

Docker can be installed from the Docker website. Follow the official guide specific to your operating system.
Then, run the following commands:

```bash
  docker-compose build
  docker-compose run app bundle install
```
    
#### Install Kubernetes Tools
  Install kubectl to interact with your Kubernetes cluster.
  ```bash
    curl -LO "https://dl.k8s.io/release/$(curl -L -s         https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    kubectl version --client
  ```
  Install Minikube

  ```bash
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    chmod +x minikube
    sudo mv minikube /usr/local/bin/
    minikube start
  ```

#### Deploy applications with the following commands:
  ```bash
    kubectl apply -f metrics-server-deployment.yaml
    kubectl apply -f rails-app-deployment.yaml
    kubectl apply -f rails-app-hpa.yaml
  ```

### 3. Database Setup
To set up the initial database and include all necessary tables:
  ```bash
    docker-compose run app rails db:create db:migrate
    docker-compose run app rails db:seed
  ```
  
### 4. Access the Application
Start the container with:
```bash
  docker compose up 
```
After starting the containers, the Rails application should be accessible via: http://0.0.0.0:3000