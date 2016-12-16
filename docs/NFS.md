README for NFS installation, configuration and maintenance
==========================================================

Prerequisite
------------

Change permissions 
------------------

The mount folder(/mnt/disk0002) must be own by nobody@nogroup. a Job change permissions of the recordings file,
originally own by Asterisk, and changes permissions to nobody@nogroup. 

Cronjob

```
* * * * * sh -c "chown -R nobody:nogroup /mnt/disk0002/recordings"
* * * * * sh -c "chown -R nobody:nogroup /mnt/disk0002/qa/recordings"
```

WARN: This will cause performance issues as we get more files on the server 