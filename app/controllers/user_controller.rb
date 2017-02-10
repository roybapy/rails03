class UserController < ApplicationController

  def profile
  @slist=[]
sql="select ran from users where id= #{params[:id]}"
rs=ActiveRecord::Base.connection.execute(sql)
if rs[0]['ran'] != nil
ra=rs[0]['ran'].split('%%')

ra.each do |x|
slist0=[];
rb= x.gsub(/[\s,|]/ ,"").gsub("-","_").downcase
rc = "c_" + rb + "_" + DateTime.now.strftime('%m%d%Y')
rd = x.split('-')

puts rc


sql="SELECT table_name FROM information_schema.tables WHERE table_name='#{rc}'"
rs1=ActiveRecord::Base.connection.execute(sql)

sql="SELECT thumb FROM cityimg where city='#{rd[1]}'"
rs3=ActiveRecord::Base.connection.execute(sql)

if rs1.values.any?
  sql="SELECT tripl, date, price from #{rc}_low order by price limit 1"
  rs2=ActiveRecord::Base.connection.execute(sql)

slist0.push( rs1[0]['table_name'], rd[0], rd[1], rs2[0]['tripl'], rs2[0]['date'], rs2[0]['price'], rs3[0]['thumb'])
@slist << slist0
else
  sql= "SELECT table_name FROM information_schema.tables WHERE table_name like '%#{rb}%'"
  rs2=ActiveRecord::Base.connection.execute(sql)
  if rs2.values.any?
    sql="SELECT tripl, date, price from #{rs2[0]['table_name']}_low order by price limit 1"
    rs4=ActiveRecord::Base.connection.execute(sql)

    slist0.push( rs2[0]['table_name'], rd[0], rd[1], rs4[0]['tripl'], rs4[0]['date'], rs4[0]['price'], rs3[0]['thumb'])
    @slist << slist0


    fname= "d_" + rs4[0]['tripl'].to_s + "_" + rd[0] + "_" + rd[1]
    rs6=ActiveRecord::Base.connection.execute("select fname, stime from scan_result where fname= '#{fname}'")
    if  rs6.values.empty?

    rs5=ActiveRecord::Base.connection.execute( "SELECT tripl from #{rs2[0]['table_name']}_low")
    Delayed::Job.enqueue BackgroundB.new( rd[0], rd[1], rs4[0]['tripl'].to_s, current_user.id, rs5.values.flatten)

    ActiveRecord::Base.connection.execute("INSERT INTO scan_result (fname, status, stime) VALUES( '#{fname}' , 'started', '#{DateTime.now}')")

    flash[:notice] = "Flight data is being updated..."
    else
      unless  rs6.values[0][1].nil?
        ta = DateTime.now ;  tb = Time.parse(rs6.values[0][1]);
        if ta-tb > 86400
          rs5=ActiveRecord::Base.connection.execute( "SELECT tripl from #{rs2[0]['table_name']}_low")
          Delayed::Job.enqueue BackgroundB.new( rd[0], rd[1], rs4[0]['tripl'].to_s, current_user.id, rs5.values.flatten)

          ActiveRecord::Base.connection.execute("INSERT INTO scan_result (fname, status, stime) VALUES( '#{fname}' , 'started', '#{DateTime.now}')")

          flash[:notice] = "Flight data is being updated..."

        end

      end

    end

  else
        a4 = [4]
      fname= "d_" + "4" + "_" + rd[0] + "_" + rd[1]
      rs6=ActiveRecord::Base.connection.execute("select fname, stime from scan_result where fname= '#{fname}'")
      if  rs6.values.empty?

      Delayed::Job.enqueue BackgroundB.new( rd[0], rd[1], "4", current_user.id, a4)

      ActiveRecord::Base.connection.execute("INSERT INTO scan_result (fname, status, stime) VALUES( '#{fname}' , 'started', '#{DateTime.now}')")
      flash[:notice] = "Flight data is being updated..."
      else
        unless  rs6.values[0][1].nil?
          ta = DateTime.now ;  tb = Time.parse(rs6.values[0][1]);

          if ta-tb > 86400
            Delayed::Job.enqueue BackgroundB.new( rd[0], rd[1], "4", current_user.id, a4)

            ActiveRecord::Base.connection.execute("INSERT INTO scan_result (fname, status, stime) VALUES( '#{fname}' , 'started', '#{DateTime.now}')")
            flash[:notice] = "Flight data is being updated..."

          end

        end

      end

  end
end

end
end

@add_footer = true
  end


def udetails

    @add_footer = true
    @c1=params[:c1]; @c2=params[:c2];  @c3=params[:c3];
    sql0="SELECT banner FROM cityimg where city='#{@c2}'"
    @banner=ActiveRecord::Base.connection.execute(sql0)

    rb = @c1.gsub(/[\s,|]/ ,"") + "_" + @c2.gsub(/[\s,|]/ ,"")
    rc = "c_" + rb + "_" + DateTime.now.strftime('%m%d%Y')

    sql="SELECT table_name FROM information_schema.tables WHERE table_name='#{rc.downcase}'"
    rs1=ActiveRecord::Base.connection.execute(sql)

    if rs1.values.any?
    @name= rc.downcase
    tn= @name + "_low"
    sql1="SELECT * from #{tn} where tripl='#{@c3}'"
    @d1=ActiveRecord::Base.connection.execute(sql1)
    @d2=ActiveRecord::Base.connection.execute("SELECT count(*) from #{tn}")

    else
    sql= "SELECT table_name FROM information_schema.tables WHERE table_name like '%#{rb.downcase}%'"
    rs2=ActiveRecord::Base.connection.execute(sql)
    if rs2.values.any?
      @name= rs2[0]['table_name']
      tn= @name + "_low"
      sql1="SELECT * from #{tn} where tripl='#{@c3}'"
      @d1=ActiveRecord::Base.connection.execute(sql1)
      @d2=ActiveRecord::Base.connection.execute("SELECT count(*) from #{tn}")

    end

  end


end



end
