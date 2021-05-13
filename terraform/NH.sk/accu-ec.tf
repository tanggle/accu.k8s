terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  # profile = "default"
  # region = var.AWS_DEFAULT_REGION
  # access_key = var.AWS_ACCESS_KEY_ID
  # secret_key = var.AWS_SECRET_ACCESS_KEY
}

data "aws_availability_zones" "available" {}

resource "aws_key_pair" "accuinsight" {
  key_name   = "accuinsight-k8s-${var.aws_cluster_name}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDphDAfyMxj8n5d+9gDrAqIBJ+VNVIO/c2IWdvkxr+NgslsivXyZL7rD/K5366L2VDbDRnMmW6DPm5KnuCrVMylyXNDZFxJ47dxWlTq1Y37xPf/DurPWi3Z2LEZdUxI4xE08UiLwikS0FYF5a5kHbhbdesgA4rTbb305fS21hdItqTEDQ6BlkYjoevnAPUNXWFNzf2i2jQBHdC6ZKmJWSfj047JU2gTg3j7VrfkdYsrxoVn3pNzNC+LzsR23FEgbVQIx5o8n7qgxGGzqCHhIg5cgCVklZK4u++bwfQIVtwVGRmoROCzSHmReyBadPOOtb/Fo68t2ZifNSNwF8ag9McF accuinsight"
}

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

resource "aws_instance" "k8s-lb" {
  ami                         = data.aws_ami.redhat.id
#  ami                         = "ami-0f8dedf5ec103d6a5"
  instance_type               = var.aws_kube_lb_type
  count                       = var.aws_kube_lb_num
  associate_public_ip_address = true
  availability_zone           = element(slice(data.aws_availability_zones.available.names, 0, 2), count.index)
  security_groups             = ["k8s-${var.aws_cluster_name}-securitygroup"]
  key_name                    = aws_key_pair.accuinsight.id
  tags = merge(var.default_tags, map(
    # "Name", "k8s-${var.aws_cluster_name}-lb0${count.index + 1}",
    "Name", "k8s-${var.aws_cluster_name}-alb",
    "Cluster", "${var.aws_cluster_name}",
    "Role", "LB"
  ))
  volume_tags = {
    # Name = "k8s-${var.aws_cluster_name}-lb0${count.index + 1}"
    Name = "k8s-${var.aws_cluster_name}-alb"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("~/accuinsight.pem")
  }

  #  provisioner "file" {
  #    source      = "files"
  #    destination = "/tmp"
  #  }

  #  provisioner "remote-exec" {
  #    inline = [
  #      "sudo mv /tmp/files/config/sshd_config /etc/ssh/sshd_config",
  #      "sudo systemctl restart sshd",
  #      "echo 'root:AccuInsight*0' | sudo chpasswd",
  #      "echo 'ec2-user:AccuInsight*0' | sudo chpasswd"
  #    ]
  #  }

  #  provisioner "local-exec" {
  #    command = "sshpass -p'AccuInsight*0' ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ec2-user@${self.public_ip}"
  #  }
}

resource "aws_instance" "k8s-nfs" {
  ami                         = data.aws_ami.redhat.id
#  ami                         = "ami-0f8dedf5ec103d6a5"
  instance_type               = var.aws_kube_nfs_type
  count                       = var.aws_kube_nfs_num
  associate_public_ip_address = true
  availability_zone           = element(slice(data.aws_availability_zones.available.names, 0, 2), count.index)
  security_groups             = ["k8s-${var.aws_cluster_name}-securitygroup"]
  key_name                    = aws_key_pair.accuinsight.id
  tags = merge(var.default_tags, map(
    "Name", "k8s-${var.aws_cluster_name}-nfs",
    "kubernetes.io/cluster/${var.aws_cluster_name}", "member",
    "Role", "NFS"
  ))
  volume_tags = {
    Name = "k8s-${var.aws_cluster_name}-nfs"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = 310
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("~/accuinsight.pem")
  }

  #  provisioner "file" {
  #    source      = "files"
  #    destination = "/tmp"
  #  }

  #  provisioner "remote-exec" {
  #    inline = [
  #      "sudo mv /tmp/files/config/sshd_config /etc/ssh/sshd_config",
  #      "sudo systemctl restart sshd",
  #      "echo 'root:AccuInsight*0' | sudo chpasswd",
  #      "echo 'ec2-user:AccuInsight*0' | sudo chpasswd"
  #    ]
  #  }

  #  provisioner "local-exec" {
  #    command = "sshpass -p'AccuInsight*0' ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ec2-user@${self.public_ip}"
  #  }

  provisioner "remote-exec" {
    inline = [
      "echo Prepare for NFS export directory",
      "sudo mkdir /nfs; sudo chmod 777 /nfs",
    ]
  }
}

resource "aws_instance" "k8s-gpu" {
  ami                         = data.aws_ami.redhat.id
#  ami                         = "ami-0f8dedf5ec103d6a5"
  instance_type               = var.aws_kube_gpu_type
  count                       = var.aws_kube_gpu_num
  associate_public_ip_address = true
  availability_zone           = element(slice(data.aws_availability_zones.available.names, 0, 2), count.index)
  security_groups             = ["k8s-${var.aws_cluster_name}-securitygroup"]
  key_name                    = aws_key_pair.accuinsight.id
  tags = merge(var.default_tags, map(
    "Name", "k8s-${var.aws_cluster_name}-g0${count.index + 1}",
    "kubernetes.io/cluster/${var.aws_cluster_name}", "member",
    "Role", "GPU"
  ))
  volume_tags = {
    Name = "k8s-${var.aws_cluster_name}-g0${count.index + 1}"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = 200
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("~/accuinsight.pem")
  }

  #  provisioner "file" {
  #    source      = "files"
  #    destination = "/tmp"
  #  }

  #  provisioner "remote-exec" {
  #    inline = [
  #      "sudo mv /tmp/files/config/sshd_config /etc/ssh/sshd_config",
  #      "sudo systemctl restart sshd",
  #      "echo 'root:AccuInsight*0' | sudo chpasswd",
  #      "echo 'ec2-user:AccuInsight*0' | sudo chpasswd"
  #    ]
  #  }

  #  provisioner "local-exec" {
  #    command = "sshpass -p'AccuInsight*0' ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ec2-user@${self.public_ip}"
  #  }

  provisioner "remote-exec" {
    inline = [
      "echo Some volume tasks will be placed here",
    ]
  }
}

#
# Create K8s Master and worker nodes and etcd instances
#
resource "aws_instance" "k8s-master" {
  ami                         = data.aws_ami.redhat.id
#  ami                         = "ami-0f8dedf5ec103d6a5"
  instance_type               = var.aws_kube_master_type
  count                       = var.aws_kube_master_num
  associate_public_ip_address = true
  availability_zone           = element(slice(data.aws_availability_zones.available.names, 0, 2), count.index)
  security_groups             = ["k8s-${var.aws_cluster_name}-securitygroup"]
  key_name                    = aws_key_pair.accuinsight.id
  tags = merge(var.default_tags, map(
    "Name", "k8s-${var.aws_cluster_name}-m0${count.index + 1}",
    "kubernetes.io/cluster/${var.aws_cluster_name}", "member",
    "Role", "MASTER"
  ))
  volume_tags = {
    Name = "k8s-${var.aws_cluster_name}-m0${count.index + 1}"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = 200
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("~/accuinsight.pem")
  }

  #  provisioner "file" {
  #    source      = "files"
  #    destination = "/tmp"
  #  }

  #  provisioner "remote-exec" {
  #    inline = [
  #      "sudo mv /tmp/files/config/sshd_config /etc/ssh/sshd_config",
  #      "sudo systemctl restart sshd",
  #      "echo 'root:AccuInsight*0' | sudo chpasswd",
  #      "echo 'ec2-user:AccuInsight*0' | sudo chpasswd"
  #    ]
  #  }

  #  provisioner "local-exec" {
  #    command = "sshpass -p'AccuInsight*0' ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ec2-user@${self.public_ip}"
  #  }

  provisioner "remote-exec" {
    inline = [
      "echo Some volume tasks will be placed here",
    ]
  }
}

resource "aws_instance" "k8s-worker" {
  ami                         = data.aws_ami.redhat.id
#  ami                         = "ami-0f8dedf5ec103d6a5"
  instance_type               = var.aws_kube_worker_type
  count                       = var.aws_kube_worker_num
  associate_public_ip_address = true
  availability_zone           = element(slice(data.aws_availability_zones.available.names, 0, 2), count.index)
  security_groups             = ["k8s-${var.aws_cluster_name}-securitygroup"]
  key_name                    = aws_key_pair.accuinsight.id
  tags = merge(var.default_tags, map(
    "Name", "k8s-${var.aws_cluster_name}-w0${count.index + 1}",
    "kubernetes.io/cluster/${var.aws_cluster_name}", "member",
    "Role", "WORKER,CEPH"
  ))
  volume_tags = {
    Name = "k8s-${var.aws_cluster_name}-w0${count.index + 1}"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = 200
  }

  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sdf"
    volume_size           = 300
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("~/accuinsight.pem")
  }

  #  provisioner "file" {
  #    source      = "files"
  #    destination = "/tmp"
  #  }

  #  provisioner "remote-exec" {
  #    inline = [
  #      "sudo mv /tmp/files/config/sshd_config /etc/ssh/sshd_config",
  #      "sudo systemctl restart sshd",
  #      "echo 'root:AccuInsight*0' | sudo chpasswd",
  #      "echo 'ec2-user:AccuInsight*0' | sudo chpasswd"
  #    ]
  #  }

  #  provisioner "local-exec" {
  #    command = "sshpass -p'AccuInsight*0' ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ec2-user@${self.public_ip}"
  #  }

  provisioner "remote-exec" {
    inline = [
      "echo Some volume tasks will be placed here",
    ]
  }
}

#
# Multipurpose Node (HAPROXY, NFS, GPU)
#
resource "aws_instance" "k8s-multi" {
  ami                         = data.aws_ami.redhat.id
#  ami                         = "ami-0f8dedf5ec103d6a5"
  instance_type               = var.aws_kube_multi_type
  count                       = var.aws_kube_multi_num
  associate_public_ip_address = true
#  availability_zone           = element(slice(data.aws_availability_zones.available.names, 0, 2), count.index)
  availability_zone           = element(slice(data.aws_availability_zones.available.names, 0, 1), count.index)
  security_groups             = ["k8s-${var.aws_cluster_name}-securitygroup"]
  key_name                    = aws_key_pair.accuinsight.id
  tags = merge(var.default_tags, map(
    "Name", "k8s-${var.aws_cluster_name}-0${count.index + 1}",
    "kubernetes.io/cluster/${var.aws_cluster_name}", "member",
    "Role", "LB,NFS,GPU"
  ))
  volume_tags = {
    Name = "k8s-${var.aws_cluster_name}-0${count.index + 1}"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = 200
  }

  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sdf"
    volume_size           = 400
  }

  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sdg"
    volume_size           = 400
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("~/accuinsight.pem")
  }

  #  provisioner "file" {
  #    source      = "files"
  #    destination = "/tmp"
  #  }

  #  provisioner "remote-exec" {
  #    inline = [
  #      "sudo mv /tmp/files/config/sshd_config /etc/ssh/sshd_config",
  #      "sudo systemctl restart sshd",
  #      "echo 'root:AccuInsight*0' | sudo chpasswd",
  #      "echo 'ec2-user:AccuInsight*0' | sudo chpasswd"
  #    ]
  #  }

  #  provisioner "local-exec" {
  #    command = "sshpass -p'AccuInsight*0' ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ec2-user@${self.public_ip}"
  #  }

  provisioner "remote-exec" {
    inline = [
      "echo Prepare for NFS export directory",
      "sudo mkdir /nfs; sudo chmod 777 /nfs",
    ]
  }
}

#
# Create Kubespray Inventory File
#
data "template_file" "inventory" {
  template = file("${path.module}/files/template/inventory.tpl")

  vars = {
    list_connstr_master = join("\n",
      formatlist(
        "%s ansible_host=%s ansible_user=ec2-user private_ip=%s",
        aws_instance.k8s-master.*.tags.Name,
        aws_instance.k8s-master.*.public_ip,
        aws_instance.k8s-master.*.private_ip
      )
    )
    list_connstr_worker = join("\n",
      formatlist(
        "%s ansible_host=%s ansible_user=ec2-user private_ip=%s",
        aws_instance.k8s-worker.*.tags.Name,
        aws_instance.k8s-worker.*.public_ip,
        aws_instance.k8s-worker.*.private_ip
      )
    )
    list_connstr_multi = join("\n",
      formatlist(
        "%s ansible_host=%s ansible_user=ec2-user private_ip=%s",
        aws_instance.k8s-multi.*.tags.Name,
        aws_instance.k8s-multi.*.public_ip,
        aws_instance.k8s-multi.*.private_ip
      )
    )
    list_connstr_gpu = join("\n",
      formatlist(
        "%s ansible_host=%s ansible_user=ec2-user private_ip=%s",
        aws_instance.k8s-gpu.*.tags.Name,
        aws_instance.k8s-gpu.*.public_ip,
        aws_instance.k8s-gpu.*.private_ip
      )
    )
    list_connstr_nfs = join("\n",
      formatlist(
        "%s ansible_host=%s ansible_user=ec2-user private_ip=%s",
        aws_instance.k8s-nfs.*.tags.Name,
        aws_instance.k8s-nfs.*.public_ip,
        aws_instance.k8s-nfs.*.private_ip
      )
    )
    list_connstr_alb = join("\n",
      formatlist(
        "%s ansible_host=%s ansible_user=ec2-user private_ip=%s",
        aws_instance.k8s-lb.*.tags.Name,
        aws_instance.k8s-lb.*.public_ip,
        aws_instance.k8s-lb.*.private_ip
      )
    )
    list_master = join("\n", aws_instance.k8s-master.*.tags.Name)
    list_worker = join("\n", aws_instance.k8s-worker.*.tags.Name)
    list_multi  = join("\n", aws_instance.k8s-multi.*.tags.Name)
    list_gpu    = join("\n", aws_instance.k8s-gpu.*.tags.Name)
    list_nfs    = join("\n", aws_instance.k8s-nfs.*.tags.Name)
    list_alb    = join("\n", aws_instance.k8s-lb.*.tags.Name)
  }
}

resource "null_resource" "inventory" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ${var.inventory_file}"
  }

  triggers = {
    template = data.template_file.inventory.rendered
  }
}

