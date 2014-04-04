#
# Author:: Nielsen Pierce
# Cookbook Name:: rackspace_wwpt
#
# Cookbook Name:: rackspace_wwpt
# Recipe::IIS
#
# Copyright 2014, Rackspace UK, Inc.
#
# All rights reserved - Do Not Redistribute
#

if platform?('windows')

  include_recipe 'iis'
  features = %w(
    IIS-WebServerRole
    IIS-WebServer
    IIS-CommonHttpFeatures
    IIS-StaticContent
    IIS-DefaultDocument
    IIS-DirectoryBrowsing
    IIS-HttpErrors
    IIS-HttpRedirect
    IIS-ApplicationDevelopment
    IIS-CGI
    IIS-ISAPIExtensions
    IIS-ASP
    IIS-ISAPIFilter
    IIS-ServerSideIncludes
    IIS-HealthAndDiagnostics
    IIS-HttpLogging
    IIS-LoggingLibraries
    IIS-RequestMonitor
    IIS-HttpTracing
    IIS-CustomLogging
    IIS-ODBCLogging
    IIS-Security
    IIS-BasicAuthentication
    IIS-WindowsAuthentication
    IIS-DigestAuthentication
    IIS-ClientCertificateMappingAuthentication
    IIS-IISCertificateMappingAuthentication
    IIS-URLAuthorization
    IIS-RequestFiltering
    IIS-IPSecurity
    IIS-Performance
    IIS-HttpCompressionStatic
    IIS-HttpCompressionDynamic
    IIS-WebServerManagementTools
    IIS-ManagementScriptingTools
    IIS-IIS6ManagementCompatibility
    IIS-Metabase
    IIS-WMICompatibility
    IIS-LegacyScripts
    WAS-WindowsActivationService
    WAS-ProcessModel
    IIS-FTPServer
    IIS-FTPSvc
    IIS-FTPExtensibility
    IIS-WebDAV
    NetFx4Extended-ASPNET45
    IIS-NetFxExtensibility
    IIS-ASPNET
    WAS-NetFxEnvironment
    WAS-ConfigurationAPI
    IIS-ManagementService
)

  features.each do |f|
    windows_feature f do
      action :install
    end
  end

else
  Chef::Log.warn('Octopus Deploy can only be installed on Windows using this cookbook.')
end
