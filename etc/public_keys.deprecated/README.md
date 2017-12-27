README SSH
==========

To gain access to Fonoster's servers via ssh a ssh_key must be use. Do the following:

1. Generate the key by running `ssh-keygen -t fonoster_rsa`
2. Ensure that ".ssh" has a permissions of 700
3. Ensure that ".ssh/fonoster_rsa.pub" has permissions of 640
4. The public key(fonoster_rsa.pub) must be added to "~/.ssh" on the server
5. Add key to keychain by running `ssh-add -K fonoster_rsa.pub`

Note: It is important that the data bag users/fonoster.json is updated with the newly created key.


ssh-keygen -t jenkins_rsa