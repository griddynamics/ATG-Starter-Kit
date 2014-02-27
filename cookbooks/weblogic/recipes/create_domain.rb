#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "weblogic::manage_scripts"


unless node[:weblogic][:password] =~ /^(?=.*[A-Z]+.*)^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{8,}$/
  error_msg = 'Password must be 8 symbols long and contain at least 1 digit and 1 capital letter!'
  Chef::Log.error(error_msg)
  raise ArgumentError, error_msg
end

domain_dir = "#{node[:weblogic][:domain_home]}/#{node[:weblogic][:domain_name]}"

if File.directory?(domain_dir)
	error_msg = 'Domain already exists!'
	Chef::Log.error(error_msg)
	raise ArgumentError, error_msg
end

if node[:weblogic][:user].nil?
  raise ArgumentError, "Admin username not specified!"
end

if node[:weblogic][:password].nil?
  raise ArgumentError, "Admin user password not specified!"
end

directory domain_dir do
  owner 'root'
  group 'root'
  mode 00755
  action :create
  recursive true
end

template "#{node[:weblogic][:tmp_path]}/create_#{node[:weblogic][:domain_name]}_domain.py" do
  source "wlst/create_domain.py.erb"
  owner "root"
  group "root"
  mode "0644"
end

wlst_script "Creating #{node[:weblogic][:domain_name]} domain" do
  script "#{node[:weblogic][:tmp_path]}/create_#{node[:weblogic][:domain_name]}_domain.py"
  log "/tmp/create_domain.log"
end

wlst_script "Starting Weblogic NodeManager" do
  script "#{node[:weblogic][:manage_scripts_path]}/start_node_manager.py"
  log "/tmp/start_node_manager.log"
end

wlst_script "Starting Weblogic AdminServer" do
  script "#{node[:weblogic][:manage_scripts_path]}/start_admin_server.py"
  log "/tmp/start_admin_server.log"
end

bash "Waiting for #{node[:weblogic][:domain_name]} domain deployment" do
  user 'root'
  code <<-EOH
  while [ "`curl -s -w "%{http_code}" "http://localhost:7001/console" -o /dev/null`" == "000" ];
  do
    sleep 10
  done
  if [ "`curl -s -w "%{http_code}" "http://localhost:7001/console" -o /dev/null`" == "200" ];
  then
    exit 0
  else
    exit 1
  fi
  EOH
end
