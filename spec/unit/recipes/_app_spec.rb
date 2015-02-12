require 'spec_helper'

describe 's9y_socialcaster::_app' do

  platforms = {
      'centos' => ['6.6']
  }

  before(:each) do
    Chef::EncryptedDataBagItem.stub(:load).with('s9y_socialcaster', 'default').and_return({
                                                                                              "zone_offset" => "-0500",
                                                                                              "secret_token" => "somesecrettokenstring",
                                                                                              "base_url" => "http://myawesomesite.com/",
                                                                                              "tries_limit" => "500",
                                                                                              "teasers" => [
                                                                                                  "Did you miss?",
                                                                                                  "From the Archive:",
                                                                                                  "Second look:",
                                                                                                  "Oldie but goodie:"
                                                                                              ],
                                                                                              "add_via" => "false",
                                                                                              "excluded_categories" => [],
                                                                                              "included_categories" => [],
                                                                                              "database" => {
                                                                                                  "mysql_host" => "127.0.0.1",
                                                                                                  "mysql_port" => "3306",
                                                                                                  "mysql_user" => "root",
                                                                                                  "mysql_pass" => "ilikerandompasswords",
                                                                                                  "mysql_db" => "myawesomesite_com",
                                                                                                  "table_prefix" => "serendipity_"
                                                                                              },
                                                                                              "shortener" => {
                                                                                                  "type" => "bitly",
                                                                                                  "username" => "bitlyuser",
                                                                                                  "token" => "888mybitlytoken"
                                                                                              },
                                                                                              "twitter" => {
                                                                                                  "username" => "twitteruser",
                                                                                                  "consumer_key" => "twitter_consumer_key",
                                                                                                  "consumer_secret" => "twitter_consumer_secret",
                                                                                                  "access_token" => "twitter_access_token",
                                                                                                  "access_token_secret" => "twitter_access_token_secret"
                                                                                              },
                                                                                              "reporting" => {
                                                                                                  "redis_host" => "localhost",
                                                                                                  "redis_port" => "6379"
                                                                                              }
                                                                                     })
  end

  platforms.each do |platform, versions|
    versions.each do |version|

      context "on #{platform.capitalize} #{version}" do
        let (:chef_run) do
          ChefSpec::Runner.new(log_level: :warn, platform: platform, version: version) do |node|
            # set additional node attributes here
          end.converge(described_recipe)
        end

        it 'creates a config.yml file from template' do
          expect(chef_run).to render_file('/var/www/apps/shared/config.yml')
        end
      end
    end
  end
end
