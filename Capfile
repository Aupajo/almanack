load 'deploy' if respond_to?(:namespace) # cap2 differentiator

# Global
set :application, "sinatra-gcal"

# Deployment
set :user, "deploy"
set :use_sudo, false
set :deploy_to, "/home/deploy/#{application}/"
set :deploy_via, :remote_cache
server "events.geek.nz", :app

# Git
set :scm, :git
set :repository,  "git@github.com:Aupajo/#{application}.git"
set :branch, "master"

namespace :deploy do
  # Compatible with upcoming Capistrano changes (http://is.gd/2BPeA)
  task(:start) {}
  task(:stop) {}
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end