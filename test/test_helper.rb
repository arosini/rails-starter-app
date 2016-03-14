require 'minitest/profile'
require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'

# For including existing helpers
require File.expand_path('../../config/environment', __FILE__)

# For setting up fixtures
require 'rails/test_help'

# Module for controller tests
module ActionController
  # Include devise helpers for generating error messages.
  class TestCase
    include Devise::TestHelpers
  end
end

# Module for view/helper tests
module ActionView
  # Include application helper for generating view content.
  class TestCase
    include ApplicationHelper
  end
end

# Module for model tests
module ActiveSupport
  # Set up fixtures and define shared methods
  class TestCase
    # Setup fixtures shared among all tests in test/fixtures/*.yml
    fixtures :all

    # Create instance variables for easy access in tests
    def setup
      @user = users(:user1)
      @other_user = users(:user2)
      @admin = users(:admin1)
      @other_admin = users(:admin2)

      @admin_role = roles(:admin)
      @user_role = roles(:user)
    end

    # Add more helper methods to be used by all tests here...
    def json_response
      ActiveSupport::JSON.decode @response.body
    end

    def assert_not_authorized
      assert_redirected_to root_path
      assert_equal 'You are not authorized to view that page.', flash[:alert]
    end

    def assert_not_authenticated
      assert_redirected_to sign_in_path
      assert_equal 'You need to sign in or sign up before continuing.', flash[:alert]
    end

    def assert_not_authenticated_js
      assert_response 401
      assert_equal @response.body, 'You need to sign in or sign up before continuing.'
    end

    def assert_not_authenticated_json
      assert_redirected_to sign_in_path + '.json'
      assert_equal 'You need to sign in or sign up before continuing.', flash[:alert]
    end

    def assert_app_layout
      assert_template layout: 'layouts/application', partial: '_navbar'
      assert_template partial: 'layouts/_alert'
    end

    def assert_404_response
      assert_response :not_found
      assert_template partial: 'errors/_404'
      assert_template layout: 'layouts/application', partial: '_navbar'
    end

    def assert_406_response
      assert_response :not_acceptable
      assert_template partial: false
    end
  end
end
