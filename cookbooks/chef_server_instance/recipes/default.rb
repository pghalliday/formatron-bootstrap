node.override['formatron_common']['configuration'] = data_bag_item 'formatron', 'formatron-bootstrap'
include_recipe 'formatron_common::default'
