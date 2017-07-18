require 'rails_helper'

feature 'Sign in' do
  scenario 'user can not sign in if not registered' do
    signin('person@example.com', 'password')
    expect(page).to have_content 'Invalid data combination ! Please log in again'
  end

  scenario 'user can sign in with valid credentials using email' do
    user_type = FactoryGirl.create(:user_type)
    user = FactoryGirl.create(:user, user_type_id: user_type.id)
    permission =  FactoryGirl.create :permission, user_type_id: user_type.id
    signin(user.email, user.password)
    expect(page).to have_content ' Logged in !'
  end

  scenario 'user can sign in with valid credentials using username' do
    user_type = FactoryGirl.create(:user_type)
    user = FactoryGirl.create(:user, user_type_id: user_type.id)
    permission =  FactoryGirl.create :permission, user_type_id: user_type.id
    signin(user.username, user.password)
    expect(page).to have_content ' Logged in !'
  end

  scenario 'user can sign in with invalid email' do
    user_type = FactoryGirl.create(:user_type)
    user = FactoryGirl.create(:user, user_type_id: user_type.id)
    permission =  FactoryGirl.create :permission, user_type_id: user_type.id
    signin('invalid@gmail.com', user.password)
    expect(page).to have_content 'Invalid data combination ! Please log in again'
  end

  scenario 'user can sign in with invalid username' do
    user_type = FactoryGirl.create(:user_type)
    user = FactoryGirl.create(:user, user_type_id: user_type.id)
    permission =  FactoryGirl.create :permission, user_type_id: user_type.id
    signin('invalid_username', user.password)
    expect(page).to have_content 'Invalid data combination ! Please log in again'
  end

  scenario 'user can sign in with invalid password' do
    user_type = FactoryGirl.create(:user_type)
    user = FactoryGirl.create(:user, user_type_id: user_type.id)
    permission =  FactoryGirl.create :permission, user_type_id: user_type.id
    signin(user.email, 'invalid_password')
    expect(page).to have_content 'Invalid data combination ! Please log in again'
  end
end
