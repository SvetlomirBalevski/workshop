# 01. Pull and test

The first step in our DevSecOps pipeline is to pull the code for our application and make sure it builds and passes unit tests.

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
                git url: 'https://github.com/WebGoat/webgoat.git', branch: 'main'
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'maven:3.9.0-eclipse-temurin-17'
                    args '-v /root/.m2:/root/.m2'
                }
            }

            steps {
                sh 'mvn test'
            } 
        }
    }
}
```

This will create a Pipeline with 2 stages:

- `Pull from Github`
  - all this stage does is pull the code from Github.
For that purpose you can use the [upstream](https://github.com/WebGoat/webgoat) repo of the WebGoat application, or your own fork.
- `Test`
  - this steps runs the `mvn test` commands, which will run the unit tests for our application.
If our application is failing the unit tests, there is no need to proceed to any of the following steps.
This step will also fail, if there is a compilation error in our code.
The step uses the `maven:3.9.0-eclipse-temurin-17` container image as agent.
This means that Jenkins will start a new container with that image, mount the local files inside and executed the `steps` inside that container.
We are using Maven, hence we need a Maven container.
The alternative would be to install Maven on the Jenkins host and run the command as a local process.

Save the Pipeline and run it via the `Build Now` button.
Observe the logs and you will see Jenkins invoking the specified command and the logs from the Maven build.

This pipeline ensures that our application is passing its unit tests.
Proceed to the [next section](../02-add-SAST/README.md) to learn about SAST and how to integrate it into your pipeline.
