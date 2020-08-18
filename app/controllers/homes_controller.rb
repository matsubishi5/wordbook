class HomesController < ApplicationController
  def top
    session[:correct] = nil
    session[:incorrect] = nil
  end
end
