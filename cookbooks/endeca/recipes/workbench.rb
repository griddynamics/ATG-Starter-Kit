#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "endeca::mdex"
include_recipe "endeca::platform_services"
include_recipe "endeca::presentation_api"

remote_file "#{node[:endeca][:tmp_dir]}/workbench.sh" do
  action :create_if_missing
  owner "root"
  group "root"
  mode "0755"
  source "#{node[:endeca][:workbench][:url]}"
end

template "#{node[:endeca][:tmp_dir]}/silent_workbench.txt" do
	source "silent_workbench.txt.erb"
	owner "root"
	group "root"
	mode "0644"
end

execute "Installing Endeca Workbench" do
	command "#{node[:endeca][:tmp_dir]}/workbench.sh --silent --target #{node[:endeca][:installation_dir]} < #{node[:endeca][:tmp_dir]}/silent_workbench.txt > #{node[:endeca][:log_dir]}/workbench.log"
	action :run
	not_if { File.directory?("#{node[:endeca][:installation_dir]}/endeca/Workbench") }
end

bash "Exporting env properties" do
	user "root"
	code <<-EOH
	source #{node[:endeca][:installation_dir]}/endeca/Workbench/workspace/setup/installer_sh.ini
	EOH
end

template "#{node[:endeca][:installation_dir]}/endeca/Workbench/workspace/setup/start.sh" do
	source "start_workbench.erb"
	owner "root"
	group "root"
	mode "0755"
end

execute "Starting Endeca Workbench" do
	user "root"
	command "nohup sh #{node[:endeca][:installation_dir]}/endeca/Workbench/workspace/setup/start.sh&"
	action :run
end

file "#{node[:endeca][:tmp_dir]}/workbench.sh" do
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
        if [ "`curl -s -w "%{http_code}" "http://localhost:8006" -o /dev/null`" == "302" ];
        then
        	exit 0
        else
        	exit 1
        fi
        EOH
end

