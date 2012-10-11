class SettingsController < ApplicationController
  respond_to :html
  def index
    @program_id = params[:program_id]
    @settings = Program.find(@program_id).settings
    respond_with @questions do |format|
      format.html {
        render layout: 'layouts/progtabs'
      }
    end
  end
end
