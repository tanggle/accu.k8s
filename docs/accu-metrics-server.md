# AccuInsight+ Metrics Server

- [AccuInsight+ Metrics Server](#accuinsight-metrics-server)
  - [AccuInsight+ Metrics Server 설정](#accuinsight-metrics-server-설정)
  - [AccuInsight+ Metrics Server 사용](#accuinsight-metrics-server-사용)

Kubernetes HPA (Horizontal Pod Autoscaling)를 위해 노드 및 컨테이너의 리소스 사용률 정보를 제공하는 메트릭스 서버를 설정합니다.

```yaml
accu_metrics_server_enabled: true
accu_metrics_server_release: "accu-metrics-server"
accu_metrics_server_version: "2.11.1"
accu_metrics_server_namespace: "accu-system"
```

## AccuInsight+ Metrics Server 설정

**`accu_metrics_server_enabled`**

(**true** / false)

Metrics Server 구성여부를 설정합니다

**`accu_metrics_server_release`**

Helm 을 통해 표시될 릴리즈 이름을 설정합니다.

**`accu_metrics_server_version`**

Helm 차트 버전을 설정합니다. 오프라인 모드에서는 "`2.11.1`"만 선택 가능합니다.

**`accu_metrics_server_namespace`**

Metrics Server 서비스가 배포될 네임스페이스를 지정합니다. 기본값은 "`accu-system`" 입니다.

## AccuInsight+ Metrics Server 사용

아래의 명령으로 노드 및 컨테이너의 상태를 확인할 수 있습니다.

```bash
kubectl top nodes
kubectl top pods 
```
