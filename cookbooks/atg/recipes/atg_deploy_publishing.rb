#
# Copyright 2014, Grid Dynamics International, Inc.
#

cookbook_file "#{node[:atg][:tmp_dir]}/atg_deploy_publishing.py" do
	source "atg_deploy_publishing.py"
	owner "root"
	group "root"
	mode "0644"
end

cookbook_file "#{node[:atg][:tmp_dir]}/deploymentTopology.xml" do
	source "deploymentTopology.xml"
	action :create
	owner "root"
	group "root"
	mode "0644"
end

[ "requests", "htmlparser", "argparse" ].each do |python_lib| 
	execute "easy_install #{python_lib}" do
		command "easy_install #{python_lib} >> #{node[:atg][:log_dir]}/python_libs_install.log"
		action :run
	end
end

execute "Running ATG BCC publishing server deployment" do
    command "python #{node[:atg][:tmp_dir]}/atg_deploy_publishing.py \
    -host localhost -port #{node[:atg][:publishing][:ports][:http]} \
    -user admin \
    -pass #{node[:atg][:admin_password]} \
    -f #{node[:atg][:tmp_dir]}/deploymentTopology.xml > #{node[:atg][:log_dir]}/atg_deploy_publishing.log"
    action :run
end

