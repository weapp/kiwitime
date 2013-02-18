set :application, "kiwitime"
 
# RVM integration
# http://beginrescueend.com/integration/capistrano/
require "rvm/capistrano"
set :rvm_ruby_string, "1.9.2"
#set :rvm_type, :user
 
# Bundler integration (bundle install)
# http://gembundler.com/deploying.html
require "bundler/capistrano"
set :bundle_without,  [:development, :test]
 

set :deploy_to, "/var/www/apps/#{application}"
set :use_sudo, false
 
# Must be set for the password prompt from git to work
# http://help.github.com/deploy-with-capistrano/
default_run_options[:pty] = true 
set :scm, :git
set :repository, "https://github.com/weapp/kiwitime.git"
set :branch, "master"
set :deploy_via, :remote_cache
set :domain, "localhost"
#ssh_options[:port] = 22
role :app, domain
role :web, domain
role :db, domain, :primary => true
#set :deploy_via, :remote_cache
set :branch, 'master'
set :rails_env, "production"
# Multiple Stages Without Multistage Extension
# https://github.com/capistrano/capistrano/wiki/2.x-Multiple-Stages-Without-Multistage-Extension
 
# http://modrails.com/documentation/Users%20guide%20Nginx.html#capistrano
namespace :deploy do
  desc "Start server"
  task :start, :roles => :app do
    run "#{try_sudo} touch #{File.join(release_path,'tmp','restart.txt')}"
  end
  
  # not supported by Passenger server
  task :stop, :roles => :app do
  end
  
  desc "Restart server"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(release_path,'tmp','restart.txt')}"
  end

  desc "Run bundler to update the gemset"
  task :bundle, :roles => :app do
     run "cd #{current_release} && bundle install --path #{deploy_to}/shared/bundle --without test:development"
     run "cd #{current_release} && bundle install --without test:development"
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    #run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end
  
  desc "Execute migrations"
  task :migrate, :roles => :db do
    run "bundle exec rake db:migrate"
  end
end
 
#after 'deploy:update_code', 'deploy:symlink_shared'