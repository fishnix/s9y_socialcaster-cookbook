require 'spec_helper'

describe 's9y_socialcaster::default' do

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

        it "should include s9y_socialcaster::_prep" do
          chef_run.should include_recipe 's9y_socialcaster::_prep'
        end

        it 'should include s9y_socialcaster::_service' do
          chef_run.should include_recipe 's9y_socialcaster::_service'
        end

        it 'should include rvm::user' do
          chef_run.should include_recipe 'rvm::user'
        end

        it 'should include s9y_socialcaster::_app' do
          chef_run.should include_recipe 's9y_socialcaster::_app'
        end

        it 'should include s9y_socialcaster::_trigger' do
          chef_run.should include_recipe 's9y_socialcaster::_trigger'
        end
      end
    end
  end
end
