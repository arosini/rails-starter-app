require 'test_helper'

# Tests for overrides to devise helpers.
class DeviseHelperTest < ActionView::TestCase
  def setup
    @resource = User.new
  end

  test 'resource with no errors' do
    assert_empty devise_error_messages!
  end

  test 'resouce with errors' do
    @resource.errors[:base] << "¯\_(ツ)_/¯"
    refute_empty devise_error_messages!
  end
end
