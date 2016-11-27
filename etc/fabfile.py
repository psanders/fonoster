#!/usr/bin/env python
from fabric.api import env, run, get, put, sudo, hosts, run, settings
from fabric.colors import green, yellow

env.user = 'fonoster'
env.key_filename = 'public_keys/fonoster_rsa.pub'

# Copy the database
def dump_db():
    run('mongodump -d fonoster')
    run('tar -zcf /tmp/fonoster_db.tar.gz dump/')
    run('rm -rf dump/')
    get('/tmp/fonoster_db.tar.gz', '.')
    run('rm /tmp/fonoster_db.tar.gz')

# Restore the database
def restore_db(backup_file):
    put(backup_file, '/tmp')
    run('tar -xvf /tmp/fonoster_db.tar.gz -C /tmp')
    run('mongorestore /tmp/dump/fonoster -d fonoster')
    run('rm /tmp/fonoster_db.tar')
    run('rm -rf /tmp/dump')

# Retrieve media from host (ie.: /opt/fserver/media/recordings)
def copy_recordings(path_to_recordings):
    with settings(warn_only=True):
        sudo("mkdir -p /tmp/media/recordings")
        sudo("rsync -avm --include='*.mp3' -f 'hide,! */' " + path_to_recordings +" /tmp/media/recordings")
    sudo('tar -zcf /tmp/fonoster_recordings.tar.gz -C ' + path_to_recordings + ' ../recordings')
    get('/tmp/fonoster_recordings.tar.gz', '.')
    sudo('rm -rf /tmp/media/ /tmp/fonoster_recordings.tar.gz')

# Restore media into host
def restore_recordings(path_to_recordings, restore_at):
    put(path_to_recordings, '/tmp')
    sudo('tar -xvf /tmp/fonoster_recordings.tar.gz')
    sudo('rsync -a /tmp/media/ ' + restore_at)
    sudo('rm -rf /tmp/media /tmp/fonoster_recordings.tar.gz')

def upload_file(local_file, remote_dir):
    put(local_file, remote_dir)

def download_file(remote_file):
    get(remote_file, '')