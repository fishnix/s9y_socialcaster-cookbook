#
# default s9y-socialcaster attributes
#
default[:s9y_socialcaster][:git_repo] = 'https://github.com/fishnix/s9y-socialcaster.git'
default[:s9y_socialcaster][:git_revno] = "HEAD"
default[:s9y_socialcaster][:deploydir] = "/var/www/apps"
default[:s9y_socialcaster][:user] = "app"
default[:s9y_socialcaster][:port] = "4567"
default[:s9y_socialcaster][:environment] = "production"
## config
default[:s9y_socialcaster][:send_tweets] = 'false'
default[:s9y_socialcaster][:zone_offset] = '-0500'
default[:s9y_socialcaster][:secret_token] = "somesecrettokenstring"
default[:s9y_socialcaster][:base_url] = "http://myawesomesite.com/"
default[:s9y_socialcaster][:tries_limit] = 500
default[:s9y_socialcaster][:teasers] = [ "Did you miss?", "From the Archive:", "Second look:", "Oldie but goodie:" ]
default[:s9y_socialcaster][:add_via] = false
default[:s9y_socialcaster][:excluded_categories] = []
default[:s9y_socialcaster][:included_categories] = []
## database
default[:s9y_socialcaster][:database][:mysql_host] = "127.0.0.1"
default[:s9y_socialcaster][:database][:mysql_port] = "3306"
default[:s9y_socialcaster][:database][:mysql_user] = "root"
default[:s9y_socialcaster][:database][:mysql_pass] ="iloverandompasswordsbutthiswilldo"
default[:s9y_socialcaster][:database][:mysql_db] = "vagrant_thebudgetbabe_com"
default[:s9y_socialcaster][:database][:table_prefix] = "serendipity_"
## shortener
default[:s9y_socialcaster][:shortener][:type] = "bitly"
default[:s9y_socialcaster][:shortener][:username] = "bitlyuser"
default[:s9y_socialcaster][:shortener][:token] = "888mybitlytoken"
## twitter
default[:s9y_socialcaster][:twitter][:username] = "twitteruser"
default[:s9y_socialcaster][:twitter][:consumer_key] = "twitter_consumer_key"
default[:s9y_socialcaster][:twitter][:consumer_secret] = "twitter_consumer_secret"
default[:s9y_socialcaster][:twitter][:access_token] = "twitter_access_token"
default[:s9y_socialcaster][:twitter][:access_token_secret] = "twitter_access_token_secret"
## reporting
default[:s9y_socialcaster][:reporting][:redis_host] = "localhost"
default[:s9y_socialcaster][:reporting][:redis_port] =   "6379"