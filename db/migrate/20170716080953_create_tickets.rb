class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |table|
      table.string :name
      table.string :email
      table.string :subject
      table.text :message
      table.integer :status_type
      table.belongs_to :user, foreign_key: true

      table.timestamps
    end
  end
end
