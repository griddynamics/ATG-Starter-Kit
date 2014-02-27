#
# Copyright 2014, Grid Dynamics International, Inc.
#

require 'chef/resource'

class Chef
  class Resource
    class OracleDatabaseUser < Chef::Resource
		def initialize(name, run_context=nil)
			super
			@resource_name = :oracle_database_user
			@username = name
	  		@privileges = [:all]
			@allowed_actions.push(:create, :drop, :grant)
        	@action = :create
			@provider = Chef::Provider::Database::OracleDatabaseUser
		end

		def username(arg=nil)
			set_or_return(
			  :username,
			  arg,
			  :kind_of => String
			)
		end

		def password(arg=nil)
			set_or_return(
			  :password,
			  arg,
			  :kind_of => String
			)
		end

		def privileges(arg=nil)
			set_or_return(
			  :privileges,
			  arg,
			  :kind_of => Array
			)
		end

		def connection(arg=nil)
			set_or_return(
			  :connection,
			  arg,
			  :required => true
			)
		end
    end
  end
end
