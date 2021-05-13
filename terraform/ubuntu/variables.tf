variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Key"
}

variable "AWS_DEFAULT_REGION" {
  description = "AWS Region"
}

# General Cluster Settings

variable "aws_cluster_name" {
  description = "Name of AWS Cluster"
}

#
# Official Ubuntu Version
#
variable "aws_os" {
  description = "OS"
}

variable "aws_ubuntu_version" {
  description = "Officail Ubuntu Version"
}

#
# AWS EC2 Settings
# The number should be divisable by the number of used
# AWS Availability Zones without an remainder.
#
variable "aws_kube_lb_type" {
  description = "EC2 Instance Type of LB Host"
}

variable "aws_kube_lb_num" {
  description = "Number of LB"
}

variable "aws_kube_nfs_type" {
  description = "Instance type of Kubernetes NFS Nodes"
}

variable "aws_kube_nfs_num" {
  description = "Number of Kubernetes NFS Nodes"
}

variable "aws_kube_master_type" {
  description = "Instance type of Kube Master Nodes"
}

variable "aws_kube_master_num" {
  description = "Number of Kubernetes Master Nodes"
}

variable "aws_kube_worker_type" {
  description = "Instance type of Kubernetes Worker Nodes"
}

variable "aws_kube_worker_num" {
  description = "Number of Kubernetes Worker Nodes"
}

variable "aws_kube_gpu_type" {
  description = "Instance type of Kubernetes GPU Nodes"
}

variable "aws_kube_gpu_num" {
  description = "Number of Kubernetes GPU Nodes"
}

variable "aws_kube_multi_type" {
  description = "Instance type of Kubernetes Multipurpose Nodes"
}

variable "aws_kube_multi_num" {
  description = "Number of Kubernetes Multipurpose Nodes"
}

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(any)
}

variable "inventory_file" {
  description = "Where to store the generated inventory file"
}

variable "private_key" {
  description = "private_key"
}

