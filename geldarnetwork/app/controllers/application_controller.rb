class ApplicationController < ActionController::Base
  before_action :config_devise_params, if: :devise_controller?
  layout :layout_by_resource
  private
  def member_controller?
    return false if controller_path ==" home"
    true
  end
  def layout_by_resource
      case
      when devise_controller? then "session" 
      when member_controller? then "member"  
      else "application"
      end
  end
  def config_devise_params
    devise_parameter_sanitizer.permit(:sign_up, keys:[
    :first_name,
    :last_name,
    :username,
    :email,
    :password,
    :password_confirmation
    ])
  end
  around_action :set_locale

  def set_locale(&action)
    session[:locale] = params[:locale] if params[:locale]
    I18n.with_locale(session[:locale] || I18n.default_locale, &action)
  end
end
