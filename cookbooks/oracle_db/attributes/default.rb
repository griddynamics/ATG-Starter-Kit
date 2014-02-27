default[:oracle_db][:url] = nil
default[:oracle_db][:installation_dir] = "/u01"
default[:oracle_db][:tmp_dir] = "/tmp"
default[:oracle_db][:swap_dir] = "/"
default[:oracle_db][:log_file] = "/var/log/oracle_db_install.log"
default[:oracle_db][:nls_lang] = "AMERICAN_AMERICA.AL32UTF8"

default[:oracle_db][:xe_config][:http_port] = 8080
default[:oracle_db][:xe_config][:listener_port] = 1521
default[:oracle_db][:xe_config][:admin_password] = nil
default[:oracle_db][:xe_config][:start_on_boot] = "y"

default[:oracle_db][:user_manager][:username] = nil
default[:oracle_db][:user_manager][:password] = nil
default[:oracle_db][:user_manager][:permissions] = [:all]
default[:oracle_db][:user_manager][:action] = :create