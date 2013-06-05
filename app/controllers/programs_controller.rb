class ProgramsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html
  
  def index2
    @programs = Program.paginate(page: params[:page])
    respond_with @programs
  end

  def index
    if (current_user.nil? || current_user.has_roles?(:admin))
      @programs = Program.paginate(page: params[:page])
    elsif current_user.has_roles? (:moderator)
      @programs = current_user.moderated_programs.paginate(page: params[:page])
    elsif current_user.has_roles? (:participant)
      @programs = current_user.participating_programs.paginate(page: params[:page])
    else
      raise "programs_controller#index user role exception for: #{current_user.name}"
    end
    respond_with @programs
  end

  def show
    @program_id = params[:id]
    render :template => 'layouts/progtabs'
  end

  def destroy
    binding.pry
    prog = Program.find(params[:id])
    prog.destroy
    flash[:success] = "Program has been deleted."
    redirect_to programs_path
  end

  def new
    @program = Program.new
  end

  def create
    @program = Program.new(params[:program])
    @program.moderator = current_user
    if @program.save
      redirect_to report_program_path(@program)
    else
      render :new
    end
  end

  def edit
    @program = Program.find(params[:id])
    respond_with @program do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end

  def update
    @program = Program.find(params[:id])
    if @program.update_attributes(params[:program])
      flash[:success] = "Program Updated!"
      redirect_to :back
    else
      render 'edit'
    end
  end

  def bulk_add_participants
    @program = Program.find(params[:id])
    @participants = @program.participants.paginate(page: params[:page])
    @result_log = @program.add_users_and_participants(params[:bulk_add_participants])
    #render controller: "participants", action: "index"
    redirect_to program_participants_path(@program)
  end


end
