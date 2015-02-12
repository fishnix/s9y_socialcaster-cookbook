#
# Cookbook Name:: s9y_socialcaster-cookbook
# Recipe:: _app.rb
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

include_recipe 's9y_socialcaster::_service'

db = node['s9y_socialcaster']['data_bag']
dbi = node['s9y_socialcaster']['data_bag_item']
socialcaster = Chef::EncryptedDataBagItem.load(db, dbi)

template "#{node['s9y_socialcaster']['deploydir']}/shared/config.yml" do
  source 'config.yml.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables({
    :send_tweets => node['s9y_socialcaster']['send_tweets'],
    :config => socialcaster
  })
  notifies :restart, 'service[unicorn_s9y-socialcaster]', :delayed
end

rvm_shell 'bundle_gems' do
  ruby_string "2.2."
  cwd "#{node['s9y_socialcaster']['deploydir']}/current"
  code 'bundle install --path .bundle'
  user node['s9y_socialcaster']['user']
  action :nothing
end

deploy_revision node['s9y_socialcaster']['deploydir'] do
  repo node['s9y_socialcaster']['git_repo']
  revision node['s9y_socialcaster']['git_revno']
  symlink_before_migrate nil
  create_dirs_before_symlink []
  symlinks(
      'config.yml' => 'config.yml',
      'log' => 'log',
      'tmp' => 'tmp'
  )
  user node['s9y_socialcaster']['user']
  enable_submodules false
  migrate false
  migration_command 'rake db:migrate'
  shallow_clone true
  notifies :run,     'rvm_shell[bundle_gems]', :immediately
  notifies :restart, 'service[unicorn_s9y-socialcaster]', :delayed
  action :deploy
end
