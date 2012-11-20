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

  def self.where_id_or_guid_is(key)
    part = Participant.find_by_id(key)
    if part.nil?
      part = Participant.find_by_guid(key)
    end
    part
  end
end
