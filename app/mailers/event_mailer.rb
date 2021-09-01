class EventMailer < ApplicationMailer
  default from: 'joe.mccann.dev@gmail.com'

  def cancelation_email
    @event = params[:event]
    mail(to: @event.invitees.pluck(:email), subject: "Event Cancelation Notice") 
  end
end
