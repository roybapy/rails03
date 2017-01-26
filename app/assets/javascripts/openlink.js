
$(function(){
  $(".card-link").click(
     function(e){


        var t=$(e.target).attr('data')

          da=t.split("-")
          var date =[];

// google 2017-02-06
//var d = new Date("nov 5 2017").toISOString().slice(0,10);

var now = new Date();
for (i in da){
var dda = new Date(da[i]); if (dda.getMonth() < now.getMonth()){ da[i]= da[i]+" "+(now.getFullYear()+1) }
else{ da[i]= da[i]+" "+ now.getFullYear()}

//momondo 30-10-2017
date[i]=new Date(da[i]).
toLocaleString('en-us', {year: 'numeric', month: '2-digit', day: '2-digit'}).
replace(/(\d+)\/(\d+)\/(\d+)/, '$2-$1-$3');

}


  port=$("#detailroot").attr('data').split("-");
  //console.log(port[0]);
  //console.log(port[1]);
  //console.log(date[0]);
  //console.log(date[1]);



url="http://www.momondo.com/flightsearch/?Search=true&TripType=2&SegNo=2&SO0="+port[0]+"&SD0="+port[1]+"&SDP0="+
date[0]+"&SO1="+port[1]+"&SD1="+port[0]+"&SDP1="+date[1]+"&AD=1&TK=ECO&DO=false&NA=true";
        var win = window.open(url, '_blank');
            //win.focus();



     }
 );
 });
