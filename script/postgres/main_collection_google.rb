
#!/usr/bin/env ruby

def google_flights(c1, c2)

begin

browser = Watir::Browser.new(:chrome)
browser.goto("google.com/flights/")

browser.div(class:"EESPNGB-ub-a").click
browser.text_field( placeholder: "Where from?" ).set c1.split("|")[0]
browser.div( class: "EESPNGB-Gb-c" ).click

browser.div( class: "EESPNGB-ub-c EESPNGB-c-r EESPNGB-D-b" ).click
browser.text_field( placeholder: "Where to?" ).set c2.split("|")[0]
browser.div( class: "gwt-HTML EESPNGB-Hb-e" ).click


browser.text_field(class: "gwt-TextBox").click
browser.div( class: "EESPNGB-o-u EESPNGB-a-i EESPNGB-o-E EESPNGB-o-h" ).click

dateprice=[];
tripla=[];
price4day=[];



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

if $i0==0 ; mindata=27; elsif $i0==4; mindata=36; elsif $i0==5; mindata=0;  else mindata=50; end


if datepricet.length < mindata;
count=0
while count < 10 do
datepricet=[];
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

if datepricet.length > 1

puts "hellooooooooooooooooooo #{$i0}"
puts datepricet;

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

if $i01 == 4; price4day.push(dpp);end
end
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

db=PG::Connection.open(:dbname => 'flysuper_development',:user => 'flysuper', :password => 'flysuper')

tname=c1.gsub(/[\s,|]/ ,"") +"_"+ c2.gsub(/[\s,|]/ ,"")+"_"+ DateTime.now.strftime('%m%d%Y')

#db.exec("DROP TABLE IF EXISTS #{tname}")

db.exec("create table if not exists #{tname} (tripl text, dp json)")
db.exec("create table if not exists #{tname}_low (tripl INT, date TEXT, price INT)")


 $i=0
 
 while  $i < dateprice.length do
 
 js=dateprice[$i].to_h.to_json

db.exec("INSERT INTO #{tname} VALUES( #{tripla[$i]} , '#{js}' )")
 
 
 xa=[]
 dateprice[$i].each do |x|; xa.push(x[1]);end
 dm=dateprice[$i][xa.index(xa.min)][0]; pm=dateprice[$i][xa.index(xa.min)][1];
 db.exec("INSERT INTO #{tname}_low VALUES('#{tripla[$i]}' , '#{dm}', '#{pm}')")
 

 $i +=1
 end

avg = price4day.reduce(:+) / price4day.size.to_f
lowest = price4day.min

len = price4day.length
sorted = price4day.sort
median = len % 2 == 1 ? sorted[len/2] : (sorted[len/2 - 1] + sorted[len/2]).to_f / 2

if avg > median; avg = median; end
   
percentlow= ((avg-lowest)/avg.to_f)*100
 
tdeal="Deals_"+ DateTime.now.strftime('%m%d%Y')
db.exec("create table if not exists #{tdeal}(destination text, date text, price int, avgp int, perl int)")
db.exec("CREATE TABLE if not exists topdeals (name TEXT, start TEXT, stop TEXT, date TEXT, price INT, avgp INT, perl INT, imgl TEXT)")
db.exec("CREATE TABLE if not exists alldeals (name TEXT, start TEXT, stop TEXT, date TEXT, price INT, avgp INT, perl INT, imgl TEXT)") 


date4=dateprice[0][price4day.index(lowest)][0]; price4=dateprice[0][price4day.index(lowest)][1];
db.exec("insert into topdeals (name, start, stop, date, price, avgp, perl) values ('#{tname}','#{c1}','#{c2}','#{date4}','#{price4}','#{avg.round}','#{percentlow.round}')")


for i in 0..(price4day.length-1); if price4day[i] < avg*0.7; 

date4=dateprice[0][i][0]; price4=dateprice[0][i][1];

db.exec("insert into alldeals (name, start, stop, date, price, avgp, perl) values ('#{tname}','#{c1}','#{c2}','#{date4}','#{price4}','#{avg.round}','#{percentlow.round}')")
db.exec("insert into #{tdeal} (destination, date, price, avgp, perl) values ('#{tname}','#{date4}','#{price4}','#{avg.round}','#{percentlow.round}')")

end;end



rescue Exception => e    
    puts c1+c2
    puts e
    
ensure
    db.close if db
end	


end