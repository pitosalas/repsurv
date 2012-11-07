class DataCube
  attr_reader :rows_english_label, :cols_english_label, :cell_english_label, :program_name

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

  def initialize (coords)
    @coords = coords
    coords.assert_valid_keys(:program, :rows, :cols, :page, :cell)
    apply_default_coords
    analyze_coords
  end

  def apply_default_coords
    @coords[:rows] ||= "q"
    @coords[:cols] ||= "r"
    @coords[:cell] ||= "p"
    @coords[:page] ||= nil
  end

  def analyze_coords
    @prog = Program.find_by_id!(@coords[:program])
    puts "****** #{@coords}, #{@prog}"
    @program_name = @prog.name
    @rows, @rows_english_label = code_to_class(@coords[:rows])
    @cols, @cols_english_label = code_to_class(@coords[:cols])
    @cell, @cell_english_label = code_to_class(@coords[:cell])
  end

  def code_to_class(code)
    if code == "q"
      [Question.where(program_id: @prog).order('pos'), "Questions"]
    elsif code == "r"
      [Round.where(program_id: @prog).order('number'), "Rounds"]
    elsif code == "p"
      [Participant.where(program_id: @prog, hidden: false).order('name'), "Participants"]
    else
      raise ArgumentError.new("invalid code in code_to_class: #{code}")
    end
  end

  def column_headers
    @cols.map do
      |col| "#{col.class.to_s} #{col.id.to_s}"
    end
  end

  def row_label(row_index)
    @rows[row_index].row_label
  end

  def row_count
    @rows.size
  end

  def col_count
    @cols.size
  end

#
# return a vector of the values that will be displayed, 
# somehow, for a specific cell.
#
  def cell_values(row_index, col_index)
    row = row_at(row_index)
    col = col_at(col_index)
    Value.where(
      id_sym(row) => row.id,
      id_sym(col) => col.id).map(&:value)
  end

  def id_sym(instance)
    (instance.class.to_s.underscore + "_id").to_sym
  end

  private

  def row_at(index)
    @rows[index]
  end

  def col_at(index)
    @cols[index]
  end


end