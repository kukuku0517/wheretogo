class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:username, :name)
      user_params.permit(:username, :provider)
      user_params.permit(:username, :uid)
      user_params.permit(:username, :image)
      
    end
  end
    
    
end
