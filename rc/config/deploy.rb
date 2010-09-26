set :application, "rc"
set :deploy_to, "/var/www/rc3"
set :user, "root"
set :runner, user
set :apache_site_folder, "/etc/apache2/sites-enabled"

set :scm, :git
set :repository,  "git@github.com:zerothabhishek/rc3.git"
set :branck, "master"

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


# following recipe is taken from 
# http://www.markrichman.com/2008/08/20/deploying-rails-apps-with-capistrano-git-and-passenger/
namespace :init do

  desc "setting proper permissions for deploy user"
  task :set_permissions do
    sudo “chown -R deploy #{base_path}/#{application}”
  end

  desc "create mysql db"
  task :create_database do
    #create the database on setup
    set :db_user, Capistrano::CLI.ui.ask("database user: ") unless defined?(:db_user)
    set :db_pass, Capistrano::CLI.password_prompt("database password: ") unless defined?(:db_pass)
    run "echo \"CREATE DATABASE #{application}_production\" | mysql -u #{db_user} –password=#{db_pass}"
  end

  desc "enable site"
  task :enable_site do
    sudo "ln -nsf #{shared_path}/config/apache_site.conf #{apache_site_folder}/#{application}"
  
  end

  desc "create database.yml"
  task :database_yml do
    set :db_user, Capistrano::CLI.ui.ask("database user: ")
    set :db_pass, Capistrano::CLI.password_prompt("database password: ")
    database_configuration = %(
—
login: &login
  adapter: mysql
  encoding: utf8
  database: #{application}_production
  host: localhost
  username: #{db_user}
  password: #{db_pass}
  socket: /var/run/mysqld/mysqld.sock

production:
  <<: *login
)
    run "mkdir -p #{shared_path}/config"
    put database_configuration, "#{shared_path}/config/database.yml"
  end

  desc "create vhost file"
  task :create_vhost do

    vhost_configuration = %(

  ServerName #{server_name}
  DocumentRoot #{base_path}/#{application}/current/public

)

    put vhost_configuration, "#{shared_path}/config/apache_site.conf"

  end

end
