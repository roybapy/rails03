#!/usr/bin/env ruby

require_relative 'scan_light'
require_relative 'scan_deep'
require_relative 'ran_today'
require_relative 'get_image'
require_relative 'has_image'
require_relative 'get_image_banner'



us = Array["Atlanta, GA|ATL","Los Angeles, CA|LAX","Chicago, IL|CHI","Dallas, TX|DFW","Denver, CO|DEN","New York City, NY|NYC","San Francisco, CA|SFO",
"Miami, FL|MIA","Charlotte, NC|CLT","Las Vegas, NV|LAS","Seattle, WA|SEA","Washington, DC|WAS","Houston, TX|HOU"]

euro = Array["London, United Kingdom|LON","Paris, France|PAR","Barcelona, Spain|BCN","Amsterdam, Netherlands|AMS","Rome, Italy|ROM","Prague, Czech Republic|PRG",
"Berlin, Germany|BER","Vienna, Austria|VIE","Madrid, Spain|MAD","Milan, Italy|MIL","Munich, Germany|MUC","Moscow, Russia|MOW",
"Oslo, Norway|OSL","Copenhagen, Denmark|CPH","Venice, Italy|VCE"]



$m = 0
while $m < euro.length  do
  
  $n = 0
  while $n < us.length  do
  
  r01 = scan_database(us[$n], euro[$m])
  if r01 == "run"
  scan_light_goog(us[$n], euro[$m])
  end
  
  $n +=1
   end

$m +=1
end













