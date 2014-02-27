#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "endeca::tools_and_frameworks"

remote_file "#{node[:endeca][:tmp_dir]}/cas.sh" do
  action :create_if_missing
  owner "root"
  group "root"
  mode "0755"
  source "#{node[:endeca][:cas][:url]}"
end

template "#{node[:endeca][:tmp_dir]}/silent_cas.txt" do
	source "silent_cas.txt.erb"
	owner "root"
	group "root"
	mode "0644"
end

bash "Installing Endeca Content Acquisition Systemg" do
	user "root"
	code <<-EOH
	source #{node[:endeca][:installation_dir]}/endeca/Workbench/workspace/setup/installer_sh.ini
	#{node[:endeca][:tmp_dir]}/cas.sh --silent --target #{node[:endeca][:installation_dir]} < #{node[:endeca][:tmp_dir]}/silent_cas.txt > #{node[:endeca][:log_dir]}/cas.log
	EOH
end

directory "#{node[:endeca][:installation_dir]}/endeca/CAS/workspace/setup" do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
end

template "#{node[:endeca][:installation_dir]}/endeca/CAS/workspace/setup/start.sh" do
	source "start_cas.erb"
	owner "root"
	group "root"
	mode "0755"
end

service "workbench" do
	action :stop
end

execute "Starting Endeca Content Acquisition System" do
	user "root"
	command "nohup sh #{node[:endeca][:installation_dir]}/endeca/CAS/workspace/setup/start.sh&"
	action :run
end

service "workbench" do
	action :start
end

file "#{node[:endeca][:tmp_dir]}/cas.sh" do
	action :delete
	owner "root"
	group "root"
	mode "0644"
end



