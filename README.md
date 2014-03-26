rackspace_wwpt Cookbook
=================
Install Octopus Tentacle v 2.0 and registers server with the DevOpsGuys (http://www.devopsguys.com/) Octopus Deploy server.

Requirements
------------

#### cookbooks
`iis`, `ms_dotnet45`, `windows_firewall`


Attributes
----------
node['rackspace_wwpt']['install_method'] - MSI or ZIP  
node['rackspace_wwpt']['msi_package_name'] - Example Octopus Tentacle 2.1.3.1223  
node['rackspace_wwpt']['url'] - Example 'http://download.octopusdeploy.com/octopus/Octopus.Tentacle.2.1.3.1223-x64.msi'
node['rackspace_wwpt']['checksum']  - Checksum value of above file (Can be found via http://hash.online-convert.com/sha256-generator)  
node['rackspace_wwpt']['server'] - Octupus Deployment server URL  

Usage
-----
#### rackspace_wwpt::default

Just include `rackspace_wwpt` in your node's `run_list`.  


Contributing
------------

https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md

License and Authors
-------------------
Authors: Nielsen Pierce <nielsen.pierce@rackspace.co.uk>
