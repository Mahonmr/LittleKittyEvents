class DropTypeInEventTypes < ActiveRecord::Migration
  def change
    add_column :event_types, :event_type, :string
    remove_column :event_types, :type
  end
end
