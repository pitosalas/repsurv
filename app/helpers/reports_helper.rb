module ReportsHelper

# canned parameters for different kinds of reports
  def report1_path (program_id)
    report_program_path(@program_id, rows: "q", cols: "r", cell: "p", page: nil)
  end

  def report2_path (program_id)
    report_program_path(@program_id, rows: "r", cols: "q", cell: "p", page: nil)
  end

  def report3_path (program_id)
    report_program_path(@program_id, rows: "p", cols: "r", cell: "q", page: nil)
  end

  def report4_path (program_id)
    report_program_path(@program_id, rows: "p", cols: "q", cell: "r", page: nil)
  end

# html generators for different formatted cells.
# data = array of Fixnums

  def spark_pie(data)
    content_tag(:span, class: "sparkpie") do
      data.join(",")
    end
  end
end

