name              'ATG'
maintainer        'GridDynamics'
maintainer_email  'nyurin@griddynamics.com'
license           'Apache 2.0'
description       'Installs Oracle ATG Web Commerce 10.2'
version           '0.1.0'

%w{ centos }.each do |os|
  supports os
end

%w{ weblogic oracle_db java }.each do |cb|
	depends cb
end
