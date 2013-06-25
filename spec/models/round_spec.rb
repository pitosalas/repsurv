require 'spec_helper'
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

	context "open and closed rounds" do
		let(:p1) { create(:program)}
		let(:r1) { create(:round, program: p1) }
		let(:r2) { create(:round, program: p1) }
		it "can open and close a round" do
			r1.open
			expect(r1.open?).to eq true
			r1.close
			expect(r1.open?).to eq false
			r1.open
			expect(r1.open?).to eq true
		end

		it "never allows more than one round open" do
			expect(r1.open?).to eq false
			expect(r2.open?).to eq false
			r1.open
			expect {r2.open}.to raise_error(RuntimeError)
		end
		it "closes the open rounds when opening the next one" do
			expect(p1.current_round).to eq nil
			p1.open_round(r1)
			p1.open_round(r2)
			expect(p1.current_round).to eq r2
			r1.reload
			r2.reload
			expect(r1.open?).to eq false
			expect(r2.open?).to eq true
		end
		it "sets the actual close date when closing a round" do
			p1.open_round r1
			p1.close_round r1, DateTime.new(2003,1,1)
			expect(r1.closed).to eq DateTime.new(2003,1,1)
		end
	end

	context "with 1 open round and zero responses" do
		before {
			@r1 = @td1[:rounds][1]
			@r1.open
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
				FactoryGirl.create(:response, participant: @part0, program: @p, round: @r1, question: @q0)
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
