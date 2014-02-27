#
# Copyright 2014, Grid Dynamics International, Inc.
#

execute "Add empty executable file set_media.sh" do
	command "echo ':' > #{node[:endeca][:installation_dir]}/endeca/ToolsAndFrameworks/3.1.2/deployment_template/app-templates/common/control/set_media.sh"
	not_if { File.exist?("#{node[:endeca][:installation_dir]}/endeca/ToolsAndFrameworks/3.1.2/deployment_template/app-templates/common/control/set_media.sh") }
	action :run
end

execute "Copy forge adapter  in CAS to fix version issue in file name" do
	command "cp recordstore-forge-adapter-3.1.2.1.jar recordstore-forge-adapter-3.1.2.jar"
	cwd "#{node[:endeca][:installation_dir]}/endeca/CAS/3.1.2.1/lib/recordstore-forge-adapter"
	not_if { File.exist?("#{node[:endeca][:installation_dir]}/endeca/CAS/3.1.2.1/lib/recordstore-forge-adapter/recordstore-forge-adapter-3.1.2.jar") }
	action :run
end