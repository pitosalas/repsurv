require 'role_model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :participations, class_name: "Participant"
  has_many :moderated_programs, class_name: "Program", foreign_key: 'moderator_id'
  has_many :participating_programs, through: :participations, class_name: "Program", source: :program

  include RoleModel
  roles :participant, :moderator, :admin

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
    a_user.participating_in.include? program
  end

end