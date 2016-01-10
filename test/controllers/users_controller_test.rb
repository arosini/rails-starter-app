require 'test_helper'

# Test authorization, authentication and routing for the UsersController
class UsersControllerTest < ActionController::TestCase
  # Not found test
  test '404 served on not found exception' do
    sign_in @user
    get :show, id: 0
    assert_404_response
  end

  # Index tests
  test 'admin request index user' do
    sign_in @admin
    get :index
    assert_index_success
  end

  test 'user request index user' do
    sign_in @user
    get :index
    assert_index_success
  end

  test 'guest request index user' do
    get :index
    assert_not_authenticated
  end

  # Show tests
  test 'admin request show user' do
    sign_in @admin
    # User
    get :show, id: @user.id
    assert_show_success

    # Admin
    get :show, id: @other_admin.id
    assert_show_success

    # Self
    get :show, id: @admin.id
    assert_show_success
  end

  test 'user request show user' do
    sign_in @user
    # User
    get :show, id: @admin.id
    assert_not_authorized

    # Admin
    get :show, id: @other_user.id
    assert_show_success

    # Self
    get :show, id: @user.id
    assert_show_success
  end

  test 'guest request show' do
    get :show, id: @admin.id
    assert_not_authenticated

    get :show, id: @user.id
    assert_not_authenticated
  end

  # New tests
  test 'admin request new user' do
    sign_in @admin
    get :new
    assert_response :success
    assert_new_user_templates
  end

  test 'user request new user' do
    sign_in @user
    get :new
    assert_not_authorized
  end

  test 'guest request new user' do
    get :new
    assert_not_authenticated
  end

  # Create tests
  test 'admin request create user' do
    sign_in @admin
    assert_difference('User.count') { post :create, user: user_form_params }
    assert_redirected_to user_path(assigns(:user))
    assert_equal 'Successfully created user.', flash[:notice]
  end

  test 'user request create user' do
    sign_in @user
    assert_no_difference('User.count') { post :create, user: user_form_params }
    assert_not_authorized
  end

  test 'guest request create user' do
    assert_no_difference('User.count') { post :create, user: user_form_params }
    assert_not_authenticated
  end

  # Edit tests
  test 'admin request edit user' do
    sign_in @admin
    # User
    get :edit, id: @user.id
    assert_edit_success

    # Admin
    get :edit, id: @other_admin.id
    assert_edit_success

    # Self
    get :edit, id: @admin.id
    assert_edit_success
  end

  test 'user request edit other user' do
    sign_in @user
    get :edit, id: @other_user.id
    assert_not_authorized
  end

  test 'user request edit admin' do
    sign_in @user
    get :edit, id: @admin.id
    assert_not_authorized
  end

  test 'user request edit self' do
    sign_in @user
    get :edit, id: @user.id
    assert_edit_success
  end

  test 'guest request edit user' do
    get :edit, id: @admin.id
    assert_not_authenticated

    get :edit, id: @user.id
    assert_not_authenticated
  end

  # Update tests
  test 'admin request update user (user)' do
    sign_in @admin
    put :update, id: @user.id, user: user_form_params
    assert_update_success
  end

  test 'admin request update user (admin)' do
    sign_in @admin
    put :update, id: @other_admin.id, user: user_form_params
    assert_update_success
  end

  test 'admin request update user (self)' do
    sign_in @admin
    put :update, id: @user.id, user: user_form_params
    assert_update_success
  end

  test 'user request update other user' do
    sign_in @user
    put :update, id: @other_user.id, user: user_form_params
    assert_not_authorized
  end

  test 'user request update admin' do
    sign_in @user
    put :update, id: @admin.id, user: user_form_params
    assert_not_authorized
  end

  test 'user request update self' do
    sign_in @user
    put :update, id: @user.id, user: user_form_params
    assert_redirected_to user_path(assigns(:user))
    assert_equal 'Successfully updated user.', flash[:notice]
  end

  test 'guest request update user' do
    put :update, id: @user.id, user: user_form_params
    assert_not_authenticated

    put :update, id: @admin.id, user: user_form_params
    assert_not_authenticated
  end

  # Destroy tests
  test 'user request destroy other user' do
    sign_in @user
    delete :destroy, id: @other_user.id
    assert_not_authorized
  end

  test 'user request destroy admin' do
    sign_in @user
    delete :destroy, id: @admin.id
    assert_not_authorized
  end

  test 'user request destroy self' do
    sign_in @user
    delete :destroy, id: @user.id
    assert_self_delete_success
  end

  test 'admin request destroy user' do
    sign_in @admin
    # User
    delete :destroy, id: @user.id
    assert_destroy_success

    # Admin
    delete :destroy, id: @other_admin.id
    assert_destroy_success

    # Self
    delete :destroy, id: @admin.id
    assert_self_delete_success
  end

  test 'guest request destroy user' do
    # User
    delete :destroy, id: @user.id
    assert_not_authenticated

    # Admin
    delete :destroy, id: @admin.id
    assert_not_authenticated
  end

  # Destroy JS tests
  test 'user request destroy other user js' do
    sign_in @user
    delete :destroy, format: :js, id: @other_user.id
    assert_not_authorized
  end

  test 'user request destroy admin js' do
    sign_in @user
    delete :destroy, format: :js, id: @admin.id
    assert_not_authorized
  end

  test 'user request destroy self js' do
    sign_in @user
    delete :destroy, format: :js, id: @user.id
    assert_response :success
  end

  test 'admin request destroy user js' do
    sign_in @admin
    # User
    delete :destroy, format: :js, id: @user.id
    assert_response :success

    # Admin
    delete :destroy, format: :js, id: @other_admin.id
    assert_response :success

    # Self
    delete :destroy, format: :js, id: @admin.id
    assert_response :success
  end

  test 'guest request destroy user js' do
    # User
    delete :destroy, format: :js, id: @user.id
    assert_not_authenticated_js

    # Admin
    delete :destroy, format: :js, id: @admin.id
    assert_not_authenticated_js
  end

  # Form error tests
  test 'email invalid message on create' do
    sign_in @admin
    assert_no_difference('User.count') do
      post :create,
           user: {
             email: 'test',
             password: 'asdqwe',
             password_confirmation: 'asdqwe',
             role_ids: [Role.find_by(name: 'User').id]
           }
    end
    assert_failed_new_user(:email, 'is invalid')
  end

  test 'email is already taken message on create' do
    sign_in @admin
    assert_no_difference('User.count') do
      post :create,
           id: @user.id,
           user: {
             email: @admin.email,
             password: 'asdqwe',
             password_confirmation: 'asdqwe',
             role_ids: [Role.find_by(name: 'User').id]
           }
    end
    assert_failed_new_user(:email, 'has already been taken')
  end

  test 'password cannot be blank message on create' do
    sign_in @admin
    assert_no_difference('User.count') do
      post :create,
           user: {
             email: 'test@test.com',
             password: '',
             password_confirmation: '',
             role_ids: [Role.find_by(name: 'User').id]
           }
    end
    assert_failed_new_user(:password, 'can\'t be blank')
  end

  test 'password minimum length message on create' do
    sign_in @admin
    assert_no_difference('User.count') do
      post :create,
           user: {
             email: 'test@test.com',
             password: 'asdqw',
             password_confirmation: 'asdqw',
             role_ids: [Role.find_by(name: 'User').id]
           }
    end
    assert_failed_new_user(:password, 'is too short (minimum is 6 characters)')
  end

  test 'password confirmation must match password message on create' do
    sign_in @admin
    assert_no_difference('User.count') do
      post :create,
           user: {
             email: 'test@test.com',
             password: 'asdqwe',
             password_confirmation: 'asdqw',
             role_ids: [Role.find_by(name: 'User').id]
           }
    end
    assert_failed_new_user(:password_confirmation, 'doesn\'t match Password')
  end

  test 'email invalid message on update' do
    sign_in @admin
    put :update,
        id: @admin.id,
        user: {
          email: 'test',
          password: 'asdqwe',
          password_confirmation: 'asdqwe',
          role_ids: [Role.find_by(name: 'Admin').id]
        }
    assert_failed_update_user(:email, 'is invalid')
  end

  test 'email is already taken message on update' do
    sign_in @admin
    put :update,
        id: @admin.id,
        user: {
          email: @user.email,
          password: 'asdqwe',
          password_confirmation: 'asdqwe',
          role_ids: [Role.find_by(name: 'Admin').id]
        }
    assert_failed_update_user(:email, 'has already been taken')
  end

  # check_email_unique tests (admin new form)
  test 'admin check if self email is unique on new form' do
    sign_in @admin
    get :check_email_unique, format: :json, email: @admin.email, form_id: ''
    assert_equal false, json_response
  end

  test 'admin check if user email is unique on new form' do
    sign_in @admin
    get :check_email_unique, format: :json, email: @user.email, form_id: ''
    assert_equal false, json_response
  end

  test 'admin check if new email is unique on new form' do
    sign_in @admin
    get :check_email_unique, format: :json, email: 'newemail@new.com', form_id: ''
    assert_equal true, json_response
  end

  test 'admin check if email is unique with html on new form' do
    sign_in @admin
    get :check_email_unique, format: :html, form_id: '', email: 'newemail@new.com'
    assert_404_response
  end

  # check_email_unique tests (admin self edit form)
  test 'admin check if self email is unique on self edit form' do
    sign_in @admin
    form_id = 'edit_user_' + @admin.id.to_s
    get :check_email_unique, format: :json, form_id: form_id, email: @admin.email
    assert_equal true, json_response
  end

  test 'admin check if user email is unique on self edit form' do
    sign_in @admin
    form_id = 'edit_user_' + @admin.id.to_s
    get :check_email_unique, format: :json, form_id: form_id, email: @user.email
    assert_equal false, json_response
  end

  test 'admin check if new email is unique on self edit form' do
    sign_in @admin
    form_id = 'edit_user_' + @admin.id.to_s
    get :check_email_unique, format: :json, form_id: form_id, email: 'newemail@new.com'
    assert_equal true, json_response
  end

  test 'admin check if email is unique with html on self edit form' do
    sign_in @admin
    form_id = 'edit_user_' + @admin.id.to_s
    get :check_email_unique, format: :html, form_id: form_id, email: 'newemail@new.com'
    assert_404_response
  end

  # check_email_unique tests (admin other edit form)
  test 'admin check if self email is unique on user edit form' do
    sign_in @admin
    form_id = 'edit_user_' + @user.id.to_s
    get :check_email_unique, format: :json, form_id: form_id, email: @admin.email
    assert_equal false, json_response
  end

  test 'admin check if user email is unique on user edit form' do
    sign_in @admin
    form_id = 'edit_user_' + @user.id.to_s
    get :check_email_unique, format: :json, form_id: form_id, email: @user.email
    assert_equal true, json_response
  end

  test 'admin check if new email is unique on user edit form' do
    sign_in @admin
    form_id = 'edit_user_' + @user.id.to_s
    get :check_email_unique, format: :json, form_id: form_id, email: 'newemail@new.com'
    assert_equal true, json_response
  end

  test 'admin check if email is unique with html on user edit form' do
    sign_in @admin
    form_id = 'edit_user_' + @user.id.to_s
    get :check_email_unique, format: :html, form_id: form_id, email: 'newemail@new.com'
    assert_404_response
  end

  # check_email_unique tests (user self edit form)
  test 'user check if self email is unique on edit form' do
    sign_in @user
    form_id = 'edit_user_' + @user.id.to_s
    get :check_email_unique, format: :json, form_id: form_id, email: @user.email
    assert_equal true, json_response
  end

  test 'user check if admin email is unique on edit form' do
    sign_in @user
    form_id = 'edit_user_' + @user.id.to_s
    get :check_email_unique, format: :json, form_id: form_id, email: @admin.email
    assert_equal false, json_response
  end

  test 'user check if new email is unique on edit form' do
    sign_in @user
    form_id = 'edit_user_' + @user.id.to_s
    get :check_email_unique, format: :json, form_id: form_id, email: 'newemail@new.com'
    assert_equal true, json_response
  end

  test 'user check if email is unique with html' do
    get :check_email_unique, format: :html, email: 'newemail@new.com', form_id: ''
    assert_404_response
  end

  # check_email_unique tests (guest new form)
  test 'guest check if admin email is unique on new form' do
    get :check_email_unique, format: :json, email: @admin.email, form_id: ''
    assert_equal false, json_response
  end

  test 'guest check if user email is unique on new form' do
    get :check_email_unique, format: :json, email: @user.email, form_id: ''
    assert_equal false, json_response
  end

  test 'guest check if new email is unique on new form' do
    get :check_email_unique, format: :json, email: 'newemail@new.com', form_id: ''
    assert_equal true, json_response
  end

  test 'guest check if email is unique with html' do
    get :check_email_unique, format: :html, email: 'newemail@new.com', form_id: ''
    assert_404_response
  end

  # Admin check_password_match tests
  test 'admin check if self password matches success' do
    sign_in @admin
    get :check_password_match, format: :json, id: @admin.id, password: 'asdqwe'
    assert_equal true, json_response
  end

  test 'admin check if self password matches failure' do
    sign_in @admin
    get :check_password_match, format: :json, id: @admin.id, password: 'asdqwe1'
    assert_equal false, json_response
  end

  test 'admin check if user password matches success' do
    sign_in @admin
    get :check_password_match, format: :json, id: @user.id, password: 'asdqwe'
    assert_equal true, json_response
  end

  test 'admin check if user password matches failure' do
    sign_in @admin
    get :check_password_match, format: :json, id: @user.id, password: 'asdqwe1'
    assert_equal false, json_response
  end

  test 'admin check if password matches with html' do
    sign_in @admin
    get :check_password_match, format: :html, id: @admin.id, password: 'asdqwe'
    assert_404_response
  end

  # User check_password_match tests
  test 'user check if self password matches success' do
    sign_in @user
    get :check_password_match, format: :json, id: @user.id, password: 'asdqwe'
    assert_equal true, json_response
  end

  test 'user check if self password matches failure' do
    sign_in @user
    get :check_password_match, format: :json, id: @user.id, password: 'asdqwe1'
    assert_equal false, json_response
  end

  test 'user check if admin password matches' do
    sign_in @user
    get :check_password_match, format: :json, id: @admin.id, password: 'asdqwe'
    assert_not_authorized
  end

  test 'user check if password matches with html' do
    sign_in @user
    get :check_password_match, format: :html, id: @user.id, password: 'asdqwe'
    assert_404_response
  end

  # Guest check_password_match tests
  test 'guest check if admin password matches' do
    get :check_password_match, format: :json, id: @admin.id, password: 'asdqwe'
    assert_not_authenticated_json
  end

  test 'guest check if user password matches' do
    get :check_password_match, format: :json, id: @user.id, password: 'asdqwe'
    assert_not_authenticated_json
  end

  private

  def user_form_params
    { email: 'test@test.com',
      password: 'asdqwe',
      password_confirmation: 'asdqwe',
      role_ids: [@user.roles.first.id]
    }
  end

  def assert_users_index_templates
    assert_template :index, partial: '_users_table'
    assert_template partial: '_search'
    assert_template partial: '_paginator'
    assert_app_layout
  end

  def assert_new_user_templates
    assert_template :new, partial: '_form'
    assert_app_layout
  end

  def assert_edit_user_templates
    assert_template :edit, partial: '_form'
    assert_app_layout
  end

  def assert_index_success
    assert_response :success
    assert_users_index_templates
  end

  def assert_show_success
    assert_response :success
    assert_template :show
    assert_app_layout
  end

  def assert_edit_success
    assert_response :success
    assert_edit_user_templates
  end

  def assert_update_success
    assert_redirected_to user_path(assigns(:user))
    assert_equal 'Successfully updated user.', flash[:notice]
  end

  def assert_destroy_success
    assert_redirected_to root_path
    assert_equal 'Successfully deleted user.', flash[:notice]
  end

  def assert_failed_new_user(field, error)
    assert_new_user_templates
    assert assigns[:user].errors[field].include? error
  end

  def assert_failed_update_user(field, error)
    assert_edit_user_templates
    assert assigns[:user].errors[field].include? error
  end

  def assert_self_delete_success
    assert_redirected_to welcome_path
    assert_equal 'Successfully deleted user.', flash[:notice]
  end
end
