# Terraform Infrastructure

This folder contains the Terraform configuration used to provision the infrastructure for this DevOps project.

## Overview

The Terraform code in this directory is used to create the AWS resources needed for the environment, including compute, networking, and security-related components.

One confirmed resource in this folder is an EC2 instance called `ansible-master`, which is configured with:

- An Ubuntu AMI
- Instance type `t3.micro`
- Public IP association
- Deployment into a public subnet
- An SSH security group
- A key pair for SSH access
- A `user_data` value for instance bootstrapping

## Confirmed Resource

The `ansible-master` instance is currently defined with the following main settings:

- AMI: `ami-025d7bea93113b6cc`
- Instance type: `t3.micro`
- Name tag: `ansible-master`
- Public IP: enabled
- Subnet: `aws_subnet.public_subnet`
- Security group: `aws_security_group.allow_ssh-ansible-master`
- Key pair: `ec2-key-2`

## Purpose of This Folder

This folder is intended to manage infrastructure such as:

- EC2 instances
- VPC and subnet resources
- Security groups
- Key pair association
- Bootstrap scripts through `user_data`

## Prerequisites

Before using this Terraform configuration, make sure you have:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- An AWS account
- AWS credentials configured locally
- A valid AWS key pair if referenced by name
- Enough AWS permissions to create EC2, VPC, subnet, and security group resources

## Usage

Initialize Terraform:
```bash
terraform init
```

Review the execution plan:
```bash
terraform plan
```

Apply the configuration:
```bash
terraform apply
```

Destroy the infrastructure when no longer needed:
```bash
terraform destroy
```

## Passwordless SSH Setup

As part of this project we configured the `ansible-master` server to SSH into other EC2 instances without a password. This is required for tools like Ansible to manage remote servers automatically.

### How It Works

- The **private key** lives on the master server (`~/.ssh/id_ed25519`)
- The **public key** is placed in `~/.ssh/authorized_keys` on each target server
- SSH reads `authorized_keys` on every connection, so no reload is needed

### Steps Followed

1. Generated an SSH key pair on the `ansible-master` server:
```bash
ssh-keygen -t ed25519
```

2. Copied the `.pem` key from the local machine to the master server so it could authenticate during setup:
```bash
# Run from local machine
scp -i ~/.ssh/ec2-key-2.pem ~/.ssh/ec2-key-2.pem ubuntu@<master-public-ip>:~/.ssh/
chmod 400 ~/.ssh/ec2-key-2.pem
```

3. Used `ssh-copy-id` to install the master's public key onto each target server:
```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub -o "IdentityFile=/home/ubuntu/.ssh/ec2-key-2.pem" ubuntu@<target-private-ip>
```

4. Configured `~/.ssh/config` on the **ansible-master** to avoid specifying the `.pem` on every connection:
```
Host server1
    HostName 10.0.1.152
    User ubuntu
    IdentityFile ~/.ssh/ec2-key-2.pem

Host server2
    HostName 10.0.1.x
    User ubuntu
    IdentityFile ~/.ssh/ec2-key-2.pem
```
```bash
chmod 600 ~/.ssh/config
```

Now from the master you can connect using just:
```bash
ssh server1
ssh server2
```

Once passwordless SSH is fully working with the `id_ed25519` key, the `IdentityFile` lines can be removed as SSH will use that key by default:
```
Host server1
    HostName 10.0.1.152
    User ubuntu

Host server2
    HostName 10.0.1.x
    User ubuntu
```

### Network Notes

- The `ansible-master` connects to other servers using **private IPs** since all instances are in the same VPC
- Target servers do not need public IPs, keeping the infrastructure more secure
- Only the `ansible-master` is exposed to the internet

## Notes

- Make sure all referenced resources such as subnets and security groups are defined in this Terraform project.
- Update AMI IDs as needed depending on the AWS region you deploy to.
- Keep secrets and credentials out of Terraform files and source control.

## Improvement Suggestion

The current `user_data` value appears to be set as a local file path string. In Terraform, that usually will not execute the script content itself.

Current pattern:
```hcl
user_data = "~/Desktop/Dev-ops-project-06/terraform-files/user-data.sh"
```

A more portable approach is:
```hcl
user_data = file("${path.module}/user-data.sh")
```

This makes the configuration work better across different machines and CI/CD environments.

## Project Goal

This Terraform setup is part of a broader DevOps project focused on automating AWS infrastructure provisioning and preparing the environment for configuration management, deployment workflows, and future automation.