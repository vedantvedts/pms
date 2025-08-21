<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	<%@page import="com.vts.pfms.FormatConverter"%>
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
#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px; 
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: #fff;
} 

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}

#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px;
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: #fff;
}

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}


.meetingsp{
  width:75%;
  transition: background-color 3s ease;
  background-image: linear-gradient(to right, green 50%, #f8f9fa 50%);
  background-size: 200% 100%;
  background-position: 100% 0;
  transition: background-position 0.5s ease;
  color:black;
  padding:10px;
  border-radius: 8px;
  display: block;
  font-weight: 600;
  margin:1%;
  margin-left:12%;
}
.meetingsp:hover{
 	/*  background-color: green;
	 background-image: linear-gradient(to right, green, blue); */
	 color:white;
 background-position: 0 0;
 box-shadow: 3px 3px 3px gray;
	/* background-color:red; */
color:white;
font-weight: 600;	
}
#span{
background: blue;
}
</style>

</head>
<body>


<%
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf2=fc.getRegularDateFormat();
SimpleDateFormat sdf3=fc.getSqlDateFormat();
	SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
List<Object[]> CommitteList=(List<Object[]>) request.getAttribute("CommitteeList");
CommitteList = CommitteList.stream().filter(e -> !Arrays.asList("CCM","DMC","CARS").contains(e[5].toString())).collect(Collectors.toList());
String committeeid=(String)request.getAttribute("committeeid");

List<Object[]>  committeeschedulelist=(List<Object[]>)request.getAttribute("committeeschedulelist");

System.out.println("committeeid: "+committeeid);
%>

<div class="card-header" style="margin-top: -1%">
	<div class="row">	
		<div class="col-md-6">
			<h4>Committee Meeting Schedules</h4>
		</div>
		<div class="col-md-6" align="right" style="margin-top: -8px;">
			<form method="post" action="CommitteeScheduleList.htm" id="myform">
			
			  <table><tr><td>
				Select Committee :   &ensp;</td><td>
				<select class="form-control selectdee" id="committeeid" required="required" name="committeeid" onchange='submitForm();' >
	   				<option disabled selected value="">Choose...</option>
	   				<% for (Object[] obj : CommitteList) {%>
					<option value="<%=obj[1]%>" <%if(committeeid!=null && committeeid.equals(obj[1].toString())){%>selected <%}%> ><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%>(<%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - "%>)</option>
					<%} %>   
	  			</select></td></tr></table>
	  			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
			</form>
		</div>
		
	</div>
</div>

<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>


<%if(committeeid!=null)
{
	Object[] committeedetails=(Object[])request.getAttribute("committeedetails");%>

<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">	
				<div class="card shadow-nohover">
					<div class="card-header">
					
					<div class="row" style="margin-top:-10px;">
					
					 <form class="form-check-inline" action="CommitteeScheduleAddSubmit.htm" method="POST" name="myfrm" id="myfrm" > 
					
						<div class="col-md-3">
							<h3><%=committeedetails[1]!=null?StringEscapeUtils.escapeHtml4(committeedetails[1].toString()): " - " %></h3>
							<input type="hidden" name="committeename" value="<%=committeedetails[2] %>">
						</div>
						
						
							<div class="col-md-2 ">
								<label class="control-label">Meeting Date &nbsp;&nbsp; : </label>
							</div>
								
							<div class="col-md-2 ">
		                          <input  class="form-control "  data-date-format="dd/mm/yyyy" id="startdate" name="startdate"  required="required" readonly >	
		                    </div>
		                    
		                    <div class="col-md-2 ">
		                    	<label class="control-label">Meeting Time &nbsp;&nbsp; : </label>
		                    </div>
		                 
		                    <div class="col-md-2 ">
		       					<input  class="form-control" type="text" id="starttime" name="starttime"  required="required" value="<%=LocalTime.now() %>" readonly>
		                    </div>
		                        
		                    <div class="col-md-3 " align="right" >
		                    	<input type="hidden" name="divisionid" value="0" />
		                    	<input type="hidden" name="committeeid" value="<%=committeeid %>" />
		                    	<input type="hidden" name="projectid" value="0"/> 
		                    	<input type="hidden" name="initiationid" value="0"/> 
		                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
		                    	<input type="submit" class="btn  btn-sm add " style="float: right" onclick="Add1('myfrm')" value="ADD SCHEDULE" > 	
	                    	</div>                   	
                  		</form> 
						
					</div>
					
					</div>
					<div class="card-body">
						<div id="calendar" style="width:79%;float:left"></div>
						<div id="meetings" style="background-color: #216583;;width:20%;margin:5px;float: right">
						<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;">Meetings</div>
						<div class="mt-4" id="scrollclass" style="height:520px;overflow: auto">
						<%if(!committeeschedulelist.isEmpty()){
							for(Object[]obj:committeeschedulelist){
							%>
						 <a class="tag meetingsp" style="text-decoration: none;" href="CommitteeScheduleView.htm?scheduleid=<%=obj[0].toString() %>&membertype=undefined"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - "%>
						&nbsp;&nbsp; Date: <%=obj[3]!=null? sdf2.format(sdf3.parse(StringEscapeUtils.escapeHtml4(obj[3].toString()))): " - "  %>
							</a>
						<%}}else{ %>
						<p class="meetingsp ml-3 mr-3"> No Meetings Listed !</p>
						<%} %>
						</div>
						</div>
					</div>
					</div>
					
				</div>
			</div>
		</div>
</div>
<%} %>

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
	/* "minDate" :new Date(), */
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


<%if(committeeid!=null)
{%>
myEvents = [
	<%	
	for(Object obj[] :committeeschedulelist) {%>
	 { 
	    id: "required-id-1",
	    name: "Meeting Details",
	    scheduleid: "<%if(obj[0]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[0].toString())%><%}%>",
	    time: "<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): ""%>",
	    ComCode : "<%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): ""%>" ,
	    date: "<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): ""%>", 
	    url: "CommitteeScheduleView.htm",
	    type: "event",  
	    color: "#0383F3",
	   type: "event"
	  },
	<%}%>
	]

<%}%>
	
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

function Add1(myfrm1){
	event.preventDefault();
		
		var date=$("#startdate").val();
		var time=$("#starttime").val();
		var result=confirm("Are You Sure To Add Schedule on "+date+"  ("+ time +") ?");
		if(result){
	    	
			$("sub").value;
	     $("#"+myfrm1).submit(); 
		}
		else{
			event.preventDefault();
		}
		
		
		}
   
</script>


</body>
</html>