class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create show)
  before_action :verify_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :find_user, except: %i(index new create)
  before_action :follow, only: %i(following followers)

  def index
    @users = User.order_by_asc.paginate(page: params[:page], per_page:
      Settings.numberpage)
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
      @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t "plscheck"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

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

  def following
    @title = t "Following"
  end

  def followers
    @title = t "Followers"
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def verify_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @user.current_user? current_user
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

  def follow
    @user  = User.find_by id: params[:id]
    @users = @user.following.paginate page: params[:page]
    render :show_follow
  end
end
