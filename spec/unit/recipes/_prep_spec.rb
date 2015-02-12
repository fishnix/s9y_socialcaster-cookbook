require 'spec_helper'

describe 's9y_socialcaster::_prep' do

  platforms = {
      'centos' => ['6.6']
  }

  before(:each) do
    stub_command("bash -c \"source /home/app/.rvm/scripts/rvm && type rvm | cat | head -1 | grep -q '^rvm is a function$'\"").and_return(1)
  end

  platforms.each do |platform, versions|
    versions.each do |version|

      context "on #{platform.capitalize} #{version}" do
        let (:chef_run) do
          ChefSpec::Runner.new(log_level: :warn, platform: platform, version: version) do |node|
            # set additional node attributes here
          end.converge(described_recipe)
        end
        it 'should create the deploy directory' do
          expect(chef_run).to create_directory('/var/www/apps')
        end

        %w{ shared shared/log shared/tmp }.each do |d|
          it "should create the subdir #{d} for deployment" do
            expect(chef_run).to create_directory("/var/www/apps/#{d}")
          end
        end

        it 'installs the mysql-devel package' do
          expect(chef_run).to install_package('mysql-devel')
        end
      end
    end
  end
end
