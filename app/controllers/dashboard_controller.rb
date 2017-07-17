class DashboardController < ApplicationController
  before_action :authorized?, only: [:index, :welcome]
  before_action :dashboard_permission, only: :index

  layout 'admin/main', except: :home

  def index
    @title = 'Dashboard'
    @breadcrumb = 'Dashboard'
    @tickets = Ticket.all
    @open_tickets = Ticket.open.count
    @closed_tickets = Ticket.closed.count
    @agents = User.agents_count
    @customers = User.customers_count
  end

  def welcome
    @title = 'Dashboard'
    @breadcrumb = 'Dashboard'
    @tickets = Ticket.open
    @open_tickets = Ticket.open_ticket(current_user) unless current_user.nil?
    @closed_tickets = Ticket.closed_ticket(current_user) unless current_user.nil?
  end

  def home
    @tickets = Ticket.where(user_id: current_user.id) unless current_user.nil?
    @open_tickets = Ticket.open_ticket(current_user) unless current_user.nil?
    @closed_tickets = Ticket.closed_ticket(current_user) unless current_user.nil?
  end

  def reports
    @title = 'Report'
    @breadcrumb = 'Report'
    @tickets = Ticket.in_last_month
  end

  private

  def dashboard_permission
    has_controller_permission?('dashboard')
  end
end
