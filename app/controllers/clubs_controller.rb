class ClubsController < ApplicationController
  load_and_authorize_resource

  def index
      @clubs = Club.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @club = Club.new(club_params)

    if @club.save && @club.club_users.create(user: current_user, manager_id: current_user.id)
      redirect_to athlete_clubs_path
      flash[:success] = 'Club was successfully created.'
    else
      flash[:error] = 'Club was not created.'
      render :new
    end

  end

  def update
    if @club.update(club_params)
      flash[:success] = 'Club was successfully updated.'
      redirect_to athlete_clubs_path
    else
      render :edit
    end
  end

  def destroy
    if @club.destroy
      flash[:success] = 'Club was successfully deleted.'
      redirect_to athlete_clubs_path
    end
  end

  def add_club
    @notice = "You have successfully joined #{@club.name}"
    @clubs = Club.all
    if @club.users << current_user
      flash[:success] = @notice
    else
      flash[:alert] = 'You were not added to the club'
      redirect_to athlete_clubs_path
    end
    respond_to do |format|
      format.html { redirect_to clubs_path }
      format.js
    end
  end

  private

  def club_params
    params.require(:club).permit(:name, :private, :location, :latitude, :longitude)
  end
end
