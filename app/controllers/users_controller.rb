class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end
end
