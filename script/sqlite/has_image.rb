#!/usr/bin/env ruby

def has_img(c1, c2)

puts c1
puts c2

begin

db=SQLite3::Database.new("db/development.sqlite3")

puts "database started"

rs=db.execute("SELECT city FROM cityimg where city='#{c2}'")

puts rs

if rs[0] != nil
rs0=db.execute("SELECT thumb FROM cityimg where city='#{c2}'")
db.execute"update topdeals set imgl='#{rs0[0][0]}' where stop='#{c2}'"
rs1=db.execute("SELECT banner FROM cityimg where city='#{c2}'")
db.close
puts "inside0"

if rs1[0][0] == nil
puts "inside"
google_image_banner(c1, c2)
end

else
db.close
google_image(c1, c2)
google_image_banner(c1, c2)
end

rescue Exception => e    
    puts c1+c2
    puts e
    return r0
ensure
    db.close if db


end

end