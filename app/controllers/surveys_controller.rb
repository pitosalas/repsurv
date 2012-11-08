class SurveysController < ApplicationController
  respond_to :html

  def present_survey
    @program = Program.find(params[:program_id])
    @participant = Participant.find(params[:participant_id])
    @current_round =  @program.rounds.where(open: true)

    raise "More than one open round" unless @current_round.size == 1
    @current_round = @current_round[0]

    @values = Value.find_or_create_round(@program, @participant, @current_round)

    respond_with @values do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end

  def store_survey
    puts "***************** "
    puts params.inspect
  end
end
