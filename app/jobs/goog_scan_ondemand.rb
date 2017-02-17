
#!/usr/bin/env ruby

def google_flights(c1, c2, c3, c4)

  c3=c3.to_s

  fname= "c_" + c3 + "_" + c1.gsub(/[\s,|]/ ,"") + "_" + c2.gsub(/[\s,|]/ ,"") + "_" + DateTime.now.strftime('%m%d%Y')

  ActiveRecord::Base.connection.execute("INSERT INTO scan_result (fname, tripl, status, stime) VALUES( '#{fname}' , #{c3}, 'started', '#{DateTime.now}')")

  tname0= "c_" + c1.gsub(/[\s,|]/ ,"") + "_" + c2.gsub(/[\s,|]/ ,"") + "_" + DateTime.now.strftime('%m%d%Y')
  tname = tname0.downcase


Delayed::Worker.logger.debug( "Starting goog scan..." )

  if c4 != "0"

  urun= c1+"-"+c2+"-"+c3+"%%"+DateTime.now.strftime('%FT%T%:z')
  ActiveRecord::Base.connection.execute("update users set running= '#{urun}' where id= #{c4}")
  end

begin
capabilities = Selenium::WebDriver::Remote::Capabilities.phantomjs("phantomjs.page.settings.userAgent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/538.1 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/538.1")
driver = Selenium::WebDriver.for :phantomjs, :desired_capabilities => capabilities
browser = ::Watir::Browser.new driver

browser.goto("google.com/flights/")
browser.div(class:"OMOBOQD-yb-a").click
browser.text_field( placeholder: "Where from?" ).set c1.split("|")[1]
browser.send_keys :enter
browser.div( class: "OMOBOQD-yb-c OMOBOQD-c-r OMOBOQD-D-b" ).click
browser.text_field( placeholder: "Where to?" ).set c2.split("|")[1]
browser.send_keys :enter
browser.text_field(class: "gwt-TextBox").click
browser.div( class: "OMOBOQD-o-u OMOBOQD-a-i OMOBOQD-o-E OMOBOQD-o-h" ).click

gd=Date.today+7

gr=gd+c3.to_i


url="https://www.google.com/flights/#search;f=" + c1.split("|")[1] + ";t=" + c2.split("|")[1] + ";d=" + gd.strftime("%F") + ";r=" + gr.strftime("%F")
browser.goto(url)


dateprice=[];
tripla=[];
price4day=[];

c3=c3.to_i

$i01 = c3
while $i01 < c3+1  do

datepricez=[];
$i0 = 0
while $i0 < 6  do

doc=Nokogiri::HTML.parse(browser.html)
month=[] ;
doc.css('div.OMOBOQD-p-b').each do |x|; month<<x.text;end
monthl=month.length-1;

for x in 0..monthl
m1=Date.today.month
m2=Date.parse('1'+ month[x]).month
if m1 > m2;  y1=Date.today.year+1; month[x]= month[x]+" "+y1.to_s; else month[x]= month[x]+" "+ Date.today.year.to_s;end
end

datepricet=[];

doc.search('td').each do |x|; if x.css('div').count==2 && x.css('div.OMOBOQD-p-d').count==1; d0=x.css('div.OMOBOQD-p-d').text; p0=x.css('div.OMOBOQD-p-f').text; datepricet<< [d0,p0];end;end;

if $i0==0 ; mindata=27; elsif $i0==4; mindata=36; elsif $i0==5; mindata=0;  else mindata=50; end


if datepricet.length < mindata;
count=0
while count < 10 do
datepricet=[];
if count==0; sleep 4; else sleep 2; end
doc=Nokogiri::HTML.parse(browser.html)
doc.search('td').each do |x|; if x.css('div').count==2 && x.css('div.OMOBOQD-p-d').count==1; d0=x.css('div.OMOBOQD-p-d').text; p0=x.css('div.OMOBOQD-p-f').text; datepricet<< [d0,p0];end;end;
if datepricet.length > mindata;  break; end
count +=1
end
end

if $i0 < 5
browser.div( class: "OMOBOQD-p-m datePickerNextButton OMOBOQD-c-b" ).click
browser.div( class: "OMOBOQD-p-m datePickerNextButton OMOBOQD-c-b" ).click
end

if datepricet.length > 1

#puts "hellooooooooooooooooooo #{$i0}"
#puts datepricet;

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

if $i01 == c3; price4day.push(dpp);end
end
end


$i0 +=1

end

if $i01 < c3
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
  Delayed::Worker.logger.debug( "Goog scan failed #{c1+c2} : #{e}" )

unless browser.nil?
  browser.close
end

end



begin

#db=PG::Connection.open(:dbname => 'flysuper_development',:user => 'flysuper', :password => 'flysuper')

#ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS #{tname}")

ActiveRecord::Base.connection.execute("create table if not exists #{tname} (tripl text, dp json)")
ActiveRecord::Base.connection.execute("create table if not exists #{tname}_low (tripl INT, date TEXT, price INT, avgp INT, perl INT, result TEXT)")




 $i=0

 while  $i < dateprice.length do

 js=dateprice[$i].to_h.to_json

ActiveRecord::Base.connection.execute("DELETE FROM #{tname} where tripl= '#{tripla[$i]}'")
ActiveRecord::Base.connection.execute("INSERT INTO #{tname} VALUES( #{tripla[$i]} , '#{js}' )")


 xa=[]
 dateprice[$i].each do |x|; xa.push(x[1]);end
 dm=dateprice[$i][xa.index(xa.min)][0]; pm=dateprice[$i][xa.index(xa.min)][1];

ActiveRecord::Base.connection.execute("DELETE FROM #{tname}_low where tripl= #{tripla[$i]}")
ActiveRecord::Base.connection.execute("INSERT INTO #{tname}_low (tripl, date, price) VALUES('#{tripla[$i]}' , '#{dm}', '#{pm}')")


 $i +=1
 end

avg = price4day.reduce(:+) / price4day.size.to_f
lowest = price4day.min

len = price4day.length
sorted = price4day.sort
median = len % 2 == 1 ? sorted[len/2] : (sorted[len/2 - 1] + sorted[len/2]).to_f / 2

if avg > median; avg = median; end

percentlow= ((avg-lowest)/avg.to_f)*100

if percentlow > 30
  res="Got something for you! Cheapest flight of the year is $#{lowest}. Usual round trip flight goes for $#{avg.round}."
else
  res="Cheapest flight of the year is $#{lowest}. Usual round trip flight goes for $#{avg.round}. No super cheap flight deal other than seasonal price change."
end

ActiveRecord::Base.connection.execute("update #{tname}_low set avgp='#{avg.round}', perl='#{percentlow.round}', result='#{res}' where tripl='#{tripla[0]}'")

ActiveRecord::Base.connection.execute("update scan_result set perl= #{percentlow.round}, status='completed', stime='#{DateTime.now}' where fname='#{fname}'")


if c4 != "0"
ActiveRecord::Base.connection.execute("update users set running= NULL where id= #{c4}")

 rs=ActiveRecord::Base.connection.execute("select ran from users where id = #{c4}")
if rs[0]['ran'] != nil
   unless rs[0]['ran'].include? c1+"-"+c2

     nrs = "#{c1}-#{c2}%%#{rs[0]['ran']}"
     ActiveRecord::Base.connection.execute("update users set ran= '#{nrs}' where id= #{c4}")
   end
 else
      nrs= "#{c1}-#{c2}"
      ActiveRecord::Base.connection.execute("update users set ran= '#{nrs}' where id= #{c4}")
 end
end



rescue Exception => e
  Delayed::Worker.logger.debug( "Goog scan failed #{c1+c2} : #{e}" )

end

puts "Collecting image"

has_img(c1, c2)

puts "Calling deep scan..."

if percentlow > 30
  r0 = scan_database(c1, c2)
   if r0 == "run"
   ActiveRecord::Base.connection.execute("create table if not exists queue_deep_scan (start text, stop text, tripl text, perl int, time timestamp)")
	 ActiveRecord::Base.connection.execute("INSERT INTO queue_deep_scan VALUES( '#{c1}', '#{c2}', '#{c3}', #{percentlow.round}, '#{DateTime.now}')")

   end
end


end
