json.extract! ticket, :id, :name, :email, :subject, :message, :status_type, :user_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
