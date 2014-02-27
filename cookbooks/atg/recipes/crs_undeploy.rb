#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "atg::default"

directory "#{node[:atg][:tmp_dir]}" do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
end

template "#{node[:atg][:tmp_dir]}/wlst/stop_crs.py" do
	source "weblogic/undeploy_crs.py.erb"
	owner "root"
	group "root"
	mode 00644
end

unless node[:weblogic][:manager_scripts].nil?
	manage_scripts_dir = node[:weblogic][:manager_scripts]
else
	template "#{node[:atg][:tmp_dir]}/wlst/stop_admin_server.py" do
		source "weblogic/manage_admin_server.py.erb"
		owner "root"
		group "root"
		variables({ :action => :stop })
		mode 00644
	end
	manage_scripts_dir = "#{node[:atg][:tmp_dir]}/wlst"
end

{
	"#{node[:atg][:tmp_dir]}/wlst/stop_crs.py" => "Stopping CRS", 
	"#{manage_scripts_dir}/stop_admin_server.py" => "Stopping AdminServer"
}.each do |script_file, action|
	wlst_script action do
		script script_file
	end
end

[:production, :publishing, :switch_a, :switch_b].each do |server_name|
	directory "#{node[:atg][:weblogic][:domain_path]}/servers/#{node[:atg][server_name][:instance]}" do
		action :delete
		recursive true
	end
end
