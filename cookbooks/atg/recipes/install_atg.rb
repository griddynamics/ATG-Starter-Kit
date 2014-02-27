#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "atg::default"

remote_file "#{node[:atg][:tmp_dir]}/atg.bin" do
	action :create_if_missing
	owner "root"
	group "root"
	mode 00755
	source "#{node[:atg][:binary_url]}"
	checksum "sha256checksum"
end

template "#{node[:atg][:tmp_dir]}/atg_platform_installation.properties" do
	source "installation/atg_platform.properties.erb"
	owner "root"
	group "root"
	mode "0644"
end

execute "Installing ATG Platform" do
	command "#{node[:atg][:tmp_dir]}/atg.bin -f #{node[:atg][:tmp_dir]}/atg_platform_installation.properties -i silent"
	action :run
	only_if { Dir["#{node[:atg][:installation_dir]}"].empty? }	
end
