module ParticipantsHelper
  def wrap_control_group(&block)
    content_tag(:div, class: "row-fluid") do
      content_tag(:div, class: "span6 bgcolor") do
        content_tag(:div, class: "control-group") do
          yield
        end
      end
    end
  end

  def current_survey_link prog, part
    round = prog.current_round
    if round.nil?
      "[no active survey right now]"
    else
      # ./program/1/participant/3312313123412/round/4/present_survey
      link_to("Current survey form", program_participant_round_survey_path(prog, part.guid, round))
    end
  end
end
