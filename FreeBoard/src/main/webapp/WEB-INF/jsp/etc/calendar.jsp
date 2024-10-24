<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<script src='./dist/index.global.js'></script>
<script>

  //document.addEventListener('DOMContentLoaded', function() {
  document.addEventListener('DOMContentLoaded', async function() {
	  //async는 await를 적용하기 위하여 사용
    var calendarEl = document.getElementById('calendar');
	  
    //Ajax 호출.
    //new Promise(성공function(){},실패function(){}})
    //프라미스 객체가 반활될 때 await 수행코드. - 기다렸다가 그다음코드 실행.
    var eventData=[];
    let resolve = await fetch('eventList.do')   //fetch('eventList.do')
    let result = await resolve.json();          //.then(resolve = > resolve.json();)
    eventData = result;                         //.then(result => {
    	                                        //eventData = result;
                                                //})
                                                //.catch(err => console.log(err);)
    
    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      initialDate: '2024-10-12',
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectMirror: true,
      select: function(arg) {
        var title = prompt('Event Title:');
        if (title) {
        	console.log(arg);
        	fetch('addEvent.do?job=add&title='+title+'&start=?&end=?')
        	.then(resolve => resolve.json())
        	.then(result => {
        		if(result.retCode == "OK"){
        			
        		}
        		
        		eventData = result;
        	})
        	.catch(err => console.log(err))
        	
          calendar.addEvent({
            title: title,
            start: arg.start,
            end: arg.end,
            allDay: arg.allDay
          })
        }
        calendar.unselect()
      },
      eventClick: function(arg) {
        if (confirm('Are you sure you want to delete this event?')) {
          arg.event.remove()
        }
      },
      editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: eventData // 배열데이터 담을 변수
    });

    calendar.render(); //출력
  });

</script>
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }

</style>
</head>
<body>

  <div id='calendar'></div>

</body>
</html>
