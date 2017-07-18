# This helper module will help to sign into the system
module Features
  module SessionHelpers

    # signin method helps to user log in to the system
    # Usage: signin('test@example', 'secret')

    def signin(email,password)
      visit new_session_path
      fill_in 'Username or Email', with: email
      fill_in 'Password', with: password
      click_on 'Sign In'
    end

    # signup method helps to user sign up to the system
    # Usage: signup('test@example', 'secret')
    def signup(name,email,phone,profession,username,password)
      user_type = FactoryGirl.create(:user_type, name: 'customer')
      FactoryGirl.create :permission, user_type_id: user_type.id
      visit registrations_path
      fill_in 'Name', with: name
      fill_in 'E-mail', with: email
      fill_in 'Phone', with: phone
      fill_in 'Profession', with: profession
      fill_in 'Username', with: username
      fill_in 'Password', with: password
      fill_in 'Confirm', with: password
      find("#user_type_id", match: :first, visible: false).set(user_type.id)
      click_on 'Submit'
    end

  end
end
