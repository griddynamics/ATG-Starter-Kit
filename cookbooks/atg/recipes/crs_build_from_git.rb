#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe "atg::default"

directory "#{node[:atg][:installation_dir]}/CommerceReferenceStore/Store" do
	owner "root"
	group "root"
	mode "0755"
	action :delete
	recursive true
end

git "#{node[:atg][:installation_dir]}/CommerceReferenceStore/Store" do
	repository "#{node[:atg][:crs][:git_url]}"
	reference "#{node[:atg][:crs][:git_revision]}"
	action :sync
end

begin
	execute "Building CRS" do
		command "ant all > #{node[:atg][:log_dir]}/ant_build_#{Time.now.strftime("%H:%M_%m-%d-%Y")}"
		environment({ 
			"DYNAMO_HOME" => "#{node[:atg][:installation_dir]}/home" 
		})
		cwd "#{node[:atg][:installation_dir]}/CommerceReferenceStore/Store"
		action :run
	end
rescue
	git "#{node[:atg][:installation_dir]}/CommerceReferenceStore/Store" do
		repository "#{node[:atg][:crs][:git_url]}"
		reference "#{node[:atg][:crs][:git_revision]}"
		action :sync
		notifies :run, "execute[Building CRS]", :immediately
	end
end


