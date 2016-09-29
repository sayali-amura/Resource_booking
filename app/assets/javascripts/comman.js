$(document).on('turbolinks:load',function() {
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

     // $('#datepicker').datepicker({
     //  startDate: new Date()
     // });


  });

