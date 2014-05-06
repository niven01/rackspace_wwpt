rackspace_wwpt Cookbook
=================
Install base config to allow deployment of DevopsGuys 'http://worldwidepagetest.com' via Octopus Deploy.

Requirements
------------

#### Cookbooks
`iis`, `ms_dotnet45`, `windows_firewall`

#### Encrypted data_bag

#####Create encrypted_data_bag_secret

- Create a random encryption key: `Openssl rand -base64 512 | tr -d '\r\n' > encrypted_data_bag_secret`
- For your chef clients to be able to decrypt the databag when needed copy over the secret key to the chef folder

#####Create Data Bag using prepopulated .json file

- Edit `devopsguys.json` and enter required details, API, Server and port
- Example:

{  
"id": "devopsguys",  
"api": "API-33485734834034",  
"server": "http://server.address.com",  
"port": "10933"  
}

- Run: `Knife data bag from file octopus devopguys devopsguys.json --secret-file encrypted_data_bag_secret`


Summary
-------
Download Tentacle.exe and install using below attributes.  
The installation of certificate requires elevated permissions. to achieve this the following takes place:  

- Temporary admin account is created (recommend storing these in encrypted data_bag)
  
- Scheduled windows task created which runs (C:\Program Files\\Octopus Deploy\Tentacle\\install.bat 

- Scheduled task and admin user deleted

Attributes
----------

#### Tentacle install details
node['rackspace_wwpt']['install_method'] - MSI or ZIP  
node['rackspace_wwpt']['msi_package_name'] - Example Octopus Tentacle 2.1.3.1223  
node['rackspace_wwpt']['url'] - Example 'http://download.octopusdeploy.com/octopus/Octopus.Tentacle.2.1.3.1223-x64.msi'  
node['rackspace_wwpt']['checksum']  - Checksum of above file (Can be found via http://hash.online-convert.com/sha256-generator)  
node['rackspace_wwpt']['install_dir'] - Example 'C:\Program Files\Octopus Deploy\Tentacle'  
node['rackspace_wwpt']['app'] - App location. Example 'C:\Applications'  
node['rackspace_wwpt']['home'] - The Tentacle home directory, contains logs and config

#### Tentacle configuration details
node['rackspace_wwpt']['server'] - Octupus Deployment server URL  
node['rackspace_wwpt']['port'] = set_octo_secrets['port'] - This must be an integer  
node['rackspace_wwpt']['env'] = 'Production'  
node['rackspace_wwpt']['role'] = 'wwpt-webserver'  
node['rackspace_wwpt']['style'] = 'TentaclePassive'  
node['rackspace_wwpt']['apikey_value'] = set_octo_secrets['api']  
node['rackspace_wwpt']['temp_admin'] = 'adminaccount' - Account created with Admin rights (This acount is then deleted) - Ideally this will be in a encrypted data_bag  
node['rackspace_wwpt']['temp_pass'] = '' - Password for above account - Ideally this will be in a encrypted data_bag  


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
