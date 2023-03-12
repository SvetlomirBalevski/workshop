We are going to start our first pipeline. For the purposes we are going to use known vulnerable web application - webgoat. It can be found here - https://github.com/WebGoat/WebGoat.
For this purposes:
(From nullsweep)
https://nullsweep.com/creating-a-secure-pipeline-jenkins-with-sonarqube-and-dependencycheck/

Install Java 11 and Maven globally:
Via SSH to jenkins instance:
sudo apt-get install openjdk-11-jdk
    In the Global Config of Jenkins (http://63.32.31.47:8080/manage/configureTools/) add java 11 - https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz and default Maven

Enable environmental varialbes and set JAVA_HOME
    Set java home to /var/jenkins_home/tools/hudson.model.JDK/JDK11/jdk-11.0.1/ after you enable enviromental variables (at http://63.32.31.47:8080/manage/configure)

Create multiconfiguration project