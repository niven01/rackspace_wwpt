#
# Author:: Nielsen Pierce
# Cookbook Name:: rackspace_wwpt
#
# Cookbook Name:: rackspace_wwpt
# Recipe:: firewall
#
# Copyright 2014, Rackspace UK, Inc.
#
# All rights reserved - Do Not Redistribute
#

if platform?("windows")
  windows_firewall_rule 'Octopus_Tentacle' do
        port node['wwpt']['port']
        protocol :TCP
        firewall_action :allow
  end
else
    Chef::Log.warn('Firewall can only be modified if OS is Windows using this cookbook.')
end