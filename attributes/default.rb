#
# Author:: Nielsen Pierce
# Cookbook Name:: rackspace_wwpt
#
# Attribute:: default
#
# Copyright 2014, Rackspace UK, Inc.

# Load encrypted data_bag values
set_octo_secrets = Chef::EncryptedDataBagItem.load('octopus', 'devopsguys')

# Octopus Tentacle version details
default['rackspace_wwpt']['install_method'] = 'msi' # msi or zip
default['rackspace_wwpt']['msi_package_name'] = 'Octopus Tentacle 2.3.3.1369'
default['rackspace_wwpt']['url'] = 'http://download.octopusdeploy.com/octopus/Octopus.Tentacle.2.3.3.1369-x64.msi'
default['rackspace_wwpt']['checksum']  = 'a0b4591406f9ba2434204ca099b99978b0497b19f384993e6e15b2931684e8d5'

# Octopus Tentacle install locations
default['rackspace_wwpt']['accept_eula'] = 'true'
default['rackspace_wwpt']['install_dir'] = 'C:\Program Files\Octopus Deploy\Tentacle'
default['rackspace_wwpt']['app'] = 'C:\Applications'
default['rackspace_wwpt']['home'] = 'C:\Octopus'

# Octopus Tentacle install configuration details
default['rackspace_wwpt']['server'] = set_octo_secrets['server']
default['rackspace_wwpt']['port'] = set_octo_secrets['port']
default['rackspace_wwpt']['env'] = 'Production'
default['rackspace_wwpt']['role'] = 'wwpt-webserver'
default['rackspace_wwpt']['style'] = 'TentaclePassive'
default['rackspace_wwpt']['apikey_value'] = set_octo_secrets['api']

# Define temp admin account to allow certificate install with elevated permissions
default['rackspace_wwpt']['temp_admin'] = 'radmin'
default['rackspace_wwpt']['temp_pass'] = 'Password123'

default['rackspace_wwpt']['log'] = "#{Chef::Config[:file_cache_path]}/Tentacle.log"
