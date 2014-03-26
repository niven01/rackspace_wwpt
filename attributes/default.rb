#
# Author:: Nielsen Pierce
# Cookbook Name:: rackspace_wwpt
#
# Author:: Nielsen Pierce
# Cookbook Name:: rackspace_wwpt
# Attribute:: default
#
# Copyright 2014, Rackspace UK, Inc.

# Load encrypted data_bag values
set_secrets = Chef::EncryptedDataBagItem.load("devopsguys", 'deploy')

# Octopus Tentacle version details
default['rackspace_wwpt']['install_method'] = "msi" # msi or zip
default['rackspace_wwpt']['msi_package_name'] = "Octopus Tentacle 2.1.3.1223"
default['rackspace_wwpt']['url'] = 'http://download.octopusdeploy.com/octopus/Octopus.Tentacle.2.1.3.1223-x64.msi'
default['rackspace_wwpt']['checksum']  = '5047cb66703cd51bccb06f521a72b6462e0365adfc36d206024481b6e940f0ed'
default['rackspace_wwpt']['server'] = 'http://devopsguys.deploy.appsentrik.com/'

# Octopus Tentacle install locations
default['rackspace_wwpt']['accept_eula'] = 'true'
default['rackspace_wwpt']['install_dir'] = 'C:\Program Files\Octopus Deploy\Tentacle'
default['rackspace_wwpt']['app'] = 'C:\Applications'
default['rackspace_wwpt']['home'] = 'C:\Octopus'

# Octopus Tentacle install configuration details
default['rackspace_wwpt']['port'] = 10933
default['rackspace_wwpt']['env'] = 'Production'
default['rackspace_wwpt']['role'] = 'wwpt-webserver'
default['rackspace_wwpt']['style'] = 'TentaclePassive'
default['rackspace_wwpt']['apikey_value'] = set_secrets['api']

default['rackspace_wwpt']['log'] = "#{Chef::Config[:file_cache_path]}/Tentacle.log"

