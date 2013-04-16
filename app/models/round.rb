class Round < ActiveRecord::Base
  attr_accessible :number, :start, :fin, :status, :open, :id, :round_id, :participant_id, :question_id, :program_id
  has_many :values
  belongs_to :program

  def row_label
    "round #{number}"
  end

  # Return true if this is owned by a certain user. Rounds are owned by the Program
  # Check user there.
  def owned_by? a_user
    a_user == program.moderator
  end

  # Round can only be managed by the owner of the Program
  def managed_by? a_user
    program.owned_by? a_user
  end

  # This Round is visbile to a user if the Round's program is one of those that the user participates in
  def visible_to? a_user
    a_user.participates_in.include? program
  end
end
