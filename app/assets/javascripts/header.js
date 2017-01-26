
$(function(){

if( $('#header00').length && $('#head00').attr('aria-hidden') == "false" ) {

  setTimeout(function(){

  txt = "ajaxt/header/banner/0"


  $.ajax({
   url: txt

 }).done(function( data ) {


          var img = [];
          var head = [];
          var shead = [];
          for(var i in data){
            a=data[i].slogan.split("|");
            img.push(data[i].banner);
            head.push(a[0]);
            shead.push(a[1]);

          }

          var counter = 0;

          function changeBg() {
    s0="url("+img[counter]+")";
    $('#header00').css('background-image', s0);
    $('#header01').text(head[counter]); $('#header02').text(shead[counter]);
    $('#header00').fadeIn(1000);
    counter++;
    if (counter >= img.length ){counter=0;}
}

function changeBackgroundSmoothly() {
    $('#header00').fadeOut(1000, changeBg);
}

setInterval(changeBackgroundSmoothly,10000);


         /*
          var clickaway = function go(){
           $("#header00").fadeOut(1, function(){

          s0="url("+img[counter]+")";

          $("#header00").css("background-image", s0);
          counter++;
          if (counter >= img.length ){counter=0;}
          $("#header00").fadeIn(1).delay(10000);
            go();
         });

       }  //go

        clickaway();

        */

/*
        var clickaway = function go(){

          $('#header00').fadeOut(3, function(){

            s0="url("+img[counter]+")";

      $('#header00').css("background-image", s0).bind('onreadystatechange load', function(){
          alert("hello");
      });
      $('#header01').text(head[counter]); $('#header02').text(shead[counter]);

      $('#header00').fadeIn(3).delay(10000);
      counter++;
      if (counter >= img.length ){counter=0;}
      go();

   });



     }  //go

      clickaway();
*/








   });

 }, 1000);

}

});
