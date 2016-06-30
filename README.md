# Apache Hadoop Docker image

# Before we start

I'm learning Hadoop and try to leverage my knowlege in Docker to containerize the Hadoop platform. This project will help you to build and run Hadoop modules inside Docker containers. This project was created just for learning purpose, it was not tested in the production systems.

## Use your Docker repo

If you wish to push your images to your Docker repo for future use, you need to change `vietanh85` (my Docker account) to yours in `docker-compose.build.yml` and `docker-compose.yml`. You will see it the `image` property of the servies.

## Why `onbuild`?

I want to run Hadoop platform in cluster and I want to reuse my code and Docker layers so I decided to implement the hirachi of my Docker images as bellow:

```
	hadoop-onbuild
		|__ hadoop-hdfs-name
		|__ hadoop-hdfs-data
		|__ hadoop-yarn
		|__ etc.
```

That's why I need to create Dockerfiles for each of them.

# Build the images

TBD

## Why `docker-compose.build.yml`?

TBD

# Pull the images

# Start the containers
## Start a Pseudo-Distributed conttainer
## Start a Cluster conttainers
## Start Cluster in multiple hosts

# Todos
- ~Ablitiy to run in Pseudo-Distributed mode~
- Ability to run in Cluster mode
- Enable Docker Swarm to run and deploy in multiple hosts
