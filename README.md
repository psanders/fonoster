# Fonoster Operations

Read this file to obtain an inside in how to build the infrastructure that supports the Fonoster Platform. 

## Requirements

They are other requirements, but they are part of a package and should be maintained by the DevOps team. 

* Java 1.8+
* Docker 17.03+
* GCloud SDK
* Berks

## ENVs Variables

Containers are loosely couple. They connect to each other via exposed APIs or ports. The following environment
variables can be use to replace the defaults:

1. The environment 'ASTIVED_HOST' and 'ASTIVED_PORT' are use by fnast
2. The MANAGER_HOST, MANAGER_PORT, DB_HOST and DB_PORT are use by fnapp to point to those services
3. If the environment FONOSTER_ENV is found to be equal than 'dev' the database will be boostraped with some test data

### Pushing the images to the Cloud

First, authenticate with the Google Cloud by running `gcloud auth login`. Then, you can push any image
with something like: `gcloud docker -- push gcr.io/fonoster-app/image:1.0.{timestamp}`

### NFS installation, configuration and maintenance

Install a virtual machine using Google Cloud Launcher. Then go to:

    Compute Engine => VM instances => nfs-server

And add the disk (disk0002). Then login using ssh and type "lsblk" to confirm that the disk is available.
Mount the disk and ensure is own by nobody@nogroup.

It also neccesary to change permissions to nobody@nogroup so that all readers/writers can access it.
For that we need to create a job to change the permissions of the media files, originally own by Asterisk.

Cronjob is as follows:

```
* * * * * sh -c "chown -R nobody:nogroup /mnt/disk0002/recordings"
```

Note: This will be unsusteinable as the amount of files grows.