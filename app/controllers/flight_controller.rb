class FlightController < ApplicationController
  def index
#  @flight=Topdeal.order(:price)
sql="SELECT * FROM topdeals ORDER BY topdeals.price ASC"
@flight=ActiveRecord::Base.connection.execute(sql)
  end

  def details
#        @detail=Topdeal.where(start: params[:name])

@name=params[:name]
sql0="SELECT * FROM alldeals where name='#{params[:name]}' order by price"
detail0=ActiveRecord::Base.connection.execute(sql0)
@detail=detail0.values

sql1="SELECT banner FROM cityimg where city='#{params[:city]}'"
@banner=ActiveRecord::Base.connection.execute(sql1)

  end


  def backglist
    @c10=params[:c1]; @c20=params[:c2];
    sql0="SELECT thumb FROM cityimg where city='#{@c20}'"
    @thumb=ActiveRecord::Base.connection.execute(sql0)
    nam= "c_"+ @c10.gsub(/[\s,|]/ ,"") +"_"+ @c20.gsub(/[\s,|]/ ,"")+"_"+ DateTime.now.strftime('%m%d%Y')
    @name= nam.downcase
    tn= @name +"_low"


    sql1="SELECT * from #{tn} order by price limit 1"
    @d10=ActiveRecord::Base.connection.execute(sql1)

    msg=["ok"]
    respond_to do |format|
      format.js
      format.json  { render :json => msg }
    end

  end



    def test
      sql2="SELECT banner FROM cityimg where city='Seoul'"
      @test00=ActiveRecord::Base.connection.execute(sql2)
    end



end
