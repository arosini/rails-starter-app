# Overrides to the Time class
class Time
  def format_time
    in_time_zone('Eastern Time (US & Canada)').strftime('%B %d, %Y %l:%M %p')
  end
end
