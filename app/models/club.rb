class Club < ActiveRecord::Base
  has_many :club_users, dependent: :delete_all
  has_many :users, through: :club_users
  validates :name, presence: true
  validates :location, presence: true

  scope :clubs, ->(user) { Club.find_by_sql("select * from clubs t1 inner join club_users t2 on t1.id = t2.club_id
    WHERE t2.manager_id IS NOT NULL and t2.manager_id <> #{user.id};")}
  scope :my_clubs, ->(user) { user.clubs.where('manager_id = ?', user.id) }
  scope :joined_clubs, ->(user) { user.clubs.where('manager_id IS NULL') }

  def manager
    User.find(self.club_users.where('manager_id IS NOT NULL' ).last.manager_id).full_name
  end

  def add_yellow(user)
    tests = self.club_users.where('user_id = ?', user.id)
    tests.each do |test|
      return 'yellow' if test.manager_id.nil?
    end
  end
end
