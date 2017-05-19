# Cooking Sip I/O

include_recipe 'users'

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

cookbook_file "/tmp/sipio-vendor-plugins-master.tar.gz" do
  source "sipio-vendor-plugins-master.tar.gz"
  action :create
end

# This needs to go. It is messy and horrible :(
bash 'Installing Sip I/O Server' do
    cwd "/tmp"
    code <<-EOH
        wget https://github.com/psanders/sip.io/archive/master.tar.gz
        tar -xzvf master.tar.gz
        cp -rf sipio-master/* #{node['sipio']['home']}

        # Installing the vendor plugin
        mkdir #{node['sipio']['home']}/mod/vendor
        tar -xzvf sipio-vendor-plugins-master.tar.gz
        mv sipio-vendor-plugins-master/fn_resources #{node['sipio']['home']}/mod/vendor

        # Installing the JDK9
        wget http://download.java.net/java/jdk9/archive/169/binaries/jdk-9-ea+169_linux-x64_bin.tar.gz
        tar xvf jdk-9-ea+169_linux-x64_bin.tar.gz
        mv jdk-9 #{node['sipio']['home']}
    EOH
end

template "#{node['sipio']['home']}/sipio" do
  source 'sipio.erb'
  mode '0755'
end

template "#{node['sipio']['home']}/sipioctl" do
  source 'sipioctl.erb'
  mode '0755'
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
