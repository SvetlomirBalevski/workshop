# 02. SAST (Static Application Security Testing)

First check in our pipeline after the unit tests should be the SAST check - Static application security testing.

More information for what is SAST can be found [here (slide 11)](https://docs.google.com/presentation/d/1nGWB1q7tkUvmdDNXC60dL9y9ywFfGHnMqkAJzBAww1M/edit?usp=sharing).

For a SAST solution we are going to use [Sonarqube](https://www.sonarsource.com/products/sonarqube/).

There is a managed version of Sonarqube known as [Sonarcloud], that is free for use for public repositories. You need to sign-up on the website here -https://www.sonarsource.com/products/sonarcloud/ with your github account (easiest way). 

For testing we are going to use Webgoat project - fork this repository - https://github.com/WebGoat/WebGoat
Add new project from the plus sign and let sonar analyze it.

We can configure how the new code is going to be treated. For example- we can use sonar to scan latest changes or code change in the last x days.

## Alternatively we can use Jenkins to run our scanner via Sonarcloud.

For this purpose - we need to login into the container (`docker exec -it 00-install-jenkins-locally_jenkins_1 bash`) and run following code:

export SONAR_SCANNER_VERSION=4.7.0.2747
export SONAR_SCANNER_HOME=$HOME/.sonar/sonar-scanner-$SONAR_SCANNER_VERSION-linux
curl --create-dirs -sSLo $HOME/.sonar/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux.zip
unzip -o $HOME/.sonar/sonar-scanner.zip -d $HOME/.sonar/
export PATH=$SONAR_SCANNER_HOME/bin:$PATH
export SONAR_SCANNER_OPTS="-server"
Sonar requires node 16 to be installed:
curl -s https://deb.nodesource.com/setup_16.x | bash
apt install nodejs -y


We need as well to pass credentials to the build, without being added to the configuration in plain text. For this purpose copy your key from sonar scanner and input it into the `Jenkins config store`, calling it `sonar-scanner-key`



## Another option to run Sonar is to use locally running sonarqube. Due to some problem with current Jenkins plugins, we would run this in future:

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

**NOTE:** There is a bug in this installation and we need to alter the sonar-scanner code. Before being able to fix it, you would need first to run the pipeline without fixing it, so sonar can install required tools.
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
