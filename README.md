Linux Installation Instructions
=================================
1. Install Git
    ```ruby
    sudo apt-get install git-core
    ```

2. Install NodeJS (or another JavaScript runtime library)

    ```sudo apt-get install nodejs```

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
    rake db:migrate RAILS_ENV=test
    rake db:seed
    ```

Your are done! To view the app, run the following command from the project root:

     rails s

Once you see something like 'INFO WEBrick::HTTPServer#start: pid=168 port=3000', this means the server is ready. Navigate to 'localhost:3000' in a browser and you should see the application. You can login to an admin account with the username 'admin@admin.com' and password 'asdqwe'.

Run the unit tests with:

    rake test TESTOPTS='--profile'
    
Run the acceptance tests with:

    cucumber
