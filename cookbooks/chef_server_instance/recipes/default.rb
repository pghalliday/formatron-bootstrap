bootstrap_data_bag = data_bag_item 'formatron', 'formatron-bootstrap'
chef_server_config = bootstrap_data_bag['config']['chef_server']
elk_config = bootstrap_data_bag['config']['elk']
sensu_config = bootstrap_data_bag['config']['sensu']

hostname = node['fqdn']
domain = hostname.dup
domain.slice! chef_server_config['sub_domain']
sensu_hostname = "#{sensu_config['sub_domain']}#{domain}"

rabbitmq_host = sensu_hostname
rabbitmq_vhost = sensu_config['rabbitmq']['vhost']
rabbitmq_user = sensu_config['rabbitmq']['user']
rabbitmq_password = sensu_config['rabbitmq']['password']

node.override['formatron_filebeat']['logstash']['hostname'] = "#{elk_config['sub_domain']}#{domain}"
node.override['formatron_filebeat']['logstash']['port'] = elk_config['logstash_port']
node.override['formatron_filebeat']['paths'] = ['/var/log/**/*.log']
include_recipe 'formatron_filebeat::default'

node.override['formatron_sensu']['rabbitmq']['host'] = rabbitmq_host
node.override['formatron_sensu']['rabbitmq']['vhost'] = rabbitmq_vhost
node.override['formatron_sensu']['rabbitmq']['user'] = rabbitmq_user
node.override['formatron_sensu']['rabbitmq']['password'] = rabbitmq_password
node.override['formatron_sensu']['client']['subscriptions'] = ['default']
include_recipe 'formatron_sensu::client'

file '/etc/sensu/plugins/check-memory.sh' do
  content sensu_config['plugins']['check-memory.sh']
  owner 'sensu'
  group 'sensu'
  mode '0755'
end
