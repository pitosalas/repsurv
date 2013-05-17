Round.create(:id => 10, :program_id => 6, :number => 0, 
						 :opened => "March 3, 2013", closed: "March 10, 2013",
						 :start => 0, :fin => 10, :open => false)

Round.create(:id => 11, :program_id => 6, :number => 1, 
						 :opened => "March 11, 2013", closed: "March 18, 2013",
							:start => 11, :fin => 21, :open => false)

Round.create(:id => 12, :program_id => 6, :number => 2, 
						 :opened => "March 19, 2013", closed: "March 26, 2013",
							:start => 22, :fin => 32, :open => false)

Round.create(:id => 13, :program_id => 6, :number => 3,
						 :opened => "March 27, 2013", closed: "April 3, 2013",
						 :start => 33, :fin => 43, :open => true)

Round.create(:id => 14, :program_id => 4, :number => 0, 
						 :opened => "Jan 3, 2013", closed: "Jan 10, 2013",
							:start => 44, :fin => 53, :open => false)

Round.create(:id => 15, :program_id => 4, :number => 1, 
						 :opened => "Jan 11, 2013", closed: "Jan 18, 2013",
							:start => 54, :fin => 64, :open => false)

Round.create(:id => 16, :program_id => 4, :number => 2, 
						 :opened => "Jan 19, 2013", closed: "Jan 26, 2013",
							:start => 65, :fin => 75, :open => false)

Round.create(:id => 17, :program_id => 4, :number => 3, 
						 :opened => "Jan 27, 2013", closed: "Feb 4, 2013",
							:start => 76, :fin => 85, :open => false)

Round.create(:id => 18, :program_id => 4, :number => 4, 
						 :opened => "FEb 5, 2013", closed: "Feb 12, 2013",
							:start => 86, :fin => 95, :open => true)
