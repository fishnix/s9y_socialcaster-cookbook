#
# Cookbook Name:: s9y_socialcaster-cookbook
# Recipe:: _service.rb
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

template '/etc/sysconfig/unicorn_s9y-socialcaster' do
  source 'unicorn_s9y-socialcaster_sysconfig.erb'
  owner 'root'
  group 'root'
  mode '0644'
end


template '/etc/init.d/unicorn_s9y-socialcaster' do
  source 'unicorn_s9y-socialcaster.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'unicorn_s9y-socialcaster' do
  action [ :enable ]
end
