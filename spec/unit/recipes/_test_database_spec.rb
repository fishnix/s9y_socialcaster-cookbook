require 'spec_helper'


describe 's9y_socialcaster::_test_database' do

  platforms = {
      'centos' => ['6.6'],
  }

  platforms.each do |platform, versions|
    versions.each do |version|

      context "on #{platform.capitalize} #{version}" do
        let (:chef_run) do
          ChefSpec::Runner.new(log_level: :warn, platform: platform, version: version) do |node|
            # set additional node attributes here
          end.converge(described_recipe)
        end

        it 'creates a default mysql service' do
          expect(chef_run).to create_mysql_service 'default'
        end

        it 'installs the mysql-community-devel package' do
          expect(chef_run).to install_package('mysql-community-devel')
        end

        it 'should create the myawesomesite_com database' do
          expect(chef_run).to create_mysql_database('myawesomesite_com')
        end
      end
    end
  end
end
