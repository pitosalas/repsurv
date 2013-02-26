require_relative '../spec_helper'

describe "ProgramServices" do
  let(:p1) { FactoryGirl.create(:program) }
  let(:p2) { FactoryGirl.create(:program) }
  let(:s1) { ProgramServices.new(p1)}
  let(:s2) { ProgramServices.new(p2)}

  it "adds a participant with valid parameters" do
    expect {
      @result_code = s1.smart_add_participant( "Outi Xska", "p@salas.com", "whynot")
    }.to change { User.count}.by(1)
    User.where(email:"p@salas.com").size.should == 1
    @result_code.should == :added_usr_n_part
  end
  it "fails to add a participant when parameters arent valid" do
    num_users = User.count
    expect {
      s1.smart_add_participant("x","", "")
    }.to_not change { User.count}.by(1)
  end
  it "correctly doesnt add a user that already existed" do
    s1.smart_add_participant("Jac Jac", "p@salas.com", "whynot")
    expect {
      @result_code = s2.smart_add_participant("Jac Jac", "p@salas.com", "whynot")
    }.to_not change { User.count }.by(1)
    @result_code.should == :added_participant
  end

end