# This code is using RHEL Official AMI.

```
################################################################################
# RHEL Official AMI                                                            #
################################################################################
data "aws_ami" "redhat" {
  most_recent = true

  owners = ["309956199498"]

  filter {
    name   = "name"
    values = ["RHEL-${var.aws_redhat_version}*"]
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

