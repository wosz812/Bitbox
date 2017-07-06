 $(document).ready(
            function() {

               var date = new Date();
               var d = date.getDate();
               var m = date.getMonth();
               var y = date.getFullYear();

               $.getJSON('/bitbox/getCalendar',
                     function(data) {
                        var calendar = $('#calendar').fullCalendar({
                           header : {
                              left : 'prev,next today',
                              center : 'title',
                              right : 'month,agendaWeek,agendaDay'
                      
                          },                           
                          events : data,
                          editable:false
                        });
                     });
            });