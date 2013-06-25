require 'spec_helper'

describe ToDoList do

  before do
    @u_nothing_to_do = create(:user)
    @u_three_programs_to_do = create(:user, roles: [:participant])
    @u_moderator = create(:user, roles: [:moderator])

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
    res[0].open
    res[0].save!
  end

  def create_programs count
    Array.new(count) { create(:program) }
  end


  it "detects when no to do list" do
    list = ToDoList.new @u_nothing_to_do
    list.create_todolist
    list.select { |x| !x[1].nil? }.count.should == 0
  end

  it "gets the right number of programs on todo list" do
    list = ToDoList.new @u_three_programs_to_do
    list.create_todolist
    list.select { |x| !x[1].nil? }.count.should == 2
  end
end
