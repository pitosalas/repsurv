class ApplicationController < ActionController::Base
  protect_from_forgery

 	rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
 	end

 	def after_sign_in_path_for(user)
		user_todolist_index_path(user)
	end

	def authenticate_user!
		unless user_signed_in?
			redirect_to root_path
		end
	end

end




