class SessionsController < ApplicationController
  skip_before_action :require_sign_in, only: %i(new create)
  skip_before_action :current_user, only: %i(new create)

  def new
  end

  def create
    if params[:session]
      @user = User.find_by(name: params[:session][:name], password: params[:session][:password])
      if @user
        session[:user_id] = @user.id
        redirect_to root_path(session[:user_id])
      else
        flash[:notice] = 'ユーザー名またはパスワードが違います'
        render 'new'
      end
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to new_session_path
  end

  private

    def session_params
      params.require(:session).permit(:name, :password)
    end
end
