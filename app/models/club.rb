class Club < ActiveRecord::Base
  has_many :club_users, dependent: :delete_all
  has_many :users, through: :club_users
  validates :name, presence: true
  validates :location, presence: true

  def manager
    User.find(user_id).full_name
  end
end
