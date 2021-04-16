module EventsHelper
  private
    def future_non_hosted_event?(event)
      Event.upcoming.include?(event) && current_user != event.host
    end

    def current_user_is_host?
      current_user == @event.host
    end

    def future_time_in_days(event)
      pluralize(((event.start_time - Time.now)/86400).round, 'day')
    end
end
