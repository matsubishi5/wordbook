class ApplicationController < ActionController::Base
  before_action :require_sign_in
  before_action :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_sign_in
    redirect_to new_session_path unless current_user
  end
end
