# 06. Container Image Scan

After we have build our container image and pushed it into the container repository we need to scan it for vulnerabilities.

This can be done via a container image scanner like [trivy](https://github.com/aquasecurity/trivy) or [grype](https://github.com/anchore/grype).

For this exercise we have chosen grype.

To do this add this stage to your `Jenkinsfile`:

```Jenkinsfile
stage('Docker Scan') {
    agent {
        docker {
            image 'asankov/grype-opa:0.1'
            args '-v /root/.m2:/root/.m2'
        }
    }
    steps {
        sh 'grype asankov/webgoat'
    }
}
```

This will tell Jenkins that the `Docker Scan` phase must be executed inside the `asankov/grype-opa` container.
This container contains the grype CLI, which we will use for scanning the container image.

Once we have the CLI the only thing we need to do is invoke it with the container image we want we scan.
Once we do that, grype will scan the image and output a list of vulnerabilities.

## Verifying the results

Scanning the container image is great, but just scanning is not enough.

Once we scan it, we need to do something with the results.
For example, we can validate that the number of vulnerabilities does not exceed a certain threshold or severity.

The Grype CLI allows us to that via the `--fail-on` flag.
We can invoke Grype like this:

```shell
grype asankov/webgoat --fail-on=critical
```

This will make Grype return a non-zero return code, if inside the results for this image there is a vulnerability that has a severity of `Critical` or similar.
We can add this to the pipeline, and this way the pipeline will fail in this scenario.

## Advanced verification via OPA

Using Grype this way is good, but it does have some deficiencies.
For example, what happens if there is a `Critical` vulnerability, but we have deemed that false positive and we want to ignore it.
Or if we want to deploy despite that Critical vulnerability.

This is where [Open Policy Agent](https://www.openpolicyagent.org/) comes in.
Open Policy Agent is a ...policy agent, suprise, suprise.
It is used to evaluate data against a policy.
The data is JSON, and the policy is [Rego](https://www.openpolicyagent.org/docs/latest/policy-language/).
Rego is a domain language, invented by the OPA creators.
More about OPA and Rego you can learn on the OPA website or [in this presentation](https://github.com/asankov/securing-kubernetes-with-open-policy-agent/blob/main/2022/bsides-sofia/presentation.pdf).

We can use OPA to implement advanced verification for the scan results.

The following Rego policy will return `allow = false` if inside the data we are passing there is a `vulnerability` that has `severity=Critical`.

```rego
package devsecops

default allow := true

allow = false {
 vulnerability = input.matches[_].vulnerability
 vulnerability.severity = "Critical"
}
```

The following Rego will do the same, but it allows us to define a list of Vulnerability IDs which we want to ignore.

```rego
package devsecops

default allow := true

ignore = ["CVE-2007-2379"]

allow = false {
 vulnerability = input.matches[_].vulnerability
 vulnerability.severity = "Critical"
 not contains(ignore, vulnerability.id)
}

contains(vulnerabilities, elem) {
  vulnerabilities[_] = elem
}
```

## Using the OPA CLI

We can use the OPA CLI to verify the results.

Since the input data is JSON we need to tell Grype to output the results as JSON:

```shell
grype <IMAGE> -o json
```

and we need to save this data as a file:

```shell
grype <IMAGE> -o json > scan.json
```

Then we can invoke OPA with that data:

```shell
opa eval --data policy.rego --input scan.json "data.devsecops.block"
```

This evaluates the `scan.json` file against the `policy.rego` policy and outputs the `data.devsecops.block` query from the results.

So how do we fail if `block = true`?

There is an OPA flag that we can use.
`--fail-defined` tells OPA to return non-zero response code if the given query returns a defined result (`block = false` is a defined result).

So the final query can be something like:

```shell
opa eval --data policy.rego --input scan.json "data.devsecops.block" --fail-defined
```

This will fail the pipeline if we have ANY vulnerabilities that satisfy the given conditions (has CRITICAL vulnerabilities and is not in exceptions list).

The final stage should look like this:

```Jenkinsfile
stage('Docker Scan') {
    agent {
        docker {
            image 'asankov/grype-opa:0.1'
            args '-v /root/.m2:/root/.m2'
        }
    }
    steps {
        sh 'grype asankov/webgoat -o json > scan.json'
        sh 'opa eval --data policy.rego --input scan.json "data.devsecops.block" --fail-defined'
    }
}
```

**NOTE:** In order for this to work, the `policy.rego` file must be located inside the root directory of your WebGoat repo.
You should either fork it and add it, or use [my fork](https://github.com/asankov/WebGoat), where it's already added.
