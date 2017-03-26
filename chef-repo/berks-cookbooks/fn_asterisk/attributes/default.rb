# Manager config
default[:asterisk][:version]                   = '11'
default[:asterisk][:manager][:username]        = 'admin'
default[:asterisk][:manager][:secret]          = '308a002ab539471394a06ce710bc96c2'
default[:asterisk][:manager][:bindAddr]        = '0.0.0.0'
default[:asterisk][:manager][:port]            = 5038
default[:asterisk][:recordingsPath]            = '/var/lib/fonoster/recordings'

# Sip Server
default[:sip][:server][:username]              = 'ms'
default[:sip][:server][:secret]                = '1c3cr34m'
default[:sip][:server][:host]                  = 'fnapp'
default[:sip][:server][:port]                  = 5060