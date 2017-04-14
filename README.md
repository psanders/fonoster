# Fonoster Operations

Read this file to obtain an inside in how to build the infrastructure that supports the Fonoster Platform. 

## Requirements

They are other requirements, but they are part of a package and should be maintained by the DevOps team. 

* Java 1.8+
* Docker 17.03+
* GCloud SDK
* Berks

To run the infrastructure in your local environment you must create the following directories and share
those files with Docker. This files will be use to create volumes and share some of the apps data.

```
/opt/rallypoint/media/recordings
/opt/rallypoint/media/tts
/opt/rallypoint/webapps
/opt/rallypoint/voiceapps
```

You can now make changes in webui and see those changes at http://localhost:8181

## Environmental Variables

All of the containers are loosely couple. They connect to each other via exposed services. The following environment 
variables can be use to replace the defaults:

1. The environment 'ASTIVED_HOST' and 'ASTIVED_PORT' are use by fnast
2. The MANAGER_HOST, MANAGER_PORT, DB_HOST and DB_PORT are use by fnapp to point to those services
3. If the environment FONOSTER_ENV is found to be equal than 'dev' the database will be populated with test data

### Pushing the images to the Cloud

First, authenticate with the Google Cloud by running `gcloud auth login`. Then, you can push any image
with something like: `gcloud docker -- push gcr.io/fonoster-app/image:1.0.{timestamp}`

### NFS installation, configuration and maintenance

Install a virtual machine provide by Google Cloud. Mount the folder(/mnt/disk0002) and ensure is own by nobody@nogroup. 
Create a Job to change permissions of the recordings file, originally own by Asterisk, and changes permissions to nobody@nogroup. 

Cronjob

```
* * * * * sh -c "chown -R nobody:nogroup /mnt/disk0002/recordings"
* * * * * sh -c "chown -R nobody:nogroup /mnt/disk0002/qa/recordings"
```

WARN: This will cause performance issues as we get more files on the server 
