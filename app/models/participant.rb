class Participant < ActiveRecord::Base
  attr_accessible :program_id, :hidden, :user, :id, :user_id, :guid
  has_many :responses
  belongs_to :user
  belongs_to :program

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

  def name
    user.name
  end

  # Return true if this is owned by a certain user.
  def owned_by? a_user
    a_user == user
  end

  # Particpant is managed by themselves or by the owner of the program.
  def managed_by? a_user
    owned_by? a_user || program.moderator == a_user
  end

  def visibile_to? a_user
    # get all programs a_user is a participant of
    prgs_where_a_user_participates = a_user.participates_in
    
    # get all programs this Participant is a participant of
    prgs_where_this_participant_participates = user.participates_in

    # true if they have a program in common
    (prgs_where_a_user_participates & prgs_where_this_participant_participates).size > 0
  end

end
