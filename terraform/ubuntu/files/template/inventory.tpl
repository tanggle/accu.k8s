${list_connstr_master}
${list_connstr_worker}
%{ if length(list_connstr_alb) != 0 ~}
${list_connstr_alb}
%{ endif ~}
%{ if length(list_connstr_nfs) != 0 ~}
${list_connstr_nfs}
%{ endif ~}
%{ if length(list_connstr_gpu) != 0 ~}
${list_connstr_gpu}
%{ endif ~}
%{ if length(list_connstr_multi) != 0 ~}
${list_connstr_multi}
%{ endif ~}

[kube-cluster:children]
kube-master
kube-worker

[kube-master]
${list_master}

[kube-worker:children]
accu-worker
accu-nvidia

[accu-worker]
${list_worker}

[accu-nvidia]
%{ if length(list_gpu) != 0 ~}
${list_gpu}
%{ endif ~}
%{ if length(list_multi) != 0 ~}
${list_multi}
%{ endif ~}

[accu-server:children]
accu-alb-server
accu-pkg-server
accu-nfs-server

[accu-alb-server]
${list_master}

[accu-pkg-server]
%{ if length(list_nfs) != 0 ~}
${list_nfs}
%{ endif ~}
%{ if length(list_multi) != 0 ~}
${list_multi}
%{ endif ~}

[accu-nfs-server]
%{ if length(list_nfs) != 0 ~}
${list_nfs}
%{ endif ~}
%{ if length(list_multi) != 0 ~}
${list_multi}
%{ endif ~}

[accu-ceph]
${list_worker}
