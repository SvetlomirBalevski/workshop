First check in our pipeline should be the SAST check - Static application security testing. 

More information for what is SAST can be found here - https://docs.google.com/presentation/d/1nGWB1q7tkUvmdDNXC60dL9y9ywFfGHnMqkAJzBAww1M/edit?usp=sharing (slide 11)For this purposes we are going to install Sonarqube. Actually it should be already running in our docker compose (you can check with docker ps) at 127.0.0.1:9000.

Change the default password from admin/admin.

Create Jenkins user from administration/security. Logout and login with new user. From account/security generate new token. Create new project - e.g. *webgoat*. Generate token for the project - 5eca0121ac56a07b9e8aa4eab034492c30872215

Instal Sonarqube plugin (https://plugins.jenkins.io/sonar/) in Jenkins from Mange Jenkins / Manage Plugins. After installation (if you select restart, Jenkins needs to  run again from compose) configure on *Global Tool Configuration*. Provide name (sonar) and install latest version.

(edit there is a bug in this installation and need to alter the sonar-scanner code. For this purpose - log into the conatiner, and hardcode JAVA_PATH into the sonar-scanner file located at /var/jenkins_home/tools/hudson.plugins.sonar.SonarRunnerInstallation/sonar/bin )

From manage jenkins / Configure system we need to add Sonarqube installation and add Server token (as secret text, not as username / password) into the credentials. Sonar url is http://sonarqube:9000

Configure build step with following properties:
sonar.projectKey=your_key
sonar.projectName=webgoat
sonar.projectVersion=1.0
sonar.language=java
sonar.java.binaries=**/target/classes
sonar.exclusions=**/*.ts

Additional arguments -X

You can look at the ouptut at 127.0.0.1:9000 and to configure the quality gates to fail the build (we would do this later)
