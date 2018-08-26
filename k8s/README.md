Running Fonoster in K8S
=========================

Create disk
-----------

Create the Disk,PersistentVolume and PersistentVolumeClaim for MongoDB storage and the NFS server

`gcloud compute disks create --size=200GB --zone=us-east1-b disk0001`
`gcloud compute disks create --size=200GB --zone=us-east1-b disk0002`


Create PV and PVC
-----------------

Create PersistantVolume and PersistantVolumeClain for MongoDB and the NFS by running the following steps:

$ cd k8s/persistance
$ kubectl apply -f db.yaml
$ kubectl apply -f nfs-server.yaml

Note: Ensure PV is pointing to the correct IP. Ensure the IP is the field "Endpoint" in kubectl describe svc nfs-server

Configure DNS
-------------

Go to GCP Network and reconfigure services dns.

Tearing everything down
-----------------------

`kubectl delete deployment,svc,pv,pvc -l app=fonoster`
