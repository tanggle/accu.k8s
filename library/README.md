# yum_repository - Helm Chart 저장소 관리

| Parameter | Choices/`Defaults` | Comments                               |
| --------- | ------------------ | -------------------------------------- |
| name      |                    | `필수`: 레파지토리 이름                |
| url       |                    | `선택`: 레파지토리 주소                |
| username  |                    | `선택`: 사용자명                       |
| password  |                    | `선택`: 패스워드                       |
| state     | present / absent   | `필수`: present (추가) / absent (제거) |
| options   |                    | `선택`: 추가옵션                       |

## Examples

```yaml
- name: Add Helm official stable chart repository
  helm_repository:
    name: stable
    url: https://kubernetes-charts.storage.googleapis.com
    state: present
    username: <username here>
    password: <password here>

- name: Remove AccuInsight+ Chartmuseum
  helm_repository:
    name: accu-repo
    state: absent
```

# helm_cmd - Helm Chart 릴리즈 관리

| Parameter    | Choices/`Defaults`                 | Comments                                                                 |
| ------------ | ---------------------------------- | ------------------------------------------------------------------------ |
| name         |                                    | `필수`: 차트 이름                                                        |
| version      |                                    | `선택`: 차트 버전                                                        |
| release      |                                    | `필수`: 릴리즈 이름                                                      |
| namespace    |                                    | `선택`: 설치될 네임스페이스                                              |
| state        | present / latest / absent / purged | `필수`: present (설치) / latest (최신버전 설치) / absent (삭제) / purged (이전 릴리즈 정보까지 모두 삭제)                                                                 |
| update_cache |                                    | `선택`: 캐쉬 업데이트                                                    |
| force        |                                    | `선택`: 강제 재설치. 동일한 버전으로 새로운 옵션을 적용할 때 사용합니다. |
| wait         |                                    | `선택`: 모든 리소스가 생성 완료까지 대기                                 |
| options      |                                    | `선택`: 추가옵션                                                         |

## Examples
```yaml
- name: AccuInsight+ Ingress - Deploy
  become: yes 
  helm_cmd:
    name: stable/nginx-ingress
    release: accu-ingress
    version: 1.41.3
    namespace: accu-system
    state: present
    update_cache: yes 
    wait: true
    options:
      - '--set first.params=original' 
    
- name: AccuInsight+ Ingress - Update with new optoins
  become: yes 
  helm_cmd:
    name: stable/nginx-ingress
    release: accu-ingress
    version: 1.41.3
    namespace: accu-system
    state: present
    update_cache: yes 
    force: true
    wait: true
    options:
      - '--set first.params=updated'


- name: AccuInsight+ Ingress - Install from chart file
  become: yes 
  helm_cmd:
    name: /home/accuinsight/nginx-ingress-1.41.3.tgz
    release: accu-ingress
    namespace: accu-system
    state: present
    wait: true
```

> 참고 1. 동일한 버전으로 옵션만 변경할 경우 `force: true` 를 사용합니다.

> 참고 2. `options` 의 항목은 single quotation 으로 감싸고, 내용은 helm 명령에서 사용하는 옵션을 그대로 사용합니다.

