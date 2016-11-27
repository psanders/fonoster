jetty README
==================

This cookbook installs Jetty Web Server. It will install the appropriate platform-specific 
chef-server Omnibus package from Package Cloud and perform the initial configuration.

Requirements
============

This cookbook is tested with  Chef (client) 12. It may work with or
without modification on earlier versions of Chef, but Chef 12 is
recommended.

## Depends

* depends 'java', '>= 1.39.0'
* depends 'users'

## Platform

This cookbook is tested on the following platforms using the
[Test Kitchen](http://kitchen.ci) `.kitchen.yml` in the repository.

- Ubuntu 14.04, 14.10 64-bit

Attributes
==========

The attributes used by this cookbook are under the `jetty` name
space.

Attribute        | Description                    | Default
-----------------|--------------------------------|-------------------
home             | location of jetty installation | /opt/jetty
base             | jetty base for easy updates    | /opt/app-base
http.port        | http port                      | 8080
https.port       | secure port                    | 8445

Note: For more attributes go to 'attributes/default/default.rb'

Recipes
=======

This section describes the recipes in the cookbook and how to use them
in your environment.


## default

This recipe:

- Installs Jetty 9.x
- Creates users jetty and fonoster
- Configure Jetty to run as a service
- Creates and configures jetty.base
- Configures the server to work with ssl and https

# License and Authors

* Author: Pedro Sanders <fonosterteam@fonoster.com>
* Copyright 2016, Fonoster Inc
