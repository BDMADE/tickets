class UserType < ApplicationRecord
  has_many :users, class_name: 'User', inverse_of: 'user_type', dependent: :destroy

  has_one :permission, class_name: 'Permission', inverse_of: 'user_type', foreign_key: 'user_type_id', dependent: :destroy
  accepts_nested_attributes_for :permission
  validates_presence_of :name
  validates_uniqueness_of :name

  delegate :dashboard, :usertype, :user,
           :add, :edit,:remove_ability, to: :permission, prefix: true
end
