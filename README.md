# Cluster-API

The goal of this demo is to show how to keep state across multiple nodes in a environment built on top of containers.

## 💻 Dependencies

Before we begin make sure you have installed:
  
   * `docker`
## 🚀 Execute the app

  Choose one of the folowing ways of executing the application.

  ### Docker 

  `docker swarm init`
  
  `docker build -t cluster -f .docker/prod/Dockerfile .`

  `docker stack deploy -c stack.yml stach`

  Your application should be available in http://localhost:8000/api/get
