#
# Copyright 2014, Grid Dynamics International, Inc.
#

require 'chef/resource'

class Chef
	class Resource
		class WlstScript < Chef::Resource
			def initialize(name, run_context=nil)
				super
				@resource_name = :wlst_script
				@allowed_actions.push(:run)
		    	@action = :run
		    	@log = "/dev/null"
				@provider = Chef::Provider::WlstScript
			end

			def script(arg=nil)
				set_or_return(
				  :script,
				  arg,
				  :kind_of => String,
				  :required => true
				)
			end

			def log(arg=nil)
				set_or_return(
				  :log,
				  arg,
				  :kind_of => String
				)
			end

			def environment(arg=nil)
				set_or_return(
					:environment,
					arg,
					:kind_of => Hash,
					:default => { }
				)
			end
		end
	end
end
