class DashboardController < ApplicationController
  before_action :authorized?
  before_action :dashboard_permission, only: :index
  
  layout 'admin/main'

  def index
  	@title = 'Dashboard'
    @breadcrumb = 'Dashboard'
  end

  def welcome
  	@title = 'Dashboard'
    @breadcrumb = 'Dashboard'
  end 

  private

  def dashboard_permission
    has_controller_permission?('dashboard')
  end
end
