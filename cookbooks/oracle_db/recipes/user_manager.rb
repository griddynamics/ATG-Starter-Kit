#
# Copyright 2014, Grid Dynamics International, Inc.
#

oracledb_connection_info = {
  :host     => 'localhost',
  :username => 'system',
  :password => node[:oracle_db][:xe_config][:admin_password],
  :sid => 'XE',
  :port => node[:oracle_db][:xe_config][:listener_port]
}

ENV["ORACLE_HOME"] = "#{node[:oracle_db][:installation_dir]}/app/oracle/product/11.2.0/xe"
ENV["NLS_LANG"] = "#{node[:oracle_db][:nls_lang]}"

oracle_database_user node[:oracle_db][:user_manager][:username] do
	connection oracledb_connection_info
	password node[:oracle_db][:user_manager][:password]
	action node[:oracle_db][:user_manager][:action]
end

oracle_database_user node[:oracle_db][:user_manager][:username] do
	connection oracledb_connection_info
	privileges node[:oracle_db][:user_manager][:permissions]
	action :grant
end
