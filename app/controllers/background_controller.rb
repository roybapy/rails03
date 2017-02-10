require 'ran_today_c.rb'

class BackgroundController < ApplicationController

  def backga

    r0 = check_last_run(params[:c1], params[:c2], params[:c3])
    puts r0
    puts "helloooooooooooooooooooooooooooo"
    puts r0.class

    if r0.nil?
      r0 = [ params[:c3] ]
    end

    if r0[0] != 0
    Delayed::Job.enqueue BackgroundA.new(params[:c1], params[:c2], params[:c3], params[:c4], r0)
    r=["job","submitted"]

    else
      r=["job","ran"]
    end

 respond_to do |format|
   format.json { render :json => r }
 end

  end


  def backgau

  tn= "c_"+params[:c3]+"_"+ params[:c1].gsub(/[\s,|]/ ,"") +"_"+ params[:c2].gsub(/[\s,|]/ ,"")+"_"+ DateTime.now.strftime('%m%d%Y')
#sql="SELECT table_name from information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE' and table_name='#{tn.downcase}'"
sql="select * from scan_result where fname='#{tn}'"

    d=ActiveRecord::Base.connection.execute(sql)
    if d.values.any?
      if d[0]['status'] == "completed"
      r=["yes"]
    else
        r=["no"]
      end
    else
      r=["no"]
    end

 respond_to do |format|
   format.json { render :json => r }
 end

  end

  def backgas
    @c1=params[:c1]; @c2=params[:c2];  @c3=params[:c3];
    sql0="SELECT banner FROM cityimg where city='#{@c2}'"
    @banner=ActiveRecord::Base.connection.execute(sql0)
    nam= "c_"+ @c1.gsub(/[\s,|]/ ,"") +"_"+ @c2.gsub(/[\s,|]/ ,"")+"_"+ DateTime.now.strftime('%m%d%Y')
    @name= nam.downcase
    tn= @name +"_low"
    sql1="SELECT * from #{tn} where tripl='#{@c3}'"
    @d1=ActiveRecord::Base.connection.execute(sql1)
    @d2=ActiveRecord::Base.connection.execute("SELECT count(*) from #{tn}")
    @add_footer = true
  end


end
