class ClubsController < ApplicationController
  #before_filter :authenticate_user!, except: [:index]
  before_action :set_club, only: [:show, :edit, :update, :destroy, :add_club]
  before_action :set_user, only: [:new, :edit, :create, :update, :destroy, :add_club]

  def index
    @clubs = Club.all
  end

  def show
  end

  def new
    @club = @user.clubs.new
  end

  def edit
  end

  def create
    @club = @user.clubs.new(club_params)

    if @club.save
      flash[:success] = 'Club was successfully created.'
      redirect_to user_clubs_path(@user)
    else
      render :new
    end
  end

  def update
    if @club.update(club_params)
      flash[:success] = 'Club was successfully updated.'
      redirect_to user_clubs_path(@user)
    else
      render :edit
    end
  end

  def destroy
    if @club.destroy
      flash[:success] = 'Club was successfully deleted.'
      redirect_to user_clubs_path(@user)
    end
  end

  def add_club
    @club.users << @user
    flash[:success] = 'Club was successfully updated.'
    redirect_to user_clubs_path(@user)
  end

  private
    def set_club
      @club = Club.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def club_params
      params.require(:club).permit(:name, :private, :location, :latitude, :longitude)
    end
end
