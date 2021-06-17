# 쿠버네티스 테스트 방법

### 쿠버네티스 클러스터 요구사항

  - Ansible v2.9.6
  - Terraform v0.15.3 (AWS 환경의 테스트에 필요)


### 쿠버네티스 클러스터 정보

* 지원 OS (Air-gapped 환경을 위한 OS 저장소 지원)

  - RedHat 7.8 / 8.2
  - CentOS 7.8 / 8.2
  - Ubuntu 18.04 / 20.04


* 지원 K8S

  - Kubernetes 1.17.x / 1.18.x / 1.19.x / 1.20.x / 1.21.x


* 지원 CRI (Kubernetes Container Runtime Interface)

  - cri-o
  - docker
  - containerd


* 지원 CSI (Kubernetes Container Storage Interface)

  - NFS
  - Ceph (RBD, CEPHFS, OBJECT STORAGE)

* 기타 지원

  - 소프트웨어 로드밸런서 (자체 HA 지원)

### 쿠버네티스 소스

```bash
git clone https://dev.k8s.bns.co.kr:10443/sk/accuinsight.git
```
> Username: ***accuinsight***, Password: ***AccuInsight+k8s@***



### Air-gapped 환경을 위한 Ansible 환경 수집

* Python 수집

  ```bash
  $ sudo rm -rf /tmp/xxx; sudo mkdir -p /tmp/xxx/etc; sudo cp /etc/os-release /tmp/xxx/etc
  $ sudo mkdir -p /tmp/offline/python
  $ sudo yum install -y --releasever=*RELEASEVER* --installroot=/tmp/xxx --downloadonly --downloaddir=/tmp/offline/python python3 python3-pip 
  ```
  > Replace `RELEASEVER` with `7Server`(RHEL 7.x), `8Server`(RHEL 8.x), `7`(CentoS 7.x), `8`(CentOS 8.x)

* Ansible 수집

  ```bash
  $ python3 -m venv ansible
  $ source ansible/bin/activate
  $ mkdir /tmp/offline/ansible; cd /tmp/offline/ansible
  $ pip3 download pip; pip3 install pip-*.whl
  $ pip3 download ansible==2.9.6 
  ```

* 압축

  ```bash
  $ cd /tmp
  $ tar cvzf ~/ansible.offline.tar.gz offline
  ```
> 수집된 `ansible.offline.tar.gz` 파일을 고객사에 반입

### Air-gapped 환경을 위한 데이터 수집

* 설정 (고객 환경에 맞게 아래의 파일을 수정)

  - inventory/accuinsight/group_vars/all/accuinsight.yaml
  - inventory/accuinsight/group_vars/all/collector-*.yaml

* 실행

  > ansible-playbook -i inventory/accuinsight/**hosts.`<OS>`** plays/accu-collector.yaml --flush-cache

* 구조
  > **참고**: charts, files, images 는 OS 와 무관하게 동일한 데이터

  - data
    - offline
      - **`<component>`**
        - charts
          - `<inventory group name>`
        - files
          - `<inventory group name>`
        - images
          - `<inventory group name>`

* OS 패키지 데이터

  - data
    - offline
      - accu-package-repository
        - files
          - **`<OS-VERSION>`**
          - redhat-8.2
          - centos-8.2
          - ubuntu-20.04
          - ...

### Air-gapped 환경을 위한 Ansible 환경 구성

* 압축 해제

  ```bash
  $ tar xvzf ansible.offline.tar.gz 
  ```

* Python 설치

  ```bash
  $ sudo yum localinstall python3-*.rpm libtirpc-*.rpm (or rpm -ivh python3-*.rpm libtirpc-*.rpm)
  ```

* Ansible 설치

  ```bash
  # 1. Creating virtual environment
  $ python3 -m venv ansible

  # 2. Activate virtual environment
  $ source ansible/bin/activate

  # 3. Upgrading pip 
  $ pip3 install --disable-pip-version-check pip-*.whl

  # 4. Installing ansible
  $ pip3 install --disable-pip-version-check *
  ```

### 쿠버네티스 배포

* 설정

  * 노드 구성

    - inventory/accuinsight/**hosts.`<OS>`**

  * 상세 설정
  
    - inventory/accuinsight/groups_all/all/**accuinsight.yaml**

* 배포

  ```bash
  $ ansible-playbook -i inventory/accuinsight/hosts.<OS> accuk8s.yaml --flush-cache
  ```

### 쿠버네티스 테스트

* /etc/hosts 파일에 아래의 FQDN을 추가후 테스트

  ```bash
  # K8S APIServer (https://k8s.accuinsight.io:6443 or https://k8s.accuinsight.io:8443)
  # Load Balancer (http://k8s.accuinsight.io:8888/stats)
  xxx.xxx.xxx.xxx k8s.accuinsight.io
  # Ceph Dashboard
  xxx.xxx.xxx.xxx ceph.accuinsight.io
  # Ceph S3 Storage
  xxx.xxx.xxx.xxx s3.accuinsight.io
  # Harbor Registry
  xxx.xxx.xxx.xxx harbor.accuinsight.io
  # Image Registry
  xxx.xxx.xxx.xxx images.accuinsight.io
  # Chart Registry
  xxx.xxx.xxx.xxx charts.accuinsight.io
  # Prometheus Dashboard (Grafana)
  xxx.xxx.xxx.xxx accupm.accuinsight.io
  # Prometheus Console
  xxx.xxx.xxx.xxx accupc.accuinsight.io
  ```
  > xxx.xxx.xxx.xxx 는 VIP 또는 Master 노드의 IP로 대체
