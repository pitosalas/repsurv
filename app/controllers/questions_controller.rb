class QuestionsController < ApplicationController
  respond_to :html
  def index
    @program = Program.find(params[:program_id])
    @questions = @program.questions.paginate(page: params[:page])
    respond_with @questions do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end

  def edit
    @program = Program.find(params[:program_id])
    @question = @program.questions.find(params[:id])
    respond_with @question do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:success] = "Question Updated!"
      redirect_to :back
    else
      render 'edit'
    end
  end

  def new
    @program = Program.find(params[:program_id])
    @question = @program.questions.new
    respond_with @question do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end

  def create
    @program = Program.find(params[:program_id])
    @question = @program.questions.new(params[:question])

    respond_with @question do |format|
      if @question.save
        format.html { redirect_to program_questions_path(@program), notice: 'Question was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @program = Program.find(params[:program_id])
    Question.find(params[:id]).destroy
    flash[:success] = "Question has been deleted."
    redirect_to program_questions_path(@program)
  end






end
