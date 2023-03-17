# 02. SAST (Static Application Security Testing)

First check in our pipeline after the unit tests should be the SAST check - Static application security testing.

More information for what is SAST can be found [here (slide 11)](https://docs.google.com/presentation/d/1nGWB1q7tkUvmdDNXC60dL9y9ywFfGHnMqkAJzBAww1M/edit?usp=sharing).

For a SAST solution we are going to use [Sonarqube](https://www.sonarsource.com/products/sonarqube/).
Actually it should be already running in our docker compose (you can check with `docker ps`) at [127.0.0.1:9000](http://127.0.0.1:9000).

Change the default password from admin/admin.

Create Jenkins user from *Administration* -> *Security*.
Logout and login with new user.
From *Account* -> *Security* generate new token.
Create new project - e.g. *webgoat*.
Generate token for the project - 5eca0121ac56a07b9e8aa4eab034492c30872215

Instal [Sonarqube plugin](https://plugins.jenkins.io/sonar/) in Jenkins from *Manage Jenkins* -> *Manage Plugins*.
After installation (if you select restart, Jenkins needs to be run again from compose) configure on *Global Tool Configuration*.
Provide name (sonar) and install latest version.

**NOTE:** There is a bug in this installation and we need to alter the sonar-scanner code.
For this purpose - log into the container, and hardcode `JAVA_PATH` into the sonar-scanner file located at `/var/jenkins_home/tools/hudson.plugins.sonar.SonarRunnerInstallation/sonar/bin` like this `JAVA_HOME="/var/jenkins_home/tools/hudson.model.JDK/JDK11/jdk-11.0.1/"`

From *Manage Jenkins* -> *Configure system* we need to add Sonarqube installation and add Server token (as secret text, not as username / password) into the credentials.
Sonar URL is <http://sonarqube:9000>

Configure build step with following properties:

```properties
sonar.projectKey=your_key
sonar.projectName=webgoat
sonar.projectVersion=1.0
sonar.language=java
sonar.java.binaries=**/target/classes
sonar.exclusions=**/*.ts
```

Additional arguments: `-X`

You can look at the output at [127.0.0.1:9000](http://127.0.0.1:900) and to configure the quality gates to fail the build (we would do this later).

In the [next section](../03-add-SCA/README.md) we are going to configure Software Composition Analysis.
