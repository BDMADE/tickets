class TicketRepliesController < ApplicationController
  before_action :set_ticket
  before_action :set_ticket_reply, except: [:create]

  def create
    @ticket_reply = @ticket.ticket_replies.create!(ticket_reply_params)
    redirect_to @ticket
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def set_ticket_reply
    @ticket_reply = @ticket.ticket_replies.find(params[:id])
  end

  def ticket_reply_params
    params[:ticket_reply].permit(:description, :user_id, :ticket_id)
  end

end
