# Cooking Asterisk

# TODO: Lock to the desired version(11?)
package 'asterisk'

directory "#{node[:asterisk][:recordingsPath]}" do
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

service 'asterisk' do
  supports :status => true
  action [:enable, :stop, :start]
end