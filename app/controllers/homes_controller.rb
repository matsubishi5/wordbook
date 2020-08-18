class HomesController < ApplicationController
  def top
    @number = 0
    session[:correct] = nil
    session[:incorrect] = nil
  end
end
