#
# Author:: Nielsen Pierce
# Cookbook Name:: rackspace_wwpt
#
# Cookbook Name:: rackspace_wwpt
# Recipe:: default
#
# Copyright 2014, Rackspace UK, Inc.
#
# All rights reserved - Do Not Redistribute
#
# Install Octopus Tentacle v 2.0 and registers server with the DevOpsGuys (http://www.devopsguys.com/) Octopus Deploy server.

if platform?('windows')
  include_recipe 'rackspace_wwpt::iis'
  include_recipe 'ms_dotnet45'
  include_recipe 'rackspace_wwpt::install'
  include_recipe 'rackspace_wwpt::firewall'
else
  Chef::Log.warn('Octopus Deploy can only be installed on Windows using this cookbook.')
end
