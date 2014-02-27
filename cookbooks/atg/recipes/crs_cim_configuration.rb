#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "atg::default"

cim_batch_file_template = node[:atg][:cim][:batch_file]

template "#{node[:atg][:tmp_dir]}/cim_batch_file.cim" do
	source "cim/#{cim_batch_file_template}"
	owner "root"
	group "root"
	mode 00644
end

execute "Run CRS configuration with CIM" do
	command "#{node[:atg][:home]}/bin/cim.sh -batch #{node[:atg][:tmp_dir]}/cim_batch_file.cim &>#{node[:atg][:log_dir]}/cim.log"
	action :run
end

