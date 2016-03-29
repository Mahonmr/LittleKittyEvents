class ClubsController < ApplicationController
  before_action :set_club, only: [:show, :edit, :update, :destroy]

  def index
    @clubs = Club.all
  end

  def show
  end

  def new
    @club = Club.new
  end

  def edit
  end

  def create
    @club = Club.new(club_params)

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

  private
    def set_club
      @club = Club.find(params[:id])
    end

    def club_params
      params.require(:club).permit(:name, :private, :location, :latitude, :longitude)
    end
end
