FactoryGirl.define do
  factory :ticket_replies do
    description 'It is first reply'
    user
    ticket
  end
end
