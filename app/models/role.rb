# Represents a user's abilities/authorization.
class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :user_role_assignments
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # String of User emails (seperated by commas)
  def print_users
    users.map(&:email).join(', ')
  end
end
