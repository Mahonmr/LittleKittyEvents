class Admin::UsersController < UsersController
  before_filter :verify_admin

  def index
    @users = User.all
  end

  private
  def verify_admin
    unless current_user.admin?
      flash[:error] = 'That is very naughty!'
      redirect_to root_url
    end
  end
end
