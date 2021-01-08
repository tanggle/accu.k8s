# AccuInsight+ NFS Provisioner

- [AccuInsight+ NFS Provisioner](#accuinsight-nfs-provisioner)
  - [AccuInsight+ NFS Provisioner 설정](#accuinsight-nfs-provisioner-설정)

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

## AccuInsight+ NFS Provisioner 설정

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
