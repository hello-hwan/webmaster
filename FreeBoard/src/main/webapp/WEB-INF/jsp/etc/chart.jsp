<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    
      var chartData=[['Writer','Count per Writer']];
      
      fetch('countByWriter.do') //서버에 데이터 요청하고 비동기 방식(순서대로 x)
      .then(resolve => resolve.json())
      .then(result => {
    	  console.log(result);
    	  result.forEach((row) => {
    		  chartData.push([row.member_name,row.count])
    	  });
    	  google.charts.load('current', {'packages':['corechart']});
          google.charts.setOnLoadCallback(drawChart);
    	  //console.log(chartData);
      })
      .catch(err => console.log(err))
      
      
      function drawChart() {
    	  
        var data = google.visualization.arrayToDataTable(chartData
        		/*[
        	
          ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        	
        ]*/
        		);
        
        var options = {
          title: '사용자별 게시글 현황'
        };
        
        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        
        chart.draw(data, options);
      }
    </script>
  </head>
  <body>
    <div id="piechart" style="width: 900px; height: 500px;"></div>
  </body>
</html>