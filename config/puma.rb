APP_ROOT = '/home/deploy/application/SpecialBlog/current'
bind  "unix:///tmp/special_blog.sock"
pidfile  "#{APP_ROOT}/tmp/pids/puma.pid"
state_path "#{APP_ROOT}/tmp/pids/puma.state"
daemonize true
workers 0
threads 1,1
preload_app!
activate_control_app
