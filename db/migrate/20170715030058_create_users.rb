class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |table|
      table.string :name
      table.string :username
      table.string :password_digest
      table.string :remember_digest
      table.string :email
      table.string :ip_address
      table.boolean :published, default: false
      table.string :profession
      table.string :phone
      table.belongs_to :user_type, foreign_key: true
      
      table.timestamps
    end
  end
end
