class Response < ActiveRecord::Base
  attr_accessible :value, :id, :round_id, :participant_id, :question_id, :program_id
  belongs_to :participant
  belongs_to :question
  belongs_to :round
  belongs_to :program

  #
  # returns the set of value objects for this program, participant and round.
  # Value objects are created if they don't exist yet.
  #
  def self.find_or_create_round(prog, partic, round)
    responses = []
    all_questions = prog.questions
    all_questions.each do |q|
      v = find_or_create_value(prog.id, partic.id, round.id, q.id)
      responses << v
    end
    responses
  end

  # Update a series of responses according to the params hash.
  # {"Qnn" => "val"} means store "val" in an existing or new Value object
  def self.store_survey(program_id, participant_id, round_id, params)
    params.each do |key, value|
      if q = param_parse(key)
        find_or_create_value(program_id, participant_id, round_id, q, value)
      end
    end
  end

private

#
# if the string 'key' starts with a "Q" then return the rest of 
# the string as an integer, otherwise don't return anything.
#
  def self.param_parse(key)
    parts = key.partition("Q")
    if parts[1] == "Q" && parts[0] == ""
      parts[2].to_i
    end
  end

  #
  # Create a new Value if it doesn't already exist, and initialize the attributes per
  # the parameters of the call.
  #
  def self.find_or_create_value(prog_id, part_id, round_id, quest_id, new_value=nil)
    prog = Program.find(prog_id)
    attrs = {participant_id: part_id, round_id: round_id, question_id: quest_id}
    v = prog.responses.where(attrs).first
    if v.nil?
      v = prog.responses.build
      v.assign_attributes(attrs, without_protection: true)
    end
    v.value = new_value unless new_value.nil?
    v.save
    v
  end

  #
  # Get a value for a specific set of coordinates
  #
  def self.lookup(program_id, round_id, participant_id, question_id)
    responses = Response.where(program_id: program_id, 
                round_id: round_id, 
                participant_id: participant_id, 
                question_id: question_id)
    raise ArgumentError("More than one Response in a slot") if responses.size > 1
    return nil if responses.size == 0
    responses[0]
  end



end
