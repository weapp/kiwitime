set :application, "kiwitime"
set :repository,  "git://git.batkiwi.com:kiwitime.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names

set :deploy_to, "/var/www/#{application}"

set :user, "deploy"
set :use_sudo, false





namespace :deploy do

  desc "Setup a GitHub-style deployment."
  task :setup, :except => { :no_release => true } do
    commands = ["mkdir -p #{deploy_to}",
               "git clone #{repository} #{current_path}",
               "mkdir -p #{current_path}/tmp",
               "mkdir -p #{deploy_to}/shared/config",
               "mkdir -p #{deploy_to}/shared/files",
               "mkdir -p #{deploy_to}/shared/log",
               "mkdir -p #{deploy_to}/shared/system",
               "mkdir -p #{deploy_to}/shared/tmp",
               "mkdir -p #{deploy_to}/shared/db"]
   run commands.join(" && ")
  end
    
end





role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "your app-server here"                          # This may be the same as your `Web` server
role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end