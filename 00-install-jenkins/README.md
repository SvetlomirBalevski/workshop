# Install Jenkins

This workshop is based on [Jenkins](https://www.jenkins.io/).

In the first part of this workshop we are going to install Jenkins on AWS EC2.

This part of the workshop is based on [this blog post](https://betterprogramming.pub/provisioning-a-jenkins-server-on-aws-using-terraform-4cd1351b5d5f).

## Generate an SSH Key

The first thing we need to do is generate an SSH key for connecting to the EC2 instance.

```shell
ssh-keygen -t rsa -b 4096 -m pem -f tutorial_kp && mv tutorial_kp.pub modules/compute/tutorial_kp.pub && mv tutorial_kp tutorial_kp.pem && chmod 400 tutorial_kp.pem
```

Next, we need to run Terraform so that it provisions the desired resources:

```shell
terraform init
terraform apply -var-file="secrets.tfvars"
```

The `apply` command will ask you for confirmation - provide it.

It will take some time for Terraform to apply the resources and for them to be provisioned.
After the `apply` command succeeds it will output the public IP of the EC2 VM that we have provisioned.

```text
Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

jenkins_public_ip = "<SOME_IP>"
```

The output value can also be retrieved via the Terraform CLI:

```shell
$ terraform output -raw jenkins_public_ip
<SOME_IP>
```

Grab that IP and open it in your browser on port `8080`.
You should see your Jenkins welcome screen that will prompt you to create the first admin account.
(It's possible that Jenkins is still installing, and you need to wait a few minutes before ready).

Once you do that, your Jenkins is ready and you can proceed to setting up your DevSecOps pipeline.

## Teardown

After the end of the workshop, it's recommended you tear down your resources, so that you don't get a big suprise in your AWS bill at the end of the month.

Do that by running the following Terraform command:

```shell
terraform destroy -var-file="secrets.tfvars"
```
