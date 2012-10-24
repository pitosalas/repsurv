require 'active_support/core_ext/hash'
require 'database_data_cache'

class ReportPresenter

# coords is a hash:
#
# :program => id of Program
# :rows => class-code which is displayed in rows
# :cols => class-code which is displayed in columns
# :cell => class-code which is summarized inside a cell
# :page => id of class that is displayed in the cell, if any
#
# class-code is one of "q" for Question, "p" for Participant, "r" for Round
#
  def initialize coords, datasource = DatabaseDataCache
    coords.assert_valid_keys(:program, :rows, :cols, :page, :cell)
    @coords = coords;
    @datasource = datasource
    @program_id = @coords[:program]
    @program = Program.find(@program_id)
    apply_default_params
    analyze_params
  end

  def headers
    @cols.where(:program_id == @program_id).map do
      |col| "#{col.class.to_s} #{col.id.to_s}"
    end
  end

  def report_description
    "This report covers all data for program #{@program.name}. Across the columns " +
    "we display the #{@cols_english_label}, across the rows, we display " + 
    "the #{@rows_english_label}, and in each cell is a summary for all " + 
    "the #{@cell_english_label}."
  end

  def row_label(row_instance)
    row_instance.row_label
  end

  #
  # return a vector of the values that will be displayed, 
  # somehow, for a specific cell.
  #
  def cell_raw_values(row_instance, col_instance)
    Value.where(
      id_sym(row_instance) => row_instance.id, 
      id_sym(col_instance) => col_instance.id).map(&:value)
  end

  #
  # Return an 
  def cell_pie_buckets(row_instance, col_instance)
    vals = cell_raw_values(row_instance, col_instance)
    buckets = vals.group_by { |x| x }
    bucket_counts = ["0","1","2","3","4"].map do
      |x| buckets[x].nil? ? 0 : buckets[x].length
    end
#   puts "*** vals #{vals}, *** buckets #{buckets}, *** bucket_counts #{bucket_counts}"
    bucket_counts
  end

  def id_sym(instance)
    (instance.class.to_s.underscore + "_id").to_sym
  end

  def analyze_params
    @rows, @rows_english_label = code_to_class(@coords[:rows])
    @cols, @cols_english_label = code_to_class(@coords[:cols])
    @cell, @cell_english_label = code_to_class(@coords[:cell])
  end

  def apply_default_params
    @coords[:rows] ||= "q"
    @coords[:cols] ||= "r"
    @coords[:cell] ||= "p"
  end


  def code_to_class(code)
    if code == "q"
      [Question.order('pos'), "Questions"]
    elsif code == "r"
      [Round.order('number'), "Rounds"]
    elsif code == "p"
      [Participant.where(hidden: false).order('name'), "Participants"]
    else
      raise PresenterError.new("invalid code in code_to_class: #{code}")
    end
  end

  def cols
    @cols.where(program_id: @program_id)
  end

  def rows
    @rows.where(program_id: @program_id)
  end

  def n_cols
    @cols.where(program_id: @program_id).count
  end

  def n_rows
    @rows.where(program_id: @program_id).count
  end

  def to_s
    "Presenter coords: #{@coords}"
  end
end

class PresenterError < ArgumentError
end

