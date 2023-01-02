# Cluster-API

The goal of this demo is to show how to keep state across multiple nodes in a environment built on top of containers.

## 💻 Dependencies

Before we begin make sure you have installed:
  
   * `docker`
   * `docker-compose`
   * `kubectl`
## 🚀 Execute the app

  Choose one of the folowing ways of executing the application.

  ### Docker-compose 
  
  `docker build -t cluster-api -f .docker/dev/Dockerfile .`
  `docker-compose up`

  Your application should be available in http://localhost:8000/api/get
  ### Kubernetes:
  Inside the cluster_api folder execute 

  `docker build -t cluster:1.6 -f .docker/prod/Dockerfile .`

  The manifest inside .k8s folder expects you to set your container with ingress and once you execute

  `kubectl apply -f .k8s/with_ingress.yml`

  you should be able to access your application https://localhost/api/get

  If you need help setting ingress or a local kubernetes cluster locally you can check [kind](https://kind.sigs.k8s.io/docs/user/ingress/#ingress-nginx)


## ☕ Available Endpoints

curl http://localhost/api/get -> see current state, node and connected nodes

curl http://localhost/api/save?key=bar&value=foo -> saves given key and value inside current state
