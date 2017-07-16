class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |table|
      table.belongs_to :user_type, foreign_key: true
      table.boolean :dashboard
      table.boolean :usertype
      table.boolean :user
      table.boolean :add
      table.boolean :edit
      table.boolean :remove_ability

      table.timestamps
    end
  end
end
