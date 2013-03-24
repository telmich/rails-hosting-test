require 'bundler/capistrano'
require 'capistrano-rbenv'

set :rbenv_ruby_version, "2.0.0-p0" 
set :rbenv_install_dependencies, false

set :rails_env, 'production'
set :application, 'rails-hosting-test'

set :scm, :git
set :repository, "git@github.com:telmich/rails-hosting-test.git"

set :deploy_via, :remote_cache

server 'wittbib-staging.panter.ch', :app, :web, :db, :primary => true
set :deploy_to, "/home/rails/app"
set :user, "rails"

set :ssh_options, {:forward_agent => true}

# Don't try to use sudo - all deps should already be there!
set :use_sudo, false

# Unicorn integration, Nico Schottelius, 2013-03-24
set :unicorn_binary, "bundle exec unicorn --listen #{current_path}/unicorn.sock --env #{rails_env} --daemonize"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"
 
namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{unicorn_binary}"
  end
 
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ]; then kill `cat #{unicorn_pid}`; fi"
  end
 
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ]; then kill -s QUIT `cat #{unicorn_pid}`; fi"
  end
 
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ]; then kill -s USR2 `cat #{unicorn_pid}`; fi"
  end
 
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end
