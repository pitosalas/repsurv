class Participant < ActiveRecord::Base
  attr_accessible :name, :program_id
  has_many :values

  def row_label
    name
  end
end
