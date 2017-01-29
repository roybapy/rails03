#!/usr/bin/env ruby

def google_image_banner(c1, c2)

puts "Collecting img banner for #{c2} #{DateTime.now}"

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



begin

#db=PG::Connection.open(:dbname => 'flysuper_development',:user => 'flysuper', :password => 'flysuper')

ActiveRecord::Base.connection.execute("update cityimg set banner ='#{imglink}' where city ='#{c2}'")

rescue Exception => e
    puts "image link database update failed for #{c2}"
    puts e


end



end
