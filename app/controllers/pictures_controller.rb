class PicturesController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(picture_params)
  end

  def show
  end

  def edit
  end

  private
  def picture_params
    params.require(:picture).permit(:title, :content, :image)
  end
end
