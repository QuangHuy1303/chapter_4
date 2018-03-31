class PasswordResetsController < ApplicationController
  before_action :load_user, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)
  before_action :check_expiration, only: %i(edit update)

  def new ;end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "reset_check_email"
      redirect_to root_url
    else
      flash.now[:danger] = t "reset_email_notfound"
      render :new
    end
  end

  def edit ;end

  def update

    if @user.update_attributes(user_params)
      log_in @user
      flash[:success] = t "reset_has_been"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email]

    if @user.nil?
      flash[:error] = t "No user"
      redirect_to users_url
    end
  end

  def valid_user
    unless (@user && @user.activated? &&
      @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration

    if @user.password_reset_expired?
      flash[:danger] = t "reset_pass_expired"
      redirect_to new_password_reset_url
    end
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email]

    if @user.nil?
      flash[:error] = t "No user"
      redirect_to users_url
    end
  end

  def valid_user
    unless (@user && @user.activated? &&
      @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration

    if @user.password_reset_expired?
      flash[:danger] = t "reset_pass_expired"
      redirect_to new_password_reset_url
    end
  end
end
