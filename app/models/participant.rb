class Participant < ActiveRecord::Base
  attr_accessible :name, :program_id, :hidden
  has_many :values

  before_create :generate_guid

  def row_label
    name
  end

  def generate_guid
    self.guid = [id.to_s, SecureRandom.hex(10)].join
  end
end
