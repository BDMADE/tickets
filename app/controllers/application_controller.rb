class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include UsersHelper
  

  helper_method :has_permission?
  helper_method :has_controller_permission?
  helper_method :can_add?
  helper_method :can_edit?
  helper_method :can_delete?

  def has_permission?(action_name)
    current_user.user_type.permission.send "#{action_name}?"
  end

  def has_controller_permission?(action)
    unless has_permission?(action)
      if has_permission?('dashboard')
        redirect_to dashboard_path, alert: 'Yo do not have permission !'
      else
        redirect_to root_path, alert: 'Yo do not have permission !'
      end
    end
  end

  def can_edit?
    has_controller_permission?('edit')
  end

  def can_add?
    has_controller_permission?('add')
  end

  def can_delete?
    has_controller_permission?('remove_ability')
  end
end
