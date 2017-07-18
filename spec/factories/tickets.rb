FactoryGirl.define do
  factory :ticket do
    name "MyString"
    email "MyString"
    subject "MyString"
    message "MyText"
    status_type 'open'
    user nil
  end
end
