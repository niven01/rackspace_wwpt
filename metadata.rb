name             'rackspace_wwpt'
maintainer       'Rackspace Hosting'
maintainer_email 'nielsen.pierce@rackspace.co.uk'
license          'All rights reserved'
description      'Installs/Configures tentacle'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

depends  'iis'
depends	 'ms_dotnet45'
depends	 'windows_firewall'
