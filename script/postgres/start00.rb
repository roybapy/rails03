#!/usr/bin/env ruby

require_relative 'main_google'
require_relative 'scan_google'
require_relative 'ran_today_0'
require_relative 'get_image'

us = Array["Seattle","Los Angeles","San Francisco","Atlanta","Dallas","New York","Denver","charlotte","Las Vegas","Phoenix","Miami",
"Houston","Orlando","Minneapolis","Boston","Chicago","Washington D.C.","Philadelphia","Fort Lauderdale","Honolulu"]

asia = Array["New Delhi","Mumbai","Bengaluru","Hyderabad","Kolkata","Bangkok","Dhaka","Singapore","Hong Kong","Ho Chi Minh City","Beijing","Kathmandu",
"Manila","Phuket","Seoul","Tokyo","Beijing","Kyoto","Hanoi","Siem Reap","Taipei","Shanghai","Kuala Lumpur","Goa"]



$m = 0
while $m < asia.length  do
  
  $n = 0
  while $n < us.length  do
  
  r01 = scan_database(us[$n], asia[$m])
  if r01 == "run"
  google_flights_scan(us[$n], asia[$m])
  end
  
  $n +=1
   end

$m +=1
end
