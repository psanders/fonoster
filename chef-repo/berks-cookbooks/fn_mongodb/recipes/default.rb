# MongoDB

bash 'add mongodb-org keyserver' do
  code <<-EOH
    KEY_LIST=$(apt-key list)

    if echo "$KEY_LIST" | grep -q "#{node[:mongodb][:package][:key]}"; then
      echo "Keyserver #{node[:mongodb][:package][:key]} is already installed";
    else
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv #{node[:mongodb][:package][:key]}
        echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/#{node[:mongodb][:package][:version]} multiverse" | tee /etc/apt/sources.list.d/mongodb-org-#{node[:mongodb][:package][:version]}.list
        apt-get update
        apt-get install -y mongodb-org
    fi
  EOH
end

template "/etc/mongod.conf" do
    source 'mongod.conf.erb'
end

# Deprecated
#service 'mongod' do
#  supports :status => false
#  action [:enable, :stop, :start]
#end
