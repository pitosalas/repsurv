class RoundsController < ApplicationController
  respond_to :html
  def index
    @program = Program.find(params[:program_id])
    @rounds = @program.rounds.paginate(page: params[:page])
    respond_with @rounds do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end

  def edit
    @program = Program.find(params[:program_id])
    @round = @program.rounds.find(params[:id])
    respond_with @round do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end

  def update
    @round = Round.find(params[:id])
    if @round.update_attributes(params[:round])
      flash[:success] = "round Updated!"
      redirect_to :back
    else
      render 'edit'
    end
  end

  def new
    @program = Program.find(params[:program_id])
    @round = @program.rounds.new
    respond_with @round do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end

  def create
    @program = Program.find(params[:program_id])
    @round = @program.rounds.new(params[:round])

    respond_with @round do |format|
      if @round.save
        format.html { redirect_to program_rounds_path(@program), notice: 'Round was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @program = Program.find(params[:program_id])
    Round.find(params[:id]).destroy
    flash[:success] = "Round has been deleted."
    redirect_to program_rounds_path(@program)
  end


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

# Survey containing data for multiple values for this round
#
# format of params hash:
#
# Any key formatted as "Qnn"=>"mm" is a chosen response. nn is the question number
# and mm is the index of the response, e.g. 0 means "not a clue"
# in addition there are keys: "program_id"=>, "participant_id"=>, "round_id"=>
#
  def store_survey
    program_id = params[:program_id]
    participant_id = params[:participant_id]
    round_id = params[:round_id]
    Value.store_survey(program_id, participant_id, round_id, params)
    redirect_to program_participant_round_survey_path

  end    
end
