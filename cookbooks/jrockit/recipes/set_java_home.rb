ruby_block  "set-env-java-home" do
	block do
		ENV["JAVA_HOME"] = node[:jrockit][:home]
	end
	not_if { ENV["JAVA_HOME"] == node[:jrockit][:home] }
end

directory "/etc/profile.d" do
	mode 00755
end

file "/etc/profile.d/jdk.sh" do
	content "export JAVA_HOME=#{node[:jrockit][:home]}"
	mode 00755
end

