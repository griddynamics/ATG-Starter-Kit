default[:weblogic][:binary_url] = nil
default[:weblogic][:tmp_path] = "/tmp"
default[:weblogic][:bea_home] = "/opt/middleware"
default[:weblogic][:java_home] = "/usr/lib/jvm/java"
default[:weblogic][:jrockit_home] = "#{node[:weblogic][:bea_home]}/jrockit"
default[:weblogic][:weblogic_home] = "#{node[:weblogic][:bea_home]}/weblogic"
default[:weblogic][:domain_home] = "#{node[:weblogic][:bea_home]}/user_domains"
default[:weblogic][:domain_name] = node[:cloud][:public_hostname]
default[:weblogic][:user] = "weblogic"
default[:weblogic][:password] = nil
default[:weblogic][:port] = 7001
default[:weblogic][:manage_scripts_path] = "#{default[:weblogic][:weblogic_home]}/manage_scripts"

default[:weblogic][:silent_conf]["BEAHOME"] = "#{node[:weblogic][:bea_home]}"
default[:weblogic][:silent_conf]["WLS_INSTALL_DIR"] = "#{node[:weblogic][:weblogic_home]}"
default[:weblogic][:silent_conf]["COMPONENT_PATHS"] = "WebLogic Server/Core Application Server|WebLogic Server/Administration Console|WebLogic Server/Configuration Wizard and Upgrade Framework|WebLogic Server/Web 2.0 HTTP Pub-Sub Server|WebLogic Server/WebLogic JDBC Drivers|WebLogic Server/Third Party JDBC Drivers|WebLogic Server/WebLogic Server Clients|WebLogic Server/WebLogic Web Server Plugins|WebLogic Server/UDDI and Xquery Support|WebLogic Server/Server Examples|Oracle Coherence/Coherence Product Files"
default[:weblogic][:silent_conf]["INSTALL_SHORTCUT_IN_ALL_USERS_FOLDER"] = "yes"
default[:weblogic][:silent_conf]["LOCAL_JVMS"] = "#{node[:weblogic][:java_home]}|#{node[:weblogic][:bea_home]}/jrockit"