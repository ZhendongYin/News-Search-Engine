# Yifan Zhu
# elasticsearch setting
require 'elasticsearch'
$client = Elasticsearch::Client.new log: true
$ela_index = :news_test
print $client.cluster.health