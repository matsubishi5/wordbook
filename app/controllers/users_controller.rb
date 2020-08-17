class UsersController < ApplicationController
  def ranking
    @users = User.ranking
  end
end
