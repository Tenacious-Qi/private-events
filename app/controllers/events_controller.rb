class EventsController < ApplicationController
  before_action :authorize, only: [:new]
  
  def new
    @event = Event.new
  end

  def create
    user = User.find_by(params[:user_id])
    @event = user.hosted_events.build(event_params)
    if @event.save
      flash[:success] = "Event created successfully"
      redirect_to @event
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.all
  end

  private
    def event_params
      params.require(:event).permit(:description)
    end
end
