class Participant < ActiveRecord::Base
  attr_accessible :name, :program_id, :hidden
  has_many :values

  def row_label
    name
  end
end
