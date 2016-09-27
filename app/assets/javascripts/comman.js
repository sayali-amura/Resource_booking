$(document).on('turbolinks:load',function() {
    $('#booking_resource_id').change(function() {
      resource_name = $("#booking_resource_id option:selected").text(),
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
      resource_name = $("#booking_resource_id option:selected").text(),
      date_of_booking = $("#booking_date_of_booking").val(),
        $.get(
          "/booking_date_slots/"+resource_name+"/date_of_booking="+date_of_booking,
           function(data,success) {
             console.log(data);
             $("#booking_slot").html(data.replace(/[\t\n\\]+/g,''));
           }
        );
    });


  });

