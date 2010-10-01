require 'config/deploy/capistrano_database_yml'

set :application, "rc"
set :deploy_to, "/var/www/rc3"
set :user, "root"
set :runner, user
set :apache_site_folder, "/etc/apache2/sites-enabled"

set :scm, :git
set :repository,  "git@github.com:zerothabhishek/rc3.git"
set :branch, "master"
set :scm_passphrase, "uma is mast"
set :deploy_via, :remote_cache

default_run_options[:pty] = true  # Must be set for the password prompt from git to work

set :app_site, "li161-110.members.linode.com" 
role :web, app_site                           # Your HTTP server, Apache/etc
role :app, app_site                           # This may be the same as your `Web` server
role :db,  app_site, :primary => true         # This is where Rails migrations will run
#role :db,  ""                                 # your slave db-server here

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end
