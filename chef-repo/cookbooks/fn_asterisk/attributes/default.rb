# Manager config
default[:ast][:version]              = '14'
default[:ast][:manager][:username]   = 'admin'
default[:ast][:manager][:secret]     = '308a002ab539471394a06ce710bc96c2'
default[:ast][:manager][:bindAddr]   = '0.0.0.0'
default[:ast][:manager][:port]       = 5038
default[:ast][:recordingsPath]       = '/var/lib/fonoster/recordings'
default[:ast][:dialplan][:context]   = 'fnus1'
default[:ast][:dialplan][:ext]       = 'ast'

# Sip Server
default[:sip][:server][:username]    = 'ast'
default[:sip][:server][:secret]      = 'N8p2exTu'
default[:sip][:server][:host]        = 'fnapp'
default[:sip][:server][:port]        = 5060

# Astive Server
default[:astived][:host]             = 'fnapp'
default[:astived][:port]             = 4573