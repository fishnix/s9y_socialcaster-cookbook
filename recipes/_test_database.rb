#
# Cookbook Name:: s9y_socialcaster-cookbook
# Recipe:: _test_database.rb
#
# Copyright (C) 2014 E Camden Fisher
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

selinux_state "SELinux Permissive" do
  action :permissive
end

node.set['mysql']['service_name'] = 'default'
node.set['mysql']['server_root_password'] = 'ilikerandompasswords'
node.set['mysql']['server_debian_password'] = 'ilikerandompasswords'
node.set['mysql']['data_dir'] = '/var/lib/mysql'
node.set['mysql']['port'] = '3306'
node.set['mysql']['version'] = '5.6'

mysql_service 'default' do
  version node['mysql']['version']
  port node['mysql']['port']
  action [:create, :start]
end

package "mysql-community-devel" do
  action :install
end

mysql_connection_info = {
    :host     => '127.0.0.1',
    :username => 'root',
    :password => 'ilikerandompasswords'
}

mysql2_chef_gem 'default' do
  action :install
end

mysql_database 'myawesomesite_com' do
  connection mysql_connection_info
  action :create
end

