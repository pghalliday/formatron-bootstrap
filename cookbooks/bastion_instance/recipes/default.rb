bootstrap_data_bag = data_bag_item 'formatron', 'formatron-bootstrap'
bastion_config = bootstrap_data_bag['config']['bastion']
elk_config = bootstrap_data_bag['config']['elk']

domain = node['fqdn']
domain.slice! bastion_config['sub_domain']

node.override['formatron_filebeat']['logstash']['hostname'] = "#{elk_config['sub_domain']}#{domain}"
node.override['formatron_filebeat']['logstash']['port'] = elk_config['logstash_port']
node.override['formatron_filebeat']['paths'] = ['/var/log/**/*.log']

include_recipe 'formatron_filebeat::default'
