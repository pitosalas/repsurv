class Question < ActiveRecord::Base
  attr_accessible :text, :pos, :data_type, :active
  has_many :values
  belongs_to :program

  def row_label
    text
  end

end
