configuration = data_bag_item 'formatron', 'formatron-bootstrap'
config = configuration['config']['management_reverse_proxy']
node.override['formatron_sensu']['client']['subscriptions'] = config['sensu_subscriptions']
node.override['formatron_reverse_proxy']['configuration'] = configuration
node.override['formatron_reverse_proxy']['proxies'] = config['proxies']
include_recipe 'formatron_reverse_proxy::default'
