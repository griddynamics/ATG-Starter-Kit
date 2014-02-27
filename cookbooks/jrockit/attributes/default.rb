default[:jrockit][:binary_url] = nil
default[:jrockit][:tmp_path] = "/tmp"
default[:jrockit][:bea_home] = "/opt/middleware"
default[:jrockit][:home] = "#{node[:jrockit][:bea_home]}/jrockit"

default[:jrockit][:silent_conf]["USER_INSTALL_DIR"] = node[:jrockit][:home]
default[:jrockit][:silent_conf]["INSTALL_DEMOS_AND_SAMPLES"] = "false"
default[:jrockit][:silent_conf]["INSTALL_SOURCE_CODE"] = "false"
default[:jrockit][:silent_conf]["INSTALL_PUBLIC_JRE"] = "true" 

