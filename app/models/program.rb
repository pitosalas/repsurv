class Program < ActiveRecord::Base
  attr_accessible :name, :description, :open, :locked
  has_many :participants
  has_many :questions
  has_many :settings
  has_many :rounds
  has_many :values
end
