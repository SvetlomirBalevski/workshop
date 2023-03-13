Apart from SAST it is a good idea to use SCA - software composition analysis. It can be integrated either in SCM, either in CI. We would show how to use Snyk into Jenkins.

More information for what is SCA can be found here - https://docs.google.com/presentation/d/1nGWB1q7tkUvmdDNXC60dL9y9ywFfGHnMqkAJzBAww1M/edit?usp=sharing (slide 12)

Install Snyk Security plugin. Make a registration (if you don't have) on the Snyk webiste for trial key- snyk.io

More details can be found here - https://docs.snyk.io/integrations/ci-cd-integrations/jenkins-integration-overview

Apply snyk into the build before the build phase but after the sonarqube scan.