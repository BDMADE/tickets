module Tickets
  class TicketsAPI < Grape::API

    format :json

    desc 'Ticket List', {
      :notes => <<-NOTE
        Get All Ticket
         __________________
      NOTE
    }

    get do
      Ticket.all
    end

    desc 'Ticket by id', {
      :notes => <<-NOTE
        Get Ticket By id
         __________________
      NOTE
    }

    params do
      requires :id, type: Integer, desc: 'Ticket id'
    end

    get ':id' do
      begin
        ticket = Ticket.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        error!({ status: :not_found }, 404)
      end
    end

    desc "Delete Ticket By Id", {
      :notes => <<-NOTE
        Delete Ticket By Id
         __________________
      NOTE
    }

    params do
      requires :id, type: Integer, desc: 'Ticket id'
    end

    delete ':id' do
      begin
        ticket = Ticket.find(params[:id])
        { status: :success } if ticket.delete
      rescue ActiveRecord::RecordNotFound
        error!({ status: :error, message: :not_found }, 404)
      end
    end

    desc "Update Ticket By Id", {
      :notes => <<-NOTE
        Update Ticket By Id
        __________________
      NOTE
    }

    params do
      requires :id, type: Integer, desc: "Ticket id"
      requires :name, type: String, desc: "Ticket name"
      requires :email, type: String, desc: "Ticketer email"
      requires :subject, type: String, desc: "Ticket subject"
      requires :message, type: String, desc: "Ticket message"
      requires :status_type, type: String, desc: "Ticket status"
      requires :user_id, type: Integer, desc: "Ticket User id"
    end

    put ':id' do
      begin
        ticket = Ticket.find(params[:id])
        if ticket.update({
                           name: params[:name],
                           email: params[:email],
                           subject: params[:subject],
                           message: params[:message],
                           status_type: params[:status_type],
                           user_id: params[:user_id]
                         })

          { status: :success }
        else
          error!({ status: :error, message: ticket.errors.full_messages.first }) if ticket.errors.any?
        end

      rescue ActiveRecord::RecordNotFound
        error!({ status: :error, message: :not_found }, 404)
      end
    end

    desc "Create Ticket", {
      :notes => <<-NOTE
        Create Ticket
         __________________
      NOTE
    }

    params do
      requires :id, type: Integer, desc: "Ticket id"
      requires :name, type: String, desc: "Ticket name"
      requires :email, type: String, desc: "Ticketer email"
      requires :subject, type: String, desc: "Ticket subject"
      requires :message, type: String, desc: "Ticket message"
      requires :status_type, type: String, desc: "Ticket status"
      requires :user_id, type: Integer, desc: "Ticket User id"
    end

    post do
      begin
        ticket= Ticket.create({
                                name: params[:name],
                                email: params[:email],
                                subject: params[:subject],
                                message: params[:message],
                                status_type: params[:status_type],
                                user_id: params[:user_id]
                              })
        if ticket.save
          { status: :success }
        else
          error!({ status: :error, message: ticket.errors.full_messages.first }) if ticket.errors.any?
        end

      rescue ActiveRecord::RecordNotFound
        error!({ status: :error, message: :not_found }, 404)
      end
    end

  end
end
