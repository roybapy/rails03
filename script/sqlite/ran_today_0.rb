#!/usr/bin/env ruby

def scan_database(c1, c2)

puts c1
puts c2

begin

db=SQLite3::Database.new("test.sqlite3")

r0="do not run"

fname=c1.gsub(/\s+/, "") +"_"+ c2.gsub(/\s+/, "")+"_"+ DateTime.now.strftime('%m%d%Y')
rs=db.execute("SELECT Flight FROM Scan_result WHERE Flight = '#{fname}'")

if rs[0] != nil
r0="do not run"

else
fname=c1.gsub(/\s+/, "") +"_"+ c2.gsub(/\s+/, "")+"_"+ DateTime.yesterday.strftime('%m%d%Y')
db.execute("DELETE FROM Scan_result WHERE Flight = '#{fname}'")

r0="run"

end

db.close
return r0

rescue Exception => e    
    puts c1+c2
    puts e
    return r0
ensure
    db.close if db


end

end