# AccuInsight+ Chart Registry

- [AccuInsight+ Chart Registry](#accuinsight-chart-registry)
  - [AccuInsight+ Chart Registry 설정](#accuinsight-chart-registry-설정)
  - [AccuInsight+ Chart Registry 사용](#accuinsight-chart-registry-사용)

Helm 차트를 저장할 로컬 레지스트리 서버를 구성합니다.

> 보다 원할한 서비스를 위해 `Harbor`로 교체 예정

```yaml
# AccuInsight+ Chartmuseum
accu_chartmuseum_enabled: true
accu_chartmuseum_release: "accu-chartmuseum"
accu_chartmuseum_version: "2.13.2"
accu_chartmuseum_namespace: "accu-system"
accu_chartmuseum_fqdn: "charts.accuinsight.io"
accu_chartmuseum_name: "accu-repo"
accu_chartmuseum_user: "dpcore"
accu_chartmuseum_pass: "dpcore"
```

## AccuInsight+ Chart Registry 설정

**`accu_chartmuseum_enabled`**

(**true** / false)

Chart Registry 구성여부를 설정합니다.

**`accu_chartmuseum_release`**

Helm 을 통해 표시될 릴리즈 이름을 설정합니다.

**`accu_chartmuseum_version`**

Helm 차트 버전을 설정합니다. 오프라인 모드에서는 "`2.13.2`"만 선택 가능합니다.

**`accu_chartmuseum_namespace`**

Chart Registry 서비스가 배포될 네임스페이스를 지정합니다. 기본값은 "`accu-system`" 입니다.

**`accu_chartmuseum_fqdn`**

Chart Registry 서비스의 접근하기 위한 도메인을 지정합니다.

> Ingress Controller를 통해 라우팅되므로 반드시 도메인을 지정해야합니다. (IP주소 불가)

**`accu_chartmuseum_name`**

AccuInsight+ 에서 사용되는 차트가 저장될 저장소 이름입니다.

**`accu_chartmuseum_user`**

CHart Registry 서비스의 사용자명을 지정합니다.

**`accu_chartmuseum_pass`**

Chart Registry 서비스의 패스워드를 지정합니다.

## AccuInsight+ Chart Registry 사용

차트 저장소를 접근하기 위해서는 다음과 같이 설정합니다.

- 저장소 추가
```bash
helm repo add accu-repo http://charts.accuinsight.io
```
- 차트 업로드
```bash
helm push <차트파일> <저장소 이름>
helm push mychart-0.0.1.tgz accu-repo
```

> 참고: [Helm Push Plugin](https://github.com/chartmuseum/helm-push)
