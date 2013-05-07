require 'role_model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :roles, :id, :encrypted_password, :sign_in_count, :roles_mask

  # Some basic validation that the email looks ok:
  validates :email, format: { with: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i, message: "Invalid email"}

  has_many :participations, class_name: "Participant"
  has_many :moderated_programs, class_name: "Program", foreign_key: 'moderator_id'
  has_many :participating_programs, through: :participations, class_name: "Program", source: :program

  include RoleModel
  roles :participant, :moderator, :admin, :public

  # initial value
  before_save :default_values

  def default_values
    self.roles ||= :participant
  end

  # get role as a string.
  def role_to_s
    roles.to_a[0].to_s.capitalize
  end
  
  # Return true if this is a_user's own instance
  def owned_by? a_user
    a_user == self
  end

  def managed_by? a_user
    owned_by? a_user
  end

  # This user is visbile to another user if 
  #   1. this user participates in program that another user also participates in  
  def visible_to? a_user
    intersection = self.participating_programs & a_user.participating_programs
    (a_user == self) || intersection.length > 0
  end

  # Return the set of particpations of this user in a certain program.
  # Should be zero or 1
  def participant_in program
    programs_participants = program.participants
    users_participations = participations
    result = programs_participants & users_participations
    raise "user#participant_in_program error" if result.length > 1
    result.first
  end
end