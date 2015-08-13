# Actions for when an error occurs. This controller is accessible by all users.
class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  # Called when a route is not found.
  def routing_error
    render_not_found
  end
end
