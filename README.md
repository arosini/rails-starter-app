# Installation Instructions

1. Install Git
    ```bash
    sudo apt-get install git-core
    ```

2. Install NodeJS (or another JavaScript runtime library)

    ```bash
    sudo apt-get install nodejs
    ```

3. Install RVM, Ruby 2.2.0 and Bundler

    ```bash
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable
    source /home/USERNAME/.rvm/scripts/rvm
    rvm install ruby-2.2.0
    rvm use 2.2.0
    rvm 2.2.0 do gem install bundler
    ```

4. Clone repo, install gems and setup database:

    ```bash
    git clone https://github.com/arosini/rails-starter-app.git
    cd rails-starter-app
    bundle install
    rake db:migrate
    rake db:migrate RAILS_ENV=test
    rake db:seed
    ```

5. Install Heroku and login

    ```bash
    wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
    heroku login
    ```

# Starting the Server
```bash
rails s
```

You can login to an admin account with the username 'admin@admin.com' and password 'asdqwe'.

# Unit Tests
```bash
rake test TESTOPTS='--profile'
```
    
# Integration Tests
```bash
cucumber
```

# Deploying

```
git push heroku master
heroku run rake db:migrate
```

Reference: https://devcenter.heroku.com/articles/getting-started-with-rails4
