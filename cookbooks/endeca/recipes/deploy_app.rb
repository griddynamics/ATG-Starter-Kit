#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "endeca::default"

directory node[:endeca][:apps_dir] do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
end

template "#{node[:endeca][:tmp_dir]}/deploy_config.xml" do
	source "install_config.xml.erb"
	owner "root"
	group "root"
	mode "0644"
end

bash "Deploy Endeca CRS application" do
	user "root"
	cwd "#{node[:endeca][:tmp_dir]}"
	code <<-EOH
	source #{node[:endeca][:installation_dir]}/endeca/PlatformServices/workspace/setup/installer_sh.ini
	source #{node[:endeca][:mdex][:installation_dir]}/endeca/MDEX/#{node[:endeca][:mdex][:version]}/mdex_setup_sh.ini
	#{node[:endeca][:installation_dir]}/endeca/ToolsAndFrameworks/#{node[:endeca][:taf][:version]}/deployment_template/bin/deploy.sh \
	--install-config ./deploy_config.xml --app #{node[:endeca][:deploy][:app_source_dir]}/deploy.xml --no-prompt
	EOH
end

bash "Init Endeca #{node[:endeca][:deploy][:app_name]} Application" do
	user "root"
	cwd "#{node[:endeca][:tmp_dir]}"
	code <<-EOH
	source #{node[:endeca][:installation_dir]}/endeca/PlatformServices/workspace/setup/installer_sh.ini
	source #{node[:endeca][:mdex][:installation_dir]}/endeca/MDEX/#{node[:endeca][:mdex][:version]}/mdex_setup_sh.ini
	sed -i '90 s/^/#/' #{node[:endeca][:apps_dir]}/#{node[:endeca][:deploy][:app_name]}/control/initialize_services.sh
	#{node[:endeca][:apps_dir]}/#{node[:endeca][:deploy][:app_name]}/control/initialize_services.sh --force
	EOH
end

