class PicturesController < ApplicationController
  before_action :set_picture, only: %i(show edit update destroy)
  before_action :prevent_wrong_user, only: %i(edit update destroy)

  def index
    @pictures = Picture.all.order(%q(updated_at DESC))
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
        flash[:danger] = %q(ユーザー登録が失敗しました)
        redirect_to pictures_path
      else
        render :new
      end
    end
  end

  def show; end

  def edit; end

  def update
    @picture.update(picture_params)

    if params[:delete_image]
      @picture.image = nil
      @picture.save
      render :edit
      return
    end

    if params[:back]
      render :new
    elsif @picture.save
      flash[:notice] = %q(記事を編集しました)
      redirect_to pictures_path
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    flash[:danger] = %q(記事を削除しました)
    redirect_to pictures_path
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private
  def picture_params
    params.require(:picture).permit(:title, :content, :image, :image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def prevent_wrong_user
    @picture = Picture.find_by(id: params[:id])
    unless @picture.user_id == current_user.id
      flash.now[:danger] = %q(権限がありません)
      redirect_to pictures_path
    end
  end
end
