# ***THIS REPOSITORY HAS NOT BEEN MANAGED SINCE THE LATEST COMMIT ON 19 NOVEMBER 2021.***
# ***THE LATEST DOCUMENTATION IS [HERE](docs/README.md)***
# https://github.com/tanggle/accu.k8s/blob/main/docs/README.md



# 쿠버네티스 테스트 방법

### 쿠버네티스 클러스터 요구사항

  - Ansible v2.9.6
  - Terraform v0.15.3 (AWS 환경의 테스트에 필요)


### 쿠버네티스 클러스터 정보

* 지원 OS (Air-gapped 환경을 위한 OS 저장소 지원)

  - RedHat 7.x / 8.x (검증 완료: 7.6/7.7/7.8/7.9/8.0/8.1/8.2/8.3)
  - CentOS 7.x / 8.x (지원 중단 예정)
  - Ubuntu 18.04 / 20.04 (검증 완료)


* 지원 K8S

  - Kubernetes 1.17.x / 1.18.x / 1.19.x / 1.20.x / 1.21.x (검증 완료)
  - Kubernetes 1.22.x / 1.23.x (검증 진행)


* 지원 CRI (Kubernetes Container Runtime Interface)

  - cri-o
  - docker
  - containerd


* 지원 CSI (Kubernetes Container Storage Interface)

  - NFS
  - Ceph (RBD, CEPHFS, OBJECT STORAGE)


* 지원 GPU

  - NVIDIA Tesla V100 (검증 완료)
  - NVIDIA Tesla A100 (Multi-instance GPU 검증 진행)


* 기타 지원

  - 소프트웨어 로드밸런서 (VIP 이중화 지원)


### 쿠버네티스 소스

```bash
git clone https://dev.k8s.bns.co.kr:10443/sk/accuinsight.git
```
> Username: ***accuinsight***, Password: ***CONTACT ME (<tanggle@gmail.com>)***


### Air-gapped 환경을 위한 데이터 수집

* 설정 (고객 환경에 맞게 아래의 파일을 수정)

  - inventory/accuinsight/group_vars/all/accuinsight.yaml
  - inventory/accuinsight/group_vars/all/collector-*.yaml

* 실행

  ```bash
  $ ansible-playbook -i inventory/accuinsight/hosts.<OS> plays/accu-collector.yaml --flush-cache
  ```

* 압축 (반입 미디어 생성)

  ```bash
  $ ./accuk8s.media
  ```
  > 실행 시 고객사 반입을 위한 `accu.k8s.tar.gz` 파일이 생성


* 구조
  > **참고**: charts, files, images 는 OS 와 무관하게 동일한 데이터

  - data
    - deployer
      - accu.k8s.deployer-`<OS>`.sh
      - accu.k8s.deployer-`<OS>`.tar.gz
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

### Air-gapped 환경을 위한 배포

* 압축 해제

  ```bash
  $ tar xvzf accu.k8s.tar.gz
  ```

* 배포 환경 생성 (deployer)

  ```bash
  $ data/deployer/accu.k8s.deployer-<OS>.sh
  $ source data/deployer/deployer/bin/activate
  ```

### 쿠버네티스 배포

* 설정

  * 노드 구성

    - inventory/accuinsight/**hosts.`<OS>`**

  * 상세 설정
  
    - inventory/accuinsight/group_vars/all/**accuinsight.yaml**

* 배포

  ```bash
  $ cp accuinsight.pem ~/
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
  xxx.xxx.xxx.xxx pm.accuinsight.io
  # Prometheus Console
  xxx.xxx.xxx.xxx pc.accuinsight.io
  # Prometheus Alertmanager
  xxx.xxx.xxx.xxx pa.accuinsight.io
  # Keycloak
  xxx.xxx.xxx.xxx idp.accuinsight.io
  ```
  > xxx.xxx.xxx.xxx 는 VIP 또는 Master 노드의 IP로 대체
