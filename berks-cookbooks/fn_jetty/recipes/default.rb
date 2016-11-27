# Cooking Fonoster Jetty

include_recipe 'users'
include_recipe 'java_se'

users_manage "jetty" do
    action [:remove, :create]
end

directory "#{node[:jetty][:home]}" do
    action [:create]
end

directory "#{node[:jetty][:base]}" do
    action [:create]
end

directory "#{node[:jetty][:base]}/webapps" do
    action [:create]
end

directory "#{node[:jetty][:base]}/etc" do
    action [:create]
end

bash 'Installing Jetty' do
    cwd "/tmp"
    code <<-EOH
        curl -L  #{node[:jetty][:download][:url]}/#{node[:jetty][:download][:file]}.tar.gz > #{node[:jetty][:download][:file]}.tar.gz
        tar -xzvf #{node[:jetty][:download][:file]}.tar.gz
        cp -rf #{node[:jetty][:download][:file]}/* #{node[:jetty][:home]}
        cp #{node[:jetty][:home]}/bin/jetty.sh /etc/init.d/jetty
        update-rc.d jetty defaults
    EOH
end

ENV['JETTY_HOME'] = "#{node[:jetty][:home]}"
bash 'JETTY_HOME is' do
  code <<-EOF
    echo $FOO
  EOF
end

template '/etc/default/jetty' do
  source 'jetty.erb'
end

template "#{node[:jetty][:base]}/start.ini" do
  source 'start.ini.erb'
end

cookbook_file "#{node[:jetty][:base]}/etc/keystore" do
  source 'fonoster.keystore'
end

execute "Update jetty.home owner" do
  command "chown -Rf #{node[:jetty][:user]}:#{node[:jetty][:group]} #{node[:jetty][:home]}"
end

execute "Update jetty.base owner" do
  command "chown -Rf #{node[:jetty][:user]}:#{node[:jetty][:group]} #{node[:jetty][:base]}"
end

