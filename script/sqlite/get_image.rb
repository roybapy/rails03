#!/usr/bin/env ruby

def google_image(c1, c2)

puts c1
puts c2

begin
imglink=""
browser = Watir::Browser.new(:chrome)
browser.goto("images.google.com")

browser.text_field(:title => "Search" ).set c2
browser.button(:type => "submit").click
sleep 1
doc=Nokogiri::HTML.parse(browser.html)

$i1 = 0
while $i1 < 100  do

stl=doc.css("div#ires img")[$i1]["style"]
stl0=stl.split";"
w=stl0[0].scan(/\d+/).first
h=stl0[1].scan(/\d+/).first
 
 if (w.to_f/h.to_f) >= 1.5 && (w.to_f/h.to_f) < 1.8
 imglink=doc.css("div#ires img")[$i1]["src"]
 break
 end

 $i1 +=1
end
 
browser.close

rescue Exception => e 
  puts e
  puts "image fetch failed for #{c2}"
unless browser.nil?
  browser.close
end

end

puts "starting database"

begin

db=SQLite3::Database.new("db/development.sqlite3")

db.execute ("update topdeals set imgl ='#{imglink}' where stop ='#{c2}'")
db.execute ("INSERT INTO cityimg (city, thumb) VALUES ('#{c2}','#{imglink}')")

#rescue SQLite3::Exception => e 
rescue Exception => e    
    puts "image link database update failed for #{c2}"
    puts e
    
ensure
    db.close if db
end	



end