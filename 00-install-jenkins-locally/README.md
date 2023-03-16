# Install Jenkins

This workshop is based on [Jenkins](https://www.jenkins.io/).

We are going to install Jenkins inside Docker.

To proceed with this guide, make sure that you have `docker` installed on your machine (or the machine you're working on).
If you don't you can download it from their [here](https://docs.docker.com/get-docker/).

Once you have installed `docker` run this command (from this directory) to spin up the necessary containers:

```shell
docker compose up
```

This will spin-up the Jenkins container and a few other containers which we'll use throughout this workshop.

## Accessing Jenkins

After the containers are running you should be able to open [localhost:8080](http://localhost:8080) in your browser and be greated by your Jenkins instance.
It will ask you the admin password.
This password can be found via the following command:

```shell
docker exec unified_pipeline_example_jenkins_1 cat /var/jenkins_home/secrets/initialAdminPassword
```

After that, Jenkins will prompt you to create the first user.
It is strongly recommended to do that, although you can skip it and continue with the default admin user.

Now that we have a running Jenkins we can proceed to the [next section](../01-first-pipeline/README.md) where we will create our first pipeline.

## Acknowledgements

This part of the workshop is based on [this blog post](https://nullsweep.com/creating-a-secure-pipeline-jenkins-with-sonarqube-and-dependencycheck/) and this [guide](https://www.jenkins.io/doc/book/installing/docker/).

The Jenkins container is slightly modified from the original one, because we need to have the [Docker CLI](https://docs.docker.com/engine/reference/commandline/cli/) in the container and also the [Docker Pipeline plugin](https://plugins.jenkins.io/docker-workflow/).
The Dockerfile can be found [here](./jenkins.Dockerfile).
