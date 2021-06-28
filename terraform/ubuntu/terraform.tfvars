### PLEASE CHANGE THIS TO YOUR IDENTICAL STRING ###
aws_cluster_name = "tanggle-ubuntu"
###################################################

# Official Ubuntu Version
# 18.04 or 20.04
aws_ubuntu_version = "20.04"

# LB Host
aws_kube_lb_type = "t3.micro"
aws_kube_lb_num  = 0

# NFS Host
aws_kube_nfs_type = "t3.small"
aws_kube_nfs_num  = 0

# Kubernetes GPU
aws_kube_gpu_type = "g3s.xlarge"
aws_kube_gpu_num  = 0

# Kubernetes Master
aws_kube_master_type = "t3.medium"
aws_kube_master_num  = 3

# Kubernetes Worker
aws_kube_worker_type = "t3.large"
aws_kube_worker_num  = 3

# Kubernetes Multipurpose (HAPROXY, NFS, GPU)
aws_kube_multi_type = "g3s.xlarge"
aws_kube_multi_num  = 1

default_tags = {
  #  Env = "devtest"
  #  Product = "kubernetes"
}

# Global Variables
private_key = "~/accuinsight.pem"

# AWS Credentials
AWS_ACCESS_KEY_ID     = ""
AWS_SECRET_ACCESS_KEY = ""
AWS_DEFAULT_REGION    = ""

inventory_file = "../../inventory/accuinsight/hosts.ubuntu"
