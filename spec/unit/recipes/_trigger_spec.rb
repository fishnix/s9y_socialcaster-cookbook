require 'spec_helper'


describe 's9y_socialcaster::_trigger' do

  platforms = {
      'centos' => ['6.6']
  }

  before(:each) do
    Chef::EncryptedDataBagItem.stub(:load).with('s9y_socialcaster', 'default').and_return({ "secret_token" => "somesecrettokenstring" })
  end


  platforms.each do |platform, versions|
    versions.each do |version|

      context "on #{platform.capitalize} #{version}" do
        let (:chef_run) do
          ChefSpec::Runner.new(log_level: :warn, platform: platform, version: version) do |node|
            # set additional node attributes here
          end.converge(described_recipe)
        end

        it 'installs the curl package' do
          expect(chef_run).to install_package('curl')
        end

        it 'creates the trigger cron job' do
          expect(chef_run).to create_cron('s9y_socialcaster_cron')
        end
      end
    end
  end
end
