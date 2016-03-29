class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.boolean :private
      t.string :location
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
