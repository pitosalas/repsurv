require 'spec_helper'

describe ToDoList do

  before do
    @u_nothing_to_do = create(:user)
    @u_three_programs_to_do = create(:user)

    @progs = create_programs(4)

    @pr11 =  create(:participant, program: @progs[0], user: @u_nothing_to_do)

    # user u_three_programs_to_do partticipates in programs 1,2,3
    @pr11 = create(:participant, program: @progs[1], user: @u_three_programs_to_do)
    @pr21 = create(:participant, program: @progs[2], user: @u_three_programs_to_do)
    @pr31 = create(:participant, program: @progs[3], user: @u_three_programs_to_do)

    # p1 has 3 rounds
    @p2_rounds = create_rounds(3, @progs[1])

    # p2 has 3 rounds
    @p3_rounds = create_rounds(3, @progs[2])
  end

  def create_rounds count, program
    res = []
    count.times { res << create(:round, program: program)}
    res[0].open = true
    res[0].save!
  end

  def create_programs count
    Array.new(count) { create(:program ) }
  end


  it "detects when no to do list" do
    list = ToDoList.new(@u_nothing_to_do)
    list.count.should == 0
  end

  it "gets the right number of programs on todo list" do
    list = ToDoList.new(@u_three_programs_to_do)
    list.count.should == 2
  end
end



#   let(:p1) { FactoryGirl.create(:program) }
#   let(:p2) { FactoryGirl.create(:program) }
#   let(:s1) { ProgramServices.new(p1)}
#   let(:s2) { ProgramServices.new(p2)}

#   it "adds a participant with valid parameters" do
#     expect {
#       @result_code = s1.smart_add_participant( "Outi Xska", "p@salas.com", "whynot")
#     }.to change { User.count}.by(1)
#     User.where(email:"p@salas.com").size.should == 1
#     @result_code.should == :added_usr_n_part
#   end
  
#   it "fails to add a participant when parameters arent valid" do
#     num_users = User.count
#     expect {
#       s1.smart_add_participant("x","", "")
#     }.to_not change { User.count}.by(1)
#   end

#   it "correctly doesnt add a user that already existed" do
#     s1.smart_add_participant("Jac Jac", "p@salas.com", "whynot")
#     expect {
#       @result_code = s2.smart_add_participant("Jac Jac", "p@salas.com", "whynot")
#     }.to_not change { User.count }.by(1)
#     @result_code.should == :added_participant
#   end
  #u2.participating_programs.joins(:rounds)
  #u.participating_programs.joins(:rounds).where(rounds: {open: true}).first.class
  #u.participations
# end