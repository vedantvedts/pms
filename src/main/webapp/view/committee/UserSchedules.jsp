<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.io.*,java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<META HTTP-EQUIV="Refresh" CONTENT="60">

<jsp:include page="../static/header.jsp"></jsp:include>


<style>
.card-body{
	padding: 0px !important;
}
.control-label{
	font-weight: bold !important;
}
</style>

</head>
<body>


<%
	SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

List<Object[]> userschedulelist=(List<Object[]>)request.getAttribute("userschedulelist");


%>

<%String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>
	<center>
	
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</center>
	<%}if(ses!=null){ %>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</center>
	<%} %>


<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">	
				<div class="card shadow-nohover">
					<div class="card-header" style="background-color: rgba(0,0,0,.03)">

						<div class="col-md-3">
							<h3>My Schedules </h3>
							
						</div>
		         
					
					</div>
					
					<div class="card-body">
						<div id="calendar"></div>
					</div>
					
				</div>
			</div>
		</div>
</div>



<script type='text/javascript'> 
function submitForm()
{ 
  document.getElementById('myform').submit(); 
} 
</script>


	
<script type="text/javascript">   

$('#startdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" :new Date(),
	"startDate" : new Date(),

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$(function() {
	   $('#starttime').daterangepicker({
	            timePicker : true,
	            singleDatePicker:true,
	            timePicker24Hour : true,
	            timePickerIncrement : 1,
	            timePickerSeconds : false,
	            locale : {
	                format : 'HH:mm'
	            }
	        }).on('show.daterangepicker', function(ev, picker) {
	            picker.container.find(".calendar-table").hide();
	   });
	})
 
 
</script>


<script type="text/javascript">

myEvents = [
	 <%	
	for(Object obj[] :userschedulelist) {%>
	 { 
	    id: "required-id-1",
	    name: "Meeting Details",
	    scheduleid: "<%if(obj[2]!=null){%><%=obj[2].toString()%><%}%>",
	    membertype: "<%if(obj[6]!=null){%><%=obj[6].toString()%><%}%>",
	    time: "<%=obj[4].toString()%>",
	    ComCode : "<%=obj[7]%>" ,
	    date: "<%=obj[3].toString()%>",  
	    url: "CommitteeUserScheduleView.htm",
	    type: "event",  
	    color: "#0383F3",
	   type: "event"
	  },
	 <%}%> 
	]


	
$("#calendar").evoCalendar(
		{
			theme : 'Royal Navy',
			calendarEvents: myEvents,
			
		});


function Add(myfrm){
	
	event.preventDefault();
	
	var date=$("#startdate").val();
	var time=$("#starttime").val();
	
	bootbox.confirm({ 
 		
	    size: "large",
		message: "<center></i>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>Are You Sure To Add Schedule on "+date+" &nbsp;("+ time +") ?</b></center>",
	    buttons: {
	        confirm: {
	            label: 'Yes',
	            className: 'btn-success'
	        },
	        cancel: {
	            label: 'No',
	            className: 'btn-danger'
	        }
	    },
	    callback: function(result){ 
	 
	    	if(result){
	    	
	    		$("sub").value;
	         $("#myfrm").submit(); 
	    	}
	    	else{
	    		event.preventDefault();
	    	}
	    } 
	}) 
	
	
}	
   
</script>


</body>
</html>