#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "endeca::default"

remote_file "#{node[:endeca][:tmp_dir]}/presentation_api.tgz" do
  action :create_if_missing
  owner "root"
  group "root"
  mode "0644"
  source "#{node[:endeca][:presentation_api][:url]}"
end

execute "Unpacking PresentationAPI" do
	command "tar xfv #{node[:endeca][:tmp_dir]}/presentation_api.tgz --directory #{node[:endeca][:installation_dir]}"
	action :run
	not_if { File.directory?("#{node[:endeca][:installation_dir]}/endeca/PresentationAPI") }
end

