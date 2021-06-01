### 쿠버네티스 클러스터 요구사항

  - Ansible v2.9.6
  - Terraform v0.15.3 (AWS 환경의 테스트에 필요)


### 쿠버네티스 클러스터 정보

* 지원 OS

  - RedHat 7.8 / 8.2 (Air-gapped 환경을 위한 OS 저장소 지원)
  - CentOS 7.8 / 8.2 (Air-gapped 환경을 위한 OS 저장소 지원)
  - Ubuntu 18.04 / 20.04 (Air-gapped 환경을 위한 OS 저장소 지원)


* 지원 K8S

  - Kubernetes 1.17.x / 1.18.x / 1.19.x


* 지원 CRI (Kubernetes Container Runtime Interface)

  - cri-o
  - docker
  - containerd


* 지원 CSI (Kubernetes Container Storage Interface)

  - NFS
  - Ceph (RBD, CEPHFS, OBJECT STORAGE)



### 쿠버네티스 클러스터 설정

  - AccuInsight 서비스 설정 및 all 범위 변수 오버라이딩

    > inventory/accuinsight/group_vars/all/accuinsight.yaml



### 쿠버네티스 클러스터 생성

* [terraform/README.md](terraform/README.md)를 참고로 AWS Resources 생성

* 아래의 명령으로 AccuInsight+ K8S Cluster 생성

  - Ubuntu

    > ansible-playbook -i inventory/accuinsight/**hosts.ubuntu** accuk8s.yaml --flush-cache

  - CentOS

    > ansible-playbook -i inventory/accuinsight/**hosts.centos** accuk8s.yaml --flush-cache

  - RHEL

    > ansible-playbook -i inventory/accuinsight/**hosts.redhat** accuk8s.yaml --flush-cache


### Air-gapped 환경을 위한 데이터 수집

* 설정 (고객 환경에 맞게 아래의 파일을 수정)

  - inventory/accuinsight/group_vars/all/accuinsight.yaml
  - roles/accu-collector/vars/*.yaml

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
