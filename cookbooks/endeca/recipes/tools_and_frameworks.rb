#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "endeca::default"
include_recipe "endeca::mdex"
include_recipe "endeca::platform_services"
include_recipe "endeca::presentation_api"

remote_file "#{node[:endeca][:tmp_dir]}/tool_and_frameworks.zip" do
  action :create_if_missing
  owner "root"
  group "root"
  mode "0644"
  source "#{node[:endeca][:taf][:url]}"
end

execute "Unpacking Tools and Frameworks" do
	command "unzip #{node[:endeca][:tmp_dir]}/tool_and_frameworks.zip -d #{node[:endeca][:installation_dir]}/endeca > /dev/null"
	action :run
	not_if { File.directory?("#{node[:endeca][:installation_dir]}/endeca/ToolsAndFrameworks") }
end

template "/etc/init.d/workbench" do
	source "workbench_service.erb"
	owner "root"
	group "root"
	mode "0755"
end

execute "chkconfig workbench" do
	command "/sbin/chkconfig --add workbench"
	user "root"
	action :run
end

service "workbench" do
	supports :start => true, :stop => true
	action [ :enable, :start ]
end

file "#{node[:endeca][:tmp_dir]}/tool_and_frameworks.zip" do
  action :delete
  owner "root"
  group "root"
  mode "0644"
end

bash "Waiting Endeca Workbench start" do
  user "root"
  code <<-EOH
  while [ "`curl -s -w "%{http_code}" "http://localhost:8006" -o /dev/null`" == "000" ];
  do
  	sleep 10
  done
  if [ "`curl -s -w "%{http_code}" "http://localhost:8006" -o /dev/null`" == "200" ];
  then
  	exit 0
  else
  	exit 1
  fi
  EOH
end
