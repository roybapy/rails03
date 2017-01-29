
#!/usr/bin/env ruby

def scan_light_goog(c1, c2)

begin

capabilities = Selenium::WebDriver::Remote::Capabilities.phantomjs("phantomjs.page.settings.userAgent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/538.1 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/538.1")
driver = Selenium::WebDriver.for :phantomjs, :desired_capabilities => capabilities
browser = ::Watir::Browser.new driver

browser.goto("google.com/flights/")
browser.div(class:"EESPNGB-ub-a").click
browser.text_field( placeholder: "Where from?" ).set c1.split("|")[1]
browser.send_keys :enter
browser.div( class: "EESPNGB-ub-c EESPNGB-c-r EESPNGB-D-b" ).click
browser.text_field( placeholder: "Where to?" ).set c2.split("|")[1]
browser.send_keys :enter
browser.text_field(class: "gwt-TextBox").click
browser.div( class: "EESPNGB-o-u EESPNGB-a-i EESPNGB-o-E EESPNGB-o-h" ).click


price4day=[];

gd=Date.today+7

$i01 = 4
while $i01 < 5  do

gr=gd+$i01

url="https://www.google.com/flights/#search;f=" + c1.split("|")[1] + ";t=" + c2.split("|")[1] + ";d=" + gd.strftime("%F") + ";r=" + gr.strftime("%F")
browser.goto(url)


$i0 = 0
while $i0 < 6  do

doc=Nokogiri::HTML.parse(browser.html)

month=[] ;
doc.css('div.EESPNGB-p-b').each do |x|; month<<x.text;end
puts month;

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

#puts "hellooooooooooooooooooo #{$i0}"
#puts datepricet;

datepricet.each do |x|

dpp=x[1].gsub(/[\s,]/ ,"").gsub('$', '').to_i

if $i01 == 4; price4day.push(dpp);end
end
end


$i0 +=1

end


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



begin

#db=PG::Connection.open(:dbname => 'flysuper_development',:user => 'flysuper', :password => 'flysuper')

tname=c1.gsub(/[\s,|]/ ,"") +"_"+ c2.gsub(/[\s,|]/ ,"")+"_"+ DateTime.now.strftime('%m%d%Y')


avg = price4day.reduce(:+) / price4day.size.to_f
lowest = price4day.min

len = price4day.length
sorted = price4day.sort
median = len % 2 == 1 ? sorted[len/2] : (sorted[len/2 - 1] + sorted[len/2]).to_f / 2

if avg > median; avg = median; end

percentlow= ((avg-lowest)/avg.to_f)*100

ActiveRecord::Base.connection.execute("INSERT INTO scan_result (fname, perl, stime) VALUES( '#{tname}' , #{percentlow.round}, '#{DateTime.now}' )")

puts "Scan complete #{c1} #{c2} #{percentlow}"

if percentlow > 30

   puts "got a deal #{percentlow}"
   scan_deep_goog(c1, c2)
   has_img(c1, c2)
   
end


rescue Exception => e
    puts c1+c2
    puts e


end


end
