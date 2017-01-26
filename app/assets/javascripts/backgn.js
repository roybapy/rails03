$(function(){

$('#backgnav').click(function(e) {

if ( $("#detailroot").length ){

window.open( "/" ,"_self");

}


if ($("#head00").attr('aria-hidden') == "false" ){

  $("#head00").attr('aria-hidden', 'true');
  $("#head00").css('display', 'none');
  $("#head01").attr('aria-hidden', 'false');
  $("#head01").css({'display' : ''});


function saverun(ca, cb){
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




if (sessionStorage.getItem("running") != null){

    console.log(sessionStorage.getItem("running"));

    $("#progress00").attr('aria-hidden', 'false');
    $("#progress00").css({'display' : ''});
    $("#backg00").attr('aria-hidden', 'true');
    $("#backg00").css('display', 'none');


var ca = sessionStorage.getItem("running").split("-");

  txt0= "backgau/"+ ca[0] +"/"+ ca[1]+"/"+ ca[2];
  txt1= "backgas/"+ ca[0] +"/"+ ca[1]+"/"+ ca[2];

    $("#backg01").val(ca[0]);
    $("#backg02").val(ca[1]);
    $("#backg03").val(ca[2]);


    $.ajax({ url: txt0, success: function(data){

       if (data[0]=="no"){  }
       else  {sessionStorage.removeItem("running");

       if (sessionStorage.getItem("ran") == null){
          sessionStorage.setItem("ran",  ca[0]+"-"+ ca[1]);
        }else{
            saverun(ca[0], ca[1]);

        }

        window.open( txt1 ,"_self"); }

    }, dataType: "json"});



  (function poll(){
     setTimeout(function(){
        $.ajax({ url: txt0, success: function(data){


           if (data[0]=="no"){   poll();  }
           else  {sessionStorage.removeItem("running");

           if (sessionStorage.getItem("ran") == null){
              sessionStorage.setItem("ran",  ca[0]+"-"+ ca[1]);
            }else{
                saverun(ca[0], ca[1]);


            }


            window.open( txt1 ,"_self"); }

        }, dataType: "json"});
    }, 30000);
  })();




}


//




if ( !$("#detailroot").length ){
if (sessionStorage.getItem("ran") != null){

    console.log(sessionStorage.getItem("ran"));

var cl=sessionStorage.getItem("ran").split("%%");

for (var i in cl) {
var cb = cl[i].split("-");

  txt2= "backglist/"+ cb[0] +"/"+ cb[1];

  console.log(cb[0]);   console.log(cb[1]);

  $.ajax({ url: txt2, success: function(data){

            //  console.log(data);

        }});

}
}
}







}

});

});
