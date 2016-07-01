# Apache Hadoop Docker image

## Before we start

I'm falling in love with Hadoop and Docker. I want to leverage them to "containerize" the Hadoop platform so I create this project to build and run Hadoop modules inside Docker containers. It just for practical purpose and is not tested in the production environment.

### Use your Docker repo

If you wish to push the images to your Docker repo for future use, you need to change `vietanh85` (my Docker account) to yours in `docker-compose.*.yml` files. You will see it the `image` property of the servies.

### Why `Dockerfile.onbuild` and so many `Dockerfile.*`?

For this practice, I'm going to use 2 modules of Hadoop system: 

- Yarn for node/resource management 
- HDFS for storage. 

All of them could be download in the same package of Hadoop, the only different thing is the starting script. To save my code and effort, I decide to create a base images for all of modules. By doing that, Docker engine will not have to download hadoop package every time it build the images. The hierarchy of our images will be as bellow:

![Docker images hierarchy](/img/docker-images-heirarchy.png?raw=true "Docker images hierarchy")

## Build the images

To build the images automatically, you can just simply run this command and `docker-compose` will take care of the rest:

```
docker-compose -f docker-compose.build.yml build
```

## Why `docker-compose.build.yml`?

You may know that `docker-compose` is a great tool to define your services with dependencies and wire them up together with one simple command `docker-compose up`.

If I use the same `docker-compose.yml` file for both build and run purpose, `docker-compose` will automatically wire up all the services including the base-images (onbuild) which I don't want to start it up. I decide to create the `docker-compose.build.yml` just for build purpose.

## Start the containers

### Start a Pseudo-Distributed container

You can run your Hadoop platform in [Pseudo-Distributed Operation](http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html#Pseudo-Distributed_Operation) by running this command:

```
docker-compose -f docker-compose.pseudo.yml up
```

Now, your Pseudo-Distributed Hadoop system will be ready with HDFS and Yarn up and running inside a single container. If you run `docker ps` you will see there is one new container has been started. To access to your HDFS Name Node web interface, you can go to `http://localhost:50070`. To access to Resource Manager, you can go to `http://localhost:8088`.

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
