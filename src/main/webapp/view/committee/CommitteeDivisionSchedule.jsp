<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<META HTTP-EQUIV="Refresh" CONTENT="60">

<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/committeeModule/CommitteeDivisionSchedule.css" var="CommitteeDivisionSchedule" />
<link href="${CommitteeDivisionSchedule}" rel="stylesheet" />
</head>
<body>


<%
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf2=fc.getRegularDateFormat();
SimpleDateFormat sdf3=fc.getSqlDateFormat();
	
List<Object[]> divisionslist=(List<Object[]>) request.getAttribute("divisionslist");
List<Object[]>  divisionchedulelist=(List<Object[]>)request.getAttribute("divisionchedulelist");
List<Object[]>  projapplicommitteelist=(List<Object[]>)request.getAttribute("projapplicommitteelist");
Object[] committeedetails=(Object[])request.getAttribute("committeedetails");
String divisionid=(String)request.getAttribute("divisionid");
String committeeid=(String)request.getAttribute("committeeid");
String initiationid=(String)request.getAttribute("initiationid");

List<Object[]>PreviousmeetingList= new ArrayList<>();

if(!divisionchedulelist.isEmpty()){
	if(committeeid.equalsIgnoreCase("all")){
		PreviousmeetingList=divisionchedulelist.stream().filter(i -> LocalDate.parse(i[3].toString()).isBefore(LocalDate.now())  ).collect(Collectors.toList());
		
	}else{
		PreviousmeetingList=divisionchedulelist.stream().filter(i -> i[1].toString().equalsIgnoreCase(committeeid) &&  LocalDate.parse(i[3].toString()).isBefore(LocalDate.now())  ).collect(Collectors.toList());
	
	}
}
%>



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



	<%Object[] Projectdetails=(Object[])request.getAttribute("Projectdetails");%>

<div class="container-fluid">
		
		<div class="row">
			<div class="col-md-12">	
				
				<div class="card shadow-nohover">
					<div class="card-header">
					
					<div class="row">
					
					<div class="col mt-n8">	
					<%if(Long.parseLong(divisionid)>0){ %>
						<form class="form-inline" method="post" action="DivisionBasedSchedule.htm" id="myform">
		
							<div class="col">
								<label class="control-label">Division : </label>
							</div>
								
							<div class="col ">
								 <select class="form-control selectdee" id="divisionid" required="required" name="divisionid" onchange='submitForm1();' >
				   						<% for (Object[] obj : divisionslist) {%>
										<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(divisionid)){ %>selected<%} %> ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
										<%} %>
										
				  				</select>
				  			</div>	
							
							
							<div class="col ">
								<label class="control-label">Committee : </label>	
							</div>
								
							<div class="col ">
								 <select class="form-control selectdee" id="committeeid" required="required" name="committeeid" onchange='submitForm();' >
							   				<option value="all"  <%if(committeeid.equals("all")){ %>selected <%} %> >All</option>
							   				<% for (Object[] obj : projapplicommitteelist) {%>
											<option value="<%=obj[0]%>"  <%if(obj[0].toString().equals(committeeid)){ %>selected<%} %> ><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%></option>
											<%} %>   
							  	</select>
				  			</div>	
		
 	
							 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
							  		
						</form>
						<%} %>
			
					</div>
					
					<div class="col">		
					
					<%if(!committeeid.equals("all") && Long.parseLong(committeeid)>0 ){ %>
					 <form class="form-check-inline" action="CommitteeScheduleAddSubmit.htm" method="POST" name="myfrm1" id="myfrm1" > 
							<input type="hidden" name="committeename" value="<%=committeedetails[2] %>">
							<div class="col ">
								<label class="control-label"> Date &nbsp;&nbsp; : </label>
							</div>
								
							<div class="col">
		                          <input  class="form-control width-115"  data-date-format="dd/mm/yyyy" id="startdate" name="startdate"  required="required"  readonly>	
		                    </div>
		                    
		                    <div class="col ">
		                    	<label class="control-label"> Time &nbsp;&nbsp; : </label>
		                    </div>
		                 
		                    <div class="col">
		       					<input  class="form-control" type="text" id="starttime" name="starttime"  required="required" value="<%=LocalTime.now() %>"  readonly>
		                    </div>
		                        
		                    <div class="col" align="right" >
		                    	<input type="hidden" name="projectid" value="0" /> 
		                    	<input type="hidden" name="initiationid" value="<%=initiationid %>" /> 
		                    	<input type="hidden" name="divisionid" value="<%=divisionid %>" /> 
		                    	<input type="hidden" name="committeeid" value="<%=committeeid%>" /> 
		                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
		                    	<input type="button" class="btn  btn-sm add float-right" onclick="Add1('myfrm1')" value="ADD SCHEDULE" > 	
	                    	</div>                   	
                  		</form> <%} %>
						
					</div>
					
					</div>
					</div>
					<div class="card-body cardBodyStyle">
						<div id="calendar" class="calendarStyle"></div>
						<div id="meetings" class="meetingsStyle">
						<div class="earlierMeetingsStyle">
						
						Earlier Meetings
						</div>
						<div class="mt-2 tagMeetingSpStyle" id="scrollclass">
						<%if(!PreviousmeetingList.isEmpty()){
							int i=0;
							for(Object[]obj:PreviousmeetingList){
							%>
						 <a class="tag meetingsp text-decoration-none" href="CommitteeScheduleView.htm?scheduleid=<%=obj[0].toString() %>&membertype=undefined"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - "%>
						&nbsp;&nbsp;Date: <%=obj[3]!=null? sdf2.format(sdf3.parse(obj[3].toString())):" - " %>
							</a>
						<%}}else{ %>
						<p class="meetingsp ml-3 mr-3"> No Previous Meetings held !</p>
						<%} %>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
</div>

<br>
	<div class="row m-1 text-center addScheduleDivStyle">

		<table align="center" class="addScheduleTblStyle">
			<tr>
				
				
				<td class="trup addScheduleTd">
					<b class="text-primary">Add Schedule  </b>
				</td>
				<td class="trup addScheduleSpaceTd"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true" ></i></td>
				<td rowspan="2" class="trup width-30 height-20"></td>
				
				<td class="trup addAgendaStyle height-20">
					<b class="text-primary">Add Agenda </b>
				</td>
				<td class="trup width-10 height-20"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup width-30 height-20"></td>
				
				<td class="trup addAgendaStyle height-20">
					<b class="text-primary">Update Venue </b>
				</td>
				<td class="trup width-10 height-20"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup width-30 height-20"></td>
				
				<td class="trup addAgendaStyle height-20">
					<b class="text-primary">Invite Participants </b>
				</td>
				<td class="trup width-10 height-20"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup width-30 height-20"></td>
				
				<td class="trup addAgendaStyle height-20">
					<b class="text-primary">Agenda Approval </b>
				</td>
				<td class="trup width-10 height-20"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup width-30 height-20"></td>
				
				<td class="trup addAgendaStyle height-20">
					<b class="text-primary">Kick off Meeting </b>
				</td>
				<td class="trup width-10 height-20"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup width-30 height-20"></td>
				
				<td class="trup addAgendaStyle height-20">
					<b class="text-primary">Update Attendance </b>
				</td>
				<td class="trup width-10 height-20"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup width-30 height-20"></td>
				
				<td class="trup addAgendaStyle height-20">
					<b class="text-primary">Prepare Minutes  </b>
				</td>
				<td class="trup width-10 height-20"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup width-30 height-20"></td>
				
				<td class="trup addAgendaStyle height-20">
					<b class="text-primary">Update Outcomes (A,I,R)  </b>
				</td>
				<td class="trup width-10 height-20"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup width-30 height-20"></td>
				
				
				<td class="trup addAgendaStyle height-20">
					<b class="text-primary"> Minutes Approval</b>
				</td>
				<td class="trup width-10 height-20"></td>
				
			

			</tr>
			
		</table>



	</div>

<script type='text/javascript'> 
function submitForm()
{ 
  document.getElementById('myform').submit(); 
} 

function submitForm1()
{ 
	$("#committeeid").val("all").change();
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


<%if(committeeid!=null &&  divisionid!=null )
{%>
myEvents = [
	<%	
	for(Object obj[] :divisionchedulelist) {%>
	 { 
	    id: "required-id-1",
	    name: "Meeting Details",
	    scheduleid: "<%if(obj[0]!=null){%><%=obj[0].toString()%><%}%>",
	    time: "<%=obj[4].toString()%>",
	    ComCode : "<%=obj[6]%>" ,
	    date: "<%=obj[3].toString()%>", 
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
 function Add(myfrm1){
	
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
	         $("#myfrm1").submit(); 
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