require 'pry'
class ProgramPresenter

	def self.all_for(user, program_clazz=Program)
		if user.has_role? :admin
			programs = program_clazz.all
		elsif user.has_role? :moderator
			programs = program_clazz.where_user_moderates(user)
		elsif user.has_role? :participant
			programs = program_clazz.where_user_participates(user)
		else
			raise "Invalid argument to ProgramPresenter.all_for"
		end
		programs.map { |p| ProgramPresenter.new(user, p)}
	end

	def initialize(usr, prog)
		@program = prog
		@user = usr
	end
end
