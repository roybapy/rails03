#!/usr/bin/env ruby



def google_flights_scan(c1, c2)

puts c1
puts c2

begin

browser = Watir::Browser.new(:chrome)
browser.goto("google.com/flights/")

browser.div(class:"EESPNGB-ub-a").click
browser.text_field( placeholder: "Where from?" ).set c1
browser.div( class: "EESPNGB-Gb-c" ).click

browser.div( class: "EESPNGB-ub-c EESPNGB-c-r EESPNGB-D-b" ).click
browser.text_field( placeholder: "Where to?" ).set c2
browser.div( class: "gwt-HTML EESPNGB-Hb-e" ).click


browser.text_field(class: "gwt-TextBox").click
browser.div( class: "EESPNGB-o-u EESPNGB-a-i EESPNGB-o-E EESPNGB-o-h" ).click
browser.div( class: "EESPNGB-o-I EESPNGB-o-x" ).click

percentlow=0
ap = Array.new

totalbar=5

$i0 = 0
while $i0 < 6  do

   if  $i0 == 0 ;breakat=55
   elsif $i0 == 1 ;breakat=111
   elsif $i0 == 2 ;breakat=167
   elsif $i0 == 3 ;breakat=223
   elsif $i0 == 4 ;breakat=279
   elsif $i0 == 5 ;breakat=326
   end
  
while totalbar < breakat  do  
    
   if  $i0 == 0 ;	clickat = (totalbar%55) + 2;
   else clickat = (totalbar%55) + 3 ; 
   end
   puts "click at here #{clickat}"
   
   browser.div(:class => "EESPNGB-bb-s EESPNGB-bb-b").div(:index => clickat).click
   sleep 1
   doc=Nokogiri::HTML.parse(browser.html)    
   date=doc.css('div.EESPNGB-bb-H').text
  
   count=0
   while date=="Loading..." do
   if count==0; sleep 4; else sleep 2; end
   browser.div(:class => "EESPNGB-bb-s EESPNGB-bb-b").div(:index => clickat).click
   sleep 1
   doc=Nokogiri::HTML.parse(browser.html)    
   date=doc.css('div.EESPNGB-bb-H').text
   
   count +=1
   if count >10
   break
   end
   end

   
   sp=doc.css("div.EESPNGB-p-f").text
   sp0=sp.gsub(/[\s,]/ ,""); puts sp0
   a0=sp0.split("$").map(&:to_i)
   a0.shift
   ap.push(*a0)
   
   totalbar +=a0.length
   
   puts a0.length
   puts totalbar
  
end  

   
   
if $i0 < 5
browser.div( class: "EESPNGB-ab-d EESPNGB-c-b" ).click
browser.div( class: "EESPNGB-ab-d EESPNGB-c-b" ).click
sleep 2
end

$i0 +=1

end

browser.close

avg = ap.reduce(:+) / ap.size.to_f

lowest = ap.min

len = ap.length
sorted = ap.sort
median = len % 2 == 1 ? sorted[len/2] : (sorted[len/2 - 1] + sorted[len/2]).to_f / 2

puts lowest
puts median, avg
puts len
puts ap


if avg > median
   avg = median
   end
   
   percentlow= ((avg-lowest)/avg.to_f)*100
   
    puts "percent_low #{percentlow}"
   
   if percentlow > 30
   puts "got a deal #{percentlow}"
   google_flights( c1, c2)
   has_img(c1, c2)
   end


rescue Exception => e 
  puts e
  puts c1+c2
unless browser.nil?
  browser.close
end
  

end

puts "starting database to log run"

begin

db=SQLite3::Database.new("test.sqlite3")

fname=c1.gsub(/\s+/, "") +"_"+ c2.gsub(/\s+/, "")+"_"+ DateTime.now.strftime('%m%d%Y')

st="INSERT INTO Scan_result (Flight, Percent) VALUES('#{fname}', '#{percentlow}')"
db.execute(st)

#rescue SQLite3::Exception => e 
rescue Exception => e    
    puts c1+c2
    puts e
    
ensure
    db.close if db
end	


end