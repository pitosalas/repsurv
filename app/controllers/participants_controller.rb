class ParticipantsController < ApplicationController
  respond_to :html
  def index
    @participants = Participant.paginate(page: params[:page])
    @program_id = params[:program_id]
    respond_with @participants do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end
end
