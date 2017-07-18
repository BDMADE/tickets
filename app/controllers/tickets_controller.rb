class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :show_tickets]
  before_action :authorized?, :type_ticket
  before_action :can_add?, only: [:new, :create]
  before_action :can_edit?, only: [:edit, :update]
  before_action :can_delete?, only: :destroy

  layout 'admin/main' ,except: [:new, :create, :show_tickets]

  # GET /tickets
  # GET /tickets.json
  def index
    @title = 'Tickets Management'
    @breadcrumb = 'Tickets'
    @tickets = Ticket.all
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @title = 'Tickets Management'
  end

  # GET /tickets/1
  def show_tickets
    @title = 'Tickets Management'
  end

  # GET /tickets/registration
  def new
    @title = 'Tickets Management'
    @breadcrumb = 'Tickets > New'
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
    @title = 'Tickets Management'
    @breadcrumb = 'Tickets > Edit'
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @title = 'Tickets Management'
    @breadcrumb = 'Tickets > New'
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html {
          if current_user.user_type.name == 'customer'
            redirect_to root_url, notice: 'Ticket was successfully created.'
          else
            redirect_to welcome_url, notice: 'Ticket was successfully created.'
          end
        }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { redirect_to new_ticket_path, alert: @ticket.errors.full_messages.to_sentence }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    @title = 'Tickets Management'
    @breadcrumb = 'Tickets > Edit'
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to tickets_url, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def type_ticket
    has_controller_permission?('ticket')
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ticket_params
    params.require(:ticket).permit(:name, :email, :subject, :message, :status_type, :user_id)
  end
end
