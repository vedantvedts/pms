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
<spring:url value="/resources/css/committeeModule/CommitteeScheduleSelect.css" var="CommitteeScheduleSelect" />
<link href="${CommitteeScheduleSelect}" rel="stylesheet" />
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

<div class="card-header mt-n1">
	<div class="row">	
		<div class="col-md-6">
			<h4>Committee Meeting Schedules</h4>
		</div>
		<div class="col-md-6 mt-n8px" align="right">
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
					
					<div class="row mt-n10px">
					
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
		                    	<input type="submit" class="btn  btn-sm add float-right" onclick="Add1('myfrm')" value="ADD SCHEDULE" > 	
	                    	</div>                   	
                  		</form> 
						
					</div>
					
					</div>
					<div class="card-body">
						<div id="calendar" class="calendarStyle"></div>
						<div id="meetings" class="meetingStyle">
						<div class="meetingFontStyle">Meetings</div>
						<div class="mt-4 ScrollDivStyle" id="scrollclass">
						<%if(!committeeschedulelist.isEmpty()){
							for(Object[]obj:committeeschedulelist){
							%>
						 <a class="tag meetingsp text-decoration-none" href="CommitteeScheduleView.htm?scheduleid=<%=obj[0].toString() %>&membertype=undefined"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - "%>
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