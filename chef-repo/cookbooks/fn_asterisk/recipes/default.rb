# Cooking Asterisk
include_recipe 'users'

users_manage "asterisk" do
    action [:remove, :create]
end

bash 'Installing Asterisk' do
    cwd "/tmp"
    code <<-EOH
        apt-get update -y
        apt-get install -y wget build-essential openssl libxml2-dev libncurses5-dev uuid-dev sqlite3 libsqlite3-dev pkg-config libjansson-dev
        wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-14.5.0.tar.gz
        tar xvf asterisk-14.5.0.tar.gz
        cd asterisk-14.5.0
        ./configure
        make
        make install
        make basic-pbx
    EOH
end

directory "#{node[:ast][:recordingsPath]}" do
    action [:create]
    recursive true
end

template '/etc/asterisk/manager.conf' do
  source 'manager.conf.erb'
end

template '/etc/asterisk/sip.conf' do
  source 'sip.conf.erb'
end

template '/etc/asterisk/extensions.conf' do
  source 'extensions.conf.erb'
end

template '/etc/asterisk/modules.conf' do
  source 'modules.conf.erb'
end

template '/etc/asterisk/amd.conf' do
  source 'amd.conf.erb'
end