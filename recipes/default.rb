#
# Cookbook Name:: s9y_socialcaster
# Recipe:: framework
#
# sets up the s9y socialcaster app
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

node.set['build-essential']['compile_time'] = true

include_recipe 's9y_socialcaster::_prep'
include_recipe 's9y_socialcaster::_redis'
include_recipe 's9y_socialcaster::_app'
include_recipe 's9y_socialcaster::_service'
include_recipe 's9y_socialcaster::_trigger'
