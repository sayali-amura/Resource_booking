// This script functionalities to booking form and company registering form.

$(document).on('turbolinks:load',function() {

  // This function is used to make ajax call to server. It supplies all the slots related to resource 
    $('#booking_resource_id').change(function() {
      resource_name = $("#booking_resource_id option:selected").text();
      //alert(resource_name),
        $.get(
          "/resource_time_slot/"+resource_name,
           function(data,success) {
             console.log(data);
             $("#booking_slot").html(data.replace(/[\t\n\\]+/g,''));
           }
        );
    });

    // This used to list all the available time slots corresponding to resource. This function makes makes ajax call to server.
    //   In the request selected date_of_booking and resource are passed.
     $('#booking_date_of_booking').change(function() {
      date_of_booking = new Date($("#booking_date_of_booking").val());
      present_date = new Date();
      if (date_of_booking.getDate() >= present_date.getDate() && date_of_booking.getMonth() >= present_date.getMonth() && date_of_booking.getFullYear() >= present_date.getFullYear() ) 
      {
        resource_name = $("#booking_resource_id option:selected").text();
          $.get(
            "/booking_date_slots/"+resource_name+"/date_of_booking="+$("#booking_date_of_booking").val(),
             function(data,success) {
               console.log(data);
               $("#booking_slot").html(data.replace(/[\t\n\\]+/g,''));
             }
          );
      }
      else
      {
        $("#form-errors").html("<div class='alert alert-danger'> Select valid date</div>");
      }
    });


  // Used to initialize variables to point to div ids
    var telInput = $("#go"),
      errorMsg = $("#error-msg"),
      validMsg = $("#valid-msg");

    // initialise intl-tel-input plugin

    telInput.intlTelInput({
    });

    var reset = function() {
      telInput.removeClass("error");
      errorMsg.addClass("hide");
      validMsg.addClass("hide");
    };

    // on blur: validate
    telInput.blur(function() {
      reset();
      if ($.trim(telInput.val())) {
        if (telInput.intlTelInput("isValidNumber")) {
          validMsg.removeClass("hide");
        } else {
          telInput.addClass("error");
          errorMsg.removeClass("hide");
        }
      }
    });

  // After the form submit event occurs, contry code and phone number is concaneted and value is set to hidden field company[phone]
  // and this field is submitted to server.
    $("form").submit(function(e) {
       $("#hidden").val($("#go").intlTelInput("getNumber"));
       if (!telInput.intlTelInput("isValidNumber")){
          e.preventDefault();
          alert("Phone number is not valid.");
       }
    });

  });

