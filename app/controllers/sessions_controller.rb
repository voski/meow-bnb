class SessionsController < ApplicationController
  before_action :routing, only: [:new]

  def new
    @user = User.new

  end

  def create
    @user = User.find_by_credentials(user_credentials)
    if @user
      login!(@user)
      redirect_to cats_url
    else
      flash[:errors] = ["Invalid Login"]
      redirect_to new_session_url
    end
  end

  def destroy
    logout!

    redirect_to new_session_url
  end

  def user_credentials
    params.require(:user).permit(:user_name, :password)
  end
end
