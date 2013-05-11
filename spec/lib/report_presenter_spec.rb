require_relative '../../lib/support/report_presenter'

describe ReportPresenter do
  before(:each) do
    data_cube =  stub
    data_cube.stub(:row_label) do |parm|
      "label #{parm}"
    end
    data_cube.stub(:cell_values) do |row, col|
      ["0","1","2","3","1","0","1","1","2","2","3","3","4","4"]
    end
    @prez = ReportPresenter.new(data_cube)
  end

  it { @prez.row_label(3).should == "label 3"}
  it "should compute buckets correctly" do
    @prez.cell_pie_buckets(2,2).should eq  [2, 4, 3, 3, 2]
  end

end
