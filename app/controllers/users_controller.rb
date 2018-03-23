class UsersController < ApplicationController

  def show
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:error] = t "No user"
      redirect_to users_url
    end
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "notewel"
      redirect_to @user
    else
      render :new
    end
  end

    private

    def user_params
      params.require(:user).permit :name, :email, :password,
       :password_confirmation
    end
end
