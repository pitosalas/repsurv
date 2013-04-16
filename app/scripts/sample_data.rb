class SampleData
	def populate
		sample_users
		sample_programs
		assign_participants
	end

	def delete_all
		User.where('email != ?', 'pitosalas@gmail.com').destroy_all
		Participant.destroy_all
		Program.destroy_all
		Question.destroy_all
		Round.destroy_all
		Value.destroy_all
	end

	def initialize
		@users = []
	end

	def sample_users
		@mod_adam = User.create(name: "Adam User", email: "adam@gmail.com", roles: :moderator, password: "deniel")
		@mod_beth = User.create(name: "Beth User", email: "beth@gmail.com", roles: :moderator, password: "deniel")
		20.times do 
			|u|
			@users[u] = User.create(name: "fake#{u}", email: "fake#{u}@gmail.com", roles: :participant, password: "deniel")
		end
	end

	def sample_programs
		@prog_zulu = Program.create(name: "Zulu Program", moderator: @mod_adam)
		@prog_yankee = Program.create(name: "Yankee Program", moderator: @mod_beth)
	end

	def assign_participants
		(0..9).each do
			|u| 
			@prog_zulu.participants.create(user: @users[u])
		end
		(1..19).each do
			|u| @prog_yankee.participants.create(user: @users[u])
		end
	end
end