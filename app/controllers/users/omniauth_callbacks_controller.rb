class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
   def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
      
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)
        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end

  [:twitter, :facebook, :google_oauth2, :kakao].each do |provider|
    provides_callback_for provider
  end
  
  
  # provider별로 서로 다른 로그인 경로 설정

  def after_sign_in_path_for(resource)
    auth = request.env['omniauth.auth']
    @identity = Identity.find_for_oauth(auth)
    @user = User.find(current_user.id)
    if @user.persisted?
      if @user.nickname
        root_path
      else
        if @identity.provider == "kakao"
          register_info2_path
        else
          register_info1_path
        end  
      end
      
      
    else
      visitor_main_path
    end
  end
end