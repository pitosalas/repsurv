class ProgramsController < ApplicationController

  respond_to :html
  
  def index
    @programs = Program.paginate(page: params[:page])
    respond_with @programs
  end

  def show
    @program_id = params[:id]
    render :template => 'layouts/progtabs'
  end

  def destroy
    Program.find(params[:id]).destroy
    flash[:success] = "Program has been deleted."
    puts "xxxxxxxxxxx"
    redirect_to programs_path
  end

  def new
    @program = Program.new
  end

  def create
    @program = Program.new(params[:program])
    if @program.save
      redirect_to @program
    else
      render :new
    end
  end

end
