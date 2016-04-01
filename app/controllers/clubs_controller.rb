class ClubsController < ApplicationController
  load_and_authorize_resource

  def index
    @clubs = Club.where(user_id: current_user.id) if current_user
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @club.user_id = user
    if @club.save
      flash[:success] = 'Club was successfully created.'
      redirect_to clubs_path
    else
      render :new
    end
  end

  def update
    if @club.update(club_params)
      flash[:success] = 'Club was successfully updated.'
      redirect_to clubs_path
    else
      render :edit
    end
  end

  def destroy
    if @club.destroy
      flash[:success] = 'Club was successfully deleted.'
      redirect_to clubs_path
    end
  end

  def add_club
    @club.users << @user
    flash[:success] = 'Club was successfully updated.'
    redirect_to user_clubs_path(@user)
  end

  private

    def user
      user_id = current_user.id
    end

    def club_params
      params.require(:club).permit(:name, :private, :location, :latitude, :longitude)
    end
end
