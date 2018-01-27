# Fonoster Server Config
default[:fonoster][:user]           = 'fonoster'
default[:fonoster][:version]        = 'v1'
default[:fonoster][:recordingsPath] = '/var/lib/fonoster/recordings'
default[:fonoster][:ttsStorePath]   = '/var/lib/fonoster/tts'
default[:admin][:username]          = 'admin'
default[:admin][:secret]            = '308a002ab539471394a06ce710bc96c2'

# Asterisk Manager
default[:ast][:manager][:host]       = 'mediaserver'
default[:ast][:manager][:port]       = 5038
default[:ast][:manager][:username]   = 'admin'
default[:ast][:manager][:secret]     = '308a002ab539471394a06ce710bc96c2'
default[:ast][:dialplan][:context]   = 'fnus1'
default[:ast][:dialplan][:ext]       = 'ast'

# Astive Server
default[:astived][:host]            = 'mediaserver'
default[:astived][:port]            = 4573

# Mongo config
default[:db][:host]                 = 'fndb'
default[:db][:port]                 = 27017
default[:db][:username]             = 'fonoster'
default[:db][:secret]               = '308a002ab539471394a06ce710bc96c2'
default[:db][:name]                 = 'fonoster'

# BrainTree (Payment Gateway)
default[:braintree][:environment]   = 'PRODUCTION'
default[:braintree][:merchantId]    = 'ft8bhvgwjcm74fvz'
default[:braintree][:publicKey]     = 'sbd8s4rrdwqms4j5'
default[:braintree][:privateKey]    = '35906b1648479a702a9a9561e7defdba'

# Bluemix TTS Service Credentials
default[:bluemix][:username]        = 'd9cae017-96b8-4840-a614-39530a7a0897'
default[:bluemix][:password]        = 'BDp2zNifptqF'

# Mailgun Config
default[:mailgun][:resource]        = 'https://api.mailgun.net/v3/fonoster.com/messages'
default[:mailgun][:apiKey]          = 'key-6b882d7dab7126118ac4456330a2dd75'
default[:mailgun][:username]        = 'postmaster@fonoster.com'
default[:mailgun][:password]        = '32f317baf25312e1745870157ae63a5a'