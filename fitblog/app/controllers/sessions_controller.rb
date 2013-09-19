class SessionsController < ApplicationController

  def new
  	
  end
  
  def create
  	@user = User.find_by(email: params[:email])
  	
  	if @user && @user.authenticate(params[:password])
  	  session[:user_id] = @user.id
  	  redirect_to root_url
  	else
  	  flash[:alert] = "Invalid email or password supplied."
  	  render 'new'
  	end
  	
  	def show
  	
  	end
  	
  	def destroy
  	  session[:user_id] = nil
  	  redirect_to root_url
  	end
  end
  
end