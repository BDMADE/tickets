FactoryGirl.define do
  factory :permission do
    association :user_type, factory: :user_type
    dashboard true    
    usertype true
    user true
    ticket true
    add true
    edit true
    remove_ability true    
  end
end
