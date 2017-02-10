
$(function(){



$('#backg00').click(function(e) {

var ca = $(e.target).attr('data-ca');
var cb = $(e.target).attr('data-cb');
var cu = $(e.target).attr('data-cu');
var cc = $('#backg03').val();
if (!cc){ cc="4"  }

function saverun(){
  var cl=sessionStorage.getItem("ran").split("%%");
  var cla= ca+"-"+cb;
  ssr=false;
  for (var j=0; j<cl.length; j++) {
   if (cl[j] == cla) {ssr=true; break;}
  }

  if (!ssr){
  var ss=sessionStorage.getItem("ran") +"%%"+ ca+"-"+cb;
      sessionStorage.removeItem("ran");
      sessionStorage.setItem("ran", ss);
    }
}



if ( ca && cb ){

    $("#progress00").attr('aria-hidden', 'false');
    $("#progress00").css({'display' : ''});
    $("#backg00").attr('aria-hidden', 'true');
    $("#backg00").css('display', 'none');

txt = "backga/"+ ca +"/"+ cb +"/"+ cc +"/"+ cu;
txt0= "backgau/"+ ca +"/"+ cb+"/"+ cc;
txt1= "backgas/"+ ca +"/"+ cb+"/"+ cc;
console.log(txt);

$.ajax({
url: txt

}).done(function( data ) {

  if (data[1] == "submitted"){

    sessionStorage.setItem("running", ca+"-"+cb+"-"+cc);
         var i = 0;
    (function poll(){
       setTimeout(function(){
          $.ajax({ url: txt0, success: function(data){

              console.log(i);
        if( i < 15){
            i++;
             if (data[0]=="no"){   poll();  }
             else {
                  sessionStorage.removeItem("running");
               if (sessionStorage.getItem("ran") == null){
                  sessionStorage.setItem("ran", ca+"-"+cb);
                }else{

                  saverun();

                }

                window.open( txt1 ,"_self");}
           }
          }, dataType: "json"});
      }, 5000);
    })();

    if (i == 15){ console.log("Server is busy")}


}else {
   if (sessionStorage.getItem("ran") == null){
     sessionStorage.setItem("ran", ca+"-"+cb);
   }else{
     saverun();
   }
   window.open( txt1 ,"_self")
}

});
}
else {

$('#searchh1').after("<div class='alert alert-alert'> <a href='#' data-dismiss='alert' class='close'>×</a><ul> <li> Make a selection from the drop down suggestions list </li> </ul> </div>");

}






});

});
