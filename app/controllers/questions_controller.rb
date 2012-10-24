class QuestionsController < ApplicationController
  respond_to :html
  def index
    @program_id = params[:program_id]
    @questions = Program.find(@program_id).questions.paginate(page: params[:page])
    respond_with @questions do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end
end
