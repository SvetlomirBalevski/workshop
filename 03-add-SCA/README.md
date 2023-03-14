Apart from SAST it is a good idea to use SCA - software composition analysis. It can be integrated either in SCM, either in CI. We would show how to use Snyk into Jenkins.

More information for what is SCA can be found here - https://docs.google.com/presentation/d/1nGWB1q7tkUvmdDNXC60dL9y9ywFfGHnMqkAJzBAww1M/edit?usp=sharing (slide 12)

Install OWASP Dependency-Check Plugin. Configure installation in Global Tools Configuration. Use latest.

Add to the pipeline. It can be done via the console or declarative.

In case you need additional details how to run into scripted pipeline, use this link http://127.0.0.1:8080/pipeline-syntax/ 