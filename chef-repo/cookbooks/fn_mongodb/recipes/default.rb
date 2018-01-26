# MongoDB

cookbook_file "/run.sh" do
  source "run.sh"
  mode '0755'
end

cookbook_file "/etc/mongod.conf" do
  source "mongod.conf"
end

template "/bootstrap.sh" do
  source "bootstrap.sh.erb"
  mode '0755'
end

template "/admin-user.js" do
  source "admin-user.js.erb"
end

template "/app-user.js" do
  source "app-user.js.erb"
end