#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "endeca::default"

remote_file "#{node[:endeca][:tmp_dir]}/platform_services.sh" do
  action :create_if_missing
  owner "root"
  group "root"
  mode "0755"
  source "#{node[:endeca][:platform_services][:url]}"
end

template "#{node[:endeca][:tmp_dir]}/silent_platform_services.txt" do
	source "silent_platform_services.txt.erb"
	owner "root"
	group "root"
	mode "0644"
end

execute "Installing Endeca Platform Services" do
	command "#{node[:endeca][:tmp_dir]}/platform_services.sh --silent --target #{node[:endeca][:installation_dir]} < #{node[:endeca][:tmp_dir]}/silent_platform_services.txt > #{node[:endeca][:log_dir]}/platform_services.log"
	action :run
	not_if { File.directory?("#{node[:endeca][:installation_dir]}/endeca/PlatformServices") }
end

bash "Exporting env properties" do
	user "root"
	code <<-EOH
	source #{node[:endeca][:installation_dir]}/endeca/PlatformServices/workspace/setup/installer_sh.ini
	EOH
end

template "#{node[:endeca][:installation_dir]}/endeca/PlatformServices/workspace/setup/start.sh" do
	source "start_http_ps.erb"
	owner "root"
	group "root"
	mode "0755"
end

execute "Starting Endeca Platform Services" do
	user "root"
	command "nohup sh #{node[:endeca][:installation_dir]}/endeca/PlatformServices/workspace/setup/start.sh&"
	action :run
end

file "#{node[:endeca][:tmp_dir]}/platform_services.sh" do
	action :delete
	owner "root"
	group "root"
	mode "0644"
end
