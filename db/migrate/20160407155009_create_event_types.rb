class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :name
      t.string :type
      t.string :type_url

      t.timestamps null: false
    end
  end
end
