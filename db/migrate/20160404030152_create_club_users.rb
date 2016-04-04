class CreateClubUsers < ActiveRecord::Migration
  def change
    create_table :club_users do |t|
      t.references :club, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :manager_id

      t.timestamps null: false
    end
  end
end
