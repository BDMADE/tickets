FactoryGirl.define do
  factory :ticket do
    name "MyString"
    email "MyString"
    subject "MyString"
    message "MyText"
    status_type 1
    user nil
  end
end
