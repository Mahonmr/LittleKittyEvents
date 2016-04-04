class Athlete::UsersController < UsersController

  def index
    @users =  User.all_except_current_user_and_admin(current_user)
  end
end
