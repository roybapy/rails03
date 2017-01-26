#!/usr/bin/env ruby

require_relative 'scan_light'
require_relative 'scan_deep'
require_relative 'ran_today'
require_relative 'get_image'
require_relative 'has_image'
require_relative 'get_image_banner'


#$stdout.reopen("out.txt", "w")
#$stderr.reopen("err.txt", "w")

c1="Seattle,WA|SEA"
c2="Rome,Italy|ROM"


  r01 = scan_database( c1, c2)
  
  if r01 == "run"
  scan_light_goog(c1, c2)
   
  end


  