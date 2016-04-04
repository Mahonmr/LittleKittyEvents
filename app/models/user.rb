class User < ActiveRecord::Base
  has_many :club_users, dependent: :delete_all
  has_many :clubs, through: :club_users
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
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
end
