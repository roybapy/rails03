class AjaxtController < ApplicationController


  def test
    sql2="SELECT banner FROM cityimg where city='Seoul'"
    @d=ActiveRecord::Base.connection.execute(sql2)
puts @d[0][0]


    if @d
   response = @d[0][0]
   status = "ok"

 respond_to do |format|
   msg = { :status => status, :cl => response }
   format.json  { render :json => msg }
 end

 end
  end

  def low
    tname= params[:name0]+"_low"
    sql2="SELECT * FROM #{tname}"
    @d=ActiveRecord::Base.connection.execute(sql2)

 respond_to do |format|

   format.json { render :json => @d }
 end

  end


  def all

    sql2="SELECT * FROM #{params[:name1]} where tripl='#{params[:id1]}'"

    @d=ActiveRecord::Base.connection.execute(sql2)

    a= ActiveSupport::JSON.decode(@d[0]['dp'])
    #a["tripl"] = @d[0]['tripl']



 respond_to do |format|

   format.json { render :json => a }
 end

  end


  def header

    sql2="SELECT banner,slogan from header"
    @d=ActiveRecord::Base.connection.execute(sql2)

 respond_to do |format|

   format.json { render :json => @d }
 end

  end


end
