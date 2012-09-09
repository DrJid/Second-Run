class UsersController < ApplicationController

#The before fileter is called with every single method here. it calls all the time before any of the
#These are called. So we give it a hash, saying only call on these methods. 
before_filter :signed_in_user , only: [:index, :edit, :update]
before_filter :correct_user, only: [:edit, :update]
before_filter :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end


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
	  		sign_in(@user)
	  		flash[:success] = "Welcome to DrJid's second-run" #The convention is to output the flash on teh site 
	  		# layout. So that anytime, there's a flash. It will display. 

	  		redirect_to user_path(@user)
	  		#Here we can just say redirect_to @user Rails is smart enought to know
	  	else
	  		render 'new' # This renders the new template but doesn't use the @user var. Hence 
	  	#we need our own @user variable that we create above. This is also used to prepopulate it. 
	    end
  end

  def edit
  	
  end

  def update
  	@user = User.find(params[:id])

  	if @user.update_attributes(params[:user])
  		sign_in @user
  		flash[:success] = "Update successful"
  		redirect_to user_path(@user)
  	else
  		render 'edit'
  	end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "#{@user.name} has been deleted"
    redirect_to users_path
  end


  private
  	def signed_in_user
      unless signed_in?
        store_location
         redirect_to signin_path, notice: "Please sign in." 
      end
  	end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
