require 'rails_helper'

feature 'Registration' do
  scenario 'user can sign up with valid credentials' do
    signup('John', 'customer@example.com', '01234567', 'engineer', 'john007', 'secret')
    expect(page).to have_content 'Registration is completed. Please login'
  end

  scenario 'user can not sign up with invalid username' do
    signup('John', 'customer@example.com', '01234567', 'engineer', nil, 'secret')
    expect(page).to have_content "Username can't be blank"
  end

  scenario 'user can not sign up with invalid password' do
    signup('John', 'customer@example.com', '01234567', 'engineer', 'john007', nil)
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'user can not sign up with existing username' do
    FactoryGirl.create(:user, username: 'john007')
    signup('John', 'customer@example.com', '01234567', 'engineer', 'john007', 'secret')
    expect(page).to have_content "Username has already been taken"
  end

  scenario 'user can not sign up with existing email' do
    FactoryGirl.create(:user, email: 'customer@example.com')
    signup('John', 'customer@example.com', '01234567', 'engineer', 'john007', 'secret')
    expect(page).to have_content "Email has already been taken"
  end
end
