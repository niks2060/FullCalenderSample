<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Calender.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="fullcalendar.css" rel="stylesheet" />
    <script src="lib/moment.min.js"></script>
    <script src="lib/jquery.min.js"></script>
    <script src="fullcalendar.js"></script>
    <script type="text/javascript">

        $(function () {

            $.ajax({
                type: 'POST',
                url: 'index.aspx/GetEvents',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: {},
                success: function (data) {
                    var events = new Object();
                    events = $.map(data.d, function (item, i) {
                        for (var j = 0; j < data.d.length; j++) {
                            var event = new Object();
                            event.id = item.CId;
                            var startDate = Date.parse(item.StartDate)
                            event.start = startDate + 8.64e+7;
                            var endDate = Date.parse(item.ToDate);
                            event.end = endDate + 8.64e+7;
                            event.title = item.EventName;
                            event.backgroundColor = "#c6458c";
                            event.description = item.EventDiscription;
                            return event;
                        }
                    })
                    callCalender(events);
                },
                error: function (e) {
                    debugger;
                }

            });
        });


        function callCalender(events) {
            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'year,month,agendaWeek,agendaDay'
                },
                defaultDate: '2018-11-12',
                defaultView: 'year',
                yearColumns: 4,
                // selectable: true,
                selectHelper: true,
                //select: function (start, end) {
                //    var title = prompt('Event Title:');
                //    var eventData;
                //    if (title) {
                //        eventData = {
                //            title: title,
                //            start: start,
                //            end: end
                //        };
                //        $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
                //    }
                //    $('#calendar').fullCalendar('unselect');
                //},
                firstDay: 0,
                // editable: true,
                eventLimit: true, // allow "more" link when too many events
                //eventRender: function (event, element, view) {
                //    if (format(event._start._d, 'MM') !== format(view.start._d, 'MM')) {
                //        return false;
                //    }
                //},
                eventSources: [events],
                eventMouseover: function (calEvent, jsEvent) {
                    $(jsEvent.target).css('cursor', 'pointer');
                    var tooltip;
                    if (calEvent.end == null)
                        tooltip = '<div class="tooltipevetn" style="border:1px solid white;text-align:center;padding:5px;border-radius:30%;color:white;background-color:' + calEvent.backgroundColor + ';width:200px;cursor:pointer;position:absolute;z-index:10001;"><b>Holiday:</b><br/><p style="text-align:center">' + calEvent.description + '</p><p style="text-align:center"> Start Date : ' + format(calEvent._start._d, 'dd-MM-yyyy') + '</p><p style="text-align:center"> End Date : ' + format(calEvent._start._d, 'dd-MM-yyyy') + '</p></div>';
                    else
                        tooltip = '<div class="tooltipevetn" style="border:1px solid white;text-align:center;padding:5px;border-radius:30%;color:white;background-color:' + calEvent.backgroundColor + ';width:200px;cursor:pointer;position:absolute;z-index:10001;"><b>Holiday: </b><br/><p style="text-align:center">' + calEvent.description + '</p><p style="text-align:center"> Start Date : ' + format(calEvent._start._d, 'dd-MM-yyyy') + '</p><p style="text-align:center"> End Date : ' + format(calEvent._end._d, 'dd-MM-yyyy') + '</p></div>';

                    $("body").append(tooltip);
                    $(this).mouseover(function (e) {
                        $(this).css('z-index', 100001);
                        $('.tooltipevetn').fadeIn('500');
                        $('.tooltipevetn').fadeTo('10', 1.9);
                    }).mousemove(function (e) {
                        $('.tooltipevetn').css('top', e.pageY - 150);
                        $('.tooltipevetn').css('left', e.pageX - 100);
                    });
                },
                eventMouseout: function (calEvent, jsEvent) {
                    $(this).css('z-index', 8);
                    $('.tooltipevetn').remove();
                }
            });
        }

        var format = function (time, format) {
            var t = new Date(time);
            var tf = function (i) { return (i < 10 ? '0' : '') + i };
            return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function (a) {
                switch (a) {
                    case 'yyyy':
                        return tf(t.getFullYear());
                        break;
                    case 'MM':
                        return tf(t.getMonth() + 1);
                        break;
                    case 'mm':
                        return tf(t.getMinutes());
                        break;
                    case 'dd':
                        return tf(t.getDate() - 1);
                        break;
                    case 'HH':
                        return tf(t.getHours());
                        break;
                    case 'ss':
                        return tf(t.getSeconds());
                        break;
                }
            })
        }
    </script>
    <style>
        body {
            margin: 40px 10px;
            padding: 0;
            font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
            font-size: 14px;
        }

        #calendar {
            max-width: 1280px;
            margin: 0 auto;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div id='calendar'></div>
    </form>
</body>
</html>
