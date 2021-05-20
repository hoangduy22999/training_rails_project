module ExamsHelper
    def show_time_in_hour(minutes)
        minutes > 60 ? "#{minutes / 60}:#{minutes % 60}" : minutes
    end
end
