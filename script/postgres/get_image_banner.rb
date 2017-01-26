#!/usr/bin/env ruby

def google_image_banner(c1, c2)

puts c1
puts c2

begin
imglink=""
browser = Watir::Browser.new(:chrome)
browser.goto("images.google.com")

browser.text_field(:title => "Search" ).set c2.split("|")[0]
browser.button(:type => "submit").click
sleep 1
doc=Nokogiri::HTML.parse(browser.html)

$i1 = 0
while $i1 < 100  do

stl=doc.css("div#ires div.rg_meta")[$i1].text
ha = JSON.parse stl
w=ha["ow"]
h=ha["oh"]
 
 if (w.to_f/h.to_f) >= 1.9 && w > 1000
 imglink=ha["ou"]
 break
 end

 $i1 +=1
end
 
browser.close

rescue Exception => e 
  puts e
  puts "banner fetch failed for #{c2}"
unless browser.nil?
  browser.close
end

end

puts "starting database"

begin

db=PG::Connection.open(:dbname => 'flysuper_development',:user => 'flysuper', :password => 'flysuper')

db.exec("update cityimg set banner ='#{imglink}' where city ='#{c2}'")

rescue Exception => e    
    puts "image link database update failed for #{c2}"
    puts e
    
ensure
    db.close if db
end	



end