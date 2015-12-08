node.default['formatron_chef_extra']['configuration'] = data_bag_item 'formatron', 'formatron-bootstrap'
node.default['formatron_sensu']['client']['subscriptions'] = ['default']
include_recipe 'formatron_chef_extra::default'
