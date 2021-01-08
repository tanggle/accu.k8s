# AccuInsight+ Ingress Controller

- [AccuInsight+ Ingress Controller](#accuinsight-ingress-controller)
  - [AccuInsight+ Ingress Controller 설정](#accuinsight-ingress-controller-설정)

Ingress Controller는 Kubernetes 네트웍 외부에서의 요청을 내부 서비스로 라우팅해주는 Layer 7 Switch 역할을 수행합니다. Nginx 기반의 Reverse Proxy 로 Ingress 리소스의 정의대로 내부 서비스로 라우팅해줍니다. 라우팅 경로는 `로드밸런서 > K8S NODEPORT > K8S SERVICE > K8S POD` 입니다. 다음과 같은 설치옵션을 제공합니다.

```yaml
# AccuInsight+ Ingress Controller
accu_ingress_controller_enabled: true
accu_ingress_controller_release: "accu-ingress"
accu_ingress_controller_version: "1.41.3"
accu_ingress_controller_namespace: "accu-system"
accu_ingress_controller_nodeport_insecure: 30080
accu_ingress_controller_nodeport_secure: 30443
```

## AccuInsight+ Ingress Controller 설정

**`accu_ingress_controller_enabled`**

(**true** / false)

Ingress Controller를 구성여부를 설정합니다.

**`accu_ingress_controller_release`**

Helm 을 통해 표시될 릴리즈 이름을 설정합니다.

**`accu_ingress_controller_version`**

Helm 차트 버전을 설정합니다. 오프라인 모드에서는 "`1.41.3`"만 선택 가능합니다.

**`accu_ingress_controller_namespace`**

Ingress Controller 가 배포될 네임스페이스를 지정합니다. 기본적으로 AccuInsight+ 컨트롤러는 "`accu-system`" 네임스페이스에 배포됩니다.

**`acc_ingress_controller_nodeport_insecure`**

Ingress Controller가 사용할 HTTP 서비스의 NodePort를 지정합니다. 30000 부터 32767 범위헤서 사용하지 않는 포트를 지정합니다. 기본값은 "`30080`" 입니다.

**`accu_ingress_controller_nodeport_secure`**

Ingress Controller가 사용할 HTTPS 서비스의 NodePort를 지정합니다. 3000 부터 32767 범위에서 사용하지 않는 포트를 지정합니다. 기본값은 "`30443`" 입니다.

