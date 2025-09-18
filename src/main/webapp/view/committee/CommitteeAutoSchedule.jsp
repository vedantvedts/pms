<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    <%@page import="java.time.LocalTime"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/committeeModule/committeeAutoSchedule.css" var="committeeAutoSchedule" />
<link href="${committeeAutoSchedule}" rel="stylesheet" />
<title> AUTO SCHEDULE</title>
</head>

<body>

<% 
String ProjectName=(String)request.getAttribute("projectname");
List<Object[]>  projectmasterlist=(List<Object[]>)request.getAttribute("projectmasterlist");
String projectid=(String)request.getAttribute("projectid");
String divisionid=(String)request.getAttribute("divisionid");
String initiationid=(String)request.getAttribute("initiationid");
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
							<h3 class="control-label" > Committee Auto Schedule </h3> 
						</div>
						
						<div class="col-md-5">	</div>
						
						<div class="col-md-3">	
							<h5 class="control-label" > Project : <%=ProjectName!=null?StringEscapeUtils.escapeHtml4(ProjectName): " - " %></h5> 
						</div>
					</div>
				</div><!-- card header -->
				
		
				<form action="CommitteeAutoScheduleSubmit.htm" method="post" id="myfrm" >
				<div class="card-body">
						
							<div class="row">
							
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Date : </label>
										<input  class="form-control "  data-date-format="dd/mm/yyyy" id="startdate" name="startdate"  required="required" readonly="readonly" >	
									</div>
								</div>
							
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Time : </label>
										<input  class="form-control" type="text" id="starttime" name="starttime"  required="required" value="<%=LocalTime.now() %>" readonly="readonly" >
									</div>
								</div>

							</div>
							<input type="hidden" name="projectid" value="<%=projectid%>"/>
							<input type="hidden" name="divisionid" value="<%=divisionid%>"/>
							<input type="hidden" name="initiationid" value="<%=initiationid%>"/>
							 <% for (Object[] obj : projectmasterlist) {%>
							<input type="hidden" name="committeeid" value="<%=obj[2]%>"/>												
							<%} %>  
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />					
					</div> <!-- card-body end -->
					
					<div class="row" >
						<div class="col-md-5"></div>
						<div class="col-md-3">
							<div class="form-group">
								<button class="btn btn-primary btn-sm submit" type="submit" name="submit" value="SUBMIT" onclick="return confirm('Are You Sure To Start Auto Scheduling ?');">SUBMIT</button>
								<button  class="btn btn-primary btn-sm back"  formaction="ProjectMaster.htm">BACK</button>
							</div>
						</div>
					</div>					
				</form>	
			</div> <!-- card end -->			
		</div>
	</div>
	
	<br>
	
	<div class="row">
		<div class="col-md-12">	
				
			<div class="card shadow-nohover">
				<div class="card-header">
					
					<div class="row">
					
						<div class="col-md-4">	
							<h3 class="control-label" > Auto-Scheduling Committees</h3> 
						</div>
						<div class="col-md-5">	</div>
						<div class="col-md-3">	
							
							<form method="get" action="CommitteeAutoScheduleList.htm" id="form" >
							
							<%-- <%if(projectmasterlist!=null&&projectmasterlist.size()>0){ %> --%>
							
								<button type="submit" name="" value="" class="btn btn-sm viewall float-right">AUTO-SCHEDULED LIST</button>
							
							<%-- <%} %> --%>
							
								<input type="hidden" name="projectname" value="<%=ProjectName %>"/>
								
								<input type="hidden" name="projectid" value="<%=projectid%>"/>	
							
							</form>
							
						</div>	

					</div>

				</div><!-- card header -->
				
			
				<div class="card-body">
					<div class="row">
						<div class="col-md-6">	
						
							<table class="scrolltable datatablex table table-bordered table-hover table-striped table-condensed table-sm">
								<thead>
									<tr class="text-white headerRowBgColor">
										<th class="text-left">Committee Name</th>
										<th class="text-left">Periodic Duration</th>
									</tr>
								</thead>
								<tbody>
								<%
									if (projectmasterlist != null&&projectmasterlist.size()>0) {
									for (Object[] obj : projectmasterlist) {
									if(obj[6].toString().equals("N")){
								%>		
												
									<tr>
										<td class="text-left"><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - "%>(<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>)</td>
										<td class="text-left"><%if(obj[4].toString().equalsIgnoreCase("P")){ %><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %> days<%} else{%>Non-Periodic<%} %> </td>
									</tr>
								<%
									}
									}	
									}
								%>
								</tbody>
							</table>	
								
						</div>
					</div>		
				</div> <!-- card-body end -->

			</div> <!-- card end -->
			
		</div>
	</div>
	
	
	
	
	
</div>
    

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

	
		
		
</body>

</html>