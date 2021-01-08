## 소프트웨어 목록

|분류|이미지|버전|라이센스|
|-------|----------|--------|-------|
|OS|CentOS|7.8, 8.2|Website (https://www.centos.org)|
||Ubuntu|18.04, 20.04|Website (https://ubuntu.com)|
||Red Hat Enterprise Linux|7.8, 8.2|Website (https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux)|
|Driver|NVIDIA|v418.126.02|Website (https://www.nvidia.com/content/DriverDownload-March2009/licence.php?lang=us&type=TESLA)|
|Container Runtime|docker-ce|v19.03.4, v19.03.11, v19.03.14|Apache License 2.0 (https://github.com/docker/docker-ce/blob/master/LICENSE)|
||cri-o|v1.17.5, v1.18.4, v1.19.0|Apache License 2.0 (https://github.com/cri-o/cri-o/blob/master/LICENSE)|
|calico|calico/cni|v3.15.2|Apache License 2.0 (https://github.com/projectcalico/calico/blob/master/LICENSE)|
||calico/kube-controllers|v3.15.2|Apache License 2.0 (https://github.com/projectcalico/calico/blob/master/LICENSE)|
||calico/node|v3.15.2|Apache License 2.0 (https://github.com/projectcalico/calico/blob/master/LICENSE)|
||calico/pod2daemon-flexvol|v3.15.2|Apache License 2.0 (https://github.com/projectcalico/calico/blob/master/LICENSE)|
|kubernetes|k8s.gcr.io/kube-controller-manager|v1.17.14, v1.18.12, v1.19.4|Apache License 2.0 (https://github.com/kubernetes/kubernetes/blob/master/LICENSE)|
||k8s.gcr.io/kube-apiserver|v1.17.14, v1.18.12, v1.19.4|Apache License 2.0 (https://github.com/kubernetes/kubernetes/blob/master/LICENSE)|
||k8s.gcr.io/kube-proxy|v1.17.14, v1.18.12, v1.19.4|Apache License 2.0 (https://github.com/kubernetes/kubernetes/blob/master/LICENSE)|
||k8s.gcr.io/kube-scheduler|v1.17.14, v1.18.12, v1.19.4|Apache License 2.0 (https://github.com/kubernetes/kubernetes/blob/master/LICENSE)|
||k8s.gcr.io/coredns|1.3.1, 1.6.2, 1.6.5, 1.6.7, 1.7.0|Apache License 2.0 (https://github.com/coredns/coredns/blob/master/LICENSE)|
||k8s.gcr.io/etcd|3.3.10, 3.3.15-0, 3.4.3-0, 3.4.9-1|Apache License 2.0 (https://github.com/etcd-io/etcd/blob/master/LICENSE)|
||k8s.gcr.io/pause|3.1, 3.2|Apache License 2.0 (https://github.com/kubernetes/kubernetes/blob/master/LICENSE)|
|accelerator|images.accuinsight.io/accu-nvidia-driver-centos|accu|Apache License 2.0 (https://github.com/GoogleCloudPlatform/container-engine-accelerators/blob/master/LICENSE)|
||images.accuinsight.io/accu-nvidia-device-plugin|google|Apache License 2.0 (https://github.com/NVIDIA/k8s-device-plugin/blob/master/LICENSE)|
||images.accuinsight.io/accu-nvidia-device-plugin|nvidia|Apache License 2.0 (https://github.com/NVIDIA/k8s-device-plugin/blob/master/LICENSE)|
||images.accuinsight.io/accu-nvidia-device-metric|1.7.2|Apache License 2.0 (https://github.com/NVIDIA/gpu-monitoring-tools/blob/master/LICENSE)|
|chartmuseum-2.13.0|chartmuseum/chartmuseum|v0.12.0|Apache License 2.0 (https://github.com/helm/chartmuseum/blob/main/LICENSE)|
|docker-registry-1.9.3|registry|2.7.1|Apache License 2.0 (https://github.com/docker/distribution/blob/master/LICENSE)|
|metrics-server-2.11.1|k8s.gcr.io/metrics-server-amd64|v0.3.6|Apache License 2.0 (https://github.com/kubernetes-sigs/metrics-server/blob/master/LICENSE)|
|nfs-client-provisioner-1.2.8|quay.io/external_storage/nfs-client-provisioner|v3.1.0-k8s1.11|Apache License 2.0 (https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner/blob/master/LICENSE)|
|nginx-ingress-1.39.0|us.gcr.io/k8s-artifacts-prod/ingress-nginx/controller|v0.34.1|Apache License 2.0 (https://github.com/kubernetes/ingress-nginx/blob/master/LICENSE)|
||k8s.gcr.io/defaultbackend-amd64|1.5|Apache License 2.0 (https://github.com/kubernetes/ingress-nginx/blob/master/LICENSE)|
|prometheus-operator-8.14.0|quay.io/prometheus/alertmanager|v0.21.0|Apache Licens 2.0 (https://github.com/prometheus-operator/prometheus-operator/blob/master/LICENSE)|
||quay.io/prometheus/prometheus|v2.18.2|Apache License 2.0 (https://github.com/prometheus/prometheus/blob/master/LICENSE)|
||grafana/grafana|7.0.3|Apache License 2.0 (https://github.com/grafana/grafana/blob/master/LICENSE)|
||quay.io/coreos/kube-state-metrics|v1.9.7|Apache License 2.0 (https://github.com/kubernetes/kube-state-metrics/blob/master/LICENSE)|
||quay.io/prometheus/node-exporter|v1.0.0|Apache License 2.0 (https://github.com/prometheus/node_exporter/blob/master/LICENSE)|
||jettech/kube-webhook-certgen|v1.2.1|Apache License 2.0 (https://github.com/jet/kube-webhook-certgen/blob/master/LICENSE)|
||kiwigrid/k8s-sidecar|0.1.151|MIT License (https://github.com/kiwigrid/k8s-sidecar/blob/master/LICENSE)|
||quay.io/coreos/prometheus-config-reloader|v0.38.1|Apache License 2.0 (https://github.com/prometheus-operator/prometheus-operator/blob/master/LICENSE)|
||quay.io/coreos/prometheus-operator|v0.38.1|Apache License 2.0 (https://github.com/prometheus-operator/prometheus-operator/blob/master/LICENSE)|
||squareup/ghostunnel|v1.5.2|Apache License 2.0 (https://github.com/ghostunnel/ghostunnel/blob/master/LICENSE)|
||jimmidyson/configmap-reload|v0.3.0|Apache License 2.0 (https://github.com/jimmidyson/configmap-reload/blob/master/LICENSE.txt)|
|rook-ceph-v1.4.2|rook/ceph|v1.4.2|Apache License 2.0 (https://github.com/rook/rook/blob/master/LICENSE)|
||ceph/ceph|v15.2.4|Mixed (https://github.com/ceph/ceph/blob/master/COPYING)|
||quay.io/cephcsi/cephcsi|v3.1.0|Apache License 2.0 (https://github.com/ceph/ceph-csi/blob/master/LICENSE)|
||quay.io/k8scsi/csi-snapshotter|v2.1.1|Apache License 2.0 (https://github.com/kubernetes-csi/external-snapshotter/blob/master/LICENSE)|
||quay.io/k8scsi/csi-provisioner|v1.6.0|Apache License 2.0 (https://github.com/kubernetes-csi/external-provisioner/blob/master/LICENSE)|
||quay.io/k8scsi/csi-attacher|v2.1.0|Apache License 2.0 (https://github.com/kubernetes-csi/external-attacher/blob/master/LICENSE)|
||quay.io/k8scsi/csi-resizer|v0.4.0|Apache License 2.0 (https://github.com/kubernetes-csi/external-resizer/blob/master/LICENSE)|
||quay.io/k8scsi/csi-node-driver-registrar|v1.2.0|Apache License 2.0 (https://github.com/kubernetes-csi/node-driver-registrar/blob/master/LICENSE)|
||gcr.io/kubernetes-helm/tiller|v2.15.2|Apache License 2.0 (https://github.com/helm/helm/blob/master/LICENSE)|
|harbor-1.5.1|goharbor/chartmuseum-photon|v2.1.1|Apache License 2.0 (https://github.com/goharbor/harbor/blob/master/LICENSE)|
||goharbor/harbor-core|v2.1.1|Apache License 2.0 (https://github.com/goharbor/harbor/blob/master/LICENSE)|
||goharbor/harbor-db|v2.1.1|Apache License 2.0 (https://github.com/goharbor/harbor/blob/master/LICENSE)|
||goharbor/harbor-jobservice|v2.1.1|Apache License 2.0 (https://github.com/goharbor/harbor/blob/master/LICENSE)|
||goharbor/harbor-portal|v2.1.1|Apache License 2.0 (https://github.com/goharbor/harbor/blob/master/LICENSE)|
||goharbor/harbor-registryctl|v2.1.1|Apache License 2.0 (https://github.com/goharbor/harbor/blob/master/LICENSE)|
||goharbor/notary-server-photon|v2.1.1|Apache License 2.0 (https://github.com/theupdateframework/notary/blob/master/LICENSE)|
||goharbor/notary-signer-photon|v2.1.1|Apache License 2.0 (https://github.com/theupdateframework/notary/blob/master/LICENSE)|
||goharbor/redis-photon|v2.1.1|BSD-3-Clause License (https://github.com/redis/redis/blob/unstable/COPYING)|
||goharbor/registry-photon|v2.1.1|Apache License 2.0 (https://github.com/docker/distribution/blob/master/LICENSE)|
||goharbor/trivy-adapter-photon|v2.1.1|Apache License 2.0 (https://github.com/goharbor/harbor/blob/master/LICENSE)|


