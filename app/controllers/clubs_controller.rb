class ClubsController < ApplicationController
  load_and_authorize_resource

  def index
    load_page
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

  def add_delete_club
    if current_user.clubs.where(:id => @club).empty?
      add_club
    else
      delete_club
    end
  end

  def delete_club
    if current_user.clubs.delete(@club)
      load_page
      @notice = "You have successfully removed #{@club.name} from your profile"
    else
      flash[:alert] = 'Club was not removed from your profile'
      redirect_to athlete_clubs_path
    end
    respond_to do |format|
      format.html { redirect_to clubs_path }
      format.js
    end
  end

  def add_club
    if @club.users << current_user
      load_page
      @notice = "You have successfully joined #{@club.name}"
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

  def load_page
    @clubs = Club.clubs(current_user)
    @joined_clubs = Club.joined_clubs(current_user)
    @my_clubs = Club.my_clubs(current_user)
  end

  def club_params
    params.require(:club).permit(:name, :private, :location, :latitude, :longitude)
  end
end
