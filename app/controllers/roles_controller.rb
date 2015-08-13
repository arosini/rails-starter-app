# CRUD for Role model.
# Contains a boolean AJAX method used by ParsleyJS.
class RolesController < ApplicationController
  before_action :check_json_format, only: :check_name_unique

  # GET /roles
  def index
    authorize! :index, Role
    init_search_vars
  end

  # GET /roles/1
  def show
    @role = Role.find(params[:id])
    authorize! :show, @role
  end

  # GET /roles/new
  def new
    @role = Role.new
    authorize! :new, @role
  end

  # GET /roles/1/edit
  def edit
    @role = Role.find(params[:id])
    authorize! :edit, @role
  end

  # POST /roles
  def create
    @role = Role.new(resource_params)
    authorize! :create, @role
    if @role.save
      redirect_to @role, notice: I18n.t('roles.notices.create')
    else
      render :new
    end
  end

  # PATCH/PUT /roles/1
  def update
    @role = Role.find(params[:id])
    authorize! :update, @role
    if @role.update(resource_params)
      redirect_to @role, notice: I18n.t('roles.notices.update')
    else
      render :edit
    end
  end

  # DELETE /roles/1
  def destroy
    @role = Role.find(params[:id])
    authorize! :destroy, @role

    @role.destroy
    flash[:notice] = I18n.t('roles.notices.delete')

    respond_to do |format|
      format.html { redirect_to roles_url }
      format.js   { init_search_vars      }
    end
  end

  # Returns true if there does not exist a role
  # named params[:name] (case insensitive).
  def check_name_unique
    authorize! :check_name_unique, Role
    render json: Role.where('lower(name) = ?', params[:name].downcase).blank?
  end

  private

  # Gets correct permitted params.
  # This method is used with load_resource from cancancan.
  def resource_params
    params[:role].permit(:name)
  end

  def init_search_vars
    @search = Role.search(params[:q])
    @roles = @search.result.page(params[:page]).per(5)
  end
end
