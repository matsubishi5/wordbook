class UsersController < ApplicationController
  skip_before_action :require_sign_in, only: %i(new create)
  skip_before_action :current_user, only: %i(new create)

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    unless params[:user][:password] == params[:user][:password_confirmation]
      flash[:notice] = 'パスワードが確認用のものと一致しません。'
      render 'new'
      return
    end
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def ranking
    @users = User.ranking
  end

  private

    def user_params
      params.require(:user).permit(:name, :password)
    end
end
