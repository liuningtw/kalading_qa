class AddIndexRoleToUsers < ActiveRecord::Migration
  def change
    add_index :users, :role
  end
end
