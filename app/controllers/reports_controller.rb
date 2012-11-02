class ReportsController < ApplicationController
  respond_to :html

  def report
    @presenter = ReportPresenter.new(DataCube.new(
                    program: params[:id], 
                    rows: params[:rows],
                    cols: params[:cols],
                    cell: params[:cell],
                    page: params[:page]))

    @program_id = params[:id]
    respond_with @reports do |format|
      format.html {
        render layout: 'layouts/reptabs'
      }
    end
  end
end
