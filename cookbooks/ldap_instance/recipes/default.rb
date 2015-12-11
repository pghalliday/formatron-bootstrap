configuration = data_bag_item 'formatron', 'formatron-bootstrap'

ldap_config = configuration['config']['ldap']
ldap_secrets = configuration['config']['secrets']['ldap']

node.default['formatron_sensu']['client']['subscriptions'] = ldap_config['sensu_subscriptions']
node.default['formatron_common']['configuration'] = configuration
include_recipe 'formatron_common::default'

include_recipe 'git::default'
include_recipe 'nodejs::default'

package 'ca-certificates'

node.override['ldapjs_crowd_server']['system_certificate_bundle'] = '/etc/ssl/certs/ca-certificates.crt'
node.override['ldapjs_crowd_server']['crowd_root_certificate'] = ldap_config['crowd_root_certificate']
node.override['ldapjs_crowd_server']['crowd_url'] = ldap_secrets['crowd_url']
node.override['ldapjs_crowd_server']['application_name'] = ldap_secrets['application_name']
node.override['ldapjs_crowd_server']['application_password'] = ldap_secrets['application_password']
node.override['ldapjs_crowd_server']['uid'] = ldap_config['uid']
node.override['ldapjs_crowd_server']['search_base'] = ldap_config['search_base']
node.override['ldapjs_crowd_server']['dn_suffix'] = ldap_config['dn_suffix']
node.override['ldapjs_crowd_server']['bind_dn'] = ldap_secrets['bind_dn']
node.override['ldapjs_crowd_server']['bind_password'] = ldap_secrets['bind_password']
node.override['ldapjs_crowd_server']['port'] = ldap_config['port']
include_recipe 'ldapjs_crowd_server::default'
