module ExamsHelper
    def show_time_in_hour(seconds)       
        "#{seconds / 3600 }h:#{seconds/60 - (seconds / 3600)*60 }m:#{seconds % 60 }s" if seconds ||= 0
    end
end
