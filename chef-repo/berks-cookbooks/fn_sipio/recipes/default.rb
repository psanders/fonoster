# Cooking Sip I/O

include_recipe 'users'

users_manage "fonoster" do
    action [:remove, :create]
end

directory "#{node['sipio']['home']}" do
    recursive true
    action [:create]
end

cookbook_file "/tmp/#{node['sipio']['file']}.tar.gz" do
  source "#{node['sipio']['file']}.tar.gz"
  action :create
end

package 'wget' do
   action :upgrade
end

# This needs to go. It is messy and horrible :(
bash 'Installing Sip I/O Server' do
    cwd "/tmp"
    code <<-EOH
        tar -xzvf #{node['sipio']['file']}.tar.gz
        cp -rf #{node['sipio']['file']}/* #{node['sipio']['home']}
        apt-get -y install wget
        wget http://www.java.net/download/java/jdk9/archive/157/binaries/jdk-9-ea+157_linux-x64_bin.tar.gz
        tar xvf jdk-9-ea+157_linux-x64_bin.tar.gz
        mv jdk-9 #{node['sipio']['home']}
    EOH
end

template "#{node['sipio']['home']}/sipio" do
  source 'sipio.erb'
end

template "#{node['sipio']['home']}/sipioctl" do
  source 'sipioctl.erb'
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

execute "Update sipio.home owner" do
  command "chown -Rf #{node[:sipio][:user]}:#{node[:sipio][:group]} #{node[:sipio][:home]}"
end
