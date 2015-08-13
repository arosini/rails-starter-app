require 'test_helper'

# Test authorization, authentication and routing for the HomeController
class HomeControllerTest < ActionController::TestCase
  # Index tests
  test 'guest request index home' do
    get :index
    assert_response :success
    assert_template :index
    assert_app_layout
  end

  test 'admin request index home' do
    sign_in @admin
    get :index
    assert_redirected_to :root
  end

  test 'user request index home' do
    sign_in @user
    get :index
    assert_redirected_to :root
  end
end
