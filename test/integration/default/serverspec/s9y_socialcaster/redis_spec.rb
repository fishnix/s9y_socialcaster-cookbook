require 'spec_helper'

describe port('6379') do
  it { should be_listening.with('tcp') }
end

describe file('/etc/init.d/redis6379') do
  it { should be_file }
end

describe service('redis6379') do
  it { should be_enabled }
end
