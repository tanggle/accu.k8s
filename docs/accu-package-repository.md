# AccuInsight+ Package Repository

- [AccuInsight+ Package Repository](#accuinsight-package-repository)
  - [AccuInsight+ Package Repository 설정](#accuinsight-package-repository-설정)

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

## AccuInsight+ Package Repository 설정

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
