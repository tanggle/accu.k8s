### AWS 테스트 환경

* Terraform 요구사항

  > Terraform v0.15.3 ([Download](https://www.terraform.io/downloads.html))


* AWS 설정 (최초 한번만 실행)

  > aws configure


* EC2 설정

  - Gitbucket(accu.k8s.native)의 KEY FILE을 홈디렉토리로 복사

    > cp accuinsight.pem accuinsight.pub ~/

  - terraform.tfvars 파일에서 아래의 설정을 수정

     > \# Global Variables
     >
     > aws_cluster_name = "xxxxxxxx" > 요부분은 반드시 수정!
     >
     > \# Kubernetes Master
     >
     > aws_kube_master_type = "t3.medium"
     >
     > aws_kube_master_num  = 3 
     >
     > \# Kubernetes Worker
     >
     > aws_kube_worker_type = "t3.medium"
     >
     > aws_kube_worker_num  = 3
     >
     > \# Kubernetes Multipurpose (HAPROXY, NFS, GPU)
     >
     > aws_kube_multi_type = "g3s.xlarge"
     >
     > aws_kube_multi_num  = 1

  - terraform.tfvars 파일에서 OS 버전을 선택

    > aws_ubuntu_version = "X.X" (18.04 또는 20.04)
    >
    > awk_centos_version = "X.X" (7.8 또는 8.2)
    >
    > aws_redhat_version = "X.X" (7.8 또는 8.2)

* EC2 생성

  - Ubuntu 인스턴스 생성

    > cd ubuntu
    >
    > terraform init

  - CentOS 인스턴스 생성

    > cd centos
    >
    > terraform init

  - RHEL 인스턴스 생성

    > cd redhat
    >
    > terraform init

  > terraform apply
  >
  > region 선택 (ap-northeast-2)

  - 인스턴스 생성 후 Inventory 파일

    > Gitbucket(accu.k8s.native)/inventory/accuinsight/hosts.ubuntu
    >
    > Gitbucket(accu.k8s.native)/inventory/accuinsight/hosts.centos
    >
    > Gitbucket(accu.k8s.native)/inventory/accuinsight/hosts.redhat


* EC2 삭제

  - Ubuntu 인스턴스 삭제

    > cd ubuntu

  - CentOS 인스턴스 삭제

    > cd centos

  - RHEL 인스턴스 삭제

    > cd redhat

  > terraform destroy
  >
  > region 선택


* EC2 연결

  > ssh -i ~/accuinsight.pem **user**@ec2-ip-addr
  >
  > **user** is 'ubuntu' for Ubuntu, 'centos' for CentOS, 'ec2-user' for RHEL.

