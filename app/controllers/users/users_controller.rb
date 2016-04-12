class UsersController < ApplicationController
  load_and_authorize_resource


  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'User was successfully updated.'
      redirect_to athlete_clubs_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
