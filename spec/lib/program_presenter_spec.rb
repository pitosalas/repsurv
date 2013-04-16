require_relative '../../lib/support/program_presenter'
require_relative '../support/spec_helpers'
require 'rspec'

include SpecHelpers

describe ProgramPresenter do
	context "self.all_for" do
		it "works with mock admin" do
			@fake_admin = double("Admin User")
			@fake_admin.should_receive(:has_role?) { |a| a == :admin}
			@fake_program_clazz = double("Program")
			@fake_program_clazz.stub(:all) { [:program1, :program2]}
			presenters = ProgramPresenter.all_for(@fake_admin, @fake_program_clazz)
			presenters.length.should == 2
		end

		it "works with mock moderator" do
			@fake_moderator = double("Moderator User")
			@fake_moderator.should_receive(:has_role?) { |a| a == :moderator}.at_least(1).times
			@fake_program_clazz = double("Program")
			@fake_program_clazz.stub(:where_user_moderates) { [:program1, :program2, :program3]}
			presenters = ProgramPresenter.all_for(@fake_moderator, @fake_program_clazz)
			presenters.length.should == 3
		end	

		it "works with mock participant" do
			@fake_participant = double("Participant User")
			@fake_participant.should_receive(:has_role?) { |a| a == :participant}.at_least(1).times
			@fake_program_clazz = double("Program")
			@fake_program_clazz.stub(:where_user_participates) { [:program1, :program2, :program3, :program4]}
			presenters = ProgramPresenter.all_for(@fake_participant, @fake_program_clazz)
			presenters.length.should == 4
		end	
	end
end
