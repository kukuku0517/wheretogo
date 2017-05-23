class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
   def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
      puts "1didyoucome?????????????????????"
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)
puts "1didyoucome?????????????????????"
        if @user.persisted?
          puts "2didyoucome?????????????????????"
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
  
  # def kakao
    
   
  #       @user = User.find_for_oauth(env["omniauth.auth"], current_user)

  #       if @user.persisted?
  #         sign_in_and_redirect @user, event: :authentication
  #       else
  #         session["devise.kakao_data"] = env["omniauth.auth"]
  #         redirect_to new_user_registration_url
  #       end
 

  # end
  
  # def facebook
  #     @user = User.find_for_oauth(env["omniauth.auth"], current_user)

  #       if @user.persisted?
  #         puts @user
  #         puts env["omniauth.auth"]
  #         puts 11111111
  #         sign_in_and_redirect @user, event: :authentication#this will throw if @user is not activated
  #         puts 222222222222222221# set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  #       else
  #         puts 'here3333333333333333333'
  #         session["devise.facebook_data"] = env["omniauth.auth"]
  #         redirect_to new_user_registration_url
  #       end
 
  # end
  
  # def google_oauth2
  #     @user = User.find_for_oauth(env["omniauth.auth"], current_user)

  #       if @user.persisted?
  #         sign_in_and_redirect @user, event: :authentication
  #       else
  #         session["devise.google_oauth2_data"] = env["omniauth.auth"]
  #         redirect_to new_user_registration_url
  #       end
 
  # end
  
  # provider별로 서로 다른 로그인 경로 설정

  def after_sign_in_path_for(resource)
    puts "didyoucome?????????????????????"
    auth = request.env['omniauth.auth']
    @identity = Identity.find_for_oauth(auth)
    @user = User.find(current_user.id)
    if @user.persisted?
      if @identity.provider == "kakao"
        register_info2_path
      else
        register_info1_path
      end
    else
      visitor_main_path
    end
  end
end