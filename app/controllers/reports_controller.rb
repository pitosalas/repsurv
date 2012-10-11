class ReportsController < ApplicationController
  respond_to :html

  def report
    @part_code = params[:part]
    @quest_code = params[:quest]
    @round_code = params[:round]
    @program_id = params[:id]
    respond_with @reports do |format|
      format.html {
        render layout: 'layouts/reptabs'
      }
    end
  end
end
