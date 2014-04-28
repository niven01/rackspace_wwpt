#
# Author:: Nielsen Pierce
# Cookbook Name:: rackspace_wwpt
#
# Recipe:: install
#
# Copyright 2014, Rackspace UK, Inc.
#
# All rights reserved - Do Not Redistribute
#

if platform?('windows')

  windows_package node['rackspace_wwpt']['msi_package_name'] do
    source node['rackspace_wwpt']['url']
    checksum node['rackspace_wwpt']['checksum']
    installer_type :custom
    options '/q'
    action :install
  end

  user node['rackspace_wwpt']['temp_admin']  do
    comment 'Temp Rackspace Admin'
    password node['rackspace_wwpt']['temp_pass']
    action :create
  end

  group 'Administrators' do
    action :modify
    members node['rackspace_wwpt']['temp_admin']
    append true
  end

  batch 'configure_tentacle_agent' do
    cwd '#{node['rackspace_wwpt']['install_dir']}'
    code <<-EOH
       tentacle.exe create-instance --instance "Tentacle" --config "#{node['rackspace_wwpt']['home']}\\Tentacle\\Tentacle.config" --console
       tentacle.exe configure --instance "Tentacle" --home #{node['rackspace_wwpt']['home']} --console
       tentacle.exe configure --instance "Tentacle" --app #{node['rackspace_wwpt']['app']} --console
       tentacle.exe configure --instance "Tentacle" --port #{node['rackspace_wwpt']['port']} --console
       tentacle.exe register-with --instance "Tentacle" --server #{node['rackspace_wwpt']['server']} --environment #{node['rackspace_wwpt']['env']} --role #{node['rackspace_wwpt']['role']} --publicHostname=#{node['ipaddress']} --apikey=#{node['rackspace_wwpt']['apikey_value']} --comms-style #{node['rackspace_wwpt']['style']} --force --console
       tentacle.exe service --instance "Tentacle" --install --start --console
       tentacle.exe service --instance "Tentacle" --stop --console
       tentacle.exe service --instance "Tentacle" --start --console
       schtasks.exe /Create /TN "Tentacle Install Certificate" /TR "'C:\\Program Files\\Octopus Deploy\\Tentacle\\tentacle.exe' new-certificate --instance 'Tentacle' --console" /ST 00:00 /SC Hourly /RU #{node['rackspace_wwpt']['temp_admin']} /RP #{node['rackspace_wwpt']['temp_pass']} /NP
       schtasks.exe /Run /TN "Tentacle Install Certificate"
       schtasks.exe /Delete /TN "Tentacle Install Certificate" /F
     EOH
  end

  user node['rackspace_wwpt']['temp_admin'] do
    action :remove
  end

else
  Chef::Log.warn('Octopus Deploy can only be installed on Windows using this cookbook.')
end
