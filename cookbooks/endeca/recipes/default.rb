#
# Copyright 2014, Grid Dynamics International, Inc.
#

directory "#{node[:endeca][:tmp_dir]}" do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
end

directory "#{node[:endeca][:log_dir]}" do
	owner "root"
	group "root"
	mode "0755"
	action :create
end

yum_package "glibc" do
	arch "i686"
	action :install
end

["tar", "unzip", "perl", "dos2unix" ].each do |pkg|
	package pkg do
		action :install
	end
end
	