class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = %q(ログインに失敗しました)
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = %q(ログアウトしました)
    redirect_to new_session_path
  end
end
