class RoundsController < ApplicationController
  respond_to :html
  def index
    @rounds = Round.all
    @program_id = params[:program_id]
    respond_with @rounds do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end
end
