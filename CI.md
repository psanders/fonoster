README for Fonoster ci/cd
=========================

Prerequisite
------------

+ Docker 1.10.2 +
    + Gems
        - Berkshelf (https://espaces.edu.au/vwrangler/deployment-tools/opscode-chef-how-tos/getting-started-with-berkshelf)
        - Ruby >= 2.2.0 > 
        - Bundler (if not present then run gem install bundler)
        - Gcloud and Kubernetes
        - Lame and Sox
   
Install Jenkins in GC with Cloud Launcher (Will need a least 20GB)
-----------------------------------------------------------------

1. Go to developer tools to select and install bitnami's Jenkins distro. Login using the default username/password/
Then create and configure a new user "fonoster" by going into 'Manage Jenkins' -> 'Manage Users' 
and 'Configure Global Security'.

    Note: Update all the plugins

2. Install Git, Docker, Maven and the JDK(1.8). To do that, just enable each module at 'Manage Jenkins' -> 'Configure System'.

3. Finally using the plugin manager install the Github Plugin.

4. Make Docker available to tomcat running the following commands in VM's console.

Run this!

```
sudo gpasswd -a tomcat docker
sudo service docker restart
echo "tomcat ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers  // Loging as ROOT and then restart tomcat
```

Create a new Job
----------------

1. Add credentials to allow access to https://github.com/fonoster/fonoster, branch develop. 
For now user/password is OK. 
2. Configure github to hook with the new Jenkins installation


