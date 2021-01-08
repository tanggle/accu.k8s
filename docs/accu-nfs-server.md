# AccuInsight+ Storage NFS

- [AccuInsight+ Storage NFS](#accuinsight-storage-nfs)
  - [AccuInsight+ Storage NFS 설정](#accuinsight-storage-nfs-설정)

별도의 스토리지가 없을 경우 사용할 수 있는 NFS 서버를 제공합니다. NFS 특성상 HA 구성이 불가하여 가용성 부족합니다. 하드웨어 스토리지가 없을 경우만 사용하고, 최적을 성능을 위해서는 하드웨어 스토리지 사용을 권장합니다.

인벤토리 설정파일의 `[accu-nfs-server]` 섹션에 나열한 호스트들이 NFS 서버로 구성됩니다.

> NFS 특성상 HA 구성이 불가하며, 반드시 하나의 호스트만 지정해야 합니다.

```yaml
accu_nfs_server_enabled: true
accu_nfs_server_option: "/nfs    *(rw,sync,no_root_squash,fsid=0,no_subtree_check)"
```

## AccuInsight+ Storage NFS 설정

**`accu_nfs_server_enabled`**

(**true** / false)

NFS 서버 구성여부를 설정합니다

**`accu_nfs_server_option`**

NFS 서버가 제공할 파일시스템 위치와 Export 옵션을 설정합니다.

