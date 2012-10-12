class Value < ActiveRecord::Base
  attr_accessible :value
  belongs_to :participant
  belongs_to :question
  belongs_to :round
end
