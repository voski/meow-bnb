class CatRentalRequestsController < ApplicationController
  before_action :verify_owner, only: [:approve, :deny]
  before_action :ensure_login, only: [:new]

  def new
    @request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    @request.user_id = current_user.id
    if @request.save
      redirect_to cat_url(@request.cat_id)
    else
      flash.now[:errors] = @request.errors.full_messages
      @cats = Cat.all
      render :new
    end
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to cat_url(@request.cat)
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to cat_url(@request.cat)
  end

  private

  def ensure_login
    unless current_user
      flash[:error] = 'Please log in to view that page'
      redirect_to new_session_url
    end
  end

  def verify_owner # refactor this doing two things instead of one
    @cat = CatRentalRequest.find(params[:id]).cat
    unless current_user && current_user.id == @cat.user.id
      flash[:notice] = "This is not your cat bro!"
      redirect_to @cat
    end
  end

  def request_params
    params.require(:request).permit(:start_date, :end_date, :cat_id)
  end
end
