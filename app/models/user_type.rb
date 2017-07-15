class UserType < ApplicationRecord
	has_many :users, class_name: 'User', inverse_of: 'user_type', dependent: :destroy
end
