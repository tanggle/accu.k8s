# AccuInsight+ Container Registry

- [AccuInsight+ Container Registry](#accuinsight-container-registry)
  - [AccuInsight+ Container Registry 설정](#accuinsight-container-registry-설정)
  - [AccuInsight+ Container Registry 사용](#accuinsight-container-registry-사용)

컨테이너 이미지를 저장할 로컬 레지스트리 서버를 구성합니다.

> 보다 원할한 서비스를 위해 `Harbor`로 교체 예정

```yaml
# AccuInsight+ Docker Registry
accu_registry_enabled: true
accu_registry_release: "accu-registry"
accu_registry_version: "1.9.4"
accu_registry_namespace: "accu-system"
accu_registry_fqdn: "images.accuinsight.io"
accu_registry_user: "dpcore"
accu_registry_pass: "dpcore"
```

## AccuInsight+ Container Registry 설정

**`accu_registry_enabled`**

(**true** / false)

Container Registry 구성여부를 설정합니다.

**`accu_registry_release`**

Helm 을 통해 표시될 릴리즈 이름을 설정합니다.

**`accu_registry_version`**

Helm 차트 버전을 설정합니다. 오프라인 모드에서는 "`1.9.4`"만 선택 가능합니다.

**`accu_registry_namespace`**

Container Registry 서비스가 배포될 네임스페이스를 지정합니다. 기본값은 "`accu-system`" 입니다.

**`accu_registry_fqdn`**

Container Registry 서비스의 접근하기 위한 도메인을 지정합니다.

> Ingress Controller를 통해 라우팅되므로 반드시 도메인을 지정해야합니다. (IP주소 불가)

**`accu_registry_user`**

Container Registry 서비스의 사용자명을 지정합니다.

**`accu_registry_pass`**

Container Registry 서비스의 패스워드를 지정합니다.

## AccuInsight+ Container Registry 사용

로컬 레지스트리는 자체 서명 인증서 (Self-signed Certificate)를 사용하며, 정상적인 사용을 위해서는 클라이언트 사이드에서 Insecure Registry로 설정해야 합니다. Docker의 경우 다음과 같이 설정합니다.

`/etc/docker/daemon.json`
```json
{
  "insecure-registries" : ["image.accuinsight.io"]
}
```

Insecure Registry 설정시 클라이언트는 다음과 같이 작동합니다.

- HTTPS로 연결시도
- HTTPS 연결은 가능하나, 인증서가 유효하지 않다면 무시하고 연결
- HTTPS 연결이 불가하면, HTTP로 연결

> 참고: [Insecure Registry](https://docs.docker.com/registry/insecure/#deploy-a-plain-http-registry)
>
> containerd, cri-o, podman 등은 해당 매뉴얼을 참고합니다.
