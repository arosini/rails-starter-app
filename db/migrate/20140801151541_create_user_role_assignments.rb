# Join table between Role and User to allow Users to have many Roles and Roles
# to have many Users.
class CreateUserRoleAssignments < ActiveRecord::Migration
  def change
    create_table :user_role_assignments do |table|
      table.integer :user_id, null: false
      table.integer :role_id, null: false
      table.timestamps
    end

    add_index :user_role_assignments, :user_id
    add_index :user_role_assignments, :role_id
  end
end
