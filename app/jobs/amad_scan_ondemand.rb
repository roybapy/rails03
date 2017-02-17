
#!/usr/bin/env ruby

def amad_flights(c1, c2, c3, c4, c5)


  fname= "c_" + c3 + "_" + c1.gsub(/[\s,|]/ ,"") + "_" + c2.gsub(/[\s,|]/ ,"") + "_" + DateTime.now.strftime('%m%d%Y')

  ActiveRecord::Base.connection.execute("INSERT INTO scan_result (fname, tripl, status, stime) VALUES( '#{fname}' , #{c3}, 'started', '#{DateTime.now}')")

  tname0= "c_" + c1.gsub(/[\s,|]/ ,"") + "_" + c2.gsub(/[\s,|]/ ,"") + "_" + DateTime.now.strftime('%m%d%Y')
  tname = tname0.downcase


  if c4 != "0"

  urun= c1+"-"+c2+"-"+c3+"%%"+DateTime.now.strftime('%FT%T%:z')
  ActiveRecord::Base.connection.execute("update users set running= '#{urun}' where id= #{c4}")
  end


begin

apik="AVJCi5m9E6ABEDuTgXE9KHQVAQ9PXJcz"

percentlow = 0

c3=c3.to_i



c5.each_with_index do |item, index|


url= "http://api.sandbox.amadeus.com/v1.2/flights/extensive-search?origin=" + c1.split("|")[1] + "&destination=" + c2.split("|")[1] + "&duration=" + item.to_s + "&apikey=" + apik

res = Net::HTTP.get(URI.parse(url))

hash = JSON.parse(res)

unless hash.key?("results")
percentlow = -1
break
end

hash0=hash['results'].sort_by { |v| v["departure_date"] }


price4day= hash0.map { |v| v["price"].to_i }


datepricez = hash0.map { |v| [ Date.parse(v["departure_date"] ).strftime('%b %d')+" - " + Date.parse(v["return_date"] ).strftime('%b %d'), v["price"].to_i ] }


if index == 0
  ActiveRecord::Base.connection.execute("create table if not exists #{tname} (tripl text, dp json)")
  ActiveRecord::Base.connection.execute("create table if not exists #{tname}_low (tripl INT, date TEXT, price INT, avgp INT, perl INT, result TEXT)")
end

 js= datepricez.to_h.to_json
ActiveRecord::Base.connection.execute("DELETE FROM #{tname} where tripl= '#{item}'")
ActiveRecord::Base.connection.execute("INSERT INTO #{tname} VALUES( '#{item}' , '#{js}' )")


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

dm = datepricez[price4day.index(lowest)][0]; pm = datepricez[price4day.index(lowest)][1];

ActiveRecord::Base.connection.execute("DELETE FROM #{tname}_low where tripl= #{item}")
ActiveRecord::Base.connection.execute("INSERT INTO #{tname}_low VALUES( '#{item}' , '#{dm}', '#{pm}', '#{avg.round}', '#{percentlow.round}', '#{res}')")






end




rescue Exception => e
  Delayed::Worker.logger.debug( "Amad scan failed #{c1+c2} : #{e}" )


end



unless percentlow < 0
begin

has_img(c1, c2)

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
  Delayed::Worker.logger.debug( "Amad scan failed #{c1+c2} : #{e}" )

end




if percentlow > 30
  r0 = scan_database(c1, c2)
   if r0 == "run"
     ActiveRecord::Base.connection.execute("create table if not exists queue_deep_scan (start text, stop text, tripl text, perl int, time timestamp)")
	 ActiveRecord::Base.connection.execute("INSERT INTO queue_deep_scan VALUES( '#{c1}', '#{c2}', '#{c3}', #{percentlow.round}, '#{DateTime.now}')")

   end
end

end

Delayed::Worker.logger.debug( percentlow )

if percentlow < 0
ActiveRecord::Base.connection.execute("delete from scan_result where fname = '#{fname}'")
c3=c3.to_s
google_flights(c1, c2, c3, c4)
end


end
