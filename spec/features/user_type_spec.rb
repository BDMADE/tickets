require 'rails_helper'

feature 'User Type' do
  scenario 'user can add new user type' do
    user_type = FactoryGirl.create(:user_type)
    user = FactoryGirl.create(:user, user_type_id: user_type.id)
    permission =  FactoryGirl.create :permission, user_type_id: user_type.id
    signin(user.email, user.password)
    visit new_user_type_path
    fill_in 'Name', with: 'agent'
    find("#user_type_permission_attributes_dashboard", match: :first, visible: false).set(1)
    find("#user_type_permission_attributes_ticket", match: :first, visible: false).set(1)
    find("#user_type_permission_attributes_add", match: :first, visible: false).set(1)
    find("#user_type_permission_attributes_edit", match: :first, visible: false).set(1)
    click_on 'Submit'
    expect(page).to have_content 'User type was successfully created.'
  end

  scenario 'user can not add new user type with existing name' do
    user_type = FactoryGirl.create(:user_type)
    user_type_1 = FactoryGirl.create(:user_type, name: 'agent')
    user = FactoryGirl.create(:user, user_type_id: user_type.id)
    permission =  FactoryGirl.create :permission, user_type_id: user_type.id
    signin(user.email, user.password)
    visit new_user_type_path
    fill_in 'Name', with: 'agent'
    find("#user_type_permission_attributes_dashboard", match: :first, visible: false).set(1)
    find("#user_type_permission_attributes_ticket", match: :first, visible: false).set(1)
    find("#user_type_permission_attributes_add", match: :first, visible: false).set(1)
    find("#user_type_permission_attributes_edit", match: :first, visible: false).set(1)
    check 'Published me'
    click_on 'Submit'
    expect(page).to have_content 'Name has already been taken'
  end
end
