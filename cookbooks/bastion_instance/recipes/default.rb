node.default['formatron_common']['configuration'] = data_bag_item 'formatron', 'formatron-bootstrap'
node.default['formatron_sensu']['client']['subscriptions'] = ['default']
include_recipe 'formatron_common::default'
