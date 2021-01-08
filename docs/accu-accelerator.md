# AccuInsight+ GPU Accelerator

- [AccuInsight+ GPU Accelerator](#accuinsight-gpu-accelerator)
  - [AccuInsight+ GPU Acclerator 설정](#accuinsight-gpu-acclerator-설정)

AccuInsight+ 서비스에서 GPU 가속을 사용하기 위한 설정입니다. 현재는 NVIDIA 하드웨어(GTX / Tesla) 만을 지원합니다.

인벤토리 설정파일의 `[accu-nvidia]` 섹션에 나열한 호스트들이 GPU 노드로 구성됩니다.

```yaml
# AccuInsight+ GPU Accelerator
accu_accelerator_enabled: true
accu_accelerator_namespace: "accu-system"
accu_accelerator_node_taint: true
accu_accelerator_nvidia_type: tesla # tesla or gtx
accu_accelerator_driver_version: "418.126.02"
accu_accelerator_device_plugin_type: nvidia # google or nvidia
accu_accelerator_driver_centos: "{{ accu_registry_fqdn }}/accu-nvidia-driver-centos:accu"
accu_accelerator_driver_ubuntu: "{{ accu_registry_fqdn }}/accu-nvidia-driver-ubuntu:accu"

accu_accelerator_device_plugin: "{{ accu_registry_fqdn }}/accu-nvidia-device-plugin:{{ accu_accelerator_device_plugin_type }}"
accu_accelerator_device_metric: "{{ accu_registry_fqdn }}/accu-nvidia-device-metric:1.7.2"
```

## AccuInsight+ GPU Acclerator 설정

**`accu_accelerator_enabled`**

(**true** / false)

AccuInsight+ GPU Accelerator 구성여부를 설정합니다.

**`accu_acclerator_namespace`**

AccuInsight+ GPU Accelerator 가 배포될 네임스페이스를 지정합니다. 기본값은 "`accu-system`" 입니다.

**`accu_accelerator_node_taint`**

(**true** / false)

GPU 하드웨어가 장착된 노드가 GPU 워크로드만을 수용할지 여부를 설정합니다. 기본값은 "`true`" 이며, 이 경우 GPU 워크로드만을 위한 전용 노드로 설정됩니다.

> GPU 하드웨어가 장작된 노드에 Kubernetes Taint 설정을 합니다. 일반 비지니스 워크로드로 인한 CPU / Memory 점유로 GPU 워크로드가 스케쥴링 되지 못하는 것을 방지합니다. CPU / Memory 가 충분하다면, 효율적인 리소스 사용을 위해 "`false`"로 설정 가능합니다.

**`accu_accelerator_nvidia_type`**

(gtx / tesla)

NVIDIA 하드웨어 플랫폼 타입을 지정합니다.

**`accu_accelerator_driver_version`**

사용할 NVIDIA 드라이버 버전을 지정합니다. 사용하는 CUDA 버전에 맞는 드라이버 버전을 지정합니다.

| CUDA Toolkit          | Linux x86_64 Driver Version |
| --------------------- | --------------------------- |
| CUDA 11.1 (11.1.0)    | >= 455.23.04                |
| CUDA 11.0 (11.0.171)  | >= 450.36.06                |
| CUDA 10.2 (10.2.89)   | >= 440.33                   |
| CUDA 10.1 (10.1.105)  | >= 418.39                   |
| CUDA 10.0 (10.0.130)  | >= 410.48                   |
| CUDA 9.2 (9.2.88)     | >= 396.26                   |
| CUDA 9.1 (9.1.85)     | >= 390.46                   |
| CUDA 9.0 (9.0.76)     | >= 384.81                   |
| CUDA 8.0 (8.0.61 GA2) | >= 375.26                   |
| CUDA 8.0 (8.0.44)     | >= 367.48                   |
| CUDA 7.5 (7.5.16)     | >= 352.31                   |
| CUDA 7.0 (7.0.28)     | >= 346.46                   |


> 참고: [CUDA Compatibility](https://docs.nvidia.com/deploy/cuda-compatibility/index.html)

**`accu_accelerator_device_plugin_type`**

(**nvidia** / google)

NVIDIA 디바이스 플러그인 타입을 지정합니다. 기본값은 "`nvidia`" 입니다.

- nvidia
  - CentOS / RHEL / Ubuntu 지원
  - GPU 노드에 커널 헤더 및 빌드를 위한 패키지 설치함
  - GPU 노드에서 드라이버를 직접 설치하고 드라이버 모듈을 빌드하여 노드에서 사용
  - GPU 리소스 모니터링 (DCGM Exporter) 지원
- google
  - CentOS / Ubuntu 지원 (`RHEL 미지원`)
  - GPU 노드에 추가적인 패키지 설치 없음
  - POD 내부에서 드라이버 모듈을 빌드하여 노드에서 사용
  - GPU 리소스 모니터링 (DCGM Exporter) `미지원`

> 참고: [Kubernetes GPU Support](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/#deploying-nvidia-gpu-device-plugin)

> 참고: [DCGM exporter](https://github.com/NVIDIA/gpu-monitoring-tools)

**`accu_accelerator_driver_centos`** (수정 금지)

`google` 타입에서 드라이버 모듈 빌드에 사용할 CentOS 이미지를 지정합니다.


**`accu_accelerator_driver_ubuntu`** (수정 금지)

`google` 타입에서 드라이버 모듈 빌드에 사용할 Ubuntu 이미지를 지정합니다.

**`accu_accelerator_device_plugin`** (수정 금지)

GPU 가속 지원을 위한 디바이스 플러그인 이미지를 지정합니다.

**`accu_accelerator_device_metric`** (수정 금지)

GPU 리소스 모니터링을 위한 DCGM Exporter 이미지를 지정합니다.

