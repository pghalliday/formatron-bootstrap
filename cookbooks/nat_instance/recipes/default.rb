bootstrap_data_bag = data_bag_item 'formatron', 'formatron-bootstrap'
nat_config = bootstrap_data_bag['config']['nat']
elk_config = bootstrap_data_bag['config']['elk']
sensu_config = bootstrap_data_bag['config']['sensu']

hostname = node['fqdn']
domain = hostname.dup
domain.slice! nat_config['sub_domain']
sensu_hostname = "#{sensu_config['sub_domain']}#{domain}"

sensu_checks = sensu_config['checks']
sensu_gems = sensu_config['gems']

rabbitmq_host = sensu_hostname
rabbitmq_vhost = sensu_config['rabbitmq']['vhost']
rabbitmq_user = sensu_config['rabbitmq']['user']
rabbitmq_password = sensu_config['rabbitmq']['password']

include_recipe 'apt::default'
include_recipe 'build-essential::default'

node.override['formatron_filebeat']['logstash']['hostname'] = "#{elk_config['sub_domain']}#{domain}"
node.override['formatron_filebeat']['logstash']['port'] = elk_config['logstash_port']
node.override['formatron_filebeat']['paths'] = ['/var/log/**/*.log']
include_recipe 'formatron_filebeat::default'

node.override['formatron_sensu']['rabbitmq']['host'] = rabbitmq_host
node.override['formatron_sensu']['rabbitmq']['vhost'] = rabbitmq_vhost
node.override['formatron_sensu']['rabbitmq']['user'] = rabbitmq_user
node.override['formatron_sensu']['rabbitmq']['password'] = rabbitmq_password
node.override['formatron_sensu']['client']['subscriptions'] = ['default']
node.override['formatron_sensu']['checks'] = sensu_checks unless sensu_checks.nil?
node.override['formatron_sensu']['gems'] = sensu_gems unless sensu_gems.nil?
include_recipe 'formatron_sensu::client'
