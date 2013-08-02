#
# Author:: Lucas Hansen <lucash@opscode.com>
# Cookbook Name:: azure
# Provider:: azure_container
#
# Copyright:: 2013, Opscode, Inc <legal@opscode.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


action 'create' do
  require 'azure'
  abs = azure_blob_service
  name = new_resource.container_name
  
  unless abs.list_containers.map{ |c| c.name }.include? name
    if new_resource.public_access_level == 'private'
      access_level = nil
    else
      access_level = new_resource.public_access_level
    end
    container = abs.create_container name, public_access_level: access_level
  end
end

action 'delete' do
  require 'azure'
  abs = azure_blob_service
  name = new_resource.container_name

  if abs.list_containers.map{ |c| c.name }.include? name
    abs.delete_container name
  end
end

def azure_blob_service
  ::Azure.configure do |config|
    config.storage_account_name = new_resource.account_name
    config.storage_access_key = new_resource.access_key
  end
  Azure::BlobService.new
end

