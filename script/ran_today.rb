#!/usr/bin/env ruby

def scan_database(c1, c2)


begin

#db=PG::Connection.open(:dbname => 'flysuper_development',:user => 'flysuper', :password => 'flysuper')

r0="do not run"

ActiveRecord::Base.connection.execute("create table if not exists scan_result (fname text, perl int, tripl int, status text, stime timestamp)")
#ActiveRecord::Base.connection.execute("INSERT INTO scan_result VALUES( '#{fname}' , 30 )")


fname= c1.gsub(/[\s,|]/ ,"") +"_"+ c2.gsub(/[\s,|]/ ,"")+"_"+ DateTime.now.strftime('%m%d%Y')
rs=ActiveRecord::Base.connection.execute("SELECT fname FROM scan_result WHERE fname = '#{fname}'")

if rs.values.any?
r0="do not run"

else
fname= c1.gsub(/\s+/, "") +"_"+ c2.gsub(/\s+/, "")+"_"+ (Date.today-1).strftime('%m%d%Y')
ActiveRecord::Base.connection.execute("DELETE FROM scan_result WHERE fname = '#{fname}'")

r0="run"

end

return r0

rescue Exception => e
    puts c1+c2
    puts e
    return r0



end

end
