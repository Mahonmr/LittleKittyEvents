class AddSubTypeToEventTypes < ActiveRecord::Migration
  def change
    add_column :event_types, :sub_type, :string
  end
end
