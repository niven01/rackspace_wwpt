#
# Author:: Nielsen Pierce
# Cookbook Name:: rackspace_wwpt
#
# Cookbook Name:: rackspace_wwpt
# Recipe:: install
#
# Copyright 2014, Rackspace UK, Inc.
#
# All rights reserved - Do Not Redistribute
#


if platform?("windows")
  
  windows_package node['rackspace_wwpt']['msi_package_name'] do
    source node['rackspace_wwpt']['url']
    checksum node['rackspace_wwpt']['checksum']
    installer_type :custom
    options "/q"
    action :install
  end

  powershell_script "configure_tentacle_agent" do
    cwd "#{node['rackspace_wwpt']['install_dir']}"
    code <<-EOH
    .\\tentacle.exe create-instance --instance "Tentacle" --config "#{node['tentacle']['home']}\\Tentacle\\Tentacle.config" --console
    .\\tentacle.exe new-certificate --instance "Tentacle" --console
    .\\tentacle.exe configure --instance "Tentacle" --home #{node['tentacle']['home']} --console
    .\\tentacle.exe configure --instance "Tentacle" --app #{node['tentacle']['app']} --console
    .\\tentacle.exe configure --instance "Tentacle" --port #{node['tentacle']['port']} --console
    .\\tentacle.exe register-with --instance "Tentacle" --server #{node['tentacle']['server']} --environment #{node['tentacle']['env']} --role #{node['tentacle']['role']} --publicHostname=#{node['ipaddress']} --apikey=#{node['tentacle']['apikey_value']} --comms-style #{node['tentacle']['style']} --force --console
    .\\tentacle.exe service --instance "Tentacle" --install --start --console
    .\\tentacle.exe service --instance "Tentacle" --stop --console
    .\\tentacle.exe service --instance "Tentacle" --start --console
    EOH
  end

else
    Chef::Log.warn('Octopus Deploy can only be installed on Windows using this cookbook.')
end