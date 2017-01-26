require_relative 'goog_scan_ondemand.rb'
require_relative 'goog_scan_ondemand0'
require_relative 'ran_today_c'
require_relative 'ran_today'
require_relative 'get_image'
require_relative 'has_image'
require_relative 'get_image_banner'

class BackgroundA < Struct.new(:c1, :c2, :c3)
  def perform

    r0 = check_last_run(c1, c2, c3)
     if r0 == "run"
    google_flights( c1, c2, c3)
  end

  end

  def max_attempts
    3
  end
end
