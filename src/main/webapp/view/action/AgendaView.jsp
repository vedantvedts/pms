<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html charset=ISO-8859-1">
<!--JQUERY JS  -->
<script src="./webjars/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
 @media print {
  #printPageButton {
    display: none;
  }
}
@page {
  margin: -6mm 25mm 25mm 25mm; }
 </style>  

  
<%
Object[] obj=(Object[])request.getAttribute("Content");
%>   
</head>
<body>
<div align="center" style="margin-top: 30px;">
<b id="iditemspec" style="font-size:18px " ></b>
						<b id="Spec" style="font-size:18px " ></b>
                       <b id="action" style="font-size:18px " ></b><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<div>
<label style="text-decoration: underline; font-weight: bolder;font-size: larger;">Content</label><br>
<%=obj[1] %></div>
<hr>

<input type="button"  class="btn btn-info btn-xs center-block"   id="printPageButton" value="Print" onClick="window.print()">
</div>
<script type="text/javascript">
$("button").click(function(){
	  $("a").remove();
	});
	
$(document).ready(function(){
		    var minutesidadd ="<%=obj[2]%>";
		    var agendasubidadd="<%=obj[4]%>";
		    var scheduleagendaidadd="<%=obj[3]%>";
		    var unitidadd="<%=obj[5]%>";
		    var typeadd="<%=obj[6]%>";
		    var specall;
		    var type;
		    if(typeadd=='A'){
		    	type="(Action Task)";
		    }else if(typeadd=='I'){
		    	type="(Issue Task)";
		    }else{
		    	type="(Risk Task)";
		    }
		    $.ajax({
				type : "GET",
				url : "CommitteeMinutesSpecAdd.htm",
				data : {
					
					minutesid : minutesidadd,
					agendasubid:agendasubidadd,
					scheduleagendaid:scheduleagendaidadd,
					minutesunitid:unitidadd,
					
				},
				datatype : 'json',
				success : function(result) {
					
					var result = JSON.parse(result);
					var values = Object.keys(result).map(function(e) {
						  return result[e]
						});
					    specall=values[1];
						if(minutesidadd==3){
						specall=specall+" / " + values[4]+" / " + values[5]+" / " + values[3];
  					       }
						if(minutesidadd==4 || minutesidadd==5 || minutesidadd==6){
  						specall=specall+" / " + values[5];
      				       }
						document.getElementById('action').innerHTML =type;
						document.getElementById('Spec').innerHTML =specall;
					  
			
				}
			});
});
</script>
</body>
</html>