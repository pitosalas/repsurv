require 'spec_helper'
require 'awesome_print'

require_relative '../support/spec_test_data_factories'
include SpecTestDataFactories

describe Round do
	before {
		clean_database
		@td1 = setup_test_data_2
		@p = @td1[:program]
		@u0 = @td1[:users][0]
		@r0 = @td1[:rounds][0]
	}
	
	context "basic" do
		it "handling of visibility" do expect(@r0.visible_to?(@u0)).to eq true; end 
		it "handling of ownership" do expect(@r0.owned_by?(@u0)).to eq true; end 
		it "handling of non ownership" do expect(@r0.owned_by?(@u2)).to eq false ; end
		it "handling of zero responses" do expect(@r0.responses_given(@u0).length).to eq 0 ; end
	end

	context "with 1 open round and zero responses" do
		before {
			@r1 = @td1[:rounds][1]
			@r1.open = true
			@r1.save
			@p.reload
		}
		it "knows programs current round" do
			expect(@p.current_round).to eq @r1
		end

		it "knows how many questions there are total" do
			expect(@p.questions.length).to eq 5
		end

		it "knows number of open questions for a user" do
			expect(@r1.still_open_for(@u0).length).to eq 5
		end

		context "with one response" do
			before {
				@q0 = @td1[:questions][0]
				@part0 = @td1[:participants][0]
				@part1 = @td1[:participants][1]
				create(:response, participant: @part0, program: @p, round: @r1, question: @q0)
			}
			it "knows how many questions there are total" do
				expect(@p.questions.length).to eq 5
			end

			it "knows number of open questions for user with one response" do
				expect(@r1.still_open_for(@part0).length).to eq 4
			end
			it "knows number of open questions for user without responses" do
				expect(@r1.still_open_for(@part1).length).to eq 5
			end
		end
 	end

end
