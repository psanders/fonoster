# Fonoster Integration

## Requirements

They are other requirements, but they are part of a package and should be maintained by the DevOps team. 

* Java 1.8+
* Docker 1.10+

## Continuous Integration Process

Run the `verify.sh` script generate docker images for fonoster app, mongodb and asterisk. This script will create a 
docker image call "fncd". This image has all the tools and credentials to access Google Cloud Engine (GCE) in behalf 
of fonoster-app. To specify the image tag you may use the following flag `-Ddocker.image.tag=1.0.201611292138`


## Developer Mode

In order to run in "developer mode" yo must run start the docker images(fnast & fnmongodb) and then run jetty. To do so, 
go to root of `fnintegration` and run this:

```
mvn docker:start -Pit
cd modules/webui
mvn jetty:run
```

You can now make changes in webui and see those changes at http://localhost:8181

## Environmental Variables

All of the containers are loosely couple. They connect to each other via exposed services. The following environment 
variables can be use to replace the defaults (at /etc/fonoster.conf):

- ASTIVED_HOST
- ASTIVED_PORT
- MANAGER_HOST
- MANAGER_PORT
- DB_HOST
- DB_PORT

## Capabilities of the fncd(continuous delivery) 

### Push Image

The script `/opt/fn/scripts/push_image.sh` will upload a given image to cloud registry. The script expects this format:
`{REGISTRY}/{CLOUD APP}/{IMAGE NAME}`. Here is an example:

```
docker run -v /var/run/docker.sock:/var/run/docker.sock fncd:latest \
    /opt/fn/scripts/push_image.sh gcr.io/fonoster-app/fnapp:1.0.201612032130
```

### Deliver Image

In order to deploy your new image you must use the script `/opt/fn/scripts/deploy.sh` which will cause google cloud to 
replace the current image by a given one. This scripts, receive the name space(qa|prod) and TAG. The TAG is the version that 
you want to send "live". Here is an example:

```
docker run -v /var/run/docker.sock:/var/run/docker.sock fncd:latest \
    /opt/fn/scripts/deploy.sh qa 1.0.201611292138
```


### Disk Backup/Snapshot

To create a backup of the disk @GCE (specially before updates) use the script `/opt/fn/scripts/dish_snapshot.sh` which which 
creates a "snapshot" of a given disk at google cloud. It takes as argument the ID/name of the disk.

Example:

```
docker run -v /var/run/docker.sock:/var/run/docker.sock fncd:latest \
    /opt/fn/scripts/disk_snapshot.sh disk0001
```
