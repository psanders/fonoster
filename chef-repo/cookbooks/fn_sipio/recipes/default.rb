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
cookbook_file "/tmp/#{node['sipio']['filename']}.tar.gz" do
  source "#{node['sipio']['filename']}.tar.gz"
  action :create
end

# This needs to go. It is messy and horrible :(
bash 'Installing Sip I/O Server' do
    cwd "/tmp"
    code <<-EOH
        tar xvf #{node['sipio']['filename']}.tar.gz
        cp -a #{node['sipio']['filename']}/* #{node['sipio']['home']}
        rm -rf #{node['sipio']['filename']} #{node['sipio']['filename']}.tar.gz
    EOH
end

template "#{node['sipio']['home']}/config/config.yml" do
  source 'config.yml.erb'
end

template "#{node['sipio']['home']}/config/peers.yml" do
  source 'peers.yml.erb'
end

execute "Update sipio.home owner" do
  command "chown -Rf #{node[:sipio][:user]}:#{node[:sipio][:group]} #{node[:sipio][:home]}"
end
