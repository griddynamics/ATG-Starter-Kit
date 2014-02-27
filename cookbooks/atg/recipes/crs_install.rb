#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "atg::default"

remote_file "#{node[:atg][:tmp_dir]}/crs.bin" do
	action :create_if_missing
	owner "root"
	group "root"
	mode 00755
	source "#{node[:atg][:store_url]}"
	checksum "sha256checksum"
end

template "#{node[:atg][:tmp_dir]}/crs_installation.properties" do
	source "installation/crs.properties.erb"
	owner "root"
	group "root"
	mode "0644"
end

execute "Installing Commerce Reference Store" do
	command "#{node[:atg][:tmp_dir]}/crs.bin -f #{node[:atg][:tmp_dir]}/crs_installation.properties -i silent"
	not_if { File.directory?("#{node[:atg][:installation_dir]}/CRS") }
	action :run
end
