# Creates the Role model. A Role defines a User's abilities within the system.
class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |table|
      table.string :name

      table.timestamps
    end
  end
end
