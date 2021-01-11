# **AccuInsight+ Kubernetes**

- [**AccuInsight+ Kubernetes**](#accuinsight-kubernetes)
  - [AccuInsight+ Kubernetes 개요](#accuinsight-kubernetes-개요)
  - [AccuInsight+ Kubernetes 특징](#accuinsight-kubernetes-특징)
  - [AccuInsight+ Kubernetest 요구사양](#accuinsight-kubernetest-요구사양)
    - [운영체제 지원](#운영체제-지원)
    - [하드웨어 스펙](#하드웨어-스펙)
    - [저장공간 스펙](#저장공간-스펙)
    - [네트워크 포트](#네트워크-포트)
- [**AccuInsight+ Kubernetes 배포**](#accuinsight-kubernetes-배포)
  - [배포를 위한 준비](#배포를-위한-준비)
    - [Ansible Managed 노드에서의 준비](#ansible-managed-노드에서의-준비)
    - [Ansible Control 노드에서의 준비](#ansible-control-노드에서의-준비)
  - [배포를 위한 설정](#배포를-위한-설정)
    - [AccuInsight+ Kubernetes 인벤토리 작성](#accuinsight-kubernetes-인벤토리-작성)
    - [AccuInsight+ Kubernetes 상세옵션 설정](#accuinsight-kubernetes-상세옵션-설정)
  - [배포를 위한 파일](#배포를-위한-파일)
  - [배포를 위한 확인](#배포를-위한-확인)
  - [배포](#배포)
- [**AccuInsight+ Kubernetes 설정**](#accuinsight-kubernetes-설정)
  - [Kubernetes 환경 설정](#kubernetes-환경-설정)
  - [Kubernetes 노드 설정](#kubernetes-노드-설정)
  - [Kubernetes 기본 설정](#kubernetes-기본-설정)
  - [Kubernetes 컨테이너 런타임 설정](#kubernetes-컨테이너-런타임-설정)
  - [Kubernetes 컨테이너 네트워크 설정](#kubernetes-컨테이너-네트워크-설정)
- [**AccuInsight+ Kubernetes 컴포넌트**](#accuinsight-kubernetes-컴포넌트)
  - [AccuInsight+ GPU Accelerator](#accuinsight-gpu-accelerator)
    - [AccuInsight+ GPU Acclerator 설정](#accuinsight-gpu-acclerator-설정)
  - [AccuInsight+ Ingress Controller](#accuinsight-ingress-controller)
    - [AccuInsight+ Ingress Controller 설정](#accuinsight-ingress-controller-설정)
  - [AccuInsight+ Load Balancer](#accuinsight-load-balancer)
    - [AccuInsight+ Load Balancer 설정](#accuinsight-load-balancer-설정)
  - [AccuInsight+ Metrics Server](#accuinsight-metrics-server)
    - [AccuInsight+ Metrics Server 설정](#accuinsight-metrics-server-설정)
    - [AccuInsight+ Metrics Server 사용](#accuinsight-metrics-server-사용)
  - [AccuInsight+ Storage NFS](#accuinsight-storage-nfs)
    - [AccuInsight+ Storage NFS 설정](#accuinsight-storage-nfs-설정)
  - [AccuInsight+ Storage Ceph](#accuinsight-storage-ceph)
    - [AccuInsight+ Storage Ceph 설정](#accuinsight-storage-ceph-설정)
    - [AccuInsight+ Storage Ceph 스토리지 클래스](#accuinsight-storage-ceph-스토리지-클래스)
    - [AccuInsight+ Storage Ceph 사용](#accuinsight-storage-ceph-사용)
  - [AccuInsight+ NFS Provisioner](#accuinsight-nfs-provisioner)
    - [AccuInsight+ NFS Provisioner 설정](#accuinsight-nfs-provisioner-설정)
  - [AccuInsight+ Monitoring](#accuinsight-monitoring)
    - [AccuInsight+ Monitoring 설정](#accuinsight-monitoring-설정)
    - [AccuInsight+ Monitoring 사용](#accuinsight-monitoring-사용)
  - [AccuInsight+ Container Registry](#accuinsight-container-registry)
    - [AccuInsight+ Container Registry 설정](#accuinsight-container-registry-설정)
    - [AccuInsight+ Container Registry 사용](#accuinsight-container-registry-사용)
  - [AccuInsight+ Chart Registry](#accuinsight-chart-registry)
    - [AccuInsight+ Chart Registry 설정](#accuinsight-chart-registry-설정)
    - [AccuInsight+ Chart Registry 사용](#accuinsight-chart-registry-사용)
  - [AccuInsight+ Package Repository](#accuinsight-package-repository)
    - [AccuInsight+ Package Repository 설정](#accuinsight-package-repository-설정)
  - [AccuInsight+ K8S Tools](#accuinsight-k8s-tools)
    - [AccuInsight+ K8S Tools 프롬프트](#accuinsight-k8s-tools-프롬프트)
    - [AccuInsight+ K8S Tools 컨텍스트 & 네임스페이스](#accuinsight-k8s-tools-컨텍스트--네임스페이스)

## AccuInsight+ Kubernetes 개요

AccuInsight+ 솔루션을 On-premises 환경에서 안정적으로 운영하기 위한 오픈소스 Kubernetes 및 필수 인프라 스트럭쳐를 포함하는 통합 플랫폼이며, 외부 네트워크와 단절된 (Air-gapped) 환경에서도 배포가 적합하게 구현되어 있습니다.

순수 오픈소스 Kubernete 에서는 정의만 있는 인터페이스에 대한 구현체를 통합합니다.

- 컨테이너 런타임 인터페이스 (CRI)
- 컨테이너 네트웍 인터페이스 (CNI)
- 컨테이너 스토리지 인터페이스 (CSI)
- 쿠버네티스 인그레스 인터페이스 (Ingress)

Kubernetes 환경의 필수 운영 요소를 제공합니다.

- GPU 하드웨어 가속 지원
- 소프트웨어 로드밸런서
- 컨테이너 이미지 및 차트 저장소
- 컨테이너 모니터링

> 현재 GPU는 NVIDIA 하드웨어만 지원합니다.

Air-gapped 환경의 필수 운영 요소를 제공합니다.

- 운영체제 패키지 저장소
  - Ubuntu
  - CentOS
  - RHEL

> Ubuntu 저장소는 현재 구현중입니다.

## AccuInsight+ Kubernetes 특징

지속적인 소프트웨어 배포와 유지보수를 고려하여 Ansible로 구현되어 있습니다. 멱등성(Idempotency)이 보장되며 신뢰할 수 있는 저장소로 버전관리 (Infrastructure as Code)가 가능합니다. 현재 2가지 방식으로 배포가 가능합니다.

- kubespray
  - 유명한 오픈소스 커뮤니티의 코드로 범용성이 좋음
  - 오픈소스 커뮤니티 산출물 특성상 일관성이 부족
  - 과도한 복잡성으로 코드 수정 및 버전 관리가 어려움
- kubeadm
  - 범용성보다 AccuInsight+ 운영에 특화된 간결한 코드로 장애 대처에 용이
  - Kubernetes 공식 배포방식으로 신속한 유지보수와 표준성을 보장
  - 공식 패키지(OS 패키지 및 Helm 패키지)만을 사용하여 일관성 보장

> kubeadm 방식을 권장합니다.

## AccuInsight+ Kubernetest 요구사양

### 운영체제 지원

 | 운영체제 |     버전      | 비고                   |
 | -------- | :-----------: | ---------------------- |
 | Ubuntu   | 18.04 / 20.04 | LTS                    |
 | CentOS   |   7.8 / 8.2   | 스트림별 현재 안정버전 |
 | RHEL     |   7.8 / 8.2   | 스트림별 현재 안정버전 |


> x86_64 아키텍쳐만 지원하며, 물리머신 또는 VM머신(AWS EC2포함)은 무관합니다.


### 하드웨어 스펙

 | 노드          | 권장 (CPU/RAM) | 최소 (CPU/RAM) | 비고                                                       |
 | ------------- | -------------- | -------------- | ---------------------------------------------------------- |
 | K8S Master    | 4 / 16G        | 2 / 8G         | K8S 순수 컨트롤 플레인만 해당 (30노드 이하)                |
 | K8S Worker    | 8 / 32G        | 4 / 16G        | K8S 순수 검포넌트만 해당 (컨트롤러, 저장소, 모니터링, ...) |
 | Storage Ceph  | 4 / 16G        | 2 / 8G         | 개별 노드로 분리할 경우                                    |
 | Storage NFS   | 2 / 16G        | 2 / 8G         | 개별 노드로 분리할 경우                                    |
 | Load Balancer | 2 / 8G         | 2 / 4G         | 개별 노드로 분리할 경우                                    |


> 30노드 이하의 Kubernetes 플랫폼이 원활히 작동하기 위한 사양이며, 비지니스 워크로드는 제외입니다.


### 저장공간 스펙


| 구분          | 파티션          | 권장   | 최소   | 비고                               |
| ------------- | --------------- | ------ | ------ | ---------------------------------- |
| 클러스터 노드 | /var/lib/docker | 1 TB   | 500 GB | CRI Images and Container Ephemeral |
|               | /var/lib/kublet | 1 TB   | 500 GB | K8S Container Ephemeral            |
| 스토리지 노드 | RAW 디스크      | 적당량 | 적당량 | 고객 데이터                        |

> 파티션 위치는 선택한 CRI에 따라 상이할 수 있습니다.


### 네트워크 포트

| 프로토콜 | 포트 범위   | 용도                          |
| -------- | ----------- | ----------------------------- |
| TCP      | 6443        | Kubernetes API Server         |
| TCP      | 2379-2381   | ETCD                          |
| TCP      | 10250       | Kubelet API                   |
| TCP      | 10251,10259 | Kubernetes Scheduler          |
| TCP      | 10252,10257 | Kubernetes Controller Manager |
| TCP      | 10249       | Kube Proxy                    |
| TCP      | 30000-32767 | Service, NodePort             |

> Kubernetes 노드 간에는 모든 통신이 가능하도록 방화벽 해제가 권장됩니다.





# **AccuInsight+ Kubernetes 배포**

Kubernetes 공식 배포툴인 kubeadm을 이용하여 배포합니다. 모든 바이너리는 제공자(Kubernetes, Docker 등등)의 공식 저장소에서 운영체제 패키지를 통해 설치하며, 기타 컴포넌트도 공식 저장소 (Helm)에서 제공하는 순수 버전을 사용합니다.

## 배포를 위한 준비

- Ansible Managed 노드들은 작업을 수행할 `사용자` 계정이 존재해야 합니다.
- Ansible Managed 노드의 `사용자`는 패스워드 없이 sudo 명령 사용이 가능해야 합니다.
- Ansible Control 노드는 모든 Ansible Managed 노드의 `사용자`로 SSH 접근이 가능해야 합니다.

### Ansible Managed 노드에서의 준비

- 사용자 생성
```bash
$ sudo adduser accuinsight
```
- sudo 허용
```bash
$ echo "accuinsight ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/accuinsight
```

### Ansible Control 노드에서의 준비
- SSH 허용
```bash
$ ssh-copy-id -i accuinsight.pub accuinsight@<IP-ADDR-OF-MANAGED-NODE>
```
> ssh-copy-id 명령을 수행하기 위해서는 Ansible Managed 노드는 패스워드를 통한 SSH 접근이 가능해야 합니다. 위의 명령이 실패할 경우, accuinsight.pub 파일을 모든 Ansible Managed 노드로 복사하고 `사용자`로 아래의 명령을 수행합니다.
>
>```bash
>$ cat accuinsight.pub >> ~/.ssh/authorized_keys
>```

- Ansible 설치

  - RHEL 또는 CentOS
  ```bash
  $ sudo yum install ansible
  ```
  - Ubuntu
  ```
  $ sudo apt update
  $ sudo apt install software-properties-common
  $ sudo apt-add-repository --yes --update ppa:ansible/ansible
  $ sudo apt install ansible
  ```

## 배포를 위한 설정

- AccuInsight+ Kubernetes 인벤토리 작성
- AccuInsight+ Kubernetes 상세옵션 설정

### AccuInsight+ Kubernetes 인벤토리 작성

인벤토리 파일 위치는 `inventory/accuinsight/hosts`이며, 아래의 샘플을 참고합니다.

```ini
# 모든 호스트 목록
#
# 형식: <hostname> ansible_host=<IP> ansible_user=<USER> private_ip=<IP>
#
# <hostname>:
# 배포 과정에서 지정한 이름이 호스트 이름으로 설정됩니다.
#
# ansible_host:
# Control 에서 SSH로 연결할 Managed 노드의 주소를 설정합니다.
#
# ansible_user:
# Control 에서 SSH로 연결할 Managed 노드의 사용자를 설정합니다.
#
# private_ip:
# Kubernetes 노드간 통신할 내부 주소를 지정합니다.
#
# 참고: Ansible Control 노드와 Managed 노드가 동일한 네트워크에 있다면
#      ansible_host 와 private_ip 는 동일하게 지정할 수 있습니다.
#
accu-k8s-m01 ansible_host=13.125.0.10 ansible_user=accuinsight private_ip=172.31.0.10
accu-k8s-m02 ansible_host=13.125.0.11 ansible_user=accuinsight private_ip=172.31.0.11
accu-k8s-m03 ansible_host=13.125.0.12 ansible_user=accuinsight private_ip=172.31.0.12
accu-k8s-w01 ansible_host=13.125.0.13 ansible_user=accuinsight private_ip=172.31.0.13
accu-k8s-w02 ansible_host=13.125.0.14 ansible_user=accuinsight private_ip=172.31.0.14
accu-k8s-w03 ansible_host=13.125.0.15 ansible_user=accuinsight private_ip=172.31.0.15
accu-k8s-x01 ansible_host=13.125.0.16 ansible_user=accuinsight private_ip=172.31.0.16

# 수정 금지
[kube-cluster:children]
kube-master
kube-worker

# Kubernetes Master로 설정될 호스트 목록
#
# 최소 3개 이상을 나열해야하며, 정족수를 충족하기 위해 홀수로 지정합니다.
#
[kube-master]
accu-k8s-m01
accu-k8s-m02
accu-k8s-m03

# 수정 금지
[kube-worker:children]
accu-worker
accu-nvidia

# Kubernetes Worker로 설정될 호스트 목록
[accu-worker]
accu-k8s-w01
accu-k8s-w02
accu-k8s-w03

# NVIDIA GPU 하드웨어가 장착된 호스트 목록
#
# GPU 워크로드를 담당할 K8S Worker로 설정이 됩니다.
#
[accu-nvidia]
accu-k8s-x01

# 수정 금지
[accu-server:children]
accu-alb-server
accu-pkg-server
accu-nfs-server

# 소프트웨어 로드밸런서로 설정될 호스트 목록
#
# 하드웨어 로드밸런서가 없을 경우만 지정하며, 하드웨어 로드밸런서가 있다면 생략합니다.
#
[accu-alb-server]
accu-k8s-x01

# 운영체제 패키지 저장소로 설정될 호스트 목록
#
# 외부 네트워크와 단절된 환경 (Air-gapped) 에서 운영체제 패키기 저장소로 설정됩니다.
# 다수의 호스트를 지정하면 저장소가 HA로 구성됩니다.
#
[accu-pkg-server]
accu-k8s-x01

# NFS 서버로 설정될 호스트
#
# 하드웨어 스토리지가 없을 경우만 지정하며, 하드웨어 스토리지가 있다면 생략합니다.
# NFS의 특성상 HA구성이 불가하므로 반드시 하나의 호스트만을 지정합니다.
#
[accu-nfs-server]
accu-k8s-x01

# CEPH 스토리지로 설정될 호스트 목록
#
# 하드웨어 스토리지가 없을 경우만 지정하며, 하드웨어 스토리지가 있다면 생략합니다.
# 최소 3개 이상을 나열해야하며, 정족수를 충족하기 위해 홀수로 지정합니다.
#
[accu-ceph]
accu-k8s-w01
accu-k8s-w02
accu-k8s-w03
```

> `[섹션]`의 호스트 목록은 없을 수 있지만, `[섹션]`은 삭제하면 안됩니다.


### AccuInsight+ Kubernetes 상세옵션 설정

상세옵션 파일 위치는 `inventory/accuinsight/group_vars/all/accuinsight.yaml`입니다.

```yaml
# AccuInsight+ Kubernetes Environment ################################ BEGIN ###

# K8S Cluster 노드 OS 기본 설정: OS 업데이트
os_update: false

# K8S Cluster 노드 OS 기본 설정: OS 타임존
os_timezone: "Asia/Seoul"

# K8S 서비스 : 버전
kube_version: 1.18.8
# K8S 서비스: POD CIDR
kube_pod_cidr: 10.0.0.0/16
# K8S 서비스: SVC CIDR
kube_svc_cidr: 10.10.0.0/16
# K8S 서비스: PROXY MODE
kube_proxy_mode: iptables
# K8S 서비스: CGROUP DRIVER
kube_cgroup_driver: "{{ cri_cgroup_driver }}"

# K8S 로드밸런서: 도메인
ext_lb_fqdn: "{{ accu_load_balancer_fqdn }}"
# K8S 로드밸런서: 주소
ext_lb_addr: "{{ accu_load_balancer_addr }}"
# K8S 로드밸런서: 포트
ext_lb_port: 6443

# K8S CRI: 컨테이너 런타임 종류
kube_cri: docker
# K8S CRI: 컨테이너 런타임 버전
kube_cri_version: 19.03.11
# K8S CRI: 컨테이너 런타임 소켓위치
kube_cri_sock: /var/run/dockershim.sock

# K8S CNI: 컨테이너 네트워크 선택
kube_cni: calico

# K8S CNI: Calico MTU
cni_calico_mtu: 1440
# K8S CNI: Calico 버전
cni_calico_version: "3.15.2"
# K8S CNI: Calico iptable 백엔드
cni_calico_iptablesbackend: "Auto"

# K8S CRI 옵션: Cgroup 드라이버 선택
cri_cgroup_driver: systd
# K8S CRI 옵션: Insecure 레지스트리
cri_insecure_registries:
  - "{{ accu_registry_fqdn }}"
  - "0.0.0.0/0"

# AccuInsight+ Offline Mode
accu_offline_enabled: false
accu_offline_source: "{{ playbook_dir }}/../data.offline"
accu_offline_target: "/accuinsight/offline"
accu_service_source: "{{ playbook_dir }}/../data.service"
accu_service_target: "/accuinsight/service"

# AccuInsight+ Menifess Location
accu_manifests_location: "/etc/kubernetes/accuinsight"

# AccuInsight+ Namespace
accu_system_namespace: "accu-system"

######################################################################## END ###

# AccuInsight+ Package Repository
accu_package_repository_enabled: false
accu_package_repository_path: "/repo"
accu_package_repository_port: 1234

# AccuInsight+ K8S Tools
accu_tools_enabled: true

# AccuInsight+ Helm
accu_helm_enabled: true
accu_helm_version: "2.15.2"
accu_helm_max_history: 10

# AccuInsight+ Load Balancer
accu_load_balancer_enabled: true
accu_load_balancer_fqdn: "k8s.accuinsight.io"
accu_load_balancer_addr: "{{ hostvars[groups['accu-alb-server'][0]]['private_ip'] }}"
# Currently this is IP address of internal load balancer but should be devided for internal and external

# AccuInsight+ Metrics Server
accu_metrics_server_enabled: true
accu_metrics_server_release: "accu-metrics-server"
accu_metrics_server_version: "2.11.1"
accu_metrics_server_namespace: "{{ accu_system_namespace }}"

# AccuInsight+ Ingress Controller
accu_ingress_controller_enabled: true
accu_ingress_controller_release: "accu-ingress"
accu_ingress_controller_version: "1.41.3"
accu_ingress_controller_namespace: "{{ accu_system_namespace }}"
accu_ingress_controller_nodeport_insecure: 30080
accu_ingress_controller_nodeport_secure: 30443

# AccuInsight+ NFS Server
accu_nfs_server_enabled: true

# AccuInsight+ Rook Ceph
accu_rook_ceph_enabled: true
accu_rook_ceph_release: "accu-rook-ceph"
accu_rook_ceph_version: "1.4.2"
accu_rook_ceph_namespace: "rook-ceph"
accu_rook_ceph_node_taint: false
accu_ceph_block_storage_enabled: true
accu_ceph_object_storage_enabled: true
accu_ceph_file_storage_enabled: true
accu_ceph_storage_device_name: nvme1n1

# AccuInsight+ NFS Provisioner
accu_nfs_provisioner_enabled: true
accu_nfs_provisioner_release: "accu-nfs-provisioner"
accu_nfs_provisioner_version: "1.2.9"
accu_nfs_provisioner_namespace: "{{ accu_system_namespace }}"
accu_nfs_provisioner_server: "{{ groups['accu-nfs-server'][0] }}"
accu_nfs_provisioner_path: "/nfs"

# AccuInsight+ Docker Registry
accu_registry_enabled: true
accu_registry_release: "accu-registry"
accu_registry_version: "1.9.4"
accu_registry_namespace: "{{ accu_system_namespace }}"
accu_registry_fqdn: "images.accuinsight.io"
accu_registry_user: "dpcore"
accu_registry_pass: "dpcore"

# AccuInsight+ Chartmuseum
accu_chartmuseum_enabled: true
accu_chartmuseum_release: "accu-chartmuseum"
accu_chartmuseum_version: "2.13.2"
accu_chartmuseum_namespace: "{{ accu_system_namespace }}"
accu_chartmuseum_fqdn: "charts.accuinsight.io"
accu_chartmuseum_name: "accu-repo"
accu_chartmuseum_user: "dpcore"
accu_chartmuseum_pass: "dpcore"

# AccuInsight+ Prometheus
accu_monitoring_enabled: true
accu_monitoring_release: "accu-monitor"
accu_monitoring_version: "9.3.1"
accu_monitoring_namespace: "accu-monitor"
accu_monitoring_prometheus_fqdn: "accupc.accuinsight.io"
accu_monitoring_grafana_fqdn: "accupm.accuinsight.io"
accu_monitoring_grafana_pass: "dpcore"

# AccuInsight+ GPU Accelerator
accu_accelerator_enabled: true
accu_accelerator_namespace: "{{ accu_system_namespace }}"
accu_accelerator_node_taint: true
accu_accelerator_nvidia_type: tesla
accu_accelerator_driver_version: "418.126.02"
accu_accelerator_device_plugin_type: nvidia
accu_accelerator_driver_centos: "{{ accu_registry_fqdn }}/accu-nvidia-driver-centos:accu"
accu_accelerator_device_plugin: "{{ accu_registry_fqdn }}/accu-nvidia-device-plugin:{{ accu_accelerator_device_plugin_type }}"
accu_accelerator_device_metric: "{{ accu_registry_fqdn }}/accu-nvidia-device-metric:1.7.2"
```

## 배포를 위한 파일

| 위치         | 용도                              |
| ------------ | --------------------------------- |
| data.offline | 오프라인 배포시 필요한 파일들     |
| data.service | AccuInsight+ 서비스를 위한 파일들 |

## 배포를 위한 확인

```bash
ansible -i inventory/accuinsight/hosts all -m "ping"
```
> 에러가 발생한다면 [배포를 위한 준비](#배포를-위한-준비)와 [배포를 위한 설정](#배포를-위한-설정)을 다시 확인합니다.

## 배포

```bash
ansible-playbook -i inventory/accuinsight/hosts accuk8s.yaml --flush-cache
```





# **AccuInsight+ Kubernetes 설정**

AccuInsight+ Kubernetes 배포를 위한 상세 설정을 설명합니다. 설치환경에 맞게 수정이 필요합니다.

설정파일 위치: `inventory/accuinsight/group_vars/all/accuinsight.yaml`

```yaml
# AccuInsight+ Kubernetes Environment ################################ BEGIN ###

# K8S Cluster 노드 OS 기본 설정: OS 업데이트
os_update: false

# K8S Cluster 노드 OS 기본 설정: OS 타임존
os_timezone: "Asia/Seoul"

# K8S 서비스 : 버전
kube_version: 1.18.8
# K8S 서비스: POD CIDR
kube_pod_cidr: 10.0.0.0/16
# K8S 서비스: SVC CIDR
kube_svc_cidr: 10.10.0.0/16
# K8S 서비스: PROXY MODE
kube_proxy_mode: iptables
# K8S 서비스: CGROUP DRIVER
kube_cgroup_driver: "{{ cri_cgroup_driver }}"

# K8S 로드밸런서: 도메인
ext_lb_fqdn: "{{ accu_load_balancer_fqdn }}"
# K8S 로드밸런서: 주소
ext_lb_addr: "{{ accu_load_balancer_addr }}"
# K8S 로드밸런서: 포트
ext_lb_port: 6443

# K8S CRI: 컨테이너 런타임 종류
kube_cri: docker
# K8S CRI: 컨테이너 런타임 버전
#kube_cri_version: 19.03.11
# K8S CRI: 컨테이너 런타임 소켓위치
kube_cri_sock: /var/run/dockershim.sock

# K8S CNI: 컨테이너 네트워크 선택
kube_cni: calico

# K8S CNI: Calico MTU
cni_calico_mtu: 1440
# K8S CNI: Calico 버전
cni_calico_version: "3.15.2"
# K8S CNI: Calico iptable 백엔드
cni_calico_iptablesbackend: "Auto"

# K8S CRI 옵션: Cgroup 드라이버 선택
cri_cgroup_driver: systemd
# K8S CRI 옵션: Insecure 레지스트리
cri_insecure_registries:
  - "{{ accu_registry_fqdn }}"
  - "0.0.0.0/0"

# AccuInsight+ 오프라인 모드 환경 설정
accu_offline_enabled: false
accu_offline_source: "{{ playbook_dir }}/../data.offline"
accu_offline_target: "/accuinsight/offline"
accu_service_source: "{{ playbook_dir }}/../data.service"
accu_service_target: "/accuinsight/service"

# AccuInsight+ 메니페스트 위치
accu_manifests_location: "/etc/kubernetes/accuinsight"

# AccuInsight+ 네임스페이스
accu_system_namespace: "accu-system"

######################################################################## END ###
```

## Kubernetes 환경 설정

**`accu_offline_enabled`**

(true / **false**)

네트워크가 단절된 Air-gapped 환경에서 오프라인 설치여부를 설정합니다.

**`accu_offline_source`**

오프라인 설치시 사용될 데이터 소스 위치입니다. 기본값은 "`{{ playbook_dir }}/../data.offline`" 입니다.

**`accu_offline_target`**

오프라인 설치시 사용될 데이터 타겟(리모트) 위치입니다. 기본값은 "`/accuinsight/offline`" 입니다.

**`accu_service_source`**

AccuInsight+ 구동에 필요한 데이터 소스 위치입니다. 기본값은 "`{{ playbook_dir }}/../data.service`" 입니다.

**`accu_service_target`**

AccuInsight+ 구동에 필요한 데이터 타겟(리모트) 위치입니다. 기본값은 "`/accuinsight/service`" 입니다.

**`accu_manifests_location`**

Kubernetes 배포과정에서 생성된 Manifest 파일들이 저장될 위치입니다. 기본값은 "`/etc/kubernetes/accuinsight`" 입니다. 배포된 시점의 설정값들을 참고할 수 있습니다.

**`accu_system_namespace`**

순수 Kubernetes 외에 추가된 컴포넌트들의 네임스페이스 입니다. 기본값은 "`accu-system`" 입니다. 순수 Kubernetes 의 컴포넌트들의 네임스페이스는 "`kube-system`" 입니다.

## Kubernetes 노드 설정

**`os_update`**

(true / **false**)

Kubernetes 노드의 운영체제를 최신으로 업데이트할 것인지 설정합니다. 기본값은 "`false`" 입니다.

**`os_timezone`**

Kubernetes 노드의 타임존을 설정합니다. 기본값은 "`Asia/Seoul`" 입니다.

> 노드의 운영체제 타임존을 변경하는 것이며, Kubernetes 이벤트나 로그에 표시되는 시간, 컨테이너 내부의 시간은 변경되지 않습니다.

## Kubernetes 기본 설정

**`kube_version`**

사용할 Kubernetes 버전을 설정합니다. 지원되는 버전은 1.15.x / 1.16.x / 1.17.x / 1.18.x / 1.19.x 입니다. 온라인 모드에서는 모든 버전이 가능하며, 오프라인 모드에서는 1.15.12 / 1.16.15 / 1.17.11 / 1.18.8 / 1.19.1 중에서 선택 가능합니다. 

**`kube_pod_cidr`**

Kubernetes POD들이 사용할 서브 네트워크 범위를 설정합니다. 기본값은 "`10.0.0.0/16`" 입니다.

> 사설 네트워크의 범위와 중복되지 않고 라우팅에 문제가 없는 범위를 지정해야합니다.

**`kube_svc_cidr`**

Kubernetes Service가 사용할 서브 네트워크 범위를 설정합니다. 기본값은 "`10.10.0.0/16`" 입니다.

> 사설 네트워크의 범위와 중복되지 않고 라우팅에 문제가 없는 범위를 지정해야합니다.

**`kube_proxy_mode`**

(**iptables** / ipvs)

Kubernetes의 내부 트래픽의 라우팅을 담당하는 kube_proxy의 작동 모드를 설정합니다. 기본값은 "`iptables`" 입니다.

**`kube_cgroup_driver`**

(**systemd** / cgroupfs)

[cgroup](https://en.wikipedia.org/wiki/Cgroups) 드라이버를 선택합니다. 기본값은 "`systemd`" 입니다.

> 반드시 `cri_cgroup_driver` 값과 동일한 값을 지정해야 합니다.

> 참고: [Cgroup drivers](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#cgroup-drivers)

**`ext_lb_fqdn`**

HA로 구성된 Kubernetes API Server 앞단의 로드밸런서 도메인을 지정합니다. 기본값은 "`{{ accu_load_balancer_fqdn }}`" 으로 내부 소프트웨어 로드밸런서의 도메인 `k8s.accuinsight.io` 입니다.

> 하드웨어 로드밸런서가 있다면, 해당 정보를 지정합니다. 안정적인 성능을 위해 하드웨어 로드밸런서가 권장됩니다.

> 지정한 도메인은 API Server의 자체 서명 인증서(Self-Signed Certificate) 생성 시 서버 정보에 추가됩니다.

**`ext_lb_addr`**

HA로 구성된 Kubernetes API Server 앞단의 로드밸러서 주소를 지정합니다. 기본값은  "`{{ accu_load_balancer_addr }}`"으로 내부 소프트웨어 로드밸런서의 주소입니다.

> 하드웨어 로드밸런서가 있다면, 해당 정보를 지정합니다. 안정적인 성능을 위해 하드웨어 로드밸런서가 권장됩니다.

> 지정한 주소는 API Server의 자체 서명 인증서(Self-Signed Certificate) 생성 시 서버 정보에 추가됩니다.

**`ext_lb_port`**

HA로 구성된 Kubernetes API Server 앞단의 로드밸런서 포트를 지정합니다. 기본값은 "`6443`" 입니다.

## Kubernetes 컨테이너 런타임 설정

**`kube_cri`**

(**docker** / cri-o)

컨테이너 런타임을 설정합니다. 기본값은 "`docker`" 입니다.

**`kube_cri_version`**

`kube_cri` 에 지정한 컨테이너 런타임의 버전을 설정합니다. 온라인 모드에서는 모든 버전이 가능하며, 오프라인 모드에서는  18.09.9 / 19.03.4 / 19.03.11 / 19.03.12 중에서 선택 가능합니다. 설정을 생략하면 `kube_version` 값으로 설정된 Kubernetes 버전에서 권장하는 런타임 버전으로 자동 설치됩니다.

| kube_version | docker                                                                                                   | cri-o                                                                         |
| ------------ | -------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| 1.19         | [19.03.12](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker)           | [1.19](https://github.com/cri-o/cri-o#compatibility-matrix-cri-o--kubernetes) |
| 1.18         | [19.03.11](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker)           | [1.18](https://github.com/cri-o/cri-o#compatibility-matrix-cri-o--kubernetes) |
| 1.17         | [19.03.4](https://v1-17.docs.kubernetes.io/docs/setup/production-environment/container-runtimes/#docker) | [1.17](https://github.com/cri-o/cri-o#compatibility-matrix-cri-o--kubernetes) |
| 1.16         | [18.09.9](https://v1-16.docs.kubernetes.io/docs/setup/production-environment/container-runtimes/#docker) | [1.16](https://github.com/cri-o/cri-o#compatibility-matrix-cri-o--kubernetes) |
| 1.15         | [18.09.9](https://v1-15.docs.kubernetes.io/docs/setup/production-environment/container-runtimes/#docker) | [1.15](https://github.com/cri-o/cri-o#compatibility-matrix-cri-o--kubernetes) |


**`kube_cri_sock`**

Kubelet이 컨테이너 런타밍과 통신하기 위한 유닉스 도메인 소켓 위치를 지정합니다.

| 런타임 | 유닉스 도메인 소켓       |
| ------ | ------------------------ |
| docker | /var/run/dockershim.sock |
| cri-o  | /var/run/crio/crio.sock  |

> 참고: [Runtime Unix Domain Socket](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-runtime)

**`cri_cgroup_driver`**

(**systemd** /cgroupfs)

[cgroup](https://en.wikipedia.org/wiki/Cgroups) 드라이버를 선택합니다. 기본값은 "`systemd`" 입니다.

> 반드시 `kube_cgroup_driver` 값과 동일한 값을 지정해야 합니다

> 참고: [Cgroup drivers](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#cgroup-drivers)

**`cri_insecure_registries`**

컨테이너 런타임에서 접근을 허용할 HTTP (Insecure) 저장소를 나열합니다. 기본값은 "`{{ accu_registry_fqdn }}`"이며 내부 이미지 저장소의 도메인입니다. "`0.0.0.0/0`"을 설정하면  모든 HTTP (Insecure) 저장소가 허용됩니다.

> 참고: [Insecure Registry](https://docs.docker.com/registry/insecure/#deploy-a-plain-http-registry)

## Kubernetes 컨테이너 네트워크 설정

**`kube_cni`**

컨테이너 네트워크 플러그인을 지정합니다. 현재는 [calico](https://www.projectcalico.org/) 만 사용할 수 있습니다.

**`cni_calico_mtu`**

컨테이너 네트워크 플러그인에서 사용할 [MTU](https://en.wikipedia.org/wiki/Maximum_transmission_unit)값을 설정합니다. 기본값은 `1440` 이며, 네트워크 환경(물리머신, 가상머신, GCE, AWS)에 맞게 설정하면 네트워크 성능이 향상됩니다.

> 참고: [Configure MTU to maximize network performance](https://docs.projectcalico.org/networking/mtu)

**`cni_calico_version`**

Calico 컨테이너 네트워크 플러그인 버전을 설정합니다. 온라인 모드에서는 모든 버전이 가능하며, 오프라인 모드에서는 `3.15.2` 만 선택 가능합니다.

**`cni_calico_iptablesbackend`**

(Legacy / NFT / **Auto**)

Calico 컨테이너 네트워크 플러그인에서 사용할 iptables 모드를 설정합니다. 기본값은 "`Auto`" 입니다. 최근의 Linux 배포본(RHEL 8 / CentOS 8)에 포함된 iptables v1.8 부터는 내부로직이 변경되어 현시점에서 정상 작동하는 CNI는 Calico 뿐입니다. Linux 배포본 버전간의 호환을 위해 반드시 "`Auto`" 로 설정합니다.




# **AccuInsight+ Kubernetes 컴포넌트**

## AccuInsight+ GPU Accelerator

AccuInsight+ 서비스에서 GPU 가속을 사용하기 위한 설정입니다. 현재는 NVIDIA 하드웨어(GTX / Tesla) 만을 지원합니다.

인벤토리 설정파일의 `[accu-nvidia]` 섹션에 나열한 호스트들이 GPU 노드로 구성됩니다.

```yaml
# AccuInsight+ GPU Accelerator
accu_accelerator_enabled: true
accu_accelerator_namespace: "accu-system"
accu_accelerator_node_taint: true
accu_accelerator_nvidia_type: tesla # tesla or gtx
accu_accelerator_driver_version: "418.126.02"
accu_accelerator_device_plugin_type: nvidia # google or nvidia
accu_accelerator_driver_centos: "{{ accu_registry_fqdn }}/accu-nvidia-driver-centos:accu"
accu_accelerator_driver_ubuntu: "{{ accu_registry_fqdn }}/accu-nvidia-driver-ubuntu:accu"

accu_accelerator_device_plugin: "{{ accu_registry_fqdn }}/accu-nvidia-device-plugin:{{ accu_accelerator_device_plugin_type }}"
accu_accelerator_device_metric: "{{ accu_registry_fqdn }}/accu-nvidia-device-metric:1.7.2"
```

### AccuInsight+ GPU Acclerator 설정

**`accu_accelerator_enabled`**

(**true** / false)

AccuInsight+ GPU Accelerator 구성여부를 설정합니다.

**`accu_acclerator_namespace`**

AccuInsight+ GPU Accelerator 가 배포될 네임스페이스를 지정합니다. 기본값은 "`accu-system`" 입니다.

**`accu_accelerator_node_taint`**

(**true** / false)

GPU 하드웨어가 장착된 노드가 GPU 워크로드만을 수용할지 여부를 설정합니다. 기본값은 "`true`" 이며, 이 경우 GPU 워크로드만을 위한 전용 노드로 설정됩니다.

> GPU 하드웨어가 장작된 노드에 Kubernetes Taint 설정을 합니다. 일반 비지니스 워크로드로 인한 CPU / Memory 점유로 GPU 워크로드가 스케쥴링 되지 못하는 것을 방지합니다. CPU / Memory 가 충분하다면, 효율적인 리소스 사용을 위해 "`false`"로 설정 가능합니다.

**`accu_accelerator_nvidia_type`**

(gtx / tesla)

NVIDIA 하드웨어 플랫폼 타입을 지정합니다.

**`accu_accelerator_driver_version`**

사용할 NVIDIA 드라이버 버전을 지정합니다. 사용하는 CUDA 버전에 맞는 드라이버 버전을 지정합니다.

| CUDA Toolkit          | Linux x86_64 Driver Version |
| --------------------- | --------------------------- |
| CUDA 11.1 (11.1.0)    | >= 455.23.04                |
| CUDA 11.0 (11.0.171)  | >= 450.36.06                |
| CUDA 10.2 (10.2.89)   | >= 440.33                   |
| CUDA 10.1 (10.1.105)  | >= 418.39                   |
| CUDA 10.0 (10.0.130)  | >= 410.48                   |
| CUDA 9.2 (9.2.88)     | >= 396.26                   |
| CUDA 9.1 (9.1.85)     | >= 390.46                   |
| CUDA 9.0 (9.0.76)     | >= 384.81                   |
| CUDA 8.0 (8.0.61 GA2) | >= 375.26                   |
| CUDA 8.0 (8.0.44)     | >= 367.48                   |
| CUDA 7.5 (7.5.16)     | >= 352.31                   |
| CUDA 7.0 (7.0.28)     | >= 346.46                   |


> 참고: [CUDA Compatibility](https://docs.nvidia.com/deploy/cuda-compatibility/index.html)

**`accu_accelerator_device_plugin_type`**

(**nvidia** / google)

NVIDIA 디바이스 플러그인 타입을 지정합니다. 기본값은 "`nvidia`" 입니다.

- nvidia
  - CentOS / RHEL / Ubuntu 지원
  - GPU 노드에 커널 헤더 및 빌드를 위한 패키지 설치함
  - GPU 노드에서 드라이버를 직접 설치하고 드라이버 모듈을 빌드하여 노드에서 사용
  - GPU 리소스 모니터링 (DCGM Exporter) 지원
- google
  - CentOS / Ubuntu 지원 (`RHEL 미지원`)
  - GPU 노드에 추가적인 패키지 설치 없음
  - POD 내부에서 드라이버 모듈을 빌드하여 노드에서 사용
  - GPU 리소스 모니터링 (DCGM Exporter) `미지원`

> 참고: [Kubernetes GPU Support](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/#deploying-nvidia-gpu-device-plugin)

> 참고: [DCGM exporter](https://github.com/NVIDIA/gpu-monitoring-tools)

**`accu_accelerator_driver_centos`** (수정 금지)

`google` 타입에서 드라이버 모듈 빌드에 사용할 CentOS 이미지를 지정합니다.


**`accu_accelerator_driver_ubuntu`** (수정 금지)

`google` 타입에서 드라이버 모듈 빌드에 사용할 Ubuntu 이미지를 지정합니다.

**`accu_accelerator_device_plugin`** (수정 금지)

GPU 가속 지원을 위한 디바이스 플러그인 이미지를 지정합니다.

**`accu_accelerator_device_metric`** (수정 금지)

GPU 리소스 모니터링을 위한 DCGM Exporter 이미지를 지정합니다.




## AccuInsight+ Ingress Controller

Ingress Controller는 Kubernetes 네트웍 외부에서의 요청을 내부 서비스로 라우팅해주는 Layer 7 Switch 역할을 수행합니다. Nginx 기반의 Reverse Proxy 로 Ingress 리소스의 정의대로 내부 서비스로 라우팅해줍니다. 라우팅 경로는 `로드밸런서 > K8S NODEPORT > K8S SERVICE > K8S POD` 입니다. 다음과 같은 설치옵션을 제공합니다.

```yaml
# AccuInsight+ Ingress Controller
accu_ingress_controller_enabled: true
accu_ingress_controller_release: "accu-ingress"
accu_ingress_controller_version: "1.41.3"
accu_ingress_controller_namespace: "accu-system"
accu_ingress_controller_nodeport_insecure: 30080
accu_ingress_controller_nodeport_secure: 30443
```

### AccuInsight+ Ingress Controller 설정

**`accu_ingress_controller_enabled`**

(**true** / false)

Ingress Controller를 구성여부를 설정합니다.

**`accu_ingress_controller_release`**

Helm 을 통해 표시될 릴리즈 이름을 설정합니다.

**`accu_ingress_controller_version`**

Helm 차트 버전을 설정합니다. 오프라인 모드에서는 "`1.41.3`"만 선택 가능합니다.

**`accu_ingress_controller_namespace`**

Ingress Controller 가 배포될 네임스페이스를 지정합니다. 기본적으로 AccuInsight+ 컨트롤러는 "`accu-system`" 네임스페이스에 배포됩니다.

**`acc_ingress_controller_nodeport_insecure`**

Ingress Controller가 사용할 HTTP 서비스의 NodePort를 지정합니다. 30000 부터 32767 범위헤서 사용하지 않는 포트를 지정합니다. 기본값은 "`30080`" 입니다.

**`accu_ingress_controller_nodeport_secure`**

Ingress Controller가 사용할 HTTPS 서비스의 NodePort를 지정합니다. 3000 부터 32767 범위에서 사용하지 않는 포트를 지정합니다. 기본값은 "`30443`" 입니다.




## AccuInsight+ Load Balancer

별도의 로드밸런서가 없을 경우 사용할 수 있는 소프트웨어 로드밸런서 입니다. HA로 구성된 Kubernetes API Server 및 Ingress Controller 의 트래픽을 가용한 서버로 분배합니다. 오픈소스 소프트웨어인 HAProxy 가 부하분산을 담당하며, Keepalived 로 HAProxy 자체의 가용성을 보장합니다. 보다 나은 퍼포먼스를 위해서 하드웨어 로드밸런서 사용을 권장합니다.

인벤토리 설정파일의 `[accu-alb-server]` 섹션에 나열한 호스트들이 로드밸런서 서버로 구성됩니다.

```yaml
# AccuInsight+ Load Balancer
accu_load_balancer_enabled: true
accu_load_balancer_keepalived: false
accu_load_balancer_fqdn: "k8s.accuinsight.io"
accu_load_balancer_virtualip: "xxx.xxx.xxx.xxx"
```

### AccuInsight+ Load Balancer 설정

**`accu_load_balancer_enabled`**

(**true** / false)

Load Balancer 구성여부를 설정합니다.

(true / **false**)

**`accu_load_balancer_keepalived`**

Load Balancer 자체의 가용성 보장을 위한 keepalived 구성여부를 서정합니다.

> keepalived 를 구성하기 위해서는 네트워크 관리자가 `Virtual IP`를 제공해야하며, 모든 로드밸런서는 반드시 동일한 서브 네트워크에서 운영되어야 합니다.

**`accu_load_balancer_fqdn`**

Kubernetes API Server의 도메인을 지정합니다. 이 값은 Kubernetes 배포시 자동생성되는 인증서의 SAN (Subject Alternative Name) 목록에 포합니다.

**`accu_load_balancer_virtualip`**

Load Balancer 가 사용할 `Virtual IP`를 지정합니다. 이 값은 Kubernetes 배포시 자동생성되는 인증서의 SAN (Subject Alternative Name) 목록에 포합니다.




## AccuInsight+ Metrics Server

Kubernetes HPA (Horizontal Pod Autoscaling)를 위해 노드 및 컨테이너의 리소스 사용률 정보를 제공하는 메트릭스 서버를 설정합니다.

```yaml
accu_metrics_server_enabled: true
accu_metrics_server_release: "accu-metrics-server"
accu_metrics_server_version: "2.11.1"
accu_metrics_server_namespace: "accu-system"
```

### AccuInsight+ Metrics Server 설정

**`accu_metrics_server_enabled`**

(**true** / false)

Metrics Server 구성여부를 설정합니다

**`accu_metrics_server_release`**

Helm 을 통해 표시될 릴리즈 이름을 설정합니다.

**`accu_metrics_server_version`**

Helm 차트 버전을 설정합니다. 오프라인 모드에서는 "`2.11.1`"만 선택 가능합니다.

**`accu_metrics_server_namespace`**

Metrics Server 서비스가 배포될 네임스페이스를 지정합니다. 기본값은 "`accu-system`" 입니다.

### AccuInsight+ Metrics Server 사용

아래의 명령으로 노드 및 컨테이너의 상태를 확인할 수 있습니다.

```bash
kubectl top nodes
kubectl top pods 
```




## AccuInsight+ Storage NFS

별도의 스토리지가 없을 경우 사용할 수 있는 NFS 서버를 제공합니다. NFS 특성상 HA 구성이 불가하여 가용성 부족합니다. 하드웨어 스토리지가 없을 경우만 사용하고, 최적을 성능을 위해서는 하드웨어 스토리지 사용을 권장합니다.

인벤토리 설정파일의 `[accu-nfs-server]` 섹션에 나열한 호스트들이 NFS 서버로 구성됩니다.

> NFS 특성상 HA 구성이 불가하며, 반드시 하나의 호스트만 지정해야 합니다.

```yaml
accu_nfs_server_enabled: true
accu_nfs_server_option: "/nfs    *(rw,sync,no_root_squash,fsid=0,no_subtree_check)"
```

### AccuInsight+ Storage NFS 설정

**`accu_nfs_server_enabled`**

(**true** / false)

NFS 서버 구성여부를 설정합니다

**`accu_nfs_server_option`**

NFS 서버가 제공할 파일시스템 위치와 Export 옵션을 설정합니다.




## AccuInsight+ Storage Ceph

Ceph 고가용성과 확장성을 제공하는 오픈소스 분산 네트워크 스토리지입니다. Kubernetes CSI (Container Storage Interface) 표준을 통한 동적 볼륨할당 (Dynaic Provisioning) 및 관리가 가능합니다. 동적으로 구성가능한 컨트롤러가 포함된 Rook-Ceph Operator 버전을 사용합니다.

인벤토리 설정파일의 `[accu-ceph]` 섹션에 나열한 호스트들이 Ceph 스토리지 서버로 구성됩니다.

> 정족수 충족을 위해 스토리지 노드는 3개 이상으로 홀수로 저정합니다.

다음과 같은 3가지 타입의 스토리지를 지원합니다.

- RBD
  - 블럭 디바이스 형식의 스토리지
  - RWO (Read Write Once) 방식으로 하나의 POD에서만 독점적으로 사용
- CEPHFS
  - 공유 파일시스템 형식의 스토리지
  - RWX (Read Write Many) 방식으로 다수의 POD에서 공유하여 사용
- OBJECT STORAGE
  - 아마존 S3 형식의 스토리지
  - RWX (Read Write Many) 방식으로 POD에서 마운트하지 않고 API로 사용

```yaml
# AccuInsight+ Rook Ceph
accu_rook_ceph_enabled: true
accu_rook_ceph_release: "accu-rook-ceph"
accu_rook_ceph_version: "1.4.2"
accu_rook_ceph_namespace: "rook-ceph"
accu_rook_ceph_node_taint: false
accu_rook_ceph_admin_fqdn: "ceph.accuinsight.io"
accu_rook_ceph_admin_pass: "dpcore"
accu_ceph_block_storage_enabled: true
accu_ceph_object_storage_enabled: true
accu_ceph_file_storage_enabled: true
accu_ceph_storage_device_name: nvme1n1
```

### AccuInsight+ Storage Ceph 설정

**`accu_rook_ceph_enabled`**

(**true** / false)

Ceph 구성여부를 설정합니다.

**`accu_rook_ceph_release`**

Helm 을 통해 표시될 릴리즈 이름을 설정합니다.

**`accu_rook_ceph_version`**

Helm 차트 버전을 설정합니다. 오프라인 모드에서는 "`1.4.2`"만 선택 가능합니다.

**`accu_rook_ceph_namespace`**

Ceph 서비스가 배포될 네임스페이스를 지정합니다. 기본값은 "`rook-ceph`" 입니다.

> rook-ceph operator 구조상 기본값 사용이 권장됩니다.

**`accu_rook_ceph_node_taint`**

(true / **false**)

Ceph 스토리지 노드가 일반 비지니스 워크로드를 수용할지 여부를 설정합니다. "`true`"로 설정할 경우, Ceph 스토리지만을 위한 전용 노드로 설정됩니다.

> 최적의 성능을 위해서는 "`true`"로 설정하여 전용 노드로 사용하길 권장합니다.

**`accu_rook_ceph_admin_fqdn`**

Ceph 스토리지 모니터링 및 관리를 위한 콘솔 도메인 이름을 지정합니다.

**`accu_rook_ceph_admin_pass`**

Ceph 스토리리 관리페이지  접근을 위한 패스워드를 지정합니다. 기본 사용자명은 "`admin`" 입니다.

**`accu_ceph_block_storage_enabled`**

RBD (블럭 디바이스) 구성 여부를 설정합니다.

**`accu_ceph_object_storage_enabled`**

S3 스토리지 구성 여부를 설정합니다.

**`accu_ceph_file_storage_enabled`**

CEPHFS(공유 파일시스템) 구성 여부를 설정합니다.

**`accu_ceph_storage_device_name`**

Ceph 스토리지로 사용할 다바이스명을 지정합니다. 지정한 디바이스명은 Ceph 를 위한 디바이스로 구성됩니다.

> `주의`: 지정된 디바이스는 저수준 포맷이 되고, **`존재하는 모든 데이터는 삭제됩니다 !!!`**

### AccuInsight+ Storage Ceph 스토리지 클래스

설정에 따라 다음과 같은 Kubernetes Storage Class 가 생성됩니다. 용도에 맞게 PVC 생성시 선택합니다.

- rook-ceph-block
  - 블럭 디바이스를 위한 스토리지 클래스
- rook-cephfs 
  - 공유 파일시스템을 위한 스토리지 클래스

### AccuInsight+ Storage Ceph 사용

모니터링을 위한 웹 인터페이스는 Ingress Controller 를 통해 도메인으로 접근합니다. 지정한 도메인이 DNS서버를 통해 Lookup 되지 않는 가상 도메인 (Unqualified Domain) 일 경우, 사용하는 운영체제의 추가 설정이 필요합니다.

| 운영체제 | 파일위치                              |
| -------- | ------------------------------------- |
| Linux    | /etc/hosts                            |
| MacOS    | /private/etc/hosts                    |
| Windows  | C:\Windows\System32\drivers\etc\hosts |

아래의 형식으로 가상 도메인을 설정합니다.

```
# IP Address       Domain Name
xxx.xxx.xxx.xxx    ceph.accuinsight.io
```

> `IP Address` 는 Load Balancer 의 IP 또는 Virtual IP를 설정하고, Domain Name 은 `accu_rook_ceph_admin_fqdn` 에 지정한 가상 도메인을 설정합니다.





## AccuInsight+ NFS Provisioner

Kubernetes CSI (Container Storage Interface) 표준으로 NFS 서버에 대한 동적 볼륨할당 (Dynaic Provisioning) 및 관리가 가능한 프로비저너를 설정합니다.

```yaml
# AccuInsight+ NFS Provisioner
accu_nfs_provisioner_enabled: true
accu_nfs_provisioner_release: "accu-nfs-provisioner"
accu_nfs_provisioner_version: "1.2.9"
accu_nfs_provisioner_namespace: "accu-system"
accu_nfs_provisioner_server: "{{ groups['accu-nfs-server'][0] }}"
accu_nfs_provisioner_path: "/nfs"
```

### AccuInsight+ NFS Provisioner 설정

**`accu_nfs_provisioner_enabled`**

NFS Provisioner 구성여부를 설정합니다

**`accu_nfs_provisioner_release`**

Helm 을 통해 표시될 릴리즈 이름을 설정합니다.

**`accu_nfs_provisioner_version`**

Helm 차트 버전을 설정합니다. 오프라인 모드에서는 "`1.4.2`"만 선택 가능합니다.

**`accu_nfs_provisioner_namespace`**

NFS Provisioner 서비스가 배포될 네임스페이스를 지정합니다. 기본값은 "`accu-system`" 입니다

**`accu_nfs_provisioner_server`**

NFS 서버의 도메인 또는 주소를 지정합니다.

**`accu_nfs_provisioner_path`**

NFS 서버에서 Export 설정된 경로를 지정합니다.

> `showmount -e 서버주소` 명령으로 서버에 설정된 Export 경로를 확인할 수 있습니다.





## AccuInsight+ Monitoring

Kubernetes 리소스 사용 모니터링을 제공합니다. Kubernetes 모니터링의 표준인 오픈소스 Prometheus 입니다. 동적으로 구성가능한 컨트롤러가 포함된 Prometheus Operator 버전을 사용합니다.

```yaml
# AccuInsight+ Monitoring
accu_monitoring_enabled: true
accu_monitoring_release: "accu-monitor"
accu_monitoring_version: "9.3.1"
accu_monitoring_namespace: "accu-monitor"
accu_monitoring_prometheus_fqdn: "accupc.accuinsight.io"
accu_monitoring_grafana_fqdn: "accupm.accuinsight.io"
accu_monitoring_grafana_pass: "dpcore
```

### AccuInsight+ Monitoring 설정

**`accu_monitoring_enabled`**

(**true** / false)

Prometheus Operator 구성여부를 설정합니다.

**`accu_monitoring_release`**

Helm 을 통해 표시될 릴리즈 이름을 설정합니다.

**`accu_monitoring_version`**

Helm 차트 버전을 설정합니다. 오프라인 모드에서는 "`9.3.1`"만 선택 가능합니다.

**`accu_monitoring_namespace`**

모니터링 서비스가 배포될 네임스페이스를 지정합니다. 기본값은 "`accu-monitor`" 입니다.

**`accu_monitoring_prometheus_fqdn`**

Prometheus 의 메트릭스 데이터를 조회하고, PromQL 을 테스트할 수 있는 콘솔의 도메인을 지정합니다.

**`accu_monitoring_grafana_fqdn`**

Grafana 접근을 위한 도메인을 지정합니다.

**`accu_monitoring_grafana_pass`**

Grafana 접근을 위한 패스워드를 지정합니다. 기본 사용자명은 "`admin`" 입니다.

### AccuInsight+ Monitoring 사용

모니터링을 위한 웹 인터페이스는 Ingress Controller 를 통해 도메인으로 접근합니다. 지정한 도메인이 DNS서버를 통해 Lookup 되지 않는 가상 도메인 (Unqualified Domain) 일 경우, 사용하는 운영체제의 추가 설정이 필요합니다.

| 운영체제 | 파일위치                              |
| -------- | ------------------------------------- |
| Linux    | /etc/hosts                            |
| MacOS    | /private/etc/hosts                    |
| Windows  | C:\Windows\System32\drivers\etc\hosts |

아래의 형식으로 가상 도메인을 설정합니다.

```
# IP Address       Domain Name
xxx.xxx.xxx.xxx    accupc.accuinsight.io
xxx.xxx.xxx.xxx    accupm.accuinsight.io
```

> `IP Address` 는 Load Balancer 의 IP 또는 Virtual IP를 설정하고, Domain Name 은 `accu_monitoring_prometheus_fqdn` 와 `accu_monitoring_grafana_fqdn` 에 지정한 가상 도메인을 설정합니다.





## AccuInsight+ Container Registry

- [AccuInsight+ Container Registry](#accuinsight-container-registry)
  - [AccuInsight+ Container Registry 설정](#accuinsight-container-registry-설정)
  - [AccuInsight+ Container Registry 사용](#accuinsight-container-registry-사용)

컨테이너 이미지를 저장할 로컬 레지스트리 서버를 구성합니다.

> 보다 원할한 서비스를 위해 `Harbor`로 교체 예정

```yaml
# AccuInsight+ Docker Registry
accu_registry_enabled: true
accu_registry_release: "accu-registry"
accu_registry_version: "1.9.4"
accu_registry_namespace: "accu-system"
accu_registry_fqdn: "images.accuinsight.io"
accu_registry_user: "dpcore"
accu_registry_pass: "dpcore"
```

### AccuInsight+ Container Registry 설정

**`accu_registry_enabled`**

(**true** / false)

Container Registry 구성여부를 설정합니다.

**`accu_registry_release`**

Helm 을 통해 표시될 릴리즈 이름을 설정합니다.

**`accu_registry_version`**

Helm 차트 버전을 설정합니다. 오프라인 모드에서는 "`1.9.4`"만 선택 가능합니다.

**`accu_registry_namespace`**

Container Registry 서비스가 배포될 네임스페이스를 지정합니다. 기본값은 "`accu-system`" 입니다.

**`accu_registry_fqdn`**

Container Registry 서비스의 접근하기 위한 도메인을 지정합니다.

> Ingress Controller를 통해 라우팅되므로 반드시 도메인을 지정해야합니다. (IP주소 불가)

**`accu_registry_user`**

Container Registry 서비스의 사용자명을 지정합니다.

**`accu_registry_pass`**

Container Registry 서비스의 패스워드를 지정합니다.

### AccuInsight+ Container Registry 사용

로컬 레지스트리는 자체 서명 인증서 (Self-signed Certificate)를 사용하며, 정상적인 사용을 위해서는 클라이언트 사이드에서 Insecure Registry로 설정해야 합니다. Docker의 경우 다음과 같이 설정합니다.

`/etc/docker/daemon.json`
```json
{
  "insecure-registries" : ["image.accuinsight.io"]
}
```

Insecure Registry 설정시 클라이언트는 다음과 같이 작동합니다.

- HTTPS로 연결시도
- HTTPS 연결은 가능하나, 인증서가 유효하지 않다면 무시하고 연결
- HTTPS 연결이 불가하면, HTTP로 연결

> 참고: [Insecure Registry](https://docs.docker.com/registry/insecure/#deploy-a-plain-http-registry)
>
> containerd, cri-o, podman 등은 해당 매뉴얼을 참고합니다.





## AccuInsight+ Chart Registry

Helm 차트를 저장할 로컬 레지스트리 서버를 구성합니다.

> 보다 원할한 서비스를 위해 `Harbor`로 교체 예정

```yaml
# AccuInsight+ Chartmuseum
accu_chartmuseum_enabled: true
accu_chartmuseum_release: "accu-chartmuseum"
accu_chartmuseum_version: "2.13.2"
accu_chartmuseum_namespace: "accu-system"
accu_chartmuseum_fqdn: "charts.accuinsight.io"
accu_chartmuseum_name: "accu-repo"
accu_chartmuseum_user: "dpcore"
accu_chartmuseum_pass: "dpcore"
```

### AccuInsight+ Chart Registry 설정

**`accu_chartmuseum_enabled`**

(**true** / false)

Chart Registry 구성여부를 설정합니다.

**`accu_chartmuseum_release`**

Helm 을 통해 표시될 릴리즈 이름을 설정합니다.

**`accu_chartmuseum_version`**

Helm 차트 버전을 설정합니다. 오프라인 모드에서는 "`2.13.2`"만 선택 가능합니다.

**`accu_chartmuseum_namespace`**

Chart Registry 서비스가 배포될 네임스페이스를 지정합니다. 기본값은 "`accu-system`" 입니다.

**`accu_chartmuseum_fqdn`**

Chart Registry 서비스의 접근하기 위한 도메인을 지정합니다.

> Ingress Controller를 통해 라우팅되므로 반드시 도메인을 지정해야합니다. (IP주소 불가)

**`accu_chartmuseum_name`**

AccuInsight+ 에서 사용되는 차트가 저장될 저장소 이름입니다.

**`accu_chartmuseum_user`**

CHart Registry 서비스의 사용자명을 지정합니다.

**`accu_chartmuseum_pass`**

Chart Registry 서비스의 패스워드를 지정합니다.

### AccuInsight+ Chart Registry 사용

차트 저장소를 접근하기 위해서는 다음과 같이 설정합니다.

- 저장소 추가
```bash
helm repo add accu-repo http://charts.accuinsight.io
```
- 차트 업로드
```bash
helm push <차트파일> <저장소 이름>
helm push mychart-0.0.1.tgz accu-repo
```

> 참고: [Helm Push Plugin](https://github.com/chartmuseum/helm-push)





## AccuInsight+ Package Repository

네트워크가 단절된 Air-gapped 환경에서 배표시 필요한 운영체제 패키지를 제공하는 저장소를 구성합니다. 운영체제 설치 이미지 및 부가 패키지를 포함합니다. 지원하는 운영체는 다음과 같습니다.

| 운영체제 |     버전      |
| -------- | :-----------: |
| CentOS   |   7.8 / 8.2   |
| RHEL     |   7.8 / 8.2   |
| Ubuntu   | 18.04 / 20.04 |

> 참고: `Ubuntu` 저장소는 구현중입니다.

인벤토리 설정파일의 `[accu-pkg-server]` 섹션에 나열한 호스트들이 Ceph 스토리지 서버로 구성됩니다.

> 다수의 호스트를 나열하면 HA로 구성됩니다.

```yaml
# AccuInsight+ Package Repository
accu_package_repository_enabled: true
accu_package_repository_path: "/repo"
accu_package_repository_port: 1234
```

### AccuInsight+ Package Repository 설정

**`accu_package_repository_enabled`**

(true / **false**)

Package Repository 구성여부를 설정합니다.

> accu_offline_enabled 설정이 "`true`"일 경우도 패키지 저장소가 구성됩니다.

**`accu_package_repository_path`**

운영체제 설치 이미지 및 부가 패키지들이 보관될 디렉토리 경로를 지정합니다.

> `15 GB` 이상의 가용공간이 필요합니다.

**`accu_package_repository_port`**

Package Repository 서버가 사용할 포트를 지정합니다. 기본값은 "`1234`"이며, 이미 사용중인 프로세스가 있는지 아래의 명령으로 확인하고, 필요시 적절한 포트로 변경합니다.

```bash
netstate -neopa | grep " LISTEN " | grep 1234
```






## AccuInsight+ K8S Tools

AccuInsight+ Kubernetes 를 편리하게 사용할 수 있는 유틸리티 셋입니다.

> K8S Master 노드에 `root` 유저로 로그인시 출력됩니다. ~/.kube/config 파일의 내용을 참고 및 변경합니다.

```yaml
# AccuInsight+ K8S Tools
accu_tools_enabled: true
```

**`accu_tools_enabled`**

(**true** / false)

AccuInsight+ Kubernetes Tools 의 사용여부를 설정합니다.

### AccuInsight+ K8S Tools 프롬프트

현재 작업중인 사용자명, 호스트명, 컨텍스트, 네임스페이스 등을 프롬프트에 직관적으로 표시합니다.

![AccuInsight+ K8S Tools](images/accu-tools.png)

> 참고: [A Powerline style prompt for your shell](https://github.com/justjanne/powerline-go)

### AccuInsight+ K8S Tools 컨텍스트 & 네임스페이스

다수의 클러스터 사이의 컨텍스트를 변경하거나, 클러스터의 네임스페이스를 변경합니다.

- kubectx

```bash
USAGE:
  kubectx                       : 등록된 컨텍스트 목록
  kubectx <NAME>                : <NAME> 컨텍스트로 변경
  kubectx -                     : 이전 컨텍스트로 변경
  kubectx -c, --current         : 현재 컨텍스트명 표시
  kubectx <NEW_NAME>=<NAME>     : 컨텍스트명을 <NAME> 에서 <NEW_NAME> 으로 변경
  kubectx <NEW_NAME>=.          : 현재 컨텍스트명을  <NEW_NAME> 으로 변경
  kubectx -d <NAME> [<NAME...>] : <NAME> 컨텍스트를 삭제
```

- kubens

```bash
USAGE:
  kubens                    : 현재 컨텍스트의 네임스페이스 표시
  kubens <NAME>             : <NAME> 네임스페이스로 변경
  kubens -                  : 이전 네임스페이스로 변경
  kubens -c, --current      : 현재 네임스페이스 표시
```

> 참고: [kubectx + kubens: Power tools for kubectl](https://github.com/ahmetb/kubectx)
스
