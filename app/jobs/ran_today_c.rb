#!/usr/bin/env ruby

def check_last_run(c1, c2, c3)


begin

r0 = [0]

ActiveRecord::Base.connection.execute("create table if not exists scan_result (fname text, perl int, tripl int, status text, stime timestamp)")

base = c1.gsub(/[\s,|]/ ,"") + "_" + c2.gsub(/[\s,|]/ ,"") + "_" + DateTime.now.strftime('%m%d%Y')
fname= "c_" + c3+ "_" + base

c3=c3.to_i
rs=ActiveRecord::Base.connection.execute("SELECT fname FROM scan_result WHERE fname = '#{fname}'")

if rs.values.any?
r0=[0]

else

  rs=ActiveRecord::Base.connection.execute("SELECT fname FROM scan_result WHERE fname like '%#{base}%'")

  if rs.values.any?
    fname= "c_" + base.downcase + "_low"

    rs=ActiveRecord::Base.connection.execute("SELECT tripl FROM #{fname} WHERE tripl = #{c3}")
     if rs.values.any?
          r0=[0]

     else
      if c3 > 2; sql="SELECT tripl FROM #{fname} WHERE tripl = #{c3-1} or tripl = #{c3+1}"
      else sql="SELECT tripl FROM #{fname} WHERE tripl = #{c3+1}"
      end
      rs=ActiveRecord::Base.connection.execute(sql)

      r0 = []
      if rs.values.any?
      if c3 > 2; unless rs.values[0].include? c3-1;  r0.push(c3-1); end; end
      r0.push(c3)
      unless rs.values[0].include? c3+1;  r0.push(c3+1); end
      else
        if c3 > 2; r0=[c3-1, c3, c3+1]; else r0=[c3, c3+1]; end
      end

     end

   else
    if c3 > 2; r0=[c3-1, c3, c3+1]; else r0=[c3, c3+1]; end

  end


end

return r0

rescue Exception => e
    puts c1+c2
    puts e


end

end
