class EventTypesController < ApplicationController
  load_and_authorize_resource

  def index
    @event_types = EventType.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @event_type = EventType.new(event_type_params)
    if @event_type.save
      flash[:success] =  "Event Type Created"
      redirect_to admin_event_types_path
    else
      flash[:error] = "Event Not Created"
      render 'new'
    end
  end

  def update
    if @event_type.update(event_type_params)
      flash[:success] =  "Event Type Updated"
      redirect_to admin_event_types_path
    else
      render 'edit'
    end
  end

  def destroy
    if @event_type.destroy
      flash[:success] =  "Event Type Deleted"
      redirect_to admin_event_types_path
    end
  end

  private

  def event_type_params
    params.require(:event_type).permit(:name, :event_type, :type_url, :sub_type)
  end
end
