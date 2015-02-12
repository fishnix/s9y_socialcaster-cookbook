require 'spec_helper'

describe file('/var/www/apps/shared') do
  it { should be_directory }
end

describe file('/var/www/apps/releases') do
  it { should be_directory }
end

describe file('/var/www/apps/current') do
  it { should be_symlink }
end

describe file('/etc/init.d/unicorn_s9y-socialcaster') do
  it { should be_file }
end

describe file('/etc/sysconfig/unicorn_s9y-socialcaster') do
  it { should be_file }
end

describe port('4567') do
  it { should be_listening.with('tcp') }
end

describe service('unicorn_s9y-socialcaster') do
  it { should be_running }
  it { should be_enabled }
end
