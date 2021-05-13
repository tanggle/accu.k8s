${list_connstr_multi}

[kube-cluster:children]
kube-master
kube-worker

[kube-master]
${list_multi}

[kube-worker:children]
accu-worker
accu-nvidia

[accu-worker]
${list_multi}

[accu-nvidia]
${list_multi}

[accu-server:children]
accu-pkg-server
accu-nfs-server

[accu-pkg-server]
${list_multi}

[accu-nfs-server]

[accu-ceph]
${list_multi}

