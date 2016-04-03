class DropTableAdmin < ActiveRecord::Migration
  def change
    drop_table :admins
    drop_table :athletes
  end
end
