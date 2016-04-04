class Admin::ClubsController < ClubsController
  before_filter :verify_admin

  def index
    @clubs = Club.all
  end

  private
  def verify_admin
    unless current_user.admin?
      flash[:error] = 'That is very naughty!'
      redirect_to root_path
    end
  end
end
