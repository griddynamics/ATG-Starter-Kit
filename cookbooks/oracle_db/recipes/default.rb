#
# Copyright 2014, Grid Dynamics International, Inc.
#

swap_file "#{node[:oracle_db][:swap_dir]}/swapfile" do
	size 2100
	not_if { File.exists?("#{node[:oracle_db][:swap_dir]}/swapfile") }
end

file "#{node[:oracle_db][:log_file]}" do
	action [:delete, :create]
	owner "root"
	group "root"
	mode 0755
end

unless node[:oracle_db][:oracle_installation_dir] == "/u01"
	[ "/u01", "#{node[:oracle_db][:installation_dir]}"].each do |dir|
		directory dir do
			action :create
			owner "root"
			group "root"
			mode 00755
			recursive true
		end
	end

	mount "/u01" do
		device "#{node[:oracle_db][:installation_dir]}"
	    fstype "none"
	    options "bind"
	    action [:mount, :enable]
	    not_if 
	end
end

directory "#{node[:oracle_db][:tmp_dir]}" do
	owner "root"
	group "root"
	mode 00755
	action :create
	recursive true
	not_if { File.exists?("#{node[:oracle_db][:tmp_dir]}") }
end

remote_file "#{node[:oracle_db][:tmp_dir]}/oracle-xe.zip" do
	action :create_if_missing
	owner "root"
	group "root"
	mode 00755
	source "#{node[:oracle_db][:url]}"
	checksum "sha256checksum"
end

execute "unzip oracle-xe-11" do
	command "unzip -o #{node[:oracle_db][:tmp_dir]}/oracle-xe.zip >> #{node[:oracle_db][:log_file]}"
	cwd "#{node[:oracle_db][:tmp_dir]}"
	not_if { File.exists?("#{node[:oracle_db][:tmp_dir]}/Disk1") }
	action :run
end

template "#{node[:oracle_db][:tmp_dir]}/xe.rsp" do
	source "xe.rsp.erb"
	owner "root"
	group "root"
	variables(node[:oracle_db][:xe_config])
	mode 00755
end

yum_package "oracle-xe-11.2.0-1.0" do
	source "#{node[:oracle_db][:tmp_dir]}/Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm"
	retries 5
	action :install
	not_if { File.directory?("/u01/app/oracle") }
end

execute "Configuring OracleDB" do
	command "service oracle-xe configure responseFile=#{node[:oracle_db][:tmp_dir]}/xe.rsp >> #{node[:oracle_db][:log_file]}"
	action :run
	not_if { File.exists?("/etc/sysconfig/oracle-xe") }
end

service "oracle-xe" do
	supports :status => true, :restart => true
	action :start
end

cookbook_file "/etc/profile.d/oracle_xe.sh" do
	source "oracle_xe.sh"
	owner "root"
	group "root"
	mode 00755
end

bash "Exporting Oracle database environment properties" do
	code <<-EOF
	source /etc/profile.d/oracle_xe.sh
	export LD_LIBRARY_PATH=`echo $ORACLE_HOME`
	EOF
	action :run
end

package "gcc" do
	action :install
end

ENV["ORACLE_HOME"] = "#{node[:oracle_db][:installation_dir]}/app/oracle/product/11.2.0/xe"

gem_package "ruby-oci8" do
	action :install
end



