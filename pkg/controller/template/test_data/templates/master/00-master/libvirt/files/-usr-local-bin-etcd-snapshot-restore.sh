contents:
  source: data:,%23!%2Fusr%2Fbin%2Fenv%20bash%0A%0Aset%20-o%20errexit%0Aset%20-o%20pipefail%0A%0A%23%20example%0A%23%20.%2Fetcd-snapshot-restore.sh%20%24path-to-snapshot%20%24inital_cluster%0A%0Aif%20%5B%5B%20%24EUID%20-ne%200%20%5D%5D%3B%20then%0A%20%20echo%20%22This%20script%20must%20be%20run%20as%20root%22%0A%20%20exit%201%0Afi%0A%0Ausage%20()%20%7B%0A%20%20%20%20echo%20'Path%20to%20snapshot%20and%20initial%20cluster%20are%20required%3A%20.%2Fetcd-snapshot-restore.sh%20%24path-to-snapshot%20%24initial_cluster'%0A%20%20%20%20exit%201%0A%7D%0A%0Aif%20%5B%20%22%241%22%20%3D%3D%20%22%22%20%5D%20%7C%7C%20%5B%20%22%242%22%20%3D%3D%20%22%22%20%5D%3B%20then%0A%20%20%20%20usage%0Afi%0A%0ASNAPSHOT_FILE%3D%22%241%22%0AINITIAL_CLUSTER%3D%22%242%22%0AASSET_DIR%3D.%2Fassets%0ACONFIG_FILE_DIR%3D%2Fetc%2Fkubernetes%0AMANIFEST_DIR%3D%22%24%7BCONFIG_FILE_DIR%7D%2Fmanifests%22%0AMANIFEST_STOPPED_DIR%3D%22%24%7BASSET_DIR%7D%2Fmanifests-stopped%22%0ARUN_ENV%3D%2Frun%2Fetcd%2Fenvironment%0A%0AETCD_VERSION%3Dv3.3.10%0AETCDCTL%3D%22%24%7BASSET_DIR%7D%2Fbin%2Fetcdctl%22%0AETCD_DATA_DIR%3D%2Fvar%2Flib%2Fetcd%0AETCD_MANIFEST%3D%22%24%7BMANIFEST_DIR%7D%2Fetcd-member.yaml%22%0AETCD_STATIC_RESOURCES%3D%22%24%7BCONFIG_FILE_DIR%7D%2Fstatic-pod-resources%2Fetcd-member%22%0ASTOPPED_STATIC_PODS%3D%22%24%7BASSET_DIR%7D%2Ftmp%2Fstopped-static-pods%22%0A%0Asource%20%22%2Fusr%2Flocal%2Fbin%2Fopenshift-recovery-tools%22%0A%0Afunction%20run%20%7B%0A%20%20ETCD_INITIAL_CLUSTER%3D%22%24%7BINITIAL_CLUSTER%7D%22%0A%20%20init%0A%20%20dl_etcdctl%0A%20%20backup_manifest%0A%20%20DISCOVERY_DOMAIN%3D%24(grep%20-oP%20'(%3F%3C%3Ddiscovery-srv%3D).*%5B%5E%22%5D'%20%24ASSET_DIR%2Fbackup%2Fetcd-member.yaml%20)%0A%20%20if%20%5B%20-z%20%22%24DISCOVERY_DOMAIN%22%20%5D%3B%20then%0A%20%20%20%20echo%20%22Discovery%20domain%20can%20not%20be%20extracted%20from%20%24ASSET_DIR%2Fbackup%2Fetcd-member.yaml%22%0A%20%20%20%20exit%201%0A%20%20fi%0A%20%20validate_environment%0A%20%20source%20%2Frun%2Fetcd%2Fenvironment%0A%20%20ETCD_INITIAL_CLUSTER%3D%22%24%7BINITIAL_CLUSTER%7D%22%0A%20%20ETCD_NAME%3D%24(validate_etcd_name)%0A%20%20stop_static_pods%0A%20%20stop_etcd%0A%20%20stop_kubelet%0A%20%20stop_all_containers%0A%20%20backup_data_dir%0A%20%20remove_data_dir%0A%20%20restore_snapshot%0A%20%20start_static_pods%0A%20%20start_kubelet%0A%7D%0A%0Arun%0A
  verification: {}
filesystem: root
mode: 493
path: /usr/local/bin/etcd-snapshot-restore.sh
