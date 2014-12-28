# coding: utf-8
require "rvm/capistrano"
require "bundler/capistrano"
require 'puma/capistrano'

role :web, "104.236.142.54"
role :app, "104.236.142.54"
role :db,  "104.236.142.54", :primary => true

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
set :ssh_options, { :forward_agent => true, :keys => '~/.ssh/id_rsa' }

# puma
set :puma_role, :app
set :puma_config_file, "config/puma.rb"

task :init_shared_path, :roles => :web do
  run "mkdir -p #{deploy_to}/shared/log"
  run "mkdir -p #{deploy_to}/shared/config"
  run "mkdir -p #{deploy_to}/shared/public/uploads"
end

task :link_shared_files, :roles => :web do
  run "ln -sf #{shared_path}/config/secret_token.rb #{deploy_to}/current/config/initializers/secret_token.rb"
  run "ln -sf #{deploy_to}/shared/public/uploads #{deploy_to}/current/public/uploads"
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

after "deploy:setup", :init_shared_path
after "deploy:finalize_update","deploy:symlink", :init_shared_path, :link_shared_files, :mongoid_create_indexes, :compile_assets 
