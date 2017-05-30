# Cooking Sip I/O

include_recipe 'users'
include_recipe 'java_se'

users_manage "fonoster" do
    action [:remove, :create]
end

directory "#{node['sipio']['home']}/config" do
    recursive true
    action [:create]
end

package 'wget' do
   action :upgrade
end

# Can't simply download this because is a private repo
cookbook_file "/tmp/sipio-vendor-plugins-master.tar.gz" do
  source "sipio-vendor-plugins-master.tar.gz"
  action :create
end

# This needs to go. It is messy and horrible :(
bash 'Installing Sip I/O Server' do
    cwd "/tmp"
    code <<-EOH
        wget #{node['sipio']['downloadUrl']}
        tar xvf #{node['sipio']['filename']}.tar.gz
        mv #{node['sipio']['filename']} #{node['sipio']['home']}
        # Maybe this should go to attributes
        tar xvf sipio-vendor-plugins-master.tar.gz
        mv sip-vendor-plugins-master/vendor #{node['sipio']['home']}/mod/
    EOH
end

template "#{node['sipio']['home']}/config/agents.yml" do
  source 'agents.yml.erb'
end

template "#{node['sipio']['home']}/config/config.yml" do
  source 'config.yml.erb'
end

template "#{node['sipio']['home']}/config/dids.yml" do
  source 'dids.yml.erb'
end

template "#{node['sipio']['home']}/config/domains.yml" do
  source 'domains.yml.erb'
end

template "#{node['sipio']['home']}/config/gateways.yml" do
  source 'gateways.yml.erb'
end

template "#{node['sipio']['home']}/config/peers.yml" do
  source 'peers.yml.erb'
end

template "#{node['sipio']['home']}/mod/core/main.js" do
  source 'main.js.erb'
end

execute "Update sipio.home owner" do
  command "chown -Rf #{node[:sipio][:user]}:#{node[:sipio][:group]} #{node[:sipio][:home]}"
end
