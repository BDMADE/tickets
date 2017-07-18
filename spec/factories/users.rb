FactoryGirl.define do
  factory :user do
    name "John Doe"
    username "johndoe"
    password "secret"
    email "john@doe.com"
    ip_address "127.0.0.1"
    published true
    profession "SOftware Engnineer"
    phone "1234567"
    user_type
  end
end
