configuration = data_bag_item 'formatron', 'formatron-bootstrap'
config = configuration['config']['chef_server']
node.default['formatron_chef_extra']['configuration'] = configuration
node.default['formatron_sensu']['client']['subscriptions'] = config['sensu_subscriptions']
include_recipe 'formatron_chef_extra::default'
