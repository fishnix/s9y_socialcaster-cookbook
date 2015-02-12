#
# Cookbook Name:: s9y_socialcaster-cookbook
# Recipe:: _trigger.rb
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

package "curl" do
  action [:install, :upgrade]
end

db = node['s9y_socialcaster']['data_bag']
dbi = node['s9y_socialcaster']['data_bag_item']
socialcaster = Chef::EncryptedDataBagItem.load(db, dbi)

command = '/usr/bin/curl -X POST -H "Content-Type: application/json" '
command += '-d \'{"token":"' + socialcaster['secret_token'] + '"}\' '
command += "http://localhost:#{node['s9y_socialcaster']['port']}/api/tweet "
command += '2>&1'

cron "s9y_socialcaster_cron" do
  day     node['s9y_socialcaster']['trigger']['frequency']['day']
  hour    node['s9y_socialcaster']['trigger']['frequency']['hour']
  minute  node['s9y_socialcaster']['trigger']['frequency']['minute']
  month   node['s9y_socialcaster']['trigger']['frequency']['month']
  weekday node['s9y_socialcaster']['trigger']['frequency']['weekday']
  command command
end
