class Program < ActiveRecord::Base
  attr_accessible :name, :description, :open, :locked, :suppress_hidden_participants, :moderator, :id

  attr_accessor :last_import_results
  has_many :questions
  has_many :settings
  has_many :rounds
  has_many :values

  belongs_to :moderator, class_name: User
  has_many :participants
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
    open_rounds = rounds.where(open: true)
    raise "More than one Round open" unless open_rounds.size <= 1
    open_rounds[0]
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

  # This program is visbile to a user it is one of their programs
  def visible_to? a_user
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
