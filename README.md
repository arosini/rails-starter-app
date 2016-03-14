# Rails Starter Application
Used as a starting point for developing new Rails applications, or just as a sandbox to play around with.

An example deployment can be found here: https://rails-starter-application.herokuapp.com/.
If you would like the "Admin role within the application, let me know and I will give them to you. 

## Installation Instructions

1. Install Git
    ```bash
    $ sudo apt-get install git-core
    ```

2. Install NodeJS (or another JavaScript runtime library)

    ```bash
    $ sudo apt-get install nodejs
    ```

3. Install RVM

    ```bash
    $ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    $ curl -sSL https://get.rvm.io | bash -s stable
    $ source /home/$(whoami)/.rvm/scripts/rvm
    ```

4. Install Ruby 2.2.1
    ```
    $ rvm install ruby-2.2.1
    $ rvm use 2.2.1
    $ rvm 2.2.1 do gem install bundler
    ```

5. Install and setup Postgres
    ```
    $ sudo apt-get install libpq-dev postgresql-9.3
    $ sudo -u postgres psql
    $ create user "rails_starter_app" password 'rails_starter_app_pass';
    $ create database "rails_starter_app_dev" owner "rails_starter_app";
    $ create database "rails_starter_app_tst" owner "rails_starter_app";
    $ \q
    ```

6. Clone the repository, install gems and setup database:

    ```bash
    $ git clone https://github.com/arosini/rails-starter-app.git
    $ cd rails-starter-app
    $ bundle install
    $ rake db:migrate
    $ rake db:migrate RAILS_ENV=test
    $ rake db:seed
    ```

7. Install and setup Heroku

    ```bash
    $ wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
    $ heroku login
    $ heroku git:remote -a rails-starter-application
    ```

## Starting the Server
```bash
$ rails s
```

You can sign in to an admin account with the username 'admin@admin.com' and password 'asdqwe'.

## Unit Tests
```bash
$ rake test TESTOPTS='--profile'
```
    
## Integration Tests
```bash
$ cucumber [--format usage]
```

The following [tags](https://github.com/cucumber/cucumber/wiki/Tags) are available:
  - @create
  - @read
  - @search
  - @update
  - @delete
  - @slow
  - @navigation
  - @authentication
  - @authorization
  - @failure
  - @email

## Reports
```
$ rubocop
$ rails_best_practices
$ rubycritic app features
$ brakeman
```

## Deploying
```
$ git push heroku master
$ heroku run rake db:migrate
```

Reference: https://devcenter.heroku.com/articles/getting-started-with-rails4
