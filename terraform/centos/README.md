# This code is using CentOS Official AMI.

```
################################################################################
# CentOS Official AMI                                                          #
# https://wiki.centos.org/Cloud/AWS                                            #
################################################################################
data "aws_ami" "centos" {
  most_recent = true

  owners = ["125523088429"]

  filter {
    name   = "name"
    values = ["CentOS ${var.aws_centos_version}*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
```

