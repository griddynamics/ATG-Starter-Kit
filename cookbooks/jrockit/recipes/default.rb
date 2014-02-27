directory "#{node[:jrockit][:tmp_path]}" do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
end

template "#{node[:jrockit][:tmp_path]}/jrockit_silent.xml" do
	source "silent.xml.erb"
	owner "root"
	group "root"
	mode 00644
	variables(:options => node[:jrockit][:silent_conf])
end

if /.bin$/.match("#{node[:jrockit][:binary_url]}")	
	remote_file "#{node[:jrockit][:tmp_path]}/jrockit.bin" do
	  owner "root"
	  group "root"
	  mode 00755
	  source "#{node[:jrockit][:binary_url]}"
	  checksum "sha256checksum"
	end

	execute "Installing jrockit" do
		command "#{node[:jrockit][:tmp_path]}/jrockit.bin -mode=silent -silent_xml=#{node[:jrockit][:tmp_path]}/jrockit_silent.xml"
		action :run
	end
else
	raize ArgumentError "Wrong JRockit should have .bin extention!"
end

java_location = "#{node[:jrockit][:home]}/bin/java"

if platform_family?('debian', 'rhel', 'fedora')
	bash 'update-java-alternatives' do
		code <<-EOH.gsub(/^\s+/, '')
			chmod -R 755 #{node[:jrockit][:home]}
			update-alternatives --install /usr/bin/java java #{java_location} 20000 && \
			update-alternatives --set java #{java_location}
		EOH
	end
end

include_recipe "jrockit::set_java_home"

execute "Clean up" do
	command "rm -f #{node[:jrockit][:tmp_path]}/jrockit.bin"
	user "root"
	action :run
end

