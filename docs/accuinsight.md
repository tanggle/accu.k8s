# **AccuInsight+ Kubernetes**

- [**AccuInsight+ Kubernetes**](#accuinsight-kubernetes)
  - [AccuInsight+ Kubernetes 개요](#accuinsight-kubernetes-개요)
  - [AccuInsight+ Kubernetes 특징](#accuinsight-kubernetes-특징)
  - [AccuInsight+ Kubernetest 요구사양](#accuinsight-kubernetest-요구사양)
    - [운영체제 지원](#운영체제-지원)
    - [하드웨어 스펙](#하드웨어-스펙)
    - [저장공간 스펙](#저장공간-스펙)
    - [네트워크 포트](#네트워크-포트)

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

