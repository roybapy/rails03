#!/usr/bin/env ruby

require_relative 'scan_light'
require_relative 'scan_deep'
require_relative 'ran_today'
require_relative 'get_image'
require_relative 'has_image'
require_relative 'get_image_banner'

c1="Seattle,WA|SEA"
c2="Rome,Italy|ROM"
 #has_img(c1, c2)
scan_light_goog(c1, c2)
