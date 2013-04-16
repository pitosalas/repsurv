class ParticipantsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html
  
  def index
    @program_id = params[:program_id]
    @program = Program.find(@program_id)
    @participants = @program.participants.paginate(page: params[:page])
    respond_with @participants do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end

  def edit
    @program = Program.find(params[:program_id])
    @participant = @program.participants.find(params[:id])
    respond_with @question do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update_attributes(params[:participant])
      flash[:success] = "participant Updated!"
      redirect_to :back
    else
      render 'edit'
    end
  end

  def new
    @program = Program.find(params[:program_id])
    @participant = @program.participants.new
    respond_with @participant do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end

  def create
    @program = Program.find(params[:program_id])
    @participant = @program.participants.new(params[:participant])

    respond_with @participant do |format|
      if @participant.save
        format.html { redirect_to program_participants_path(@program), notice: 'participant was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @program = Program.find(params[:program_id])
    participant.find(params[:id]).destroy
    flash[:success] = "Participant has been deleted."
    redirect_to program_participants_path(@program)
  end
end
