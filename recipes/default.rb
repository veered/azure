#
# Cookbook Name:: azure
# Recipe:: default
#
# Copyright 2011-2013, Lucas Hansen
#

gem_package 'azure' do
  version node['azure']['gem_version']
end
