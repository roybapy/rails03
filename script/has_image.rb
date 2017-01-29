#!/usr/bin/env ruby

def has_img(c1, c2)


begin

#db=PG::Connection.open(:dbname => 'flysuper_development',:user => 'flysuper', :password => 'flysuper')

ActiveRecord::Base.connection.execute("create table if not exists cityimg (city text, thumb text, banner text)")

rs=ActiveRecord::Base.connection.execute("SELECT city FROM cityimg where city='#{c2}'")


if rs.values.any?
rs0=ActiveRecord::Base.connection.execute("SELECT thumb FROM cityimg where city='#{c2}'")
ActiveRecord::Base.connection.execute("update topdeals set imgl='#{rs0[0]['thumb']}' where stop='#{c2}'")

rs1=ActiveRecord::Base.connection.execute("SELECT banner FROM cityimg where city='#{c2}'")


unless rs1.values.any?
puts "inside"
google_image_banner(c1, c2)
end

else

google_image(c1, c2)
google_image_banner(c1, c2)
end

rescue Exception => e
    puts c1+c2
    puts e
    return r0


end

end
