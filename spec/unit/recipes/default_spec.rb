require 'spec_helper'

describe 's9y_socialcaster::default' do
  let (:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.5').converge('s9y_socialcaster::default') }
  
  it 'should create the deploy directory' do
    expect(chef_run).to create_directory('/var/www/apps')
  end
  
  %w{ shared shared/log shared/tmp }.each do |d|
    it "should create the subdir #{d} for deployment" do
      expect(chef_run).to create_directory("/var/www/apps/#{d}")
    end
  end
  
  it 'creates a sysconfig file from template' do
    expect(chef_run).to render_file('/etc/sysconfig/unicorn_s9y-socialcaster')
  end
  
  it 'creates a config.yml file from template' do
    expect(chef_run).to render_file('/var/www/apps/shared/config.yml')
  end
  
  it 'installs the mysql-devel package' do
    expect(chef_run).to install_package('mysql-devel')
  end
  
end