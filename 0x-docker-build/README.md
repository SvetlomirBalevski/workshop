# 0x. Docker Build

Now that we are able to build our application, we would want to be able to build a container image that contains our JAR file.
Once we build our container image we would need to store it into a container repository.

For that purpose we can use [Docker Hub](https://hub.docker.com/) or any other free or paid container registry.
Create an account in your registry of choice if you don't have one.
Once you do that, as a best practice create a Personal Access Token that will be used by Jenkins to push images inside your registry account.

## Create a Jenkins secret

TODO: how to setup secrets?

## Create another Pipeline Stage

Once we have our registry account in place, and have provided Jenkins with the credentials for it, we can write the next stage that will build and push our container image.

Paste the following `stage` snippet after the two stages from the previous section:


```jenkinsfile
pipeline {
    agent none

    stages {
        // stages from the previous section

        stage('Docker Build and Push') {
            agent any

            steps {
                sh 'docker build -t ${DOCKER_HUB_USERNAME}/webgoat .'
                sh 'docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}'
                sh 'docker push ${DOCKER_HUB_USERNAME}/webgoat'
            }
        }
    }
}
```

This tell Jenkins to build the container image from the `Dockerfile` that is inside the WebGoat root directory.
It tags the image with the right tag and pushes it to the container registry.

**NOTE:** If you are using registry different than Docker Hub, you would also need to prefix the tag with the registry domain name, e.g. if you are using [quay.io](https://quay.io/) your tag will be something like `quay.io/<username>/webgoat`.

In this stage we built our container image and pushed it to a container registry.
We are almost ready to run our application container.
But first, we are going to apply some security scanning in the next section.
<!-- TODO: link to next section once we agree on section order -->
