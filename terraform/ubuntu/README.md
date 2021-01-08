# This code is using Ubuntu Official AMI.

```
################################################################################
# Ubuntu Official AMI                                                          #
# https://help.ubuntu.com/community/EC2StartersGuide                           #
################################################################################
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}
```

