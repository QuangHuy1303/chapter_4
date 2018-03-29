class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :verify_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :find_user, except: [:index, :new, :create]

  def index
    @users = User.page(params[:page])
  end

  def show
  end

  def new
      @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "notewel"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".profileupdated"
      redirect_to @user
    else
      flash[:fail] = t ".failcmnr"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "userdete"
      redirect_to users_url
    else
      flash[:fails]= t "fail"
      redirect_to users_url
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "pleadelogin"
      redirect_to login_url
    end
  end

  def verify_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:error] = t "No user"
      redirect_to users_url
    end
  end

end
