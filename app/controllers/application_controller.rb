# Configuration for all requests.
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  check_authorization unless: :devise_controller?
  skip_authorization_check only: :routing_error
  skip_before_action :authenticate_user!, only: :routing_error

  # Catch when a user tries to access a page they cannot.
  rescue_from CanCan::AccessDenied do
    redirect_to root_url, alert: I18n.t('alert.not_authorized')
  end

  # Catch when a user tries to access a record that doesn't exist.
  rescue_from ActiveRecord::RecordNotFound do
    render_not_found
  end

  private

  # Ensures the type of request is JSON.
  def check_json_format
    render_not_found if request.format != Mime::JSON
  end

  def render_not_found
    render 'errors/_404', status: :not_found
  end
end
