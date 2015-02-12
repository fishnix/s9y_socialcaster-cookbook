require 'spec_helper'

%w{ client common devel libs libs-compat server }.each do |component|
  describe package("mysql-community-#{component}") do
    it { should be_installed }
  end
end

describe service('mysql-default') do
  it { should be_enabled }
end

describe port('3306') do
  it { should be_listening.with('tcp') }
end
