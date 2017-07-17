class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorized?
  before_action :user_permission, only: [:index]
  before_action :can_add?, only: [:new, :create]
  before_action :edit_ability?, only: [:edit, :update]
  before_action :can_delete?, only: :destroy

  layout 'admin/main'

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @title = 'Users Management'
    @breadcrumb = 'Users'
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @title = 'Users Management'
    @breadcrumb = 'Users > Show'
  end

  # GET /users/new
  def new
    @title = 'Users Management'
    @breadcrumb = 'Users > New'
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @title = 'Users Management'
    @breadcrumb = 'Users > Edit'
  end

  # POST /users
  # POST /users.json
  def create
    @title = 'Users Management'
    @breadcrumb = 'Users > New'
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @title = 'Users Management'
    @breadcrumb = 'Users > Edit'
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def user_permission
    has_controller_permission?('user')
  end

  def set_user
    @user = User.find(params[:id])
  end

  def match_user?
    user= User.find_by_id(current_user.id)
    user.id == set_user.id
  end

  def edit_ability?
    unless match_user? || has_permission?('edit')
      redirect_to users_path, notice: "You don't have permission!"
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation, :email, :ip_address,
                                 :published, :user_type_id, :profession, :image, :phone)
  end
end
