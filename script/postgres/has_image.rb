#!/usr/bin/env ruby

def has_img(c1, c2)

puts c1
puts c2

begin

db=PG::Connection.open(:dbname => 'flysuper_development',:user => 'flysuper', :password => 'flysuper')

db.exec("create table if not exists cityimg (city text, thumb text, banner text)")

rs=db.exec("SELECT city FROM cityimg where city='#{c2}'")

puts rs

if rs.values.any?
rs0=db.exec("SELECT thumb FROM cityimg where city='#{c2}'")
db.exec("update topdeals set imgl='#{rs0[0]['thumb']}' where stop='#{c2}'")

rs1=db.exec("SELECT banner FROM cityimg where city='#{c2}'")
db.close


unless rs1.values.any?
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