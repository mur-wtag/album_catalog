# frozen_string_literal: true

module ApplicationHelper
  def duration_string(time_sec)
    formatter = time_sec >= 3600 ? '%H:%M:%S' : '%M:%S'
    Time.at(time_sec).utc.strftime(formatter)
  end
end
