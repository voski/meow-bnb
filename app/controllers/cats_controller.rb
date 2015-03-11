class CatsController < ApplicationController
  before_action :verify_owner, only: [:edit, :update, :destroy]

  def index
    @cats = Cat.all

    render :index
  end

  def show
    @cat = Cat.find(params[:id])

    render :show
  end

  def new
    @cat = Cat.new

    render :new
  end

  def edit

    @cat = Cat.find(params[:id])

    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    @cat.update(cat_params)

    redirect_to @cat
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def destroy
    @cat = Cat.find(params[:id])

    if @cat.destroy
      flash.notice = "#{@cat.name} has mysteriously disapeared from our location"
      redirect_to root_url
    else
      flash[:errors] = @cat.errors.full_messages
      redirect_to @cat
    end

  end


  private

    def verify_owner
      @cat = Cat.find(params[:id])
      unless current_user.id == @cat.user.id
        flash[:notice] = "This is not your cat bro!"
        redirect_to @cat
      end
    end

    def cat_params
      params.require(:cat).permit(:birth_date, :name, :color, :sex, :description, :user_id)
    end
end
