class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  before_action :prevent_wrong_user, only: %i(edit update)

  def new
    @user = User.new
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      redirect_to user_path(@user.id)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id unless current_user
      @user = User.find_by(id: session[:user_id])
      flash[:notice] = %q(ユーザー登録が完了しました)
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = %q(ユーザー登録が失敗しました)
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    @user.update(user_params)

    if params[:delete_image]
      @user.image = nil
      @user.save
      render :edit
      return
    end

    if params[:back]
      redirect_to user_path(@user.id)
    elsif @user.save
      flash[:notice] = %q(プロフィールを編集しました)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :image, :image_cache, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def prevent_wrong_user
    @user = User.find_by(id: params[:id])
    unless @user.id == current_user.id
      flash.now[:danger] = %q(権限がありません)
      render :show
    end
  end
end
