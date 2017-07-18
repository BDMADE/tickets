class CreateTicketReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :ticket_replies do |t|
      t.text :description
      t.belongs_to :user, foreign_key: true
      t.belongs_to :ticket, foreign_key: true

      t.timestamps
    end
  end
end
