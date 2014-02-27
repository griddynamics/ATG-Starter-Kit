#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "atg::default"

unless node[:weblogic][:manager_scripts].nil?
	manage_scripts_dir = node[:weblogic][:manager_scripts]
else
	template "#{node[:atg][:tmp_dir]}/wlst/start_admin_server.py" do
		source "weblogic/manage_admin_server.py.erb"
		owner "root"
		group "root"
		variables({ :action => :start })
		mode 00644
	end
	manage_scripts_dir = "#{node[:atg][:tmp_dir]}/wlst"
end

wlst_script "Starting Weblogic AdminServer" do
	script "#{manage_scripts_dir}/start_admin_server.py"
end

bash "Waiting Weblogic start" do
	user "root"
	code <<-EOH
	while [ "`curl -s -w "%{http_code}" "http://localhost:7001/console/login/LoginForm.jsp" -o /dev/null`" == "000" ];
	do
		sleep 10
	done
	if [ "`curl -s -w "%{http_code}" "http://localhost:7001/console/login/LoginForm.jsp" -o /dev/null`" == "200" ];
	then
		exit 0
	else
		exit 1
	fi
	EOH
end

template "#{node[:atg][:tmp_dir]}/crs_redeploy.cim" do
	source "cim/crs_redeploy.erb"
	owner "root"
	group "root"
	mode 00644
end

execute "Backuping log" do
	command "mv #{node[:atg][:tmp_dir]}/crs_redeploy.log{,.1}"
	creates "#{node[:atg][:tmp_dir]}/crs_redeploy.log.1"
	only_if { File.exists?("#{node[:atg][:tmp_dir]}/crs_redeploy.log") }
	action :run
end	

execute "Redeploying CRS" do
	command "#{node[:atg][:home]}/bin/cim.sh -batch #{node[:atg][:tmp_dir]}/crs_redeploy.cim &> #{node[:atg][:tmp_dir]}/crs_redeploy.log"
	action :run
end

include_recipe "atg::setup_weblogic"

