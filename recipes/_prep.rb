#
# Cookbook Name:: s9y_socialcaster-cookbook
# Recipe:: _prep.rb
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

%w{ sqlite-devel mysql-devel }.each do |p|
  package p do
    action :install
  end
end

user node['s9y_socialcaster']['user']  do
  action :create
  comment "App User"
end

node.set['rvm']['user_installs'] = [{ 'user' => node['s9y_socialcaster']['user'],
                                      'default_ruby' => 'ruby-2.1.4',
                                      'rubies' => ['2.1.4'],
                                      'rvmrc' => {
                                          'rvm_project_rvmrc' => 1,
                                          'rvm_gemset_create_on_use_flag' => 1,
                                          'rvm_pretty_print_flag' => 1
                                      }
                                    }]
include_recipe 'rvm::default'
include_recipe 'rvm::user'

directory node['s9y_socialcaster']['deploydir'] do
  owner  node['s9y_socialcaster']['user']
  group 'root'
  mode '0755'
  recursive true
  action :create
end

%w{ shared shared/log shared/tmp }.each do |d|
  directory "#{node['s9y_socialcaster']['deploydir']}/#{d}" do
    owner  node['s9y_socialcaster']['user']
    group 'root'
    mode '0755'
    recursive true
    action :create
  end
end

