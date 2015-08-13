# Overrides to the devise controller including a custom AJAX password update
# and custom permitted parameters for the registration form.
class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  # Custom update method which works with AJAX and notifies on error
  # with blank password update (which Devise doesn't do).
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    if update_resource(resource, account_update_params)
      render_update_success
    else
      render_update_failure
    end
  end

  protected

  # Allow custom fields for registration here
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |user|
      user.permit(:email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |user|
      user.permit(:email, :password, :password_confirmation, :current_password)
    end
  end

  private

  def render_update_success
    sign_in resource_name, resource, bypass: true
    render json: { success: true, update: !params[:user][:password].blank? }
  end

  def render_update_failure
    clean_up_passwords resource
    render json: { success: false, errors: resource.errors.full_messages.to_json }
  end
end
