class Settings < ActiveRecord::Base
  belongs_to :program
  attr_accessible :datatype, :name, :name, :program_id, :visible
end
