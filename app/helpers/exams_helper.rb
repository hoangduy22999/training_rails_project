module ExamsHelper
    def show_time_exam(seconds)
        "#{seconds/60}m"
    end

    def time_exam
        [["15m", 15*60], ["30m", 30*60], ["45m", 45*60], ["60m", 60*60], ["90m", 90*60]]
    end
end
