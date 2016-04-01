class HomeController < ApplicationController

  def index
    #redirect_to_user_dashboard and return unless current_user.nil?
  end

  def admin
    redirect_to root_path
  end

  # def manager
  #   @manager = Manager.find(current_user)
  #   redirect_to manager_club_path(current_user, @manager.club)
  # end

  def athlete
    redirect_to root_path
  end
end
