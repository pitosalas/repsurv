class Question < ActiveRecord::Base
  attr_accessible :text, :pos, :data_type, :active
  has_many :values
  belongs_to :program

  validates :text, presence: true

  def row_label
    text
  end
end
