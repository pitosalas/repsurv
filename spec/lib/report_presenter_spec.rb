require_relative '../../lib/support/report_presenter'
require 'rspec'

describe ReportPresenter do
  let(:pres1) { ReportPresenter.new({program: 1, rows: "q", cols: "p", cell: "r"})}
  it "correctly changes an Id to a symbol" do
    pres1.id_sym(stub("Foo")).is == "Foo"
  end
  it "checks for valid parameters"
  it "correctly generates headers"
end