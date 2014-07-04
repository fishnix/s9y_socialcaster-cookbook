#
# Cookbook Name:: s9y_socialcaster
# Recipe:: framework
#
# sets up the s9y frameowork, including code, directories + config
#
# Copyright 2011, E Camden Fisher
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

directory node[:s9y_socialcaster][:deploydir] do
	owner  node[:s9y_socialcaster][:user]
	group "root"
	mode "0755"
	recursive true
	action :create
end

user node[:s9y_socialcaster][:user]  do
  action :create
  comment "App User"
end

%w{ shared shared/log shared/tmp }.each do |d|
	directory "#{node[:s9y_socialcaster][:deploydir]}/#{d}" do
		owner  node[:s9y_socialcaster][:user]
		group "root"
		mode "0755"
		recursive true
		action :create
	end
end

template "/etc/sysconfig/unicorn_s9y-socialcaster" do
	source "unicorn_s9y-socialcaster_sysconfig.erb"
	owner "root"
	group "root"
	mode "0644"
end


cookbook_file "/etc/init.d/unicorn_s9y-socialcaster" do
	source "unicorn_s9y-socialcaster"
	owner "root"
	group "root"
	mode "0755"
end

package "mysql-devel" do
	action :install
end

rvm_shell 'bundle_gems' do 
	ruby_string "2.1.1"
	cwd "#{node[:s9y_socialcaster][:deploydir]}/current"
	code 'bundle install --path .bundle'
	user node[:s9y_socialcaster][:user]
	action :nothing
end

service "unicorn_s9y-socialcaster" do
	supports :status => true, :restart => true, :reload => true
	action :nothing
end

deploy_revision node[:s9y_socialcaster][:deploydir] do
	repo node[:s9y_socialcaster][:git_repo]
	revision node[:s9y_socialcaster][:git_revno]
	symlink_before_migrate nil
	create_dirs_before_symlink []
	symlinks(
		"config.yml" => "config.yml",
		"log" => "log",
		"tmp" => "tmp"
	)
	user node[:s9y_socialcaster][:user]
	enable_submodules false
	migrate false
	migration_command "rake db:migrate"
	# environment "RAILS_ENV" => "production", "OTHER_ENV" => "foo"
	shallow_clone true
	notifies :run,     'rvm_shell[bundle_gems]', :immediately
	notifies :restart, 'service[unicorn_s9y-socialcaster]'	
	action :deploy # or :rollback
end


template "#{node[:s9y_socialcaster][:deploydir]}/shared/config.yml" do
	source "config.yml.erb"
	owner "root"
	group "root"
	mode "0644"
  	notifies :restart, 'service[unicorn_s9y-socialcaster]'	
end

service "unicorn_s9y-socialcaster" do
	action [ :enable, :start ]
end
