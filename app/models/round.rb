class Round < ActiveRecord::Base
  attr_accessible :number, :start, :fin, :opened, :closed,
                  :status, :open, :id, :program_id
  has_many :responses
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
    a_user.participating_programs.include? program
  end

  def responses_given a_participant
    responses.where(round_id: id, participant_id: a_participant.id, program_id: program.id)
  end

  def still_open_for a_participant
    program.questions - responses_given(a_participant).map(&:question)
  end

  def n_responses_by_participant
    responses.group(:participant_id).count
  end
end
