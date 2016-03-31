class User < ActiveRecord::Base
  has_many :clubs
  has_and_belongs_to_many :clubs
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    first_name + ' ' + last_name
  end
end
