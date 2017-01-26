#!/usr/bin/env ruby

require_relative 'main_collection_google'
require_relative 'scan_google'
require_relative 'ran_today_0'
require_relative 'get_image'
require_relative 'has_image'
require_relative 'get_image_banner'

c1="Seattle,WA|SEA"
c2="Rome,Italy|ROM"
 #has_img(c1, c2)
 google_flights_scan(c1, c2)