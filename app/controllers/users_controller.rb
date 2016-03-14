# CRUD for User model.
# Contains boolean AJAX methods used by ParsleyJS.
class UsersController < ApplicationController
  # Guests can check if emails are unique
  skip_authorization_check only: :check_email_unique
  skip_before_action :authenticate_user!, only: :check_email_unique

  # Only JSON requests are supported for these actions
  before_action :check_json_format, only: [:check_email_unique, :check_password_match]

  # Loading @user and authorizing actions
  before_action :find_user, only: [:show]
  load_and_authorize_resource except: :check_email_unique

  def index
    init_search_vars
  end

  def show
  end

  def new
  end

  def create
    if @user.save
      flash[:notice] = t('users.notices.create')
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(update_params)
      flash[:notice] = t('users.notices.update')
      update_params[:email] == current_user.email ? redirect_to(my_profile_path) : redirect_to(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = t('users.notices.delete')
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js   { init_search_vars     }
    end
  end

  # Returns true if email is not in use (case insensitive). Accessible by all roles.
  def check_email_unique
    # TO REMOVE: This DOM coupling. Perhaps an existing_email param which would be null for guests?
    action, _controller, user_id = params[:form_id].split('_')
    email = params[:email]
    same_email = true if action == 'edit' && email.casecmp(User.find(user_id).email) == 0

    respond_to do |format|
      format.json { render json: same_email ? same_email : User.where('LOWER(email) = ?', email).empty? }
    end
  end

  # Returns true if the password param matches the user's current password.
  def check_password_match
    respond_to do |format|
      format.json { render json: @user.valid_password?(params[:password]) }
    end
  end

  private

  # Gets a user based on the user_id / id parameter or the current_user if neither parameter is present.
  def find_user
    @user = User.find(params[:id] || current_user.id)
  end

  def required_params
    params.require(:user)
  end

  def create_params
    required_params.permit(:email, :password, :password_confirmation, role_ids: [])
  end

  def update_params
    if current_user.id.to_s == params[:id] && !current_user.admin?
      required_params.permit(:email)
    elsif current_user.id.to_s == params[:id] && current_user.admin?
      required_params.permit(:email, role_ids: [])
    elsif can?(:edit, @user)
      required_params.permit(role_ids: [])
    end
  end

  def init_search_vars
    @search = User.search(params[:q])
    @users = @search.result.includes(:roles).select { |user| can? :read, user }
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(5)
  end
end
