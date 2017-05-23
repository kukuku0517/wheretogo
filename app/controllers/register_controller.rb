class RegisterController < ApplicationController
  def info1
  @user = current_user
  end

  def info2
  @user = current_user
  end
  
   def infoget
     @user = current_user
    # 이메일 있음
    unless @user.email.nil?
      @user.nickname = params[:nickname]
    # 이메일 없음 = kakao
    else
      @user.email = params[:email]
      @user.nickname = params[:nickname]
    end
    @user.save
    redirect_to visitor_main_path
  end
end
