class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, {only: [:edit]}

  def index
    @book = Book.new
    @users = User.all
  end
  def show
  	@user = User.find(params[:id])
    @book = Book.new
  	@books = @user.books
  end

  def edit
  	  @user = User.find(params[:id])
  end
  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
  	redirect_to user_path(@user.id)
    else
    render :edit
    end
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
  
  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def ensure_correct_user
       @user = User.find(params[:id])
    if current_user.id != @user.id
       redirect_to user_path(current_user.id)
    end
  end
end
