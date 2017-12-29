# Manager config
default[:ast][:version]              = '14'
default[:ast][:manager][:username]   = 'admin'
default[:ast][:manager][:secret]     = '308a002ab539471394a06ce710bc96c2'
default[:ast][:manager][:bindAddr]   = '0.0.0.0'
default[:ast][:manager][:port]       = 5038
default[:ast][:recordingsPath]       = '/var/lib/fonoster/recordings'
default[:ast][:dialplan][:context]   = 'fnus1'
default[:ast][:dialplan][:ext]       = 'ast'

default[:ari][:username]             = 'ari'
default[:ari][:secret]               = '308a002ab539471394a06ce710bc96c2'
default[:ari][:host]                 = 'localhost'
default[:ari][:port]                 = '8088'

# Simple http server that exposes Sip I/O container's IP
default[:ipNotifier][:host]          = 'fnapp'
default[:ipNotifier][:port]          = '8001'
default[:ipConsumer][:script]        = 'proxy_ip_updater.sh'
default[:ipConsumer][:path]          = '/opt'
default[:ipConsumer][:file]          = '/opt/proxyip.old'

# Sip Proxy information
default[:sip][:server][:username]    = 'ast'
default[:sip][:server][:secret]      = 'N8p2exTu'
default[:sip][:server][:host]        = 'sip.fonoster.com'
default[:sip][:server][:port]        = 5060

# Astive Server
default[:astived][:host]             = 'fnapp'
default[:astived][:port]             = 4573