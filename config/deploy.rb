require 'bundler/capistrano'
require 'capistrano-rbenv'

set :rbenv_ruby_version, "2.0.0-p247" 
set :rbenv_install_dependencies, false

set :rails_env, 'production'
set :application, 'rails-hosting-test'

set :scm, :git
set :repository, "git@github.com:telmich/rails-hosting-test.git"

set :deploy_via, :remote_cache

server 'rails-19.panter.ch', :app, :web, :db, :primary => true
set :deploy_to, "/home/rails/app"
set :user, "rails"

set :ssh_options, {:forward_agent => true}

# Don't try to use sudo - all deps should already be there!
set :use_sudo, false

# Unicorn integration, Nico Schottelius, 2013-03-24
set :unicorn_binary, "bundle exec unicorn --listen #{current_path}/unicorn.sock --env #{rails_env} --daemonize"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"
 
namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "$HOME/bin/unicorn_wrapper restart"
  end 
end
