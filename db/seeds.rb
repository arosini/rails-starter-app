# This file should contain all the record creation needed to
# seed the database with its default values. The data can then
# be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Rails.logger.info 'Seeding database from /db/seeds.rb:'

Rails.logger.info 'Creating "Admin" role....'
Role.create(name: 'Admin')
Rails.logger.info 'Done!'

Rails.logger.info 'Creating "User" role....'
Role.create(name: 'User')
Rails.logger.info 'Done!'

Rails.logger.info 'Creating admin user with email "admin@admin.com" and
                   password "asdqwe"...'
User.create(email: 'admin@admin.com', password: 'asdqwe',
            password_confirmation: 'asdqwe',
            roles: [Role.find_by(name: 'Admin')])
Rails.logger.info 'Done!'

Rails.logger.info 'Creating regular user with email "user@user.com"
                   and password "asdqwe"..'
User.create(email: 'user@user.com', password: 'asdqwe',
            password_confirmation: 'asdqwe',
            roles: [Role.find_by(name: 'User')])
Rails.logger.info 'Done!'

Rails.logger.info 'Database seed task complete!'
