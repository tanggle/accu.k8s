### PLEASE CHANGE THIS TO YOUR IDENTICAL STRING ###
aws_cluster_name = "tanggle-nh-skcc"
###################################################

# Official RHEL Version
# 7.8 or 8.2
aws_redhat_version = "7.6"

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
aws_kube_master_num  = 0

# Kubernetes Worker
aws_kube_worker_type = "t3.large"
aws_kube_worker_num  = 0

# Kubernetes Multipurpose (HAPROXY, NFS, GPU)
#aws_kube_multi_type = "g3.8xlarge"
aws_kube_multi_type = "g3s.xlarge"
aws_kube_multi_num  = 2

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

inventory_file = "../../inventory/accuinsight/hosts.NH.sk"
