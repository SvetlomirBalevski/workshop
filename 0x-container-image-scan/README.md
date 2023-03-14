# 0X. Container Image Scan

After we have build our container image and pushed it into the container repository we need to scan it for vulnerabilities.

This can be done via a container image scanner like [trivy](https://github.com/aquasecurity/trivy) or [grype](https://github.com/anchore/grype).

For this exercise we have chosen grype.

To do this add this stage to your `Jenkinsfile`:

```Jenkinsfile
stage('Docker Scan') {
    agent {
        docker {
            <!-- TODO: replace hash with proper tag -->
            image 'asankov/grype@sha256:4e5f08a5bb38a56a692bad56a59369d30adceae2d6db8de1dc6326279d1a8a0c'
            args '-v /root/.m2:/root/.m2'
        }
    }
    steps {
        sh 'echo START'
        sh 'grype asankov/webgoat'
    }
}
```

This will tell Jenkins that the `Docker Scan` phase must be executed inside the `asankov/grype-opa` container.
This container contains the grype CLI, which we will use for scanning the container image.

Once we have the CLI the only thing we need to do is invoke it with the container image we want we scan.
Once we do that, grype will scan the image and output a list of vulnerabilities.

<!-- TODO: add scanning via OPA -->