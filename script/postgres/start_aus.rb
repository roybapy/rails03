#!/usr/bin/env ruby

require_relative 'main_google'
require_relative 'scan_google'
require_relative 'ran_today_0'
require_relative 'get_image'
require_relative 'has_image'
require_relative 'get_image_banner'


#$stdout.reopen("out.txt", "w")
#$stderr.reopen("err.txt", "w")




  r01 = scan_database("New York", "Sydney")
  
  if r01 == "run"
   google_flights_scan("New York", "Sydney")
   
  end

  google_flights_scan("Seattle", "London")
  
  google_flights_scan("Honolulu", "Hyderabad")
  google_flights_scan("Minneapolis", "Bangkok")
  
  
#google_flights_scan("New York", "Sydney")

#google_flights_scan("Seattle", "London")

#google_flights_scan("New York", "Melbourne")

#google_flights_scan("New York", "Auckland")