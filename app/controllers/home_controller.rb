# This controller is accessible to everybody, regardless of authentication.
# Only guests have access to the index action/landing page.
class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  # Landing page for guests.
  def index
    authorize! :index, HomeController
  end
end
