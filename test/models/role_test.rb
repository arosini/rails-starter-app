require 'test_helper'

# Role model tests.
class RoleTest < ActiveSupport::TestCase
  setup do
    @admin_role = roles(:admin)
    @user_role = roles(:user)
  end

  test 'admin role saves' do
    assert @admin_role.save
  end

  test 'user role saves' do
    assert @user_role.save
  end

  test 'new role saves' do
    assert new_role.save
  end

  test 'name required for existing roles' do
    @user_role.name = ''
    assert !@user_role.save
  end

  test 'name required for new role' do
    role = new_role
    role.name = ''
    assert !role.save
  end

  test 'name must be unique for existing roles' do
    @user_role.name = @admin_role.name
    assert !@user_role.save
  end

  test 'name must be unique for new roles' do
    role = new_role
    role.name = @admin_role.name
    assert !role.save
  end

  test 'users role can access users through has_and_belongs_to_many' do
    users = @user_role.users
    assert users.count == 2 && users.include?(@user) && users.include?(@other_user)
  end

  test 'admin role can access users through has_and_belongs_to_many' do
    admins = @admin_role.users
    assert admins.count == 2 && admins.include?(@admin) && admins.include?(@other_admin)
  end

  private

  def new_role
    Role.new(name: 'Test')
  end
end
