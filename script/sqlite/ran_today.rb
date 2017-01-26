#!/usr/bin/env ruby

def scan_database(c1, c2)

puts c1
puts c2

begin

db=SQLite3::Database.new("test.sqlite3")

r0="do not run"

tname=c1.gsub(/\s+/, "") +"_"+ c2.gsub(/\s+/, "")+"_"+ DateTime.now.strftime('%m%d%Y')
rs=db.execute("SELECT tbl_name FROM sqlite_master WHERE tbl_name = '"+tname+"' AND type = 'table'")
puts rs

tname0=c1.gsub(/\s+/, "") +"_"+ c2.gsub(/\s+/, "")
rs0=db.execute("SELECT tbl_name FROM sqlite_master WHERE tbl_name = '"+tname0+"' AND type = 'table'")
puts rs0

if rs[0] != nil
r0="do not run"

elsif rs0[0] != nil
r0="do not run"

else
tname=c1.gsub(/\s+/, "") +"_"+ c2.gsub(/\s+/, "")+"_"+ DateTime.yesterday.strftime('%m%d%Y')
db.execute("DROP TABLE IF EXISTS "+tname)
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