# 04. Build

After we know that the tests for our application passed, including the SAST and SCA, we can proceed to building and shipping our application.

To do this add the following step to the pipeline:

```jenkinsfile
pipeline {
    agent none

    stages {
        // stages from the previous sections

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

This step will build the application JAR.
It uses the `maven:3.9.0-eclipse-temurin-17` container image as agent.
This means that Jenkins will start a new container with that image, mount the local files inside and executed the `steps` inside that container.
We are using Maven to build our application, hence we need a Maven container.
The alternative would be to install Maven on the Jenkins host and run the command as a local process.

This pipeline produced the JAR file for our application.
However, we are still not using this JAR for anything.

The next steps would be to put this JAR inside a container.

To do that head to the [next section](../05-container-build/).
