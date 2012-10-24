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
end
