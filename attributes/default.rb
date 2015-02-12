#
# default s9y-socialcaster attributes
#
default['s9y_socialcaster']['git_repo'] = 'https://github.com/fishnix/s9y-socialcaster.git'
default['s9y_socialcaster']['git_revno'] = "HEAD"
default['s9y_socialcaster']['deploydir'] = "/var/www/apps"
default['s9y_socialcaster']['user'] = "app"
default['s9y_socialcaster']['port'] = "4567"
default['s9y_socialcaster']['environment'] = "production"

# Should we actually send tweets?
default['s9y_socialcaster']['send_tweets'] = 'false'

# specify data bag information for config
default['s9y_socialcaster']['data_bag'] = 's9y_socialcaster'
default['s9y_socialcaster']['data_bag_item'] = 'default'

# trigger frequency
default['s9y_socialcaster']['trigger']['type'] = 'cron'
default['s9y_socialcaster']['trigger']['frequency'] = {
                                                        'day' => '*',
                                                        'hour' => '16,21',
                                                        'minute' => '10',
                                                        'month' => '*',
                                                        'weekday' => '*'
                                                      }
