default[:endeca][:installation_dir] = "/opt"
default[:endeca][:log_dir] = "/var/log/endeca_install"
default[:endeca][:tmp_dir] = "/tmp"
default[:endeca][:apps_dir] = "#{node[:endeca][:installation_dir]}/endeca/apps"
default[:endeca][:user] = "root"

default[:endeca][:platform_services][:url] = nil
default[:endeca][:platform_services][:include_eac] = true
default[:endeca][:platform_services][:include_reference] = true
default[:endeca][:platform_services][:ports][:http] = 8888
default[:endeca][:platform_services][:ports][:shutdown] = 8090
default[:endeca][:platform_services][:ports][:jcd] = 8088

default[:endeca][:presentation_api][:url] = nil

default[:endeca][:mdex][:url] = nil
default[:endeca][:mdex][:version] = "6.4.1.2"
default[:endeca][:mdex][:installation_dir] = "#{node[:endeca][:installation_dir]}"

default[:endeca][:workbench][:url] = nil
default[:endeca][:workbench][:ports][:http] = 8006
default[:endeca][:workbench][:ports][:shutdown] = 8084

default[:endeca][:cas][:url] = nil
default[:endeca][:cas][:version] = "3.1.2.1"
default[:endeca][:cas][:host] = "localhost"
default[:endeca][:cas][:ports][:http] = 8500
default[:endeca][:cas][:ports][:shutdown] = 8085

default[:endeca][:taf][:url] = nil
default[:endeca][:taf][:version] = "3.1.2"

default[:endeca][:deploy][:app_name] = "CRS"
default[:endeca][:deploy][:app_config] = nil
default[:endeca][:deploy][:app_source_dir] = nil
