configuration = data_bag_item 'formatron', 'formatron-bootstrap'
config  = configuration['config']['nat']
node.default['formatron_common']['configuration'] = configuration
node.default['formatron_sensu']['client']['subscriptions'] = config['sensu_subscriptions']
include_recipe 'formatron_common::default'
