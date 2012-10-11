module ReportsHelper
  def report1_path (program_id)
    report_program_path(@program_id, quest: "a", part: "a", round: "a")
  end

  def report2_path (program_id)
    report_program_path(@program_id, quest: "a", part: "r", round: "c")
  end

  def report3_path (program_id)
    report_program_path(@program_id, quest: "r", part: "c", round: "a")
  end
end
