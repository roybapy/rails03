
$(function(){


  $('#show0000').click(function(e) {
    var txt = $(e.target).text();
    alert($(e.target).attr('data'));

    alert(txt);


      $.ajax({
   url: "/ajaxt/test0"

 }).done(function( data ) {

          alert(data[0].Date);

          $(e.target).text(data);

          var date = [];
          var price = [];
          for(var i in data){
            date.push(data[i].Date);
            price.push(data[i].Price);

          }

          var ctx = $("#canvas0");
          var myChart = new Chart(ctx, {
              type: 'bar',
              data: {
                  labels: date,
                  datasets: [{
                      label: '# of Votes',
                      data: price,
                      backgroundColor: [
                          'rgba(255, 99, 132, 0.2)',
                          'rgba(54, 162, 235, 0.2)',
                          'rgba(255, 206, 86, 0.2)',
                          'rgba(75, 192, 192, 0.2)',
                          'rgba(153, 102, 255, 0.2)',
                          'rgba(255, 159, 64, 0.2)'
                      ],
                      borderColor: [
                          'rgba(255,99,132,1)',
                          'rgba(54, 162, 235, 1)',
                          'rgba(255, 206, 86, 1)',
                          'rgba(75, 192, 192, 1)',
                          'rgba(153, 102, 255, 1)',
                          'rgba(255, 159, 64, 1)'
                      ],
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
                           display: false
                     }]
                  }
              }
          });





   });


  });


});

//skeleton
/*

$(function(){

$('#show00').click(function(e) {

txt = "ajaxt/header/banner/0"

$.ajax({
url: txt

}).done(function( data ) {


});

});

});

*/
