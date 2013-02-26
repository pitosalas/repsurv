require_relative '../spec_helper'

describe "data cube" do
  context "first case" do
    let(:data) { DataCube.new(program: 1, rows: "q", cols: "r", cell: "p")}


    it { data.col_count.should == 4 }
    it { data.row_count.should == 3 }
    it { data.column_headers.size.should == 4 }
    it { data.column_headers[0].should == "Round 1" }
    it { data.cell_values(0, 0).size.should == 2 }
    it { data.cell_values(0,0).should == ["1","1"] }

    it "checks invalid parameters" do
      expect { DataCube.new }.to raise_error(ArgumentError)
    end
  end
end
