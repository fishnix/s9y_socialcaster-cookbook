require 'spec_helper'

describe 's9y_socialcaster::_service' do

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

        it 'creates a sysconfig file from template' do
          expect(chef_run).to render_file('/etc/sysconfig/unicorn_s9y-socialcaster')
        end
      end
    end
  end
end
