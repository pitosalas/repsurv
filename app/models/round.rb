class Round < ActiveRecord::Base
  attr_accessible :number, :start, :fin, :status
  has_many :values
  belongs_to :program

  def row_label
    "round #{number}"
  end

end
