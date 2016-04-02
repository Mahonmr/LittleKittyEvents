class Club < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :users
  validates :name, presence: true
  validates :location, presence: true

  def manager
    User.find(user_id).full_name
  end
end
