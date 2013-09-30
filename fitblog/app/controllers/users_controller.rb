class UsersController < ApplicationController
	def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def create
  	@user = User.new(user_params)
    @user.is_admin = 0;
  	if @user.save
      redirect_to root_path
  	end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'User deleted.'
      render 'index'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
