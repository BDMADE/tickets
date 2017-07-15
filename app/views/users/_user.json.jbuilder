json.extract! user, :id, :name, :username, :password_digest, :remember_digest, :email, :ip_address, :publised, :profession, :phone, :user_type_id, :created_at, :updated_at
json.url user_url(user, format: :json)
