class Value < ActiveRecord::Base
  attr_accessible :value
  belongs_to :participant
  belongs_to :question
  belongs_to :round
  belongs_to :program

  scope :for, 
    lambda { 
      |round, participant, question| 
      where(round_id: round, participant_id: participant, question_id: question)
    }

  #
  # returns the set of value objects for this program, participant and round.
  # Value objects are created if they don't exist yet.
  #
  def self.find_or_create_round(prog, partic, round)
    values = []
    questions = prog.questions.all
    questions.each do |q|
      attrs = {participant_id: partic.id, round_id: round.id, question_id: q.id}
      v = prog.values.where(attrs).first
      if v.nil?
        v = prog.values.build
        v.assign_attributes(attrs, without_protection: true)
        v.save
      end
      values << v
    end
    values
  end


end
