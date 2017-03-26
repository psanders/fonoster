# Base settings

include_recipe 'users'

%w( fonoster sysadmin ).each do |group|
    users_manage group do
        action [ :remove, :create ]
    end
end
