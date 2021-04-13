class EventsController < ApplicationController
  before_action :authorize, only: [:new]
  helper_method :future_non_hosted_event?
  helper_method :current_user_is_host?
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
    if current_user
      @rsvp = @event.invitations.find_by(event_id: @event.id, invitee_id: current_user.id)
    end
  end

  def index
    @events = Event.all
  end

  private
    def event_params
      params.require(:event).permit(:location, :description, :start_time, :title)
    end

    def future_non_hosted_event?(event)
      Event.upcoming.include?(event) && current_user != event.host
    end

    def current_user_is_host?
      current_user == @event.host
    end
end
