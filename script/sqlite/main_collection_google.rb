
#!/usr/bin/env ruby

def google_flights(c1, c2)



browser = Watir::Browser.new(:chrome)
browser.goto("google.com/flights/")

browser.div(class:"EESPNGB-ub-a").click
browser.text_field( placeholder: "Where from?" ).set "New York"
browser.div( class: "EESPNGB-Gb-c" ).click

browser.div( class: "EESPNGB-ub-c EESPNGB-c-r EESPNGB-D-b" ).click
browser.text_field( placeholder: "Where to?" ).set "Nairobi"
browser.div( class: "gwt-HTML EESPNGB-Hb-e" ).click


browser.text_field(class: "gwt-TextBox").click
browser.div( class: "EESPNGB-o-u EESPNGB-a-i EESPNGB-o-E EESPNGB-o-h" ).click

dateprice=[];
tripla=[];



$i01 = 4
while $i01 < 31  do

datepricez=[];
$i0 = 0
while $i0 < 6  do

doc=Nokogiri::HTML.parse(browser.html)
month=[] ; 
doc.css('div.EESPNGB-p-b').each do |x|; month<<x.text;end
monthl=month.length-1;

for x in 0..monthl
m1=Date.today.month
m2=Date.parse('1'+ month[x]).month
if m1 > m2;  y1=Date.today.year+1; month[x]= month[x]+" "+y1.to_s; else month[x]= month[x]+" "+ Date.today.year.to_s;end
end

datepricet=[];

doc.search('td').each do |x|; if x.css('div').count==2 && x.css('div.EESPNGB-p-d').count==1; d0=x.css('div.EESPNGB-p-d').text; p0=x.css('div.EESPNGB-p-f').text; datepricet<< [d0,p0];end;end;

if $i0==0 || $i0==5; mindata=27; else mindata=50; end


if datepricet.length < mindata;
datepricet=[];
count=0
while count < 10 do
if count==0; sleep 4; else sleep 2; end
doc=Nokogiri::HTML.parse(browser.html)
doc.search('td').each do |x|; if x.css('div').count==2 && x.css('div.EESPNGB-p-d').count==1; d0=x.css('div.EESPNGB-p-d').text; p0=x.css('div.EESPNGB-p-f').text; datepricet<< [d0,p0];end;end;
if datepricet.length > mindata;  break; end
count +=1
end
end

if $i0 < 5
browser.div( class: "EESPNGB-p-m datePickerNextButton EESPNGB-c-b" ).click
browser.div( class: "EESPNGB-p-m datePickerNextButton EESPNGB-c-b" ).click
end

mt=datepricet[0][0].to_i
datepricet.each do |x|

if mt <= x[0].to_i
d1 = Date.parse(x[0]+month[0])
d2 = d1+$i01
dpd= d1.strftime('%b %d')+" - " + d2.strftime('%b %d')
mt=x[0].to_i
else
mt=32
d1 = Date.parse(x[0]+month[1])
d2 = d1+$i01
dpd= d1.strftime('%b %d')+" - " + d2.strftime('%b %d')

end

dpp=x[1].gsub(/[\s,]/ ,"").gsub('$', '').to_i

datepricez << [dpd, dpp ]
end

$i0 +=1

end

if $i01 < 30
browser.div( class: "EESPNGB-o-I EESPNGB-o-x" ).click
#browser.div( class: "EESPNGB-G-f EESPNGB-G-i" ).hover
#browser.div( class: "EESPNGB-G-f EESPNGB-G-h" ).click

browser.div( class: "EESPNGB-G-s EESPNGB-G-r EESPNGB-c-r EESPNGB-eb-i" ).text_field( class: "gwt-TextBox" ).set $i01+1
browser.div( class: "EESPNGB-eb-g" ).click
browser.div( class: "EESPNGB-o-I EESPNGB-o-a" ).click
end
tripla << $i01
dateprice << datepricez

$i01 +=1

end


puts "starting database"

begin

db=SQLite3::Database.new("db/development.sqlite3")

tname=c1.gsub(/\s+/, "") +"_"+ c2.gsub(/\s+/, "")+"_"+ DateTime.now.strftime('%m%d%Y')

#db.execute ("DROP TABLE IF EXISTS "+tname)
db.execute "CREATE TABLE IF NOT EXISTS "+ tname+"(Id INTEGER PRIMARY KEY, date4 TEXT, price4 INT,date5 TEXT, price5 INT,date6 TEXT, price6 INT,date7 TEXT, price7 INT,date8 TEXT, price8 INT,date9 TEXT, price9 INT,date10 TEXT, price10 INT,date11 TEXT, price11 INT,date12 TEXT, price12 INT,date13 TEXT, price13 INT,date14 TEXT, price14 INT,date15 TEXT, price15 INT,date16 TEXT, price16 INT,date17 TEXT, price17 INT,date18 TEXT, price18 INT,date19 TEXT, price19 INT,date20 TEXT, price20 INT,date21 TEXT, price21 INT,date22 TEXT, price22 INT,date23 TEXT, price23 INT,date24 TEXT, price24 INT,date25 TEXT, price25 INT,date26 TEXT, price26 INT,date27 TEXT, price27 INT,date28 TEXT, price28 INT,date29 TEXT, price29 INT,date30 TEXT, price30 INT)"


 $i=0
 
 while  $i < dateprice.length do
 $j=0
 
 while  $j < dateprice[$i].length do
 
 st="INSERT INTO #{tname} (date#{tripla[$i]}, price#{tripla[$i]}) VALUES('#{dateprice[$i][$j][0]}' , '#{dateprice[$i][$j][1]}')"
 db.execute(st)
 puts dateprice[$i][$j][0]
 
 $j +=1
 end

 $i +=1
 end
 
 #incomplete need to update row with primary id 

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