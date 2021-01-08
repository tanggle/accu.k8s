# AccuInsight+ Load Balancer

- [AccuInsight+ Load Balancer](#accuinsight-load-balancer)
  - [AccuInsight+ Load Balancer 설정](#accuinsight-load-balancer-설정)

별도의 로드밸런서가 없을 경우 사용할 수 있는 소프트웨어 로드밸런서 입니다. HA로 구성된 Kubernetes API Server 및 Ingress Controller 의 트래픽을 가용한 서버로 분배합니다. 오픈소스 소프트웨어인 HAProxy 가 부하분산을 담당하며, Keepalived 로 HAProxy 자체의 가용성을 보장합니다. 보다 나은 퍼포먼스를 위해서 하드웨어 로드밸런서 사용을 권장합니다.

인벤토리 설정파일의 `[accu-alb-server]` 섹션에 나열한 호스트들이 로드밸런서 서버로 구성됩니다.

```yaml
# AccuInsight+ Load Balancer
accu_load_balancer_enabled: true
accu_load_balancer_keepalived: false
accu_load_balancer_fqdn: "k8s.accuinsight.io"
accu_load_balancer_virtualip: "xxx.xxx.xxx.xxx"
```

## AccuInsight+ Load Balancer 설정

**`accu_load_balancer_enabled`**

(**true** / false)

Load Balancer 구성여부를 설정합니다.

(true / **false**)

**`accu_load_balancer_keepalived`**

Load Balancer 자체의 가용성 보장을 위한 keepalived 구성여부를 서정합니다.

> keepalived 를 구성하기 위해서는 네트워크 관리자가 `Virtual IP`를 제공해야하며, 모든 로드밸런서는 반드시 동일한 서브 네트워크에서 운영되어야 합니다.

**`accu_load_balancer_fqdn`**

Kubernetes API Server의 도메인을 지정합니다. 이 값은 Kubernetes 배포시 자동생성되는 인증서의 SAN (Subject Alternative Name) 목록에 포합니다.

**`accu_load_balancer_virtualip`**

Load Balancer 가 사용할 `Virtual IP`를 지정합니다. 이 값은 Kubernetes 배포시 자동생성되는 인증서의 SAN (Subject Alternative Name) 목록에 포합니다.
