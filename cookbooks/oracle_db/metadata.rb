name              'oracle_db'
maintainer        'GridDynamics'
maintainer_email  'nyurin@griddynamics.com'
license           'Apache 2.0'
description       'Installs Oracle Database XE.'
version           '0.1.0'

%w{ centos }.each do |os|
  supports os
end

%w{ swap secure_manager }.each do |cb|
  depends cb
end
