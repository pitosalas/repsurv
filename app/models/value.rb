class Value < ActiveRecord::Base
  attr_accessible :value
  belongs_to :participant
  belongs_to :question
  belongs_to :round
  belongs_to :program

  scope :for, 
    lambda { 
      |round, participant, question| 
      where(round_id: round, participant_id: participant, question_id: question)
    }

  #
  # Return value as an integer, unless it's nil, in which case return nil
  #
  def value_as_i
    value.nil? ? nil : value.to_i
  end

  #
  # Get a value for a specific set of coordinates
  #
  def self.lookup(program_id, round_id, participant_id, question_id)
    values = Value.where(program_id: program_id, 
                round_id: round_id, 
                participant_id: participant_id, 
                question_id: question_id)
    raise ArgumentError("More than one value in a slot") if values.size > 1
    return nil if values.size == 0
    values[0]
  end


  #
  # returns the set of value objects for this program, participant and round.
  # Value objects are created if they don't exist yet.
  #
  def self.find_or_create_round(prog, partic, round)
    values = []
    all_questions = prog.questions.all
    all_questions.each do |q|
      v = find_or_create_value(prog.id, partic.id, round.id, q.id)
      values << v
    end
    values
  end

  # Update a series of values according to the params hash.
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
    v = prog.values.where(attrs).first
    if v.nil?
      v = prog.values.build
      v.assign_attributes(attrs, without_protection: true)
    end
    v.value = new_value unless new_value.nil?
    v.save
    v
  end
end
