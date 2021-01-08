# AccuInsight+ Kubernetes 설정

- [AccuInsight+ Kubernetes 설정](#accuinsight-kubernetes-설정)
  - [Kubernetes 환경 설정](#kubernetes-환경-설정)
  - [Kubernetes 노드 설정](#kubernetes-노드-설정)
  - [Kubernetes 기본 설정](#kubernetes-기본-설정)
  - [Kubernetes 컨테이너 런타임 설정](#kubernetes-컨테이너-런타임-설정)
  - [Kubernetes 컨테이너 네트워크 설정](#kubernetes-컨테이너-네트워크-설정)

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
