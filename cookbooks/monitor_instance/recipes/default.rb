configuration = data_bag_item 'formatron', 'formatron-bootstrap'
config = configuration['config']['monitor']
hosted_zone_name = configuration['dsl']['global']['hosted_zone_name']
node.override['formatron_monitor']['configuration'] = configuration
node.override['formatron_sensu']['client']['subscriptions'] = config['sensu_subscriptions']
node.override['formatron_monitor']['grafana_instance_dashboards'] = config['grafana_instance_dashboards']
include_recipe 'formatron_monitor::default'
