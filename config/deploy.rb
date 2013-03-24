require 'bundler/capistrano'
require 'capistrano-rbenv'

set :rbenv_ruby_version, "2.0.0" 
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
