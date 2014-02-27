#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "endeca::default"

remote_file "#{node[:endeca][:tmp_dir]}/mdex.sh" do
  action :create_if_missing
  owner "root"
  group "root"
  mode "0755"
  source "#{node[:endeca][:mdex][:url]}"
end

execute "Installing Endeca MDEX" do
	command "#{node[:endeca][:tmp_dir]}/mdex.sh --silent --target #{node[:endeca][:installation_dir]} > #{node[:endeca][:log_dir]}/mdex.log"
	action :run
	not_if { File.directory?("#{node[:endeca][:installation_dir]}/endeca/MDEX") }
end

bash "Exporting env properties" do
	user "root"
	code <<-EOH
	source #{node[:endeca][:mdex][:installation_dir]}/endeca/MDEX/#{node[:endeca][:mdex][:version]}/mdex_setup_sh.ini
	EOH
end

file "#{node[:endeca][:tmp_dir]}/mdex.sh" do
	action :delete
	owner "root"
	group "root"
	mode "0644"
end
