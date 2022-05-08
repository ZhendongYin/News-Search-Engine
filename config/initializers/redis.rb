# Yifan Zhu
# redis setting
$redis_client = Redis.new(host: 'localhost', port: 6379, db: 1)
$login_redis_client  = Redis.new(host: 'localhost', port: 6379, db: 2)