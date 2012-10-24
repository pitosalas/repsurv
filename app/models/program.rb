class Program < ActiveRecord::Base
  attr_accessible :name, :description, :open, :locked, :suppress_hidden_participants
  has_many :participants
  has_many :questions
  has_many :settings
  has_many :rounds
  has_many :values
end
