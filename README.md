Linux Installation Instructions!!
=================================
1. Install Git
    ```ruby
    sudo apt-get install git-core
    ```

2. Add ssh using: https://help.github.com/articles/generating-ssh-keys/#platform-linux

3. Install rvm/ruby 2.2.0/bundler

    ```ruby
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable
    source /home/USERNAME/.rvm/scripts/rvm
    rvm install ruby-2.2.0
    rvm use 2.2.0
    rvm 2.2.0 do gem install bundler
    ```

4. Clone repo, install gems and setup database:

    ```ruby
    git clone https://github.com/arosini/rails-starter-app.git
    cd rails-starter-app
    bundle install
    rake db:migrate
    rake db:seed
    ```

Your are done! To view the app, run the following command from the project root:

     rails s

Once you see something like 'INFO WEBrick::HTTPServer#start: pid=168 port=3000', this means the server is ready. Navigate to 'localhost:3000' in a browser and you should see the application. You can login to an admin account with the username 'admin@admin.com' and password 'asdqwe'.

Run the unit tests with:

    rake test TESTOPTS='--profile'
    
Run the acceptance tests with:

    cucumber

Windows Installation Instructions!!
=================================

1. Install Git from: http://msysgit.github.io

2. Add ssh using: https://help.github.com/articles/generating-ssh-keys/#platform-windows

3. Download Ruby 2.0.0-p481 or higher (x64 if on a 64-bit machine) from: http://rubyinstaller.org/downloads/. Download the corresponding DevKit from the same location. Run the Ruby installer and after it is complete, open a new command prompt and run 'ruby -v' to see if the ruby install worked. 

4. To install the DevKit downloaded in pevious step, follow the instructions at: https://github.com/oneclick/rubyinstaller/wiki/Development-Kit

5. Clone this repo: 
     ```ruby
     git clone https://github.com/arosini/rails-starter-app.git
     ```

6. Open a new command prompt and from the project root, run the following:
     ```ruby
     gem install bundle
     bundle install
     ```
   If you get any errors, follow the instructions (ie: may need to run: gem install json -v '1.8.1')

6. From the the project root, run the following to set up the database:
     ```ruby
     rake db:migrate
     rake db:seed
     ```
Your are done! To view the app, run the following command from the project root:

     ```ruby
     rails s 
     ```
Once you see something like 'INFO  WEBrick::HTTPServer#start: pid=168 port=3000', this means the server is ready. 
Navigate to 'localhost:3000' in a browser and you should see the application. You should be able to sign in to an admin account with the username 'admin@admin.com' and password 'asdqwe'. You should be able to sign in to a user account with the username 'user@user.com' and password 'asdqwe'.

Run the unit tests with:

    rake test TESTOPTS='--profile'
    
Run the acceptance tests with:

    cucumber
