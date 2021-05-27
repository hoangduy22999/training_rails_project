module ExamsHelper
    def show_minutes_seconds(seconds)
        "#{seconds/60}m:#{seconds%60}" if seconds ||= 0
    end
end
