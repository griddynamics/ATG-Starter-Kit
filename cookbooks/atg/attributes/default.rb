default[:atg][:cim][:batch_file] = "crs_with_endeca_search.erb"
default[:atg][:tmp_dir] = "/tmp"
default[:atg][:installation_dir] = "/u01/app/ATG"
default[:atg][:log_dir] = "#{node[:atg][:tmp_dir]}/logs/atg"
default[:atg][:home] = "#{node[:atg][:installation_dir]}/home"
default[:atg][:binary_url] = nil
default[:atg][:store_url] = nil
default[:atg][:crs][:git_url] = nil
default[:atg][:crs][:git_revision] = "master"
default[:atg][:non_switching] = true
default[:atg][:without_publising] = true
default[:atg][:admin_password] = nil
default[:atg][:merch_password] = nil
default[:atg][:webserver] = "Weblogic Online"

default[:atg][:bea_home] = "/opt/middleware"

default[:atg][:weblogic][:host] = node[:cloud][:public_hostname]
default[:atg][:weblogic][:port] = "7001"
default[:atg][:weblogic][:username] = "weblogic"
default[:atg][:weblogic][:password] = nil
default[:atg][:weblogic][:installation_dir] = "#{node[:atg][:bea_home]}/weblogic"
default[:atg][:weblogic][:domain_name] = node[:cloud][:public_hostname]
default[:atg][:weblogic][:domain_path] = "#{node[:atg][:bea_home]}/user_domains/#{node[:atg][:weblogic][:domain_name]}"

default[:atg][:jrockit][:installation_dir] = "#{node[:atg][:bea_home]}/jrockit"

default[:atg][:db][:username] = "system"
default[:atg][:db][:password] = nil
default[:atg][:db][:connector_url] = nil
default[:atg][:db][:host] = "localhost"
default[:atg][:db][:port] = 1521
default[:atg][:db][:sid] = "XE"

default[:atg][:production][:instance] = "atg_production_lockserver"
default[:atg][:production][:app_name] = "CRS"

default[:atg][:production][:lockserver][:host] = "localhost"
default[:atg][:production][:lockserver][:port] = 9012

default[:atg][:production][:ports][:http] = 7003
default[:atg][:production][:ports][:https] = 7004
default[:atg][:production][:ports][:rmi] = 8860
default[:atg][:production][:ports][:drp] = 8850
default[:atg][:production][:ports][:deploy] = 8810

default[:atg][:production][:db][:username] = "atg_prod"
default[:atg][:production][:db][:password] = nil
default[:atg][:production][:db][:hostname] = node[:atg][:db][:host]
default[:atg][:production][:db][:port] = node[:atg][:db][:port]
default[:atg][:production][:db][:type] = "oraclethin"
default[:atg][:production][:db][:jdni_name] = "ATGProductionDS"
default[:atg][:production][:db][:db_name] = "XE"
default[:atg][:production][:db][:driver_classpath] = "oracle.jdbc.xa.client.OracleXADataSource"

default[:atg][:publishing][:instance] = "atg_publishing_lockserver"
default[:atg][:publishing][:app_name] = "CRS"

default[:atg][:publishing][:lockserver][:host] = "localhost"
default[:atg][:publishing][:lockserver][:port] = 9010

default[:atg][:publishing][:ports][:http] = 7103
default[:atg][:publishing][:ports][:https] = 7104
default[:atg][:publishing][:ports][:rmi] = 8861
default[:atg][:publishing][:ports][:drp] = 8851
default[:atg][:publishing][:ports][:deploy] = 8811
default[:atg][:publishing][:ports][:sync_deploy] = 8816

default[:atg][:publishing][:db][:username] = "atg_publ"
default[:atg][:publishing][:db][:password] = nil
default[:atg][:publishing][:db][:hostname] = node[:atg][:db][:host]
default[:atg][:publishing][:db][:port] = node[:atg][:db][:port]
default[:atg][:publishing][:db][:type] = "oraclethin"
default[:atg][:publishing][:db][:jdni_name] = "ATGPublishingDS"
default[:atg][:publishing][:db][:db_name] = "XE"
default[:atg][:publishing][:db][:driver_classpath] = "oracle.jdbc.xa.client.OracleXADataSource"

default[:atg][:switch_a][:instance] = "atg_production_lockserver"
default[:atg][:switch_a][:db][:username] = "atg_switch_a"
default[:atg][:switch_a][:db][:password] = nil
default[:atg][:switch_a][:db][:hostname] = node[:atg][:db][:host]
default[:atg][:switch_a][:db][:port] = node[:atg][:db][:port]
default[:atg][:switch_a][:db][:type] = "oraclethin"
default[:atg][:switch_a][:db][:jdni_name] = "ATGProductionDS"
default[:atg][:switch_a][:db][:db_name] = "XE"
default[:atg][:switch_a][:db][:driver_classpath] = "oracle.jdbc.xa.client.OracleXADataSource"

default[:atg][:switch_b][:instance] = "atg_production_lockserver"
default[:atg][:switch_b][:db][:username] = "atg_switch_b"
default[:atg][:switch_b][:db][:password] = nil
default[:atg][:switch_b][:db][:hostname] = node[:atg][:db][:host]
default[:atg][:switch_b][:db][:port] = node[:atg][:db][:port]
default[:atg][:switch_b][:db][:type] = "oraclethin"
default[:atg][:switch_b][:db][:jdni_name] = "ATGProductionDS"
default[:atg][:switch_b][:db][:db_name] = "XE"
default[:atg][:switch_b][:db][:driver_classpath] = "oracle.jdbc.xa.client.OracleXADataSource"


default[:atg][:endeca][:path]="/opt/endeca"
default[:atg][:endeca][:application][:appname] = "CRS"
default[:atg][:endeca][:application][:deploymentpath] = "#{node[:atg][:endeca][:path]}/apps"
default[:atg][:endeca][:application][:rootpath] = "#{node[:atg][:endeca][:application][:deploymentpath]}/#{node[:atg][:endeca][:application][:appname]}"
default[:atg][:endeca][:eac][:port] = "8888"
default[:atg][:endeca][:eac][:hostname] = "localhost"
default[:atg][:endeca][:dgraph][:port] = "15000"
default[:atg][:endeca][:authoring][:port] = "15002"
default[:atg][:endeca][:logserver][:port] = "15010"
default[:atg][:endeca][:cas][:hostname] = "localhost"
default[:atg][:endeca][:cas][:port] = "8500"
default[:atg][:endeca][:cas][:path] =  "#{node[:atg][:endeca][:path]}/CAS/3.1.2.1"
default[:atg][:endeca][:cas][:jarversion] = "3.1.2"

default[:atg][:endeca][:application][:host]  = "localhost"

default[:atg][:endeca][:workbench][:port] = "8006"
default[:atg][:endeca][:workbench][:hostname] = "localhost"

default[:atg][:endeca][:preview][:hostname] = "localhost" 
default[:atg][:endeca][:preview][:port] = "7003"
default[:atg][:endeca][:preview][:contectRoot] = "crs"

default[:atg][:endeca][:mdex][:path] = "#{node[:atg][:endeca][:path]}/MDEX/6.4.1.2"
default[:atg][:endeca][:taf][:path] = "#{node[:atg][:endeca][:path]}/ToolsAndFrameworks/3.1.2"
default[:atg][:endeca][:ps][:path] = "#{node[:atg][:endeca][:path]}/PlatformServices/6.1.4"


