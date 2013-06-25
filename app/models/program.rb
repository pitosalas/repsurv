class Program < ActiveRecord::Base
  attr_accessible :name, :description, :open, 
                  :locked, :suppress_hidden_participants, 
                  :moderator, :id, :opened, :closed, :moderator_id

  attr_accessor :last_import_results
  has_many :questions, dependent: :destroy
  has_many :rounds, dependent: :destroy
  has_many :open_rounds, :class_name => 'Round', :conditions => { open: true }
  
  has_many :responses, dependent: :destroy

  belongs_to :moderator, class_name: User
  has_many :participants, dependent: :destroy
  has_many :users, through: Participant

  def self.participated_in_by usr
    self.all.select {|p| p.visible_to? (usr)}
  end

  def self.moderated_by usr
    self.all.select {|p| p.managed_by? (usr)}
  end
#
# return the currently open Round for this program, or nil
#
  def current_round
    open_rounds = rounds.where(open_status: true)
    raise "More than one Round open" unless open_rounds.size <= 1
    if (open_rounds.length == 1) 
      open_rounds[0]
    else
      nil
    end
  end

  def close_round(round, date=nil)
    round.close date
  end

  def open_round(round, date=nil)
    if (cr = current_round)
      cr.close date
    end
    round.open date
  end

  def highest_question
    high_question = questions.order("pos DESC").first
    high_question.nil? ? 0 : high_question.pos
  end

  # all programs where a certain user participates
  def self.where_user_participates(user)
    Program.joins(:participants).where('participants.user_id' => user.id)
  end

  # all programs where a certain user moderates
  def self.where_user_moderates(user)
    Program.where(moderator: user)
  end

  # Return true if this is owned by a certain user.
  def owned_by? a_user
    a_user == moderator
  end

  def managed_by? a_user
    a_user == moderator
  end

  # This program is visbile to a user if the user participates in it
  def visible_to? a_user
    user_is_participant? a_user
  end

  def user_is_participant? a_user
    a_user.participating_programs.include? self
  end

  # Interface to bulk adding of participants
  def add_users_and_participants user_entered_text
    pi = ParticipantImporter.new(ProgramServices.new(self))
    pi.import_info = user_entered_text
    pi.perform_import
    @last_import_results = pi.message_log.join("\n")
  end



end
