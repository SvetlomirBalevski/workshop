# How to Automate Application Security - the DevSecOps way

This repo contains the material for the **How to Automate Application Security - the DevSecOps way** workshop.

## Prerequisites

1. Create an AWS account.
2. Install the [AWS CLI](https://aws.amazon.com/cli/) and [configure it](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) to use your account.
3. Install the [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

## Agenda

### [0. Install Jenkins in TF](./00-install-jenkins/)
Installation of Jenkins can be done in a lot of places. We would have 2 possibilities - install in AWS via tf or install locally in a docker conatiner. 
**Installation of Jenkins in AWS will lead to adidtional charges. Free tear machines are not enough for running Jenkins**