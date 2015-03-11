class UsersController < ApplicationController
  before_action :routing, only: [:new]

  def new
    @user = User.new
    #render form
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by(session_token: session[:session_token])
    if @user
      render :show
    else
      redirect_to new_session_url
    end
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :password)
    end
end
