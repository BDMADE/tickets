class PasswordChangesController < ApplicationController
  
  before_action :authorized?
  layout 'admin/main'

  def edit
    @title = 'Password Reset'
    @breadcrumb = 'Password Reset'
  end

  def update
    @title = 'Password Reset'
    @breadcrumb = 'Password Reset'
    password_changes = params[:password_changes]
    old_password = password_changes[:old_password]
    new_password = password_changes[:password]
    confirm_password = password_changes[:password_confirmation]
    user = User.find_by(id: current_user.id)
    if user.authenticate(old_password)
      if new_password == confirm_password
        user.update(password: new_password)
        redirect_to welcome_path, notice: 'Password changed successfully!'
      else
        redirect_to password_changes_path, alert: 'Your password confirmation is failed !'
      end
    else
      redirect_to password_changes_path, alert: 'You have entered invalid current paasword !'
    end
  end
end
