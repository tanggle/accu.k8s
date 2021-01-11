# AccuInsight+ Kubernetes 배포

- [AccuInsight+ Kubernetes 배포](#accuinsight-kubernetes-배포)
  - [배포를 위한 준비](#배포를-위한-준비)
    - [Ansible Managed 노드에서의 준비](#ansible-managed-노드에서의-준비)
    - [Ansible Control 노드에서의 준비](#ansible-control-노드에서의-준비)
  - [배포를 위한 설정](#배포를-위한-설정)
    - [AccuInsight+ Kubernetes 인벤토리 작성](#accuinsight-kubernetes-인벤토리-작성)
    - [AccuInsight+ Kubernetes 상세옵션 설정](#accuinsight-kubernetes-상세옵션-설정)
  - [배포를 위한 파일](#배포를-위한-파일)
  - [배포를 위한 확인](#배포를-위한-확인)
  - [배포](#배포)

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

