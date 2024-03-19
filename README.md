# How to Automate Application Security - the DevSecOps way

This repo contains the material for the **How to Automate Application Security - the DevSecOps way** workshop.

## What is DevSecOps?

First of all - **a methodology**.

> DevSecOps—short for development, security, and operations—automates the integration of security at every phase of the software development lifecycle, from initial design through integration, testing, deployment, and software delivery.

[**IBM**](https://www.ibm.com/topics/devsecops#:~:text=DevSecOps%E2%80%94short%20for%20development%2C%20security,%2C%20deployment%2C%20and%20software%20delivery.)

> DevSecOps stands for development, security, and operations. It's an approach to culture, automation, and platform design that integrates security as a shared responsibility throughout the entire IT lifecycle.

[**RedHat**](https://www.redhat.com/en/topics/devops/what-is-devsecops)

> DevSecOps (short for development, security, and operations) is a development practice that integrates security initiatives at every stage of the software development lifecycle to deliver robust and secure applications.

[**VMware**](https://www.vmware.com/topics/glossary/content/devsecops.html)

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
