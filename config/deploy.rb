require 'capistrano-rbenv'
require 'bundler/capistrano'

set :rbenv_ruby_version, "2.0.0" 
set :rbenv_install_dependencie, false"

set :rails_env, 'production'
set :application 'rails-hosting-test'

# Deployment source
set :scm, :git
set :repository, "git@github.com:telmich/rails-hosting-test.git"

# Deployment method
set :deploy_via, :remote_cache

# Deployment destination
server 'wittbib-staging.panter.ch', :app, :web, :db, :primary => true
set :deploy_to, "/home/rails/app"
set :user, "rails"

# Forward agent so cloning from github is possible
set :ssh_options, {:forward_agent => true}

# Don't try to use sudo - all deps should already be there!
set :use_sudo, false
