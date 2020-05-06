class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
  end

  def create
    favorite = current_user.favorites.create(picture_id: params[:picture_id])
    flash[:notice] = %Q(#{favorite.picture.user.name}さんの投稿をお気に入りに登録しました)
    redirect_to picture_path(favorite.picture.id)
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id])
    if favorite.nil?
      redirect_to pictures_path
    elsif favorite.destroy
      flash[:notice] = %Q(#{favorite.picture.user.name}さんの投稿をお気に入り解除しました)
      redirect_to pictures_path
    end
  end
end
