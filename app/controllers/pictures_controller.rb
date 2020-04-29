class PicturesController < ApplicationController
  before_action :set_picture, only: %i(show)
  def index
    @pictures = Pictures.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      redirect_to pictures_path
    else
      render :new
    end
  end

  def show; end

  def edit
  end

  private
  def picture_params
    params.require(:picture).permit(:title, :content, :image)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
