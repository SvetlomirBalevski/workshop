# 01. Build

The first step in our DevSecOps pipeline is to pull the code for our application and build it.

The application we have chosen for this exercise is the [Java WebGoat app](https://github.com/WebGoat/WebGoat).
This is an app that is intentionally vulnerable in many ways.

Create a new Jenkins pipeline and give it an arbitrary name (like `devsecops-pipeline`).

In the setup screen, the `Pipeline` section is where we are going to specify the steps of our pipeline.
The syntax for the pipeline is the so-called [Jenkinsfile](https://www.jenkins.io/doc/book/pipeline/syntax/), which uses the Groovy syntax.

To start our Pipeline paste the following code inside the Pipeline input:

```jenkinsfile
pipeline {
    agent none

    stages {
        stage('Pull from Github') {
            agent any

            steps {
                git url: 'https://github.com/asankov/webgoat.git', branch: 'main'
            }
        }
        stage('Build') {
            agent {
                docker {
                    // use the maven container image to build the application JAR file
                    image 'maven:3.9.0-eclipse-temurin-17'
                    args '-v /root/.m2:/root/.m2'
                }
            }

            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
    }
}
```

This will create a Pipeline with 2 stages:

- `Pull from Github`
  - all this stage does is pull the code from Github.
For that purpose you can use the upstream repo of the WebGoat application, or your own fork.
- `Build`
  - this steps builds the application JAR.
It uses the `maven:3.9.0-eclipse-temurin-17` container image as agent.
This means that Jenkins will start a new container with that image, mount the local files inside and executed the `steps` inside that container.
We are using Maven to build our application, hence we need a Maven container.
The alternative would be to install Maven on the Jenkins host and run the command as a local process.

Save the Pipeline and run it via the `Build Now` button.
Observe the logs and you will see Jenkins invoking the specified command and the logs from the Maven build.

This pipeline produced the JAR file for our application.
However, we are still not using this JAR for anything.

The next steps would be to run a SAST solution like SonarQube.

To do that head to the [next section](../02-add-SAST/README.md).