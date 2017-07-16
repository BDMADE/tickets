class Ticket < ApplicationRecord
  belongs_to :user, class_name: 'User', inverse_of: 'tickets'
  has_many :ticket_replies, class_name: 'TicketReply', inverse_of: 'ticket'
  enum status_type: [:open, :pending, :closed, :spam]
end
