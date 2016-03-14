require 'test_helper'

# Test error routing.
class ErrorsControllerTest < ActionController::TestCase
  test 'route not found unauthenticated' do
    get :routing_error
    assert_not_authenticated
  end

  test 'route not found authenticated' do
    sign_in @user
    get :routing_error
    assert_404_response
  end
end
