class UsersController < ApplicationController



  def show
  	@user = User.find(params[:id])
  end

  def new
  	#create a new user
  	@user = User.new
  end

  def create
	  	#We don't want a template for create. Create redirects. 
	  	@user = User.new(params[:user]) #Rails figures out how to call this user from the class in the form. 
	  	if @user.save #if @user.save is true, it means the user was valid. 

	  		flash[:success] = "Welcome to DrJid's second-run" #The convention is to output the flash on teh site 
	  		# layout. So that anytime, there's a flash. It will display. 

	  		redirect_to user_path(@user)
	  		#Here we can just say redirect_to @user Rails is smart enought to know
	  	else
	  		render 'new' # This renders the new template but doesn't use the @user var. Hence 
	  	#we need our own @user variable that we create above. This is also used to prepopulate it. 
	    end
  end

end
