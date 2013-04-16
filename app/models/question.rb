class Question < ActiveRecord::Base
  attr_accessible :text, :pos, :data_type, :active, :id, :program_id
  has_many :values
  belongs_to :program

  validates :text, presence: true

  def row_label
    text
  end

  # Return true if this is owned by a certain user. Questions are owned by the Program
  # Check user there.
  def owned_by? a_user
    a_user == program.user
  end

  # Question can only be managed by the owner
  def managed_by? a_user
    owned_by? a_user
  end

  # This question is visbile to a user if the question's program is one of those that the user participates in
  def visible_to? a_user
    a_user.participates_in.include? program
  end

end
