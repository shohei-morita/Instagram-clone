class PicturesController < ApplicationController
  before_action :set_picture, only: %i(show, edit, update, destroy)
  def index
    @pictures = Pictures.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to pictures_path
        flash.now[:notice] = %q(記事を投稿しました。)
      else
        render :new
      end
    end
  end

  def show; end

  def edit; end

  def update
    @picture = Picture.update(picture_params)
    if @picure.save
      redirect_to pictures_path
      flash.now[:notice] = %q(記事を編集しました)
    else
      render :edit
    end
  end

  def destroy
    @picture = Picture.destroy
    redirect_to pictures_path
    flash.now[:notice] = %q(記事を削除しました)
  end

  def confirm
    @picuture = current_user.pictures.build(picture_params)
    render :new if @picure.invalid?
  end

  private
  def picture_params
    params.require(:picture).permit(:title, :content, :image)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
