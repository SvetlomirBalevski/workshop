We are going to start our first pipeline. For the purposes we are going to use known vulnerable web application - webgoat. It can be found here - https://github.com/WebGoat/WebGoat.
For this purposes:
(From nullsweep)
https://nullsweep.com/creating-a-secure-pipeline-jenkins-with-sonarqube-and-dependencycheck/

First we need to connect to jenkins with the initial admin password. If you are using docker container, you need to execute
docker exec -it unified_pipeline_example_jenkins_1 sh
and cat /var/jenkins_home/secrets/initialAdminPassword (or to look for your password into the output from docker-compose)

For AWS installation, ssh into your jenkins with the ip from terraform output.

Connect to Jenkins (ip from terraform or 127.0.0.1) at port 8080. Paste the admin password.

You can create a user (mandatory in real word enviroment) and you can install recomended plugins.

We can create our first pipeline, to build our first vulnerable application - webgoat.

Configure global tool configuration to use JDK called JDK11 from  https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz and maven 3.6.1

Enable environmental varialbes and set JAVA_HOME
    Set java home to /var/jenkins_home/tools/hudson.model.JDK/JDK11/jdk-11.0.1/ after you enable enviromental variables (at http://63.32.31.47:8080/manage/configure)

Fork Webgoat or use my fork - https://github.com/SvetlomirBalevski/WebGoat

Create freestyle project to build git@github.com:WebGoat/WebGoat.git (or https://github.com/SvetlomirBalevski/WebGoat)

Build command should be 