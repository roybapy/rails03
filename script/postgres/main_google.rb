#!/usr/bin/env ruby

def google_flights(c1, c2)

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


browser.text_field(class: "gwt-TextBox").set "February 2"
browser.div( class: "EESPNGB-o-u EESPNGB-a-i EESPNGB-o-E EESPNGB-o-h" ).click
browser.div( class: "EESPNGB-o-I EESPNGB-o-x" ).click


price = Hash.new

$i0 = 0
while $i0 < 6  do

$i = 0
$num = 56
while $i < $num  do
   browser.div(:class => "EESPNGB-bb-s EESPNGB-bb-b").div(:index => $i).hover
   doc=Nokogiri::HTML.parse(browser.html)    
   date=doc.css('div.EESPNGB-bb-H').text
  
   count=0
   while date=="Loading..." do
   sleep 2
   browser.div(:class => "EESPNGB-bb-s EESPNGB-bb-b").div(:index => $i).click
   doc=Nokogiri::HTML.parse(browser.html)    
   date=doc.css('div.EESPNGB-bb-H').text
   
   count +=1
   if count >10
   break
   end
   end

   if date != "Your search did not match any of our flights." && date != "Loading..."
   
   p0=doc.css('div.EESPNGB-bb-I').text
   if p0.nil? 
   p0="" 
   end
   p1=p0.split("$")
   p2=p1[1].split(",")
   
   p3=""
   if p2.length > 1
   $k = 0
   while $k < p2.length  do
   p3=p3+p2[$k]
   $k +=1
   end
   else 
   p3=p3+p2[0]
   end
   puts p3

   price.store(doc.css('div.EESPNGB-bb-H').text, p3.to_i)
   
   end
   
   $i +=1
end

if $i0 < 5
browser.div( class: "EESPNGB-ab-d EESPNGB-c-b" ).click
browser.div( class: "EESPNGB-ab-d EESPNGB-c-b" ).click
end

$i0 +=1

end

browser.close

rescue Exception => e 
  puts e
  puts c1+c2
unless browser.nil?
  browser.close
end
  

end

puts "starting database"

begin

db=SQLite3::Database.new("db/development.sqlite3")

tname=c1.gsub(/\s+/, "") +"_"+ c2.gsub(/\s+/, "")+"_"+ DateTime.now.strftime('%m%d%Y')

db.execute ("DROP TABLE IF EXISTS "+tname)
db.execute "CREATE TABLE IF NOT EXISTS "+ tname+"(Id INTEGER PRIMARY KEY, Date TEXT, Price INT)"

 $i=0
 price.each do |key, value|
 puts key
 puts value
 puts $i
 
 st="INSERT INTO "+tname+"(Id, Date, Price) VALUES(" + $i.to_s + "," + "'"+ key.to_s + "'" + "," + value.to_s + ")"
 db.execute(st)

 $i +=1
 end

rs=db.execute("select avg(Price), ((avg(Price)-min(Price))/avg(Price))*100 from "+tname)

plow = rs[0][0]*0.7

puts rs[0][1]
if rs[0][1] > 30
tdeal="Deals_"+ DateTime.now.strftime('%m%d%Y')
db.execute "CREATE TABLE IF NOT EXISTS "+tdeal+" (Destination TEXT, Date TEXT, Price INT, Avgprice INT, Percentlow INT)"
db.execute ("insert into "+tdeal+"(Destination, Date, Price, Avgprice, Percentlow) select '"+tname+"', Date, Price, '#{rs[0][0]}','#{rs[0][1]}' from "+tname+" where Price < #{plow}")
db.execute ("insert into topdeals(start, stop, date, price, avgp, perl, created_at, updated_at) select '#{c1}','#{c2}',Date, Price,'#{rs[0][0].round}','#{rs[0][1].round}','0','0' from #{tname} order by Price asc limit 1")

end

#rescue SQLite3::Exception => e 
rescue Exception => e    
    puts c1+c2
    puts e
    
ensure
    db.close if db
end	
end