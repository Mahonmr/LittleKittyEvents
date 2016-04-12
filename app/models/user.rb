class User < ActiveRecord::Base
  has_many :club_users, dependent: :delete_all
  has_many :clubs, through: :club_users
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  before_save :assign_role
  devise :omniauthable, :omniauth_providers => [:facebook]

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

  def self.new_with_session(params, session)
    super.tap do |user|
      binding.pry
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
