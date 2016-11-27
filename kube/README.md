Fonoster with Kubernetes
=========================

Create disk
-----------

Create the Disk,PersistentVolume and PersistentVolumeClaim for MongoDB storage

`gcloud compute disks create --size=200GB --zone=us-east1-b disk0001`


Tearing everything down
-----------------------

`kubectl delete deployment,svc,pv,pvc -l app=fonoster --namespace=qa`


Create PV and PVC 
-----------------

Create PersistantVolume for MongoDB (mongodb.yaml) and the NFS server by running the following steps:

$ cd resources/pv
$ kubectl apply -f mongodb.yaml --namespace=prod|qa
$ kubectl apply -f nfs-server.yaml --namespace=prod|qa # Ensure PV is pointing to the correct IP

Then create Claims 

$ cd resources/pvc
$ kubectl apply -f mongodb.yaml --namespace=prod|qa
$ kubectl apply -f nfs-server.yaml --namespace=prod|qa 

Note: Ensure PV is pointing to the correct IP. Ensure the IP is the field "Endpoint" in kubectl describe svc nfs-server

Run fnmongo, fnapp, fnast
-------------------------

The order does not matter. Just make sure that the proper version of the images are use.

$ cd resources/deployment
$ kubectl apply -f {deployment} --namespace=qa

Note: mongodb-qa.yaml points to a temporary storage.

Configure DNS
-------------

Go to GCP Network and reconfigure services dns.