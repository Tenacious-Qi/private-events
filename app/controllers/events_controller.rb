class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:index, :show]
  before_action :authorize_edit, only: [:edit, :update, :destroy]

  def new
    @event = Event.new
  end

  def create
    # create a new instance of Invitation in case host wants to invite someone from events#show
    # @invitation = Invitation.new
    user = User.find(current_user.id)
    @event = user.hosted_events.build(event_params)
    if @event.save
      flash[:success] = "Event created successfully"
      redirect_to @event
    else
      flash[:warning] = "Event creation failed. Please try again."
      render 'new'
    end
  end

  def show
    return unless current_user
    
    @invitation = @event.invitations.find_by(event_id: @event.id, invitee_id: current_user.id)
  end

  def index
    @events = Event.all
    @upcoming_events = @events.upcoming.order(:start_time).paginate(page: params[:page], per_page: 8)
    @past_events = @events.past.order(:start_time)
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:success] = "Event info updated."
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    EventMailer.with(event: @event).cancelation_email.deliver_later
    @event.destroy
    flash[:success] = "Event successfully deleted."
    redirect_to @event.host
  end

  private
    def event_params
      params.require(:event).permit(:location, :description, :start_time, :title)
    end

    def set_event
      @event = Event.find(params[:id])
    end

    def authorize_edit
      unless current_user_hosts_upcoming_event?(@event)
        flash[:warning] = "Redirected to event page. You can only edit upcoming events you are hosting."
        redirect_to @event
      end
    end

    def current_user_hosts_upcoming_event?(event)
      event.host == current_user && Event.upcoming.include?(event)
    end
end
