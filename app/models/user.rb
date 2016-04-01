class User < ActiveRecord::Base
  has_many :clubs
  has_and_belongs_to_many :clubs
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  before_save :assign_role

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
    first_name + ' ' + last_name + '::' + role
  end

  def full_name
    first_name + ' ' + last_name
  end
end
