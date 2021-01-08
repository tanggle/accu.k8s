# AccuInsight+ K8S Tools

- [AccuInsight+ K8S Tools](#accuinsight-k8s-tools)
  - [AccuInsight+ K8S Tools 프롬프트](#accuinsight-k8s-tools-프롬프트)
  - [AccuInsight+ K8S Tools 컨텍스트 & 네임스페이스](#accuinsight-k8s-tools-컨텍스트--네임스페이스)

AccuInsight+ Kubernetes 를 편리하게 사용할 수 있는 유틸리티 셋입니다.

> K8S Master 노드에 `root` 유저로 로그인시 출력됩니다. ~/.kube/config 파일의 내용을 참고 및 변경합니다.

```yaml
# AccuInsight+ K8S Tools
accu_tools_enabled: true
```

**`accu_tools_enabled`**

(**true** / false)

AccuInsight+ Kubernetes Tools 의 사용여부를 설정합니다.

## AccuInsight+ K8S Tools 프롬프트

현재 작업중인 사용자명, 호스트명, 컨텍스트, 네임스페이스 등을 프롬프트에 직관적으로 표시합니다.

![AccuInsight+ K8S Tools](images/accu-tools.png)

> 참고: [A Powerline style prompt for your shell](https://github.com/justjanne/powerline-go)

## AccuInsight+ K8S Tools 컨텍스트 & 네임스페이스

다수의 클러스터 사이의 컨텍스트를 변경하거나, 클러스터의 네임스페이스를 변경합니다.

- kubectx

```bash
USAGE:
  kubectx                       : 등록된 컨텍스트 목록
  kubectx <NAME>                : <NAME> 컨텍스트로 변경
  kubectx -                     : 이전 컨텍스트로 변경
  kubectx -c, --current         : 현재 컨텍스트명 표시
  kubectx <NEW_NAME>=<NAME>     : 컨텍스트명을 <NAME> 에서 <NEW_NAME> 으로 변경
  kubectx <NEW_NAME>=.          : 현재 컨텍스트명을  <NEW_NAME> 으로 변경
  kubectx -d <NAME> [<NAME...>] : <NAME> 컨텍스트를 삭제
```

- kubens

```bash
USAGE:
  kubens                    : 현재 컨텍스트의 네임스페이스 표시
  kubens <NAME>             : <NAME> 네임스페이스로 변경
  kubens -                  : 이전 네임스페이스로 변경
  kubens -c, --current      : 현재 네임스페이스 표시
```

> 참고: [kubectx + kubens: Power tools for kubectl](https://github.com/ahmetb/kubectx)
