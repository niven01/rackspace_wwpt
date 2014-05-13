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

  template "#{node['rackspace_wwpt']['install_dir']}\\install.bat" do
    source 'install.erb'
  end

  windows_task 'Tentacle Install' do
    user node['rackspace_wwpt']['temp_admin']
    password node['rackspace_wwpt']['temp_pass']
    cwd node['rackspace_wwpt']['install_dir']
    command "#{node['rackspace_wwpt']['install_dir']}\\install.bat"
    run_level :highest
  end

  windows_task 'Tentacle Install' do
    user node['rackspace_wwpt']['temp_admin']
    password node['rackspace_wwpt']['temp_pass']
    action :run
  end

else
  Chef::Log.warn('Octopus Deploy Tentacle can only be installed on Windows using this cookbook.')
end
