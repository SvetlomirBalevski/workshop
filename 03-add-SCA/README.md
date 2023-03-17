# 03. Software Composition Analysis

Apart from SAST it is a good idea to use SCA - **Software Composition Analysis**.
It can be integrated either in SCM, or in CI.

We will show you how to use Snyk into Jenkins.

More information for what is SCA can be found [here (slide 12)](https://docs.google.com/presentation/d/1nGWB1q7tkUvmdDNXC60dL9y9ywFfGHnMqkAJzBAww1M/edit?usp=sharing).

Install **OWASP Dependency-Check Plugin**.
Configure installation in _Global Tools Configuration_.
Use _latest_.

Add the dependency check step to the pipeline.

The easiest way to do it is via the `dependencyCheck` command:

```jenkinsfile
dependencyCheck additionalArguments: 'scan="path to scan" --format HTML', odcInstallation: 'dependency-check'
```

The full stage looks like this:

```jenkinsfile
pipeline {
    agent none

    stages {
        // stages from previous sections

        stage('SCA') {
            agent any

            steps {
               dependencyCheck additionalArguments: ''' -o "./" -s "./" -f "ALL" --prettyPrint''', odcInstallation: 'dependency-check'
               dependencyCheckPublisher (pattern: 'dependency-check-report.xml')
            }
        }
    }
}
```

If you want to include publishing of the reports add this step to the pipeline:

```jenkinsfile
dependencyCheckPublisher (pattern: 'dependency-check-report.xml')
```

The final version of the pipeline should look like this:

```jenkinsfile
pipeline {
    agent none

    stages {
        // stages from previous sections

        stage('SCA') {
            agent any

            steps {
               dependencyCheck additionalArguments: ''' -o "./" -s "./" -f "ALL" --prettyPrint''', odcInstallation: 'dependency-check'
               dependencyCheckPublisher (pattern: 'dependency-check-report.xml')
            }
        }
    }
}
```

In case you need additional details for the syntax of the Pipeline, the Jenkins docs are available locally at <http://127.0.0.1:8080/pipeline-syntax/>.

In the [next section](../04-build/README.md) we are going to build our application.
