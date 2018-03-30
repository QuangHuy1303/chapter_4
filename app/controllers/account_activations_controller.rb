class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in_user
      flash[:success] = t "accountactivated"
      redirect_to user
    else
      flash[:danger] = t "invalidlink"
      redirect_to root_url
    end
  end
end
