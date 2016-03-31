class AddUserToClubs < ActiveRecord::Migration
  def change
    add_reference :clubs, :user, index: true, foreign_key: true
  end
end
