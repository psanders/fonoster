# MongoDB

cookbook_file "/run.sh" do
  source "run.sh"
  mode '0755'
end

template "/bootstrap.sh" do
  source "bootstrap.sh.erb"
  mode '0755'
end

template "/etc/mongod.conf" do
    source 'mongod.conf.erb'
end

template "/create-db-user.js" do
  source "create-db-user.js.erb"
end