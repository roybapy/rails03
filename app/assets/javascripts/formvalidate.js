
$(function(){

  $.validator.setDefaults({
    submitHandler: function() {

    var fd =  $( 'form' ).serializeArray();

      $.ajax({
    type: 'POST',
    url: 'usermsg',
    data: fd,
    success: function(msg){

        $('#showmsg').after("<div class='alert alert-success'> <a href='#' data-dismiss='alert' class='close'>×</a><ul> <li> Your message has been delivered. Thank you! </li> </ul> </div>");
    }
});

    }
  });


  $('#contact-form').validate({

      rules: {
          name: {
              minlength: 2,
              required: true
          },
          email: {
              required: true,
              email: true
          },
          phone: {
            minlength: 10,
            required: true
          },
          message: {
              minlength: 2,
              required: true
          }
      },
      highlight: function (element) {
          $(element).closest('.control-group').removeClass('success').addClass('has-error');
      },
      success: function (element) {
          element.addClass('valid')
              .closest('.control-group').removeClass('has-error').addClass('has-success');
      }
  });

});
