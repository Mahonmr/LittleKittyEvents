class Admin::UsersController < UsersController

  def index
    @users = User.all
  end
end
