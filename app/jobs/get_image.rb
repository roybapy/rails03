#!/usr/bin/env ruby

def google_image(c1, c2)

puts c1
puts c2

begin
imglink=""
capabilities = Selenium::WebDriver::Remote::Capabilities.phantomjs("phantomjs.page.settings.userAgent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/538.1 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/538.1")
driver = Selenium::WebDriver.for :phantomjs, :desired_capabilities => capabilities
browser = ::Watir::Browser.new driver
browser.goto("images.google.com")

browser.text_field(:title => "Search" ).set c2.split("|")[0]
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

#db=PG::Connection.open(:dbname => 'flysuper_development',:user => 'flysuper', :password => 'flysuper')

ActiveRecord::Base.connection.execute("update topdeals set imgl ='#{imglink}' where stop ='#{c2}'")
ActiveRecord::Base.connection.execute("INSERT INTO cityimg (city, thumb) VALUES ('#{c2}','#{imglink}')")

rescue Exception => e
    puts "image link database update failed for #{c2}"
    puts e


end



end
