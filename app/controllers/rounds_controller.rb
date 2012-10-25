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
end
