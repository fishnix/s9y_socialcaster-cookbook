require 'spec_helper'


describe 's9y_socialcaster::_redis' do

  platforms = {
      'centos' => ['6.6']
  }

  platforms.each do |platform, versions|
    versions.each do |version|

      context "on #{platform.capitalize} #{version}" do
        let (:chef_run) do
          ChefSpec::Runner.new(log_level: :warn, platform: platform, version: version) do |node|
            # set additional node attributes here
          end.converge(described_recipe)
        end

        it 'should include redisio::default' do
          expect(chef_run).to include_recipe 'redisio::default'
        end

        it 'should include redisio::enable' do
          expect(chef_run).to include_recipe 'redisio::enable'
        end
      end
    end
  end
end
