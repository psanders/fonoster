# Astive Config
default['astive']['file']               = 'astivetoolkit-server-1.0.6'
default['astive']['home']               = '/opt/astive'
default['astive']['user']               = 'astive'
default['astive']['group']              = 'astive'

# Daemon config
default[:astived][:bindAddr]            = '0.0.0.0'
default[:astived][:bindPort]            = 4573
default[:astived][:backlog]             = 1000
default[:astived][:threads]             = 1000
default[:astived][:onlyFrom]            = '*'
