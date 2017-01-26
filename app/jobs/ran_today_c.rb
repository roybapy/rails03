#!/usr/bin/env ruby

def check_last_run(c1, c2, c3)


begin

r0="do not run"


fname= "c_"+c3+"_"+ c1.gsub(/[\s,|]/ ,"") +"_"+ c2.gsub(/[\s,|]/ ,"")+"_"+ DateTime.now.strftime('%m%d%Y')
rs=ActiveRecord::Base.connection.execute("SELECT fname FROM scan_result WHERE fname = '#{fname}'")

if rs.values.any?
r0="do not run"

else
fname="c_"+c3+"_"+ c1.gsub(/\s+/, "") +"_"+ c2.gsub(/\s+/, "")+"_"+ (Date.today-1).strftime('%m%d%Y')
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
