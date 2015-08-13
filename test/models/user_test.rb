require 'test_helper'

# User model tests
class UserTest < ActiveSupport::TestCase
  test 'existing user saves' do
    assert @user.save
  end

  test 'new user saves' do
    assert new_user.save
  end

  test 'email required for existing users' do
    @user.email = ''
    assert !@user.save
  end

  test 'email required for new users' do
    user = new_user
    user.email = ''
    assert !user.save
  end

  test 'email must be unique for existing users' do
    @user.email = @admin.email
    assert !@user.save
  end

  test 'email must be unique for new users' do
    user = new_user
    user.email = @admin.email
    assert !user.save
  end

  test 'password required for existing users' do
    @user.password = ''
    assert !@user.save
  end

  test 'password required for new users' do
    user = new_user
    user.password = ''
    assert !user.save
  end

  test 'password confirmation required for existing users' do
    @user.password_confirmation = ''
    assert !@user.save
  end

  test 'password confirmation required for new users' do
    user = new_user
    user.password_confirmation = ''
    assert !user.save
  end

  test 'password confirmation must match password for existing users' do
    @user.password_confirmation = 'asdqwe1'
    assert !@user.save
  end

  test 'password confirmation  must match password for new users' do
    user = new_user
    user.password_confirmation = 'asdqwe1'
    assert !user.save
  end

  test 'default role of user is assigned for new user' do
    user = new_user
    user.save
    assert user.user? && user.roles.length == 1
  end

  test 'admin role identity method' do
    assert @admin.admin? && !@admin.user? && !@admin.guest?
  end

  test 'user role identity method' do
    assert @user.user? && !@user.admin? && !@user.guest?
  end

  test 'guest role identity method' do
    guest = new_user
    assert guest.guest? && !guest.user? && !guest.admin?
  end

  test 'an admin can access roles through has_and_belongs_to_many' do
    admin_roles = @admin.roles
    assert admin_roles.count == 1 && admin_roles.include?(Role.find_by(name: 'Admin'))
  end

  test 'a user can access roles through has_and_belongs_to_many' do
    user_roles = @user.roles
    assert user_roles.count == 1 && user_roles.include?(Role.find_by(name: 'User'))
  end

  private

  def new_user
    User.new(email: 'test@test.com', password: 'asdqwe', password_confirmation: 'asdqwe')
  end
end
