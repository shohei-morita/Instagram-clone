class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(picture_id: params[:picture_id])
    flash[:notice] = %Q(#{favorite.picture.user.name}さんの投稿をお気に入りに登録しました)
    redirect_to pictures_path
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    flash[:notice] = %Q(#{favorite.picture.user.name}さんの投稿をお気に入り解除しました)
    redirect_to pictures_path
  end
end
