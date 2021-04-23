class EventsController < ApplicationController
  before_action :authorize, only: [:new, :create]

  def new
    @event = Event.new
  end

  def create
    # create a new instance of Invitation in case host wants to invite someone from events#show
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
    @upcoming_events = @events.upcoming.order(:start_date).paginate(page: params[:page], per_page: 8)
    @past_events = @events.past.order(:start_date)
  end

  private
    def event_params
      params.require(:event).permit(:location, :description, :start_time, :title)
    end
end
