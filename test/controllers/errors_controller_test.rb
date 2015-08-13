require 'test_helper'

# Test error routing.
class ErrorsControllerTest < ActionController::TestCase
  test 'route not found' do
    get :routing_error
    assert_404_response
  end
end
