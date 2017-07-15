class CreateUserTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_types do |table|
      table.string :name
      table.boolean :published

      table.timestamps
    end
  end
end
