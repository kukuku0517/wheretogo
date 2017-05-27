class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # rolify
  # include Authority::UserAbilities
  # after_create :set_default_role, if: Proc.new { User.count > 1 }

devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable 
  has_many :identitys
  
  has_and_belongs_to_many :likes
  

TEMP_EMAIL_PREFIX = 'change@me'  
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # user와 identity가 nil이 아니라면 받는다

    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user

    # user가 nil이라면 새로 만든다.

    if user.nil?

      # 이미 있는 이메일인지 확인한다.
  email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
          email = auth.info.email if email_is_verified
      user = User.where(:email => email).first
      unless self.where(email: auth.info.email).exists?
        # 없다면 새로운 데이터를 생성한다.

        if user.nil?
          # 카카오는 email을 제공하지 않음

          if auth.provider == "kakao"
           
            # provider(회사)별로 데이터를 제공해주는 hash의 이름이 다릅니다.

            # 각각의 omnaiuth별로 auth hash가 어떤 경로로, 어떤 이름으로 제공되는지 확인하고 설정해주세요.
        
            user = User.new(
              profile_img: auth.info.image,
              email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
              # remote_profile_img_url: auth.info.image.gsub('http://','https://'),

              password: Devise.friendly_token[0,20]
            )

          elsif auth.provider == "facebook" || auth.provider =="google_oauth2"
            user = User.new(
              email: auth.info.email,
              profile_img: auth.info.image,
              # remote_profile_img_url: auth.info.image.gsub('http://','https://'),

              password: Devise.friendly_token[0,20]
            )
          else
             user = User.new(
              email: auth.info.email,
             
              password: Devise.friendly_token[0,20]
            )
          end
          user.skip_confirmation!
          user.save!
        end
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
   user

  end

  # email이 없어도 가입이 되도록 설정
 def confirmation_required? 
  false
end
  
  def email_required?
    false
  end
end