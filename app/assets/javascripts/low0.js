
$(function(){
var myChart;
var myChart0;
  $("#canvas0").click(
     function(evt){
         var activePoints = myChart.getElementAtEvent(evt);

         if (activePoints.length > 0){

         var tripl0 = activePoints[0]._model.label;
         var price0 = activePoints[0]._chart.config.data.datasets[activePoints[0]._datasetIndex].data[activePoints[0]._index];
         var date0 = activePoints[0]._chart.config.data.datasets[1].data[activePoints[0]._index];

         $(".chart-container01").attr('aria-hidden', 'true');
         $(".chart-container01").css('display', 'none');

         if (tripl0 === "4 day trip"){
           $(".0daydiv").attr('aria-hidden', 'true');
           $(".0daydiv").css('display', 'none');
           $(".4daydiv").attr('aria-hidden', 'false');
           $(".4daydiv").css({'display' : ''});

             $("#tog06").text("Show me all available "+tripl0.split(" ")[0]+" day round trip flights for whole year");
             $("#show01").attr('data-tripl', tripl0.split(" ")[0]);
         }else{
           $(".4daydiv").attr('aria-hidden', 'true');
           $(".4daydiv").css('display', 'none');
           $(".0daydiv").attr('aria-hidden', 'false');
           $(".0daydiv").css({'display' : ''});

            $("#tog00").text("Selected cheapest flight for "+tripl0);
            $("#tog01").text("$"+price0);
            $("#tog02").text(date0);
            $("#tog03").text(tripl0.split(" ")[0]+" day round trip");
            $("#tog04").attr('data', date0 );

              $("#tog06").text("Show me all available "+tripl0.split(" ")[0]+" day round trip flights for whole year");
              $("#show01").attr('data-tripl', tripl0.split(" ")[0]);

         }


       }

     }
 );


 $("#canvas01").click(
    function(evt){
        var activePoints = myChart0.getElementAtEvent(evt);

        if (activePoints.length > 0){

        var tripl0 =   $("#show01").attr('data-tripl');
        var price0 = activePoints[0]._chart.config.data.datasets[activePoints[0]._datasetIndex].data[activePoints[0]._index];
        var date0 = activePoints[0]._model.label;


          $(".4daydiv").attr('aria-hidden', 'true');
          $(".4daydiv").css('display', 'none');
          $(".0daydiv").attr('aria-hidden', 'false');
          $(".0daydiv").css({'display' : ''});

          $("#tog00").text("Your selected "+ tripl0+" day round trip flight");
           $("#tog01").text("$"+price0);
           $("#tog02").text(date0);
           $("#tog03").text(tripl0+" day round trip");
            $("#tog04").attr('data', date0 );

      }

    }
);






 $("#hide00").click(
    function(evt){
      $(".chart-container").attr('aria-hidden', 'true');
      $(".chart-container").css('display', 'none');


    }
);

$("#hide01").click(
   function(evt){
     $(".chart-container01").attr('aria-hidden', 'true');
     $(".chart-container01").css('display', 'none');


   }
);


  $('#show00').click(function(e) {

    $(".chart-container").attr('aria-hidden', 'false');
    $(".chart-container").css({'display' : ''});


    var txt = "/ajaxt/"+$(e.target).attr('data');


  $.ajax({
   url: txt

 }).done(function( data ) {

          var date = [];
          var price = [];
          var tripl = [];
          var colorx = [];
          var colory = [];
          for(var i in data){
            date.push(data[i].date);
            price.push(data[i].price);
            tripl.push(data[i].tripl+" day trip")
            colorx.push("rgba(54, 162, 235, 0.2)");
            colory.push("rgba(54, 162, 235, 1)");
          }

          if( date.length > 15 ){
            var barp = 1.6; var titl="Lowest fare for different trip length - 4 to 30 day round trip";
          }else {
            var barp = 1; var titl="Lowest fare for different trip length";
          }



          var ctx = $("#canvas0");
           myChart = new Chart(ctx, {
              type: 'bar',
              data: {
                  labels: tripl,
                  datasets: [{
                      label: 'Hover for details | Click for selection',
                      xAxisID: "x-axis-1",
                      data: price,
                      backgroundColor : colorx,
                      borderColor: colory,
                      borderWidth: 1
                    },{

                      xAxisID: "x-axis-2",
                      data: date

                  }]
              },
              options: {
                  scales: {
                      yAxes: [{
                          ticks: {
                              beginAtZero:true
                          }
                      }],
                      xAxes: [{
                           display: true,
                            barPercentage: barp,
                            categorySpacing: 0,
                            id: "x-axis-1"
                          },
                          {
                            display: false,
                             barPercentage: 0,
                             categorySpacing: 0,
                             id: "x-axis-2"

                     }]
                  },
                  legend: { display: false },
                  title: {display: true, position: 'top',fontSize: 16, text:titl },

                  //elements: {rectangle:{ backgroundColor: 'rgba(75, 192, 192, 0.2)', borderWidth: 1, borderColor: 'rgba(75, 192, 192, 1)' }},
                  tooltips: {
                     callbacks: {
                 label: function(tooltipItems, data) {

                    // return data.datasets[tooltipItems.datasetIndex].label +':' + tooltipItems.yLabel + ' €';
                    return ' '+tooltipItems.xLabel +' :' + ' $'+ tooltipItems.yLabel;
                 },
                 title: function(tooltipItems, data) {

                   return data.datasets[1].data[tooltipItems[0].index];

                 }



             }

         }







              }
          });




              adata = myChart.data.datasets[0].data
              amin = Math.min.apply( Math, adata );

              myChart.data.datasets[0].backgroundColor[adata.indexOf(amin)]="rgba(255, 99, 132, 0.2)";
              myChart.data.datasets[0].borderColor[adata.indexOf(amin)]="rgba(255,99,132,1)";

              bdata = myChart.data.datasets[1].data
              var now = new Date();

                  for(var i in bdata){

                    var di = new Date(bdata[i].split("-")[0]);
                    if ((di.getMonth()-now.getMonth()) < 3 && (di.getMonth()-now.getMonth()) >= 0)


                    { if( i != adata.indexOf(amin)  ){

                        p=adata[i];

                        if ((((p-amin)/amin)*100) < 5 ){

                          myChart.data.datasets[0].backgroundColor[i]="rgba(255, 99, 132, 0.2)";
                          myChart.data.datasets[0].borderColor[i]="rgba(255,99,132,1)";
                        }
                    }
                     }
                  }

               myChart.update();



   });


  });






  $('#show01').click(function(e) {

    $(".chart-container01").attr('aria-hidden', 'false');
    $(".chart-container01").css({'display' : ''});

    var tripl = $(e.target).attr('data-tripl');
    $(".chart-container01").attr('aria-hidden', 'false');
    $(".chart-container01").css({'display' : ''});

    var txt = "/ajaxt/"+$(e.target).attr('data')+"/"+$(e.target).attr('data-tripl');



  $.ajax({
   url: txt

 }).done(function( data ) {


          var date = [];
          var price = [];
          var colorx = [];
          var colory = [];
          var ctitle= tripl+" day round trip flight price for whole year";


          for (var key in data) {
                   if (data.hasOwnProperty(key)) {

                  date.push(key);
                  price.push(data[key]);

                  colorx.push("rgba(54, 162, 235, 0.2)");
                  colory.push("rgba(54, 162, 235, 1)");
          }
          }


          var ctx = $("#canvas01");
           myChart0 = new Chart(ctx, {
              type: 'bar',
              data: {
                  labels: date,
                  datasets: [{
                      label: 'Hover for details | Click for selection',

                      data: price,
                      backgroundColor : colorx,
                      borderColor: colory,
                      borderWidth: 1


                  }]
              },
              options: {
                  scales: {
                      yAxes: [{
                          ticks: {
                              beginAtZero:true
                          }
                      }],
                      xAxes: [{
                           display: true,


                     }]
                  },
                  legend: { display: true },
                  title: {display: true, position: 'top',fontSize: 14, text:ctitle },

                  //elements: {rectangle:{ backgroundColor: 'rgba(75, 192, 192, 0.2)', borderWidth: 1, borderColor: 'rgba(75, 192, 192, 1)' }},
                  tooltips: {
                     callbacks: {
                 label: function(tooltipItems, data) {


                    return ' Price'+' :' + ' $'+ tooltipItems.yLabel;
                 },



             }

         }







              }
          });




              adata = myChart0.data.datasets[0].data
              amin = Math.min.apply( Math, adata );

              myChart0.data.datasets[0].backgroundColor[adata.indexOf(amin)]="rgba(255, 99, 132, 0.2)";
              myChart0.data.datasets[0].borderColor[adata.indexOf(amin)]="rgba(255,99,132,1)";

               myChart0.update();



   });


  });


});
