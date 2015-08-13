# Join table for M:M relationship between User and Role
class UserRoleAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
end
