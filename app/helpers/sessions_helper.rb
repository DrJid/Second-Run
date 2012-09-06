module SessionsHelper

#By defaulte these Helper files are included in the views, but they are not included in t
#the controller. So we would have to add them in ouselves. 

#Here we just included it in the ApplicationController: Now we can use it in
# all of our controllers

	def sign_in(user)
		# Sign the user in

		#cookies is a hash: We can retrive this using the remem_toek
		# cookies[:remember_token] = { value: user.remember_token,
		# 							 expires: 20.years.from_now }
		#this convention of having a remember_token that stays long is so
		#common that we can do it this way. 
		cookies.permanent[:remember_token] = user.remember_token

		current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

#Traps the current user in the current user variable. 
	def current_user=(user)
		@current_user = user
	end

	#We also want to pull the user out. 
	def current_user
		#memoization
		# @current_user = @current_user || User.find_by_remember_token(cookies[:remember_token])
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])

	end

	def sign_out
		current_user = nil
		cookies.delete(:remember_token)
	end





end
