class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    remove_column :users, :type
  end
end
