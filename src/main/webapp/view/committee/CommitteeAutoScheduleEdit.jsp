<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.time.format.TextStyle"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    <%@page import="java.time.LocalTime"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/committeeModule/CommitteeAutoScheduleEdit.css" var="CommitteeAutoScheduleEdit" />
<link href="${CommitteeAutoScheduleEdit}" rel="stylesheet" />
<title> AUTO SCHEDULE</title>
</head>
<body>
<%

SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");




Object[] scheduledata=(Object[] )request.getAttribute("scheduledata");
String projectname=(String)request.getAttribute("projectname");
String divisionid=scheduledata[16].toString();
String projectid=scheduledata[9].toString();
String initiationid=scheduledata[17].toString();
String projectstatus=(String)request.getAttribute("projectstatus");
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

    <br />
    
    
    <div class="container-fluid">
		
	<div class="row">
		<div class="col-md-12">	
				
			<div class="card shadow-nohover">
				<div class="card-header">
					
					<div class="row">
					
						<div class="col-md-4">	
							<h3 class="control-label" ><%=scheduledata[8]!=null?StringEscapeUtils.escapeHtml4(scheduledata[8].toString()): " - " %> Schedule Edit </h3> 
						</div>
						
						<div class="col-md-5">	
								<h3><%String day=LocalDate.parse(scheduledata[2] .toString()).getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.US);%>							
								<span<%if(day.equalsIgnoreCase("sunday") || day.equalsIgnoreCase("saturday")){ %> class="text-danger" <%} %> > <%=day!=null?StringEscapeUtils.escapeHtml4(day): " - "%> </span>&nbsp; 
								- &nbsp;<%=LocalDate.parse(scheduledata[2] .toString()).getMonth().getDisplayName(TextStyle.FULL, Locale.US)%> &nbsp; 
								- &nbsp; <%= sdf.format(sdf1.parse( scheduledata[2] .toString()))%></h3>  
						</div>
						<div class="col-md-3"><h3 class="control-label" > <%if(projectname!=null){%><%=StringEscapeUtils.escapeHtml4(projectname) %><%} %></h3>	</div>
						
						
							
						

					</div>

				</div><!-- card header -->
				
		
				<form action="CommitteeAutoScheduleUpdate.htm" method="post" id="myfrm" >
				<div class="card-body">
						
							<div class="row">
							
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Date : </label>
										<input  class="form-control "  data-date-format="dd/mm/yyyy" id="startdate" name="startdate"  required="required" value="<%=sdf.format(sdf1.parse( scheduledata[2] .toString()))%>" >	
									</div>
								</div>
							
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Time : </label>
										<input  class="form-control" type="text" id="starttime" name="starttime"  required="required" value="<%=scheduledata[3] %>" >
									</div>
								</div>

							</div>						 
							<input type="hidden" name="scheduleid" value="<%=scheduledata[6]%>"/>												
							<input type="hidden" name="projectid" value="<%=projectid%>"/>
							<input type="hidden" name="divisionid" value="<%=divisionid%>"/>
							<input type="hidden" name="committeeid" value="<%=scheduledata[0]%>"/>
							<input type="hidden" name="initiationid" value="<%=initiationid%>"/>
							<input type="hidden" name="projectstatus" value="<%=projectstatus%>"/>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />					
					</div> <!-- card-body end -->
					
					<div class="row" >
						<div class="col-md-5"></div>
						<div class="col-md-3">
							<div class="form-group">
								<button class="btn btn-primary btn-sm submit" type="submit" name="submit" onclick="return confirm('Changes In This Schedule Will Affect Other Schedules of  <%=scheduledata[8] %>');" >SUBMIT</button>
								<%if(Long.parseLong(projectid)>0){ %>
									<button class="btn btn-primary btn-sm back" formaction="CommitteeAutoScheduleList.htm">BACK</button>
								<%}else  { %>
									<button type="button" class="btn btn-primary btn-sm back" onclick=" submitForm('backfrm')">BACK</button>
								<%} %>
							</div>
						</div>
						
					</div>
					</form>	
					<%if(Long.parseLong(divisionid)>0 || Long.parseLong(initiationid )>0){ %>
						<form action="DivCommitteeAutoSchedule.htm" method="post" id="backfrm" >
							<input type="hidden" name="projectid" value="<%=projectid%>"/>
							<input type="hidden" name="divisionid" value="<%=divisionid%>"/>
							<input type="hidden" name="committeeid" value="<%=scheduledata[0]%>"/>
							<input type="hidden" name="initiationid" value="<%=initiationid%>"/>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
						</form>
					
					<%} else { %>
						<form action="NonProjectCommitteeAutoSchedule.htm" method="post" id="backfrm" >
							<input type="hidden" name="committeeid" value="<%=scheduledata[0]%>"/>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
						</form>
					<%} %>

			</div> <!-- card end -->
			
			

			
		</div>
	</div>
	
</div>
    

<script type="text/javascript">   

function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 




$('#startdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :new Date(), */
	

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

	
		
		
</body>

</html>