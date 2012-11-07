require 'active_support/core_ext/hash'
require_relative 'database_data_cache'

class ReportPresenter

  def initialize data_cube
    @data = data_cube
  end

  def report_description
    "This report covers all data for program #{@data.program_name}. Across the columns " +
    "we display the #{@data.cols_english_label}, across the rows, we display " + 
    "the #{@data.rows_english_label}, and in each cell is a summary for all " + 
    "the #{@data.cell_english_label}."
  end

  def row_label(row_index)
    @data.row_label(row_index)
  end

  def cell_values(row_index, col_index)
    @data.cell_values(row_index, col_index)
  end

  def cell_pie_buckets(row_index, col_index)
    vals = @data.cell_values(row_index, col_index)
    buckets = vals.group_by { |x| x }
    bucket_counts = ["0","1","2","3","4"].map do
      |x| buckets[x].nil? ? 0 : buckets[x].length
    end
    bucket_counts
  end

  def column_headers
    @data.column_headers
  end

  def row_count
    @data.row_count
  end

  def col_count
    @data.col_count
  end
end