class Ticket < ApplicationRecord
  belongs_to :user, class_name: 'User', inverse_of: 'tickets'
  has_many :ticket_replies, class_name: 'TicketReply', inverse_of: 'ticket', dependent: :destroy
  enum status_type: [:open, :closed]
  validates :name, :email, :message, :subject, presence: true

# scope for oepn data
  scope :closed_ticket, -> (user) {
    where(user_id: user.id, status_type: 'closed')
  }

# scope for oepn data
  scope :open_ticket, -> (user) {
    where(user_id: user.id, status_type: 'open')
  }
  # scope for last month data
  scope :in_last_month, -> {
    where(created_at: 1.month.ago.beginning_of_month..1.month.ago.end_of_month, status_type: 'closed')
  }
end
