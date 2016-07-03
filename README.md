# Apache Hadoop Cluster Docker images

## Before we start

I'm falling in love with Hadoop and Docker. I want to leverage them to "containerize" the Hadoop cluster. I create this project to build and run Hadoop modules inside Docker containers. It is just for practical purpose and not tested in the production environment.

### Use your Docker repo

If you wish to customize the source code and push the images to your Docker repo for future use, you will need to change `vietanh85` (my Docker account) to yours in the `docker-compose.*.yml` files. You will see the `image` property of the servies.

### Why `Dockerfile.onbuild` and so many `Dockerfile.*`?

For this practice, I'm going to use 2 modules of Hadoop system: 

- Yarn for node/resource management 
- HDFS for storage. 

All of them could be downloaded in the same package of Hadoop, the only different thing is the starting script. To save my code and effort, I decide to create a base images for all modules. By doing that, Docker engine will not have to download hadoop package every time it build the images. The hierarchy of our images will be as bellow:

![Docker images hierarchy](/img/docker-images-heirarchy.png?raw=true "Docker images hierarchy")

### Why `docker-compose.build.yml`?

You may know that `docker-compose` is a great tool to define your services with dependencies and wire them up together with one simple command `docker-compose up`.

If I use the same `docker-compose.yml` file for both build and run purpose, `docker-compose` will automatically wire up all the services including the base-images (onbuild) which I don't want to start it up. I decide to create the `docker-compose.build.yml` just for build purpose.

## Build the images

To automatically build the images, you can just simply run this command and `docker-compose` will take care of the rest:

```
docker-compose -f docker-compose.build.yml build
```

To check the build result, you can run `docker images`, you will see your new images there.

## Start the containers

### Start a Pseudo-Distributed container

You can run your [Pseudo-Distributed Operation Hadoop system](http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html#Pseudo-Distributed_Operation) by running this command:

```
docker-compose -f docker-compose.pseudo.yml up
```

Now, your Pseudo-Distributed Hadoop system will be ready with HDFS and Yarn up and running inside a single container. If you run `docker ps` you will see there is one new container has been started. To access to your HDFS Name Node web interface, you can go to `http://localhost:50070`. To access to Resource Manager, you can go to `http://localhost:8088`.

[IMG]

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

Now it's the time to run your Hadoop system in "fully" distributed mode. I put the word "fully" inside double-quotes, since it is not a real fully distributed system which run in multiple hosts. Instead of that, we will run our cluster inside multiple containers and all of them will run in one host.

[IMG]

To start your [Hadoop Cluster](http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/ClusterSetup.html), you can run this command:

```
docker-compose -f docker-compose.cluster.yml up
```

docker-compose will start 3 containers including:
- HDFS (name node)
- Yarn (both resource and node manager)
- HDFS (data node)

To see your containers, run `docker ps`. 

You can easily scale your data nodes using docker-compose as well:

```
docker-compose -f docker-compose.cluster.yml scale hdfs_data=3
```

### Start Cluster in multiple hosts

TBD

## Todos
- [x] Ablitiy to run Pseudo-Distributed Operation
- [x] Ability to run Cluster Operation
- [ ] Enable Docker Swarm to run and deploy in multiple hosts
