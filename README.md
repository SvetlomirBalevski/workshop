# How to Automate Application Security - the DevSecOps way

This repo contains the material for the **How to Automate Application Security - the DevSecOps way** workshop.

## Prerequisites

1. Create an AWS account.
2. Install the [AWS CLI](https://aws.amazon.com/cli/) and [configure it](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) to use your account.
3. Install the [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

## Agenda

### [0. Install Jenkins](./00-install-jenkins-locally/)

Installation of Jenkins can be done in a lot of places.
We would have 2 possibilities - [install in AWS via Terraform](./00-install-jenkins/) or [install locally in a docker conatiner](./00-install-jenkins-locally/).
**Installation of Jenkins in AWS will lead to adidtional charges. Free tier machines are not enough for running Jenkins**

### [1. Pull and Test](./01-pull-and-test/)

### [2. Static Application Security Testing](./02-add-SAST/)

### [3. Software Composition Analysis](./03-add-SCA/)

### [4. Build](./04-build/)

### [5. Container Build and Push](./05-container-build/)

### [6. Container Image Scan](./06-container-image-scan/)

### 7. Deploy

### [8. Dynamic Application Security Testing](./08-add-DAST/)
