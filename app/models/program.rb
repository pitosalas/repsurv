class Program < ActiveRecord::Base
  attr_accessible :name
  has_many :participants
  has_many :questions
  has_many :settings
end
