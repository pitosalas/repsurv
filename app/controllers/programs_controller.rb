class ProgramsController < ApplicationController

  respond_to :html
  def index
    @programs = Program.all
    respond_with @programs
  end

  def show
    @program_id = params[:id]
    render :template => 'layouts/progtabs'
  end
end
