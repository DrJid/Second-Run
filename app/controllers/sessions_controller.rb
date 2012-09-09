class SessionsController < ApplicationController


	#NEw for rendering a page to have new signins by creating new sessions.
	def new
	end

	#Creates the session!
	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user_path(user)
		else
			flash.now[:error] = "Invalid login/password combination"
		#Flash persists for one request. render doesn't constitute a redirect. So the flash stays. 
		#Hence we need the Flash.now
			render 'new'
		end
	end

	def destroy
		#When user clicks sign out, we want to destroy this sesssion and redirect to page
		sign_out
		redirect_to root_path
	end


end
