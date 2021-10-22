class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    current_user.appear
    stream_from 'appearance'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_user.disappear
  end

  def appear
    current_user.appear
  end

  def away
    current_user.away
  end
end
