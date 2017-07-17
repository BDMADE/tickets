class DashboardController < ApplicationController
  before_action :authorized?, only: [:index, :welcome]
  before_action :dashboard_permission, only: :index
  
  layout 'admin/main', except: :home

  def index
  	@title = 'Dashboard'
    @breadcrumb = 'Dashboard'
  end

  def welcome
  	@title = 'Dashboard'
    @breadcrumb = 'Dashboard'
  end
  
  def home
    @title = 'Home'
    @breadcrumb = 'Home'
  end

  private

  def dashboard_permission
    has_controller_permission?('dashboard')
  end
end
