class Program < ActiveRecord::Base
  attr_accessible :name, :description, :open, :locked, :suppress_hidden_participants
  has_many :participants
  has_many :questions
  has_many :settings
  has_many :rounds
  has_many :values

#
# return the currently open Round for this program, or nil
#
  def current_round
    open_rounds = rounds.where(open: true)
    raise "More than one Round open" unless open_rounds.size <= 1
    open_rounds[0]
  end
end
