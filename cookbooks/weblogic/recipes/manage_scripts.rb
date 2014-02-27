#
# Copyright 2014, Grid Dynamics International, Inc.
#

directory node[:weblogic][:manage_scripts_path] do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
end

template "#{node[:weblogic][:manage_scripts_path]}/start_node_manager.py" do
	source "wlst/start_node_manager.py.erb"
	owner "root"
	group "root"
	mode "0755"
end

template "#{node[:weblogic][:manage_scripts_path]}/start_admin_server.py" do
	source "wlst/manage_admin_server.py.erb"
	owner "root"
	group "root"
	mode "0755"
	variables( :action => :start )
end

template "#{node[:weblogic][:manage_scripts_path]}/stop_admin_server.py" do
	source "wlst/manage_admin_server.py.erb"
	owner "root"
	group "root"
	mode "0755"
	variables( :action => :stop )
end
