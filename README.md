# Apache Hadoop Docker image

## Before we start

I'm learning Hadoop and Docker. I want to leverage them to containerize the Hadoop platform. This project will help you to build and run Hadoop modules inside Docker containers. I created it just for learning purpose, it's not tested in the production.

### Use your Docker repo

If you wish to push your images to your Docker repo for future use, you need to change `vietanh85` (my Docker account) to yours in `docker-compose.*.yml` files. You will see it the `image` property of the servies.

### Why `Dockerfile.onbuild` and so many `Dockerfile.*`?

For this practice, I'm going to use 2 modules of Hadoop system: 

	- Yarn for node/resource management 
	- HDFS for storage. 

All of them use the same package of Hadoop, the only different thing is the starting script. To save my code and effort, I decide to create a base images for all of images. By doing that, Docker engine will not have to download hadoop package every time it build the images. The hierarchy of our images will be as bellow:

![Docker images hierarchy](/img/docker-images-heirarchy.png?raw=true "Docker images hierarchy")

## Build the images

To build the images automatically, just simply run this command:

```
docker-compose -f docker-compose.build.yml build
```

## Why `docker-compose.build.yml`?

docker-compose is a great tool to define your services stacks and wire them up together with one simple command `docker-compose up` or build all the images automatically using `docker-compose build`. 

The problem is that I'm building the hierarchy of the Docker images, which contains `onbuild` images and I don't want to start them. By solving this, I decided to create the `docker-compose.build.yml` just for build purpose.

## Start the containers

### Start a Pseudo-Distributed container

You can run your Hadoop platform in [Pseudo-Distributed Operation](http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html#Pseudo-Distributed_Operation) by running this command:

```
docker-compose -f docker-compose.pseudo.yml up
```

After running the command, your Pseudo-Distributed Hadoop platform will be ready with HDFS and Yarn up and running. To access to your HDFS Name Node web interface, you can go to `http://localhost:50070`. To access to Resource Manager, you can go to `http://localhost:8088`.

##### Testing
By default, docker-compose will set your container name to `hadoopdocker_hadoop_pseudo_1`, to see your container name, you can run `docker ps`. Bellows are the steps to test your containers:

```
# Make the HDFS directories required to execute MapReduce jobs
$ docker exec hadoopdocker_hadoop_pseudo_1 bash -c "hdfs dfs -mkdir -p /user/root/input"

# Copy the input files into the distributed filesystem
$ docker exec hadoopdocker_hadoop_pseudo_1 bash -c "hdfs dfs -put etc/hadoop/*.xml input"

# Run some of the examples provided:
$ docker exec hadoopdocker_hadoop_pseudo_1 bash -c "hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar grep input output 'dfs[a-z.]+'"

# View the output files on the distributed filesystem:
$ docker exec hadoopdocker_hadoop_pseudo_1 bash -c "hdfs dfs -cat output/*"
```

### Start Cluster containers

TBD

### Start Cluster in multiple hosts

TBD

## Todos
- [x] Ablitiy to run Pseudo-Distributed Operation
- [ ] Ability to run Cluster Operation
- [ ] Enable Docker Swarm to run and deploy in multiple hosts
