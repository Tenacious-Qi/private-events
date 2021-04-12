class EventsController < ApplicationController
  before_action :authorize, only: [:new]

  def new
    @event = Event.new
  end

  def create
    @invitation = Invitation.new
    user = User.find(current_user.id)
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
    @rsvp = @event.invitations.find_by(event_id: @event.id, invitee_id: current_user.id)
  end

  def index
    @events = Event.all
  end

  private
    def event_params
      params.require(:event).permit(:location, :description, :start_time, :title)
    end
end
