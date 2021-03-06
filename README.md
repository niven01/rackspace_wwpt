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

#####Create Data Bag 

- Linux: `knife data bag create --editor /usr/bin/vim --secret-file encrypted_data_bag_secret octopus devopsguys`
- Windows: `knife data bag create --editor notepad --secret-file encrypted_data_bag_secret octopus devopsguys`  

- Example: 

{  
"id": "devopsguys",  
"api": "API-FR43434343543543DFF",  
"server": "http://server.address.com/",  
"port": 10933,  
"TempUser": "radmin",  
"TempPass": "Password123"  
}

Summary
-------
Download Tentacle.exe and install using below attributes  .  
The installation of certificate requires elevated permissions. To achieve this the following takes place:  

- Temporary admin account is created 
  
- Scheduled windows task created which runs (C:\Program Files\Octopus Deploy\Tentacle\install.bat)

- Scheduled task and admin user deleted

The install runs for about 5 mins after cookbook completes so server will not appear in Octopus Deploy environment straight away.

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
node['rackspace_wwpt']['temp_admin'] = set_octo_secrets['TempUser'] (Temp user with admin rights in order to install cert,  this is then deleted)  
node['rackspace_wwpt']['temp_pass'] = set_octo_secrets['TempPass']  

Usage
-----
#### rackspace_wwpt::default

Just include `rackspace_wwpt` in your node's `run_list`.  

`knife node run_list add NODE rackspace_wwpt`  


Contributing
------------

https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md

License and Authors
-------------------
Authors: Nielsen Pierce <nielsen.pierce@rackspace.co.uk>
