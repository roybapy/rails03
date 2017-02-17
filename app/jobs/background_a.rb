require_relative 'goog_scan_ondemand.rb'
require_relative 'amad_scan_ondemand.rb'
require_relative 'ran_today_c'
require_relative 'ran_today'
require_relative 'get_image'
require_relative 'has_image'
require_relative 'get_image_banner'

class BackgroundA < Struct.new(:c1, :c2, :c3, :c4, :c5)
  def perform
    Delayed::Worker.logger.debug(c5)

    amad_flights(c1, c2, c3, c4, c5)

  end

  def max_attempts
    3
  end
end
