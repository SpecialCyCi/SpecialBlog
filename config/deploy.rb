# coding: utf-8
require "bundler/capistrano"
require "capistrano-rbenv"
require 'puma/capistrano'

set :rbenv_ruby_version, "2.0.0-p353"

role :web, "54.254.193.110"
role :app, "54.254.193.110"
role :db,  "54.254.193.110", :primary => true

set :application, "SpecialBlog"
set :repository,  "git@github.com:SpecialCyCi/SpecialBlog.git"
set :branch, "master"
set :scm, :git
set :git_shallow_clone, 1

# 部署用户
set :user, "deploy"
set :use_sudo, false
set :deploy_to, "/home/deploy/application/#{application}"

default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true, :keys => "/Users/special/百度云同步盘/SSH/AWS/deploy_key" }
# puma
set :puma_role, :app
set :puma_config_file, "config/puma.rb"

# 添加github的ssh key

task :add_github_key, :roles => :web do  
  run "ssh-agent"
  run "ssh-add ~/.ssh/id_github_rsa"
end

task :init_shared_path, :roles => :web do
  run "mkdir -p #{deploy_to}/shared/log"
  run "mkdir -p #{deploy_to}/shared/config"
  run "mkdir -p #{deploy_to}/shared/tmp"
  run "mkdir -p #{deploy_to}/shared/public/uploads"
end

task :link_shared_files, :roles => :web do
  run "ln -sf #{shared_path}/config/secret_token.rb #{deploy_to}/current/config/initializers/secret_token.rb"
  run "ln -sf #{deploy_to}/shared/public/uploads #{deploy_to}/current/public/uploads"
  run "ln -sf #{shared_path}/tmp #{deploy_to}/current/tmp"
end

task :compile_assets, :roles => :web do
  run "cd #{deploy_to}/current/; RAILS_ENV=production bundle exec rake assets:precompile"
end

task :mongoid_migrate_database, :roles => :web do
  run "cd #{deploy_to}/current/; RAILS_ENV=production bundle exec rake db:migrate"
end

task :mongoid_create_indexes, :roles => :web do
  run "cd #{deploy_to}/current/; RAILS_ENV=production bundle exec rake db:mongoid:create_indexes"
end

task :mongoid_migrate_database, :roles => :web do
  run "cd #{deploy_to}/current/; RAILS_ENV=production bundle exec rake db:migrate"
end

before "deploy", :add_github_key
after "deploy:finalize_update","deploy:symlink", :init_shared_path, :link_shared_files, :mongoid_create_indexes, :compile_assets 
