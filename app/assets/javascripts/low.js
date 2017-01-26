
$(function(){
var myChart;
  $("#canvas0").click(
     function(evt){
         var activePoints = myChart.getElementAtEvent(evt);
         console.log(activePoints.length);
         if (activePoints.length > 0){
        alert(activePoints[0]._model.label);
        alert(activePoints[0]._chart.config.data.datasets[activePoints[0]._datasetIndex].data[activePoints[0]._index])
       }

     }
 );

  $('#show00').click(function(e) {
    var txt = "/ajaxt/"+$(e.target).attr('data');

  alert(txt);

  $.ajax({
   url: txt

 }).done(function( data ) {

          alert(data[0].Date);

          var date = [];
          var price = [];
          var tripl = [];
          for(var i in data){
            date.push(data[i].Date);
            price.push(data[i].Price);
            tripl.push(data[i].Tripl)

          }

          var ctx = $("#canvas0");
           myChart = new Chart(ctx, {
              type: 'bar',
              data: {
                  labels: tripl,
                  datasets: [{
                      label: 'Cheapest price',
                      xAxisID: "x-axis-1",
                      data: price
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
                            barPercentage: 1.5,
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
                  title: {display: true, position: 'top', text:'Lowest price for different trip length - 4 to 30 day round trip' },

                  elements: {rectangle:{ backgroundColor: 'rgba(75, 192, 192, 0.2)', borderWidth: 1, borderColor: 'rgba(75, 192, 192, 1)' }},
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





   });


  });


});
