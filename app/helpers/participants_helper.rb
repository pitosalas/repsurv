module ParticipantsHelper
  def current_survey_link prog, part
    round = prog.current_round
    if round.nil? || part.guid.nil?
      "[no active survey right now]"
    else
      # ./program/1/participant/3312313123412/round/4/present_survey
      link_to("Current survey form", program_participant_round_survey_path(prog, part.guid, round))
    end
  end
end
