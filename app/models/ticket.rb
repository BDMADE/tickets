class Ticket < ApplicationRecord
  belongs_to :user, class_name: 'User', inverse_of: 'tickets'
  has_many :ticket_replies, class_name: 'TicketReply', inverse_of: 'ticket', dependent: :destroy
  enum status_type: [:open, :pending, :closed, :spam]
  validates :name, :email, :message, :subject, presence: true
end
