11sep2010

- ruby on this system was 1.9.1. Installed rails for it. That won't work
- Installed ruby 1.9.2. Installed rails
- tried installing Rdiscount - markdown interpreter - fail
- tried installing mysql2 -failed
- The above two failed because the rubyinstaller doesn't now come with the _devkit_ within it.
This devkit is the thing that brings very essential *nix domain tools - gcc, sh, make etc to win platform.
The problem here was, gems that have C/c++ code (extensions) within them (native rubygems) will not work if not compiled, for which the devkit is necessary. Go through its installation steps to get it done(http://github.com/oneclick/rubyinstaller/wiki/Development-Kit)

- mysql2 installation will still fail. This is because mysql2 gem is not yet supported for Windows.
Postgres also has problems in rails-3 on windows. SO installed sqlite3

12sep2010

rails generate scaffold resume content:text 


08oct2010

Log of all cap-stuff today -

cipher:rc3 abhishek$ sudo cap deploy:setup
Password:
Enter your git passphrase: 
  * executing `deploy:setup'
  * executing "sudo -p 'sudo password: ' mkdir -p /var/www/ /var/www/releases /var/www/shared /var/www/shared/system /var/www/shared/log /var/www/shared/pids && sudo -p 'sudo password: ' chmod g+w /var/www/ /var/www/releases /var/www/shared /var/www/shared/system /var/www/shared/log /var/www/shared/pids"
    servers: ["li161-110.members.linode.com"]
Password: 
    [li161-110.members.linode.com] executing command
    command finished
    triggering after callbacks for `deploy:setup'
  * executing `deploy:db:setup'
  * executing "mkdir -p /var/www/shared/db"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
  * executing "mkdir -p /var/www/shared/config"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
Enter MySQL database password: 
    servers: ["li161-110.members.linode.com"]
 ** sftp upload #<StringIO:0x1017bdc28> -> /var/www/shared/config/database.yml
    [li161-110.members.linode.com] /var/www/shared/config/database.yml
    [li161-110.members.linode.com] done
  * sftp upload complete
cipher:rc3 abhishek$ sudo cap deploy:check
Enter your git passphrase: 
  * executing `deploy:check'
  * executing "test -d /var/www/releases"
    servers: ["li161-110.members.linode.com"]
Password: 
    [li161-110.members.linode.com] executing command
    command finished
  * executing "test -w /var/www/"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
  * executing "test -w /var/www/releases"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
  * executing "which git"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
  * executing "test -w /var/www/shared"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
You appear to have all necessary dependencies installed
cipher:rc3 abhishek$ sudo cap deploy:update
Enter your git passphrase: 
  * executing `deploy:update'
 ** transaction: start
  * executing `deploy:update_code'
    updating the cached checkout on all servers
    executing locally: "git ls-remote git@github.com:zerothabhishek/rc3.git master"
  * executing "if [ -d /var/www/shared/cached-copy ]; then cd /var/www/shared/cached-copy && git fetch -q origin && git reset -q --hard ac09faa6283e56fd786a4cdf3300b6c5bc827d5d && git clean -q -d -x -f; else git clone -q git@github.com:zerothabhishek/rc3.git /var/www/shared/cached-copy && cd /var/www/shared/cached-copy && git checkout -q -b deploy ac09faa6283e56fd786a4cdf3300b6c5bc827d5d; fi"
    servers: ["li161-110.members.linode.com"]
Password: 
    [li161-110.members.linode.com] executing command
 ** [li161-110.members.linode.com :: out] Enter passphrase for key '/root/.ssh/id_rsa':
 ** [li161-110.members.linode.com :: out]
    command finished
    copying the cached version to /var/www/releases/20101007192545
  * executing "cp -RPp /var/www/shared/cached-copy /var/www/releases/20101007192545 && (echo ac09faa6283e56fd786a4cdf3300b6c5bc827d5d > /var/www/releases/20101007192545/REVISION)"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
  * executing `deploy:finalize_update'
  * executing "chmod -R g+w /var/www/releases/20101007192545"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
  * executing "rm -rf /var/www/releases/20101007192545/log /var/www/releases/20101007192545/public/system /var/www/releases/20101007192545/tmp/pids &&\\\n      mkdir -p /var/www/releases/20101007192545/public &&\\\n      mkdir -p /var/www/releases/20101007192545/tmp &&\\\n      ln -s /var/www/shared/log /var/www/releases/20101007192545/log &&\\\n      ln -s /var/www/shared/system /var/www/releases/20101007192545/public/system &&\\\n      ln -s /var/www/shared/pids /var/www/releases/20101007192545/tmp/pids"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
  * executing "find /var/www/releases/20101007192545/public/images /var/www/releases/20101007192545/public/stylesheets /var/www/releases/20101007192545/public/javascripts -exec touch -t 201010071925.49 {} ';'; true"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
    triggering after callbacks for `deploy:finalize_update'
  * executing `deploy:db:symlink'
  * executing "ls -x /var/www/releases"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
  * executing "ln -nfs /var/www/shared/config/database.yml /var/www/releases/20101007192545/config/database.yml"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
  * executing `deploy:symlink'
  * executing "rm -f /var/www/current && ln -s /var/www/releases/20101007192545 /var/www/current"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
    command finished
 ** transaction: commit
cipher:rc3 abhishek$ cap -T
Enter your git passphrase: 
cap deploy               # Deploys your project.
cap deploy:check         # Test deployment dependencies.
cap deploy:cleanup       # Clean up old releases.
cap deploy:cold          # Deploys and starts a `cold' application.
cap deploy:db:setup      # Creates the database.yml configuration file in sha...
cap deploy:migrate       # Run the migrate rake task.
cap deploy:migrations    # Deploy and run pending migrations.
cap deploy:pending       # Displays the commits since your last deploy.
cap deploy:pending:diff  # Displays the `diff' since your last deploy.
cap deploy:rollback      # Rolls back to a previous version and restarts.
cap deploy:rollback:code # Rolls back to the previously deployed version.
cap deploy:setup         # Prepares one or more servers for deployment.
cap deploy:symlink       # Updates the symlink to the most recently deployed ...
cap deploy:update        # Copies your project and updates the symlink.
cap deploy:update_code   # Copies your project to the remote servers.
cap deploy:upload        # Copy files to the currently deployed version.
cap deploy:web:disable   # Present a maintenance page to visitors.
cap deploy:web:enable    # Makes the application web-accessible again.
cap invoke               # Invoke a single command on the remote servers.
cap shell                # Begin an interactive Capistrano session.

Some tasks were not listed, either because they have no description,
or because they are only used internally by other tasks. To see all
tasks, type `cap -vT'.

Extended help may be available for these tasks.
Type `cap -e taskname' to view it.
cipher:rc3 abhishek$ sudo cap deploy:migrate
Enter your git passphrase: 
  * executing `deploy:migrate'
  * executing "ls -x /var/www/releases"
    servers: ["li161-110.members.linode.com"]
Password: 
    [li161-110.members.linode.com] executing command
    command finished
latest => /var/www/releases/20101007192545
  * executing "cd /var/www/releases/20101007192545; rake RAILS_ENV=production  db:migrate"
    servers: ["li161-110.members.linode.com"]
    [li161-110.members.linode.com] executing command
 ** [out :: li161-110.members.linode.com] (in /var/www/releases/20101007192545)
 ** [out :: li161-110.members.linode.com] rake aborted!
 ** [out :: li161-110.members.linode.com] Unknown database 'rc3_production'
 ** [out :: li161-110.members.linode.com] 
 ** [out :: li161-110.members.linode.com] (See full trace by running task with --trace)
    command finished
failed: "sh -c 'cd /var/www/releases/20101007192545; rake RAILS_ENV=production  db:migrate'" on li161-110.members.linode.com
cipher:rc3 abhishek$ 
cipher:rc3 abhishek$ 
cipher:rc3 abhishek$ 
cipher:rc3 abhishek$ 
cipher:rc3 abhishek$ cap deploy:start
Enter your git passphrase: 
  * executing `deploy:start'
cipher:rc3 abhishek$ ping li161-110.members.linode.com
PING li161-110.members.linode.com (173.230.151.110): 56 data bytes
64 bytes from 173.230.151.110: icmp_seq=0 ttl=54 time=323.364 ms
64 bytes from 173.230.151.110: icmp_seq=1 ttl=54 time=449.456 ms
64 bytes from 173.230.151.110: icmp_seq=2 ttl=54 time=370.780 ms
64 bytes from 173.230.151.110: icmp_seq=3 ttl=54 time=394.502 ms
64 bytes from 173.230.151.110: icmp_seq=4 ttl=54 time=315.479 ms
^C
--- li161-110.members.linode.com ping statistics ---
6 packets transmitted, 5 packets received, 16.7% packet loss
round-trip min/avg/max/stddev = 315.479/370.716/449.456/49.110 ms
cipher:rc3 abhishek$ 
cipher:rc3 abhishek$ 
cipher:rc3 abhishek$ 
cipher:rc3 abhishek$ cap deploy:restart
Enter your git passphrase: 
  * executing `deploy:restart'
  * executing "sudo -p 'sudo password: ' touch /var/www/current/tmp/restart.txt"
    servers: ["li161-110.members.linode.com"]
Password: 
    [li161-110.members.linode.com] executing command
    command finished
----------------------------

Passenger reinstall -

Please edit your Apache configuration file, and add these lines:

   LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-2.2.15/ext/apache2/mod_passenger.so
   PassengerRoot /usr/lib/ruby/gems/1.8/gems/passenger-2.2.15
   PassengerRuby /usr/bin/ruby1.8

Deploying a Ruby on Rails application: an example

Suppose you have a Rails application in /somewhere. Add a virtual host to your
Apache configuration file and set its DocumentRoot to /somewhere/public:

   <VirtualHost *:80>
      ServerName www.yourhost.com
      DocumentRoot /somewhere/public    # <-- be sure to point to 'public'!
      <Directory /somewhere/public>
         AllowOverride all              # <-- relax Apache security settings
         Options -MultiViews            # <-- MultiViews must be turned off
      </Directory>
   </VirtualHost>

And that's it! You may also want to check the Users Guide for security and
optimization tips, troubleshooting and other useful information:

  /usr/lib/ruby/gems/1.8/gems/passenger-2.2.15/doc/Users guide Apache.html

The dafault vhosts file is copy-pasted in the #{RAILS_ROOT}/tmp/default.xsl file -

To restart the server use -

/etc/init.d/apache2 restart
or stop or start


Finally the vhost that got me going is -
<VirtualHost 173.230.151.110:80>
  DocumentRoot /var/www/current/public
  <Directory /var/www/current/public>
     AllowOverride all 
     Options -MultiViews
  </Directory>
</VirtualHost>


Starting rails3 webrick in production -
rails s -e "production" -p 80

AllowOverride all

#10oct2010

class Resume < ActiveRecord::Base
  has_one :style, :through => :style_attachments
end

class Template < ActiveRecord::Base
  has_many :resumes, :through => :style_attachments  
end

class Style < ActiveRecord::Base
  has_many :resumes, :through => :style_attachment
end

#12oct2010

Finally getting the associations correct
rails generate scaffold style title:string css:text
rails generate model style_attachment style_id:integer resume_id:integer

resume.rb:
    
	has_one :style_attachment, :dependent => :destroy
    has_one :style, :through => :style_attachment

style.rb:

	has_many :style_attachments, :dependent => :destroy
	has_many :resumes, :through => :style_attachments

style_attachment.rb:

	class StyleAttachment < ActiveRecord::Base
	  belongs_to :resume
	  belongs_to :style
	end


Now everytime we need a style for a resume or some resumes for a style, 
a StyleAttachment object will need to be created for the resume and the style
After that we can freely use __resume.style__ and __style.resumes__, and so on.


### Authentication options-
For rails-3 authlogic and devise are ready. 
Devise involves lesser no. of steps for rails-3 and is currently more active.

gem install devise
add it to gemfile
do the bundle install

rails generate devise:install
= command output ===============================================================
	create  config/initializers/devise.rb
	create  config/locales/devise.en.yml
	
	  Some setup you must do manually if you haven't yet:
	  1. Setup default url options for your specific environment. Here is an
	     example of development environment:
		
	       config.action_mailer.default_url_options = { :host => 'localhost:3000' }
		
	     This is a required Rails configuration. In production it must be the
	     actual host of your application. In config/environments/development.rb
		
	  2. Ensure you have defined root_url to *something* in your config/routes.rb.
	     For example:
		
	       root :to => "home#index"
		
	  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
	     For example:
		
	       <p class="notice"><%= notice %></p>
	       <p class="alert"><%= alert %></p>
===============================================================================

$ rails generate devise User
      invoke  active_record
      create    app/models/user.rb
      invoke    test_unit
      create      test/unit/user_test.rb
      create      test/fixtures/users.yml
      create    db/migrate/20101012184628_devise_create_users.rb
      inject    app/models/user.rb
       route  devise_for :users

===============================================================================
Trial actions:
1st time - Go
2rd time - save, preview, change-style 	| register
3th time - save, preview, change-style, delete 		| register   

Created observer- 
$> rails generate observer Resume
      invoke  active_record
      create    app/models/resume_observer.rb
      invoke    test_unit
      create      test/unit/resume_observer_test.rb
Added its config to config/application.rb
$> rails destroy observer Resume

Using observer to update save_counts is wrong. Hence destroyed.
This is because save_count is a measure of the no. of times the user has tried to save the resume,
and not the count of actual saves. Moreover updating an attribute of the model in its own after_save 
method can never work, as the new value will need to be saved, which will call after_save recursively
ending up in an infinite loop.

===============================================================================

25dec2010

Tasks left:

- homepage : design : rc is now resumeupdator, some look and feel

- demo-edit page : design : needs better help and directions
- demo-edit page : design : textbox should be larger
- demo-edit page : workflow : sign-up/sign-in link should be there
- demo-html page : UX : The message should appear in a collapsable div
- demo-edit page : UX : Markdown examples should appear only on click
- demo-edit page : UX : message within textbox should disappear on click

- code :Y: demo resumes should be created for demo account. Not admin account.
- code :Y: initializer/rake task to create the demo account - migration
- code : markup : carriage returns should automatically become <br/>
- code : switch from Kramdown to Rdiscount
- code : setup javascript - coffeescript or no, which jquery?


===============================================================================
temp:
<ul>
	<li> 
		headings - #, ##, ### <br/>
		# major heading => <h1>major heading</h1> <br/>
		## sub heading => <h2>sub heading</h2> <br/>
		### next level subheading => <h3>next level sub heading</h3> <br/>
	</li>
	<li> 
		__bold text__ => <b>bold text</b>
	</li>
	<li> 
		_italicized text_ => <i>italicized text</i>
	</li>
	<li> 
		[link to google]("http://google.com") => <a href="http://google.com">link to google"</a>
	</li>
</ul>	

===============================================================================

## 09jan2010

Changes needed now:

- DB: 	V	is_demo fields should go from resume model
- UI: 		edit page should be the home page if user is not logged in
- UI: 		edit layout needs to be further simplified
- code: V 	replace Kramdown with rdiscount 

To generate my own views:
	rails generate devise:views
      create  app/views/devise
      create  app/views/devise/confirmations/new.html.erb
      create  app/views/devise/mailer/confirmation_instructions.html.erb
      create  app/views/devise/mailer/reset_password_instructions.html.erb
      create  app/views/devise/mailer/unlock_instructions.html.erb
      create  app/views/devise/passwords/edit.html.erb
      create  app/views/devise/passwords/new.html.erb
      create  app/views/devise/registrations/edit.html.erb
      create  app/views/devise/registrations/new.html.erb
      create  app/views/devise/sessions/new.html.erb
      create  app/views/devise/shared/_links.erb
      create  app/views/devise/unlocks/new.html.erb

