class TicketReply < ApplicationRecord
 belongs_to :ticket, class_name: 'Ticket', inverse_of: 'ticket_replies'
 belongs_to :user, class_name: 'User'

 validates :description, presence: true

end
