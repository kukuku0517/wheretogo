class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   before_action :configure_permitted_parameters, if: :devise_controller?
   protect_from_forgery with: :exception
  
   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :nickname)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:password, :password_confirmation, :current_password, :nickname)
    end
    
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:username, :name, :profile_img, :nickname)
    end
  end
    
    
end
