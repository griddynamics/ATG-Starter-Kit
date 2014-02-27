#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "atg::default"

template "#{node[:atg][:tmp_dir]}/weblogic_config.py" do
	source "weblogic/config.py.erb"
	owner "root"
	group "root"
	mode 00644
end

template "#{node[:atg][:tmp_dir]}/disable_weblogic_auth.py" do
	source "weblogic/disable_weblogic_auth.py.erb"
	owner "root"
	group "root"
	mode 00644
end

template "#{node[:atg][:tmp_dir]}/start_atg_instances.py" do
	source "weblogic/start_atg_instances.py.erb"
	owner "root"
	group "root"
	mode 00644
end

[ "weblogic_config", "disable_weblogic_auth", "start_atg_instances" ].each do |script|
	wlst_script "#{script}" do
		script "#{node[:atg][:tmp_dir]}/#{script}.py"
		log "#{node[:atg][:log_dir]}/#{script}.log"
	end
end
