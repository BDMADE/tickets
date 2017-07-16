class UserTypesController < ApplicationController
  before_action :set_user_type, only: [:show, :edit, :update, :destroy]
  before_action :authorized?, :type_permission
  before_action :can_add?, only: [:new, :create]
  before_action :can_edit?, only: [:edit, :update]
  before_action :can_delete?, only: :destroy

  layout 'admin/main'

  # GET /user_types
  # GET /user_types.json
  def index
    @title = 'User Types Management'
    @breadcrumb = 'Users Types'
    @user_types = UserType.all
  end

  # GET /user_types/1
  # GET /user_types/1.json
  def show
    @title = 'User Types Management'
  end

  # GET /user_types/new
  def new
    @title = 'User Types Management'
    @breadcrumb = 'Users Types > New'
    @user_type = UserType.new
    @user_type.build_permission
  end

  # GET /user_types/1/edit
  def edit
    @title = 'User Types Management'
    @breadcrumb = 'Users Types > Edit'
  end

  # POST /user_types
  # POST /user_types.json
  def create
    @title = 'User Types Management'
    @breadcrumb = 'Users Types > New'
    @user_type = UserType.new(user_type_params)

    respond_to do |format|
      if @user_type.save
        format.html { redirect_to @user_type, notice: 'User type was successfully created.' }
        format.json { render :show, status: :created, location: @user_type }
      else
        format.html { render :new }
        format.json { render json: @user_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_types/1
  # PATCH/PUT /user_types/1.json
  def update
    @title = 'User Types Management'
    @breadcrumb = 'Users Types > Edit'
    respond_to do |format|
      if @user_type.update(user_type_params)
        format.html { redirect_to @user_type, notice: 'User type was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_type }
      else
        format.html { render :edit }
        format.json { render json: @user_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_types/1
  # DELETE /user_types/1.json
  def destroy
    @user_type.destroy
    respond_to do |format|
      format.html { redirect_to user_types_url, notice: 'User type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_type
      @user_type = UserType.find(params[:id])
    end

    def type_permission
      has_controller_permission?('usertype')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_type_params
      params.require(:user_type).permit(:name, :published,
                                        permission_attributes: [:dashboard, :usertype, :user, :add, :edit, :remove_ability])
    end
end
