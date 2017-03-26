# Cooking Fonoster Astive

include_recipe 'users'
include_recipe 'java_se'

users_manage "astive" do
    action [:remove, :create]
end

directory "#{node['astive']['home']}" do
    action [:create]
end

cookbook_file "/tmp/#{node['astive']['file']}.tar.gz" do
  source "#{node['astive']['file']}.tar.gz"
  action :create
end

bash 'Installing Astive Server' do
    cwd "/tmp"
    code <<-EOH
        tar -xzvf #{node['astive']['file']}.tar.gz
        cp -rf #{node['astive']['file']}/* #{node['astive']['home']}
    EOH
end

template "#{node['astive']['home']}/conf/astived.properties" do
  source 'astived.properties.erb'
end

execute "Update astive.home owner" do
  command "chown -Rf #{node[:astive][:user]}:#{node[:astive][:group]} #{node[:astive][:home]}"
end
