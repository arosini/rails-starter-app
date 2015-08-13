require 'test_helper'

# Test authorization, authentication and routing for the RolesController
class RolesControllerTest < ActionController::TestCase
  # Not found test
  test '404 served on not found exception' do
    sign_in @user
    get :show, id: 1337
    assert_404_response
  end

  # Index tests
  test 'admin request index roles' do
    sign_in @admin
    get :index
    assert_response :success
    assert_template :index, partial: '_roles_table'
    assert_template partial: '_search'
    assert_template partial: '_paginator'
    assert_app_layout
  end

  test 'user request index roles' do
    sign_in @user
    get :index
    assert_not_authorized
  end

  test 'guest request index roles' do
    get :index
    assert_not_authenticated
  end

  # Show tests
  test 'admin request show role' do
    sign_in @admin
    get :show, id: @user_role.id
    assert_response :success
    assert_template :show
    assert_app_layout
  end

  test 'user request show role' do
    sign_in @user
    get :show, id: @user_role.id
    assert_not_authorized
  end

  test 'guest request show role' do
    get :show, id: @user_role.id
    assert_not_authenticated
  end

  # New tests
  test 'admin request new role' do
    sign_in @admin
    get :new
    assert_response :success
    assert_template :new, partial: '_form'
    assert_app_layout
  end

  test 'user request new role' do
    sign_in @user
    get :new
    assert_not_authorized
  end

  test 'guest request new role' do
    get :new
    assert_not_authenticated
  end

  # Edit tests
  test 'admin request edit role' do
    sign_in @admin
    get :edit, id: @user_role.id
    assert_response :success
    assert_template :edit, partial: '_form'
    assert_app_layout
  end

  test 'user request edit role' do
    sign_in @user
    get :edit, id: @user_role.id
    assert_not_authorized
  end

  test 'guest request edit role' do
    get :edit, id: @user_role.id
    assert_not_authenticated
  end

  # Create tests
  test 'admin request create role' do
    sign_in @admin
    assert_difference('Role.count') { post :create, role: role_form_params }
    assert_redirected_to role_path(assigns(:role))
    assert_equal 'Successfully created role.', flash[:notice]
  end

  test 'user request create role' do
    sign_in @user
    assert_no_difference('Role.count') { post :create, role: role_form_params }
    assert_not_authorized
  end

  test 'guest request create role' do
    assert_no_difference('Role.count') { post :create, role: role_form_params }
    assert_not_authenticated
  end

  # Update tests
  test 'admin request update role' do
    sign_in @admin
    put :update, id: @user_role.id, role: role_form_params
    assert_redirected_to role_path(assigns(:role))
    assert_equal 'Successfully updated role.', flash[:notice]
  end

  test 'user request update role' do
    sign_in @user
    put :update, id: @user_role.id, role: role_form_params
    assert_not_authorized
  end

  test 'guest request update role' do
    put :update, id: @user_role.id, role: role_form_params
    assert_not_authenticated
  end

  # Destroy tests
  test 'admin request destroy role' do
    sign_in @admin
    delete :destroy, id: @user_role.id
    assert_redirected_to roles_path
    assert_equal 'Successfully destroyed role.', flash[:notice]
  end

  test 'user request destroy role' do
    sign_in @user
    delete :destroy, id: @user_role.id
    assert_not_authorized
  end

  test 'guest request destroy role' do
    delete :destroy, id: @user_role.id
    assert_not_authenticated
  end

  # Destroy JS tests
  test 'admin request destroy role js' do
    sign_in @admin
    delete :destroy, format: :js, id: @user_role.id
    assert_response :success
  end

  test 'user request destroy role js' do
    sign_in @user
    delete :destroy, format: :js, id: @user_role.id
    assert_not_authorized
  end

  test 'guest request destroy role js' do
    delete :destroy, format: :js, id: @user_role.id
    assert_not_authenticated_js
  end

  # Check name unique tests
  test 'admin check if role name unique success' do
    sign_in @admin
    get :check_name_unique, format: :json, name: 'Quite Unique'
    assert_equal true, json_response
  end

  test 'admin check if role name unique failure' do
    sign_in @admin
    get :check_name_unique, format: :json, name: 'Admin'
    assert_equal false, json_response
  end

  test 'user check if role name unique' do
    sign_in @user
    get :check_name_unique, format: :json, name: 'Quite Unique'
    assert_not_authorized
  end

  test 'guest check if role name unique' do
    get :check_name_unique, format: :json, name: 'Quite Unique'
    assert_not_authenticated_json
  end

  test 'admin request role name unique with html' do
    sign_in @admin
    get :check_name_unique, format: :html, name: 'Quite Unique'
    assert_404_response
  end

  # Form error tests
  test 'name can\'t be blank message on create' do
    sign_in @admin
    assert_no_difference('Role.count') { post :create, role: { name: '' } }
    assert_failed_new_role(:name, 'can\'t be blank')
  end

  test 'name must be unique on create' do
    sign_in @admin
    assert_no_difference('Role.count') { post :create, role: { name: @admin_role.name } }
    assert_failed_new_role(:name, 'has already been taken')
  end

  test 'name can\'t be blank message on update' do
    sign_in @admin
    assert_no_difference('Role.count') do
      put :update, id: @user_role.id, role: { name: '' }
    end
    assert_failed_update_role(:name, 'can\'t be blank')
  end

  test 'name must be unique on update' do
    sign_in @admin
    assert_no_difference('Role.count') do
      put :update, id: @user_role.id, role: { name: @admin_role.name }
    end
    assert_failed_update_role(:name, 'has already been taken')
  end

  private

  def role_form_params
    { name: 'Test' }
  end

  def assert_failed_new_role(field, error)
    assert assigns[:role].errors[field].include? error
    assert_template :new, partial: '_form'
    assert_app_layout
  end

  def assert_failed_update_role(field, error)
    assert assigns[:role].errors[field].include? error
    assert_template :edit, partial: '_form'
    assert_app_layout
  end
end
