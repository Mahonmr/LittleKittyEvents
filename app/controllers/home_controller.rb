class HomeController < ApplicationController

  def index
  end

  def admin
    redirect_to root_path
  end

  def athlete
    redirect_to root_path
  end
end
