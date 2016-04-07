class Admin::EventTypesController < EventTypesController
  before_filter :verify_admin

  def index
    @event_types = EventType.all.order(:event_type)
  end

  private
  def verify_admin
    unless current_user.admin?
      flash[:error] = 'That is very naughty!'
      redirect_to root_url
    end
  end
end
