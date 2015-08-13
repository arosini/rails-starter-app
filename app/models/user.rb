# Model using Devise. Has many 'roles' through 'user_role_assignment'.
# Default role is 'User'.' Contains role identifier methods (ie: 'admin?').
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Relationships
  has_and_belongs_to_many :roles, join_table: :user_role_assignments

  # Validations
  validates :roles, presence: true

  # Callbacks
  before_validation :assign_defaults

  # Callback definitions
  def assign_defaults
    roles << Role.find_by(name: 'User') if roles.empty?
  end

  ### ROLE METHODS ###

  def admin?
    roles.include? Role.find_by(name: 'Admin')
  end

  def user?
    roles.include? Role.find_by(name: 'User')
  end

  def guest?
    roles.empty?
  end
end
