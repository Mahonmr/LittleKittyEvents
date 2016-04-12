class User < ActiveRecord::Base
  has_many :club_users, dependent: :delete_all
  has_many :clubs, through: :club_users
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  validates :first_name, presence: true
  validates :last_name, presence: true
  before_save :assign_role


  scope :all_except_current_user_and_admin, ->(user) { where("id <> ? and role <> ?", user.id, 'admin') }

  def assign_role
    self.role = 'athlete' if self.role.nil?
  end

  def admin?
    self.role == "admin"
  end

  def athlete?
    self.role == "athlete"
  end

  def home_path
    role + "_home_path"
  end

  def signin_as
    first_name + ' ' + last_name + '::' + role.capitalize
  end

  def full_name
    first_name + ' ' + last_name
  end

  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
      return_user = self.where(email: auth.info.email).first
      return_user.provider = auth.provider
      return_user.uid = auth.uid
    else
      return_user = self.create do |user|
       user.provider = auth.provider
       user.uid = auth.uid
       user.first_name = auth.info.name.split.first
       user.last_name = auth.info.name.split.last
       user.image = auth.info.image
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       UserNotifier.send_signup_email(user).deliver
     end
    end

    return_user
  end
end
