#
# Copyright 2014, Grid Dynamics International, Inc.
#

include_recipe 'atg::default'

data_sources = [:production, :publishing]
data_sources << :switch_a << :switch_b unless node[:atg][:non_switching]

ENV["ORACLE_HOME"] = "#{node[:oracle_db][:installation_dir]}/app/oracle/product/11.2.0/xe"
ENV["NLS_LANG"] = "#{node[:oracle_db][:nls_lang]}"

data_sources.each do |data_source|
	oracle_database_user node[:atg][data_source][:db][:username] do
		connection node[:atg][:db]
		password node[:atg][data_source][:db][:password]
		action :create
	end

	oracle_database_user node[:atg][data_source][:db][:username] do
		connection node[:atg][:db]
		privileges node[:oracle_db][:user_manager][:permissions]
		action :grant
	end
end

bash "Adding datafile: #{node[:oracle_db][:installation_dir]}/app/oracle/oradata/XE/system02.dbf" do
	user 'root'
	code <<-EOH
	source /etc/profile.d/oracle_xe.sh
	sqlplus -S system/#{node[:atg][:db][:password]} <<-EOF
	ALTER TABLESPACE system ADD DATAFILE '#{node[:oracle_db][:installation_dir]}/oracle/oradata/XE/system02.dbf' SIZE 1G AUTOEXTEND OFF;
	EOF
	EOH
end
