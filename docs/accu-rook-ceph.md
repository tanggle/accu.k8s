# AccuInsight+ Storage Ceph

- [AccuInsight+ Storage Ceph](#accuinsight-storage-ceph)
  - [AccuInsight+ Storage Ceph 설정](#accuinsight-storage-ceph-설정)
  - [AccuInsight+ Storage Ceph 스토리지 클래스](#accuinsight-storage-ceph-스토리지-클래스)
  - [AccuInsight+ Storage Ceph 사용](#accuinsight-storage-ceph-사용)

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

## AccuInsight+ Storage Ceph 설정

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

> `필수`: 퍼포먼스 향상을 위해 filestore 방식 대신 bluestore 방식을 사용합니다. **`Ceph 스토리지로 사용할 전용 디바이스(HDD 또는 SSD)가 Ceph 노드에 Attach 되어 있어야 합니다.`**
> 
> `주의`: 지정된 디바이스는 저수준 포맷이 되고, **`존재하는 모든 데이터는 삭제됩니다 !!!`**

## AccuInsight+ Storage Ceph 스토리지 클래스

설정에 따라 다음과 같은 Kubernetes Storage Class 가 생성됩니다. 용도에 맞게 PVC 생성시 선택합니다.

- rook-ceph-block
  - 블럭 디바이스를 위한 스토리지 클래스
- rook-cephfs 
  - 공유 파일시스템을 위한 스토리지 클래스

## AccuInsight+ Storage Ceph 사용

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
