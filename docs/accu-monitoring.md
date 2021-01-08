# AccuInsight+ Monitoring

- [AccuInsight+ Monitoring](#accuinsight-monitoring)
  - [AccuInsight+ Monitoring 설정](#accuinsight-monitoring-설정)
  - [AccuInsight+ Monitoring 사용](#accuinsight-monitoring-사용)

Kubernetes 리소스 사용 모니터링을 제공합니다. Kubernetes 모니터링의 표준인 오픈소스 Prometheus 입니다. 동적으로 구성가능한 컨트롤러가 포함된 Prometheus Operator 버전을 사용합니다.

```yaml
# AccuInsight+ Monitoring
accu_monitoring_enabled: true
accu_monitoring_release: "accu-monitor"
accu_monitoring_version: "9.3.1"
accu_monitoring_namespace: "accu-monitor"
accu_monitoring_prometheus_fqdn: "accupc.accuinsight.io"
accu_monitoring_grafana_fqdn: "accupm.accuinsight.io"
accu_monitoring_grafana_pass: "dpcore
```

## AccuInsight+ Monitoring 설정

**`accu_monitoring_enabled`**

(**true** / false)

Prometheus Operator 구성여부를 설정합니다.

**`accu_monitoring_release`**

Helm 을 통해 표시될 릴리즈 이름을 설정합니다.

**`accu_monitoring_version`**

Helm 차트 버전을 설정합니다. 오프라인 모드에서는 "`9.3.1`"만 선택 가능합니다.

**`accu_monitoring_namespace`**

모니터링 서비스가 배포될 네임스페이스를 지정합니다. 기본값은 "`accu-monitor`" 입니다.

**`accu_monitoring_prometheus_fqdn`**

Prometheus 의 메트릭스 데이터를 조회하고, PromQL 을 테스트할 수 있는 콘솔의 도메인을 지정합니다.

**`accu_monitoring_grafana_fqdn`**

Grafana 접근을 위한 도메인을 지정합니다.

**`accu_monitoring_grafana_pass`**

Grafana 접근을 위한 패스워드를 지정합니다. 기본 사용자명은 "`admin`" 입니다.

## AccuInsight+ Monitoring 사용

모니터링을 위한 웹 인터페이스는 Ingress Controller 를 통해 도메인으로 접근합니다. 지정한 도메인이 DNS서버를 통해 Lookup 되지 않는 가상 도메인 (Unqualified Domain) 일 경우, 사용하는 운영체제의 추가 설정이 필요합니다.

| 운영체제 | 파일위치                              |
| -------- | ------------------------------------- |
| Linux    | /etc/hosts                            |
| MacOS    | /private/etc/hosts                    |
| Windows  | C:\Windows\System32\drivers\etc\hosts |

아래의 형식으로 가상 도메인을 설정합니다.

```
# IP Address       Domain Name
xxx.xxx.xxx.xxx    accupc.accuinsight.io
xxx.xxx.xxx.xxx    accupm.accuinsight.io
```

> `IP Address` 는 Load Balancer 의 IP 또는 Virtual IP를 설정하고, Domain Name 은 `accu_monitoring_prometheus_fqdn` 와 `accu_monitoring_grafana_fqdn` 에 지정한 가상 도메인을 설정합니다.

