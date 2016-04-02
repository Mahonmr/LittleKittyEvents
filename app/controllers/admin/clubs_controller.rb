class Admin::ClubsController < ClubsController

  def index
    @clubs = Club.all
  end
end
