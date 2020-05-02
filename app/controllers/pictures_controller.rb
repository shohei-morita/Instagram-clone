class PicturesController < ApplicationController
  before_action :set_picture, only: %i(show edit update destroy)
  before_action :prevent_wrong_user, only: %i(edit update destroy)

  def index
    @pictures = Picture.all.order(id: %q(DESC))
  end

  def new
    @picture = Picture.new
    unless current_user.present?
      flash[:danger] = %q(ユーザー登録をしてください)
      redirect_to pictures_path
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    @user = @picture.user
    if params[:back]
      render :new
    elsif @picture.save
      ContactMailer.contact_mail(@user, @picture).deliver
      flash[:danger] = %q(記事を投稿しました)
      redirect_to pictures_path
    else
      render :new
    end
  end

  def show
    if current_user.present?
      @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    end
  end

  def edit; end

  def update
    if params[:remove_image]
      @picture.image = nil
      @picture.save
      render :edit
      return
    end

    if params[:return]
      redirect_to pictures_path
    elsif @picture.update(picture_params)
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
    if params[:return]
      render :new
    end
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
