module ResultsHelper
  def show_time_result(seconds)
    "#{seconds/60}m:#{seconds%60}s"
  end
end
