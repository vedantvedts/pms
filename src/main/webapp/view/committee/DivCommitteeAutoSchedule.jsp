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
<spring:url value="/resources/css/committeeModule/DivCommitteeAutoSchedule.css" var="DivCommitteeAutoSchedule" />
<link href="${DivCommitteeAutoSchedule}" rel="stylesheet" />
<title> AUTO SCHEDULE</title>
</head>

<body>

<% 
Object[] divisiondata=(Object[])request.getAttribute("divisiondata");
Object[] initiationdata=(Object[])request.getAttribute("initiationdata");
List<Object[]>  divisionmasterlist=(List<Object[]>)request.getAttribute("divisionmasterlist");
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
				
			<div class="row">
		<div class="col-md-12">	
				
			<div class="card shadow-nohover">
				<div class="card-header">
					
					<div class="row">
						<div class="col-md-6"><h3>Auto Schedule </h3> </div>
						<div class="col-md-6">
							<div>
								<%if(Long.parseLong(divisionid)>0){ %>
								<h3 class="control-label float-right">Division : <%=divisiondata[2]!=null?StringEscapeUtils.escapeHtml4(divisiondata[2].toString()): " - " %> </h3>
								<%}else if(Long.parseLong(initiationid)>0){%>
								<h3 class="control-label float-right"> Initiated Project :<%=initiationdata[2]!=null?StringEscapeUtils.escapeHtml4(initiationdata[2].toString()): " - " %>  </h3>						 
								<%} %>
							</div> 
						</div>
					</div>
				</div>
				
		
				<form action="DivCommitteeAutoScheduleSubmit.htm" method="post" id="myfrm" >
				<div class="card-body">
						
							<div class="row">
							
									<div class="col-md-2">
										<div class="form-group">
											<label class="control-label">From </label>
											 <input  class="form-control"  data-date-format="dd/mm/yyyy" readonly="readonly" id="fdate" name="startdate"  required="required" value="">
										</div>
									</div>

									<div class="col-md-2">
										<div class="form-group">
											<label class="control-label">To </label> 
											<input  class="form-control"  data-date-format="dd/mm/yyyy" readonly="readonly" id="tdate" name="enddate"  required="required" value="">
										</div>
									</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Time : </label>
										<input  class="form-control" type="text" id="starttime" name="starttime"  required="required"  readonly="readonly" value="<%=LocalTime.now() %>" >
									</div>
								</div>

							</div>
							<% for (Object[] obj : divisionmasterlist) {%>
										<input type="hidden" name="committeeid" value="<%=obj[2]%>"/>												
							<%} %>  
																	
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />					
					</div> 
					
					<div class="row" >
						<div class="col-md-5"></div>
						<div class="col-md-3">
							<div class="form-group">
								<button class="btn btn-primary btn-sm submit" type="submit" name="submit" value="SUBMIT" onclick="return confirm('Are You Sure To Start Auto Scheduling ?');">SUBMIT</button>
								<button type="button" class="btn btn-primary btn-sm back" onclick="submitForm('backfrm')" >BACK</button>
							</div>
						</div>
					</div>		
					
					<input type="hidden" name="projectid" value="<%=projectid%>"/>
					<input type="hidden" name="divisionid" value="<%=divisionid%>"/>
					<input type="hidden" name="initiationid" value="<%=initiationid%>"/>
								
				</form>	
				<%if(Long.parseLong(divisionid)>0){ %>
				<form action="DivisionCommitteeMaster.htm" method="post" id="backfrm">
				<%}else if(Long.parseLong(initiationid)>0) {%>
				<form action="InitiationCommitteeMaster.htm" method="post" id="backfrm">
				<%} %>
					<input type="hidden" name="divisionid" value="<%=divisionid %>" />
					<input type="hidden" name="projectid" value="<%=projectid%>"/>
					<input type="hidden" name="initiationid" value="<%=initiationid%>"/>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
				
				
				
			</div>			
		</div>
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
								<button type="submit" name="" value="" class="btn btn-sm viewall float-right">AUTO-SCHEDULED LIST</button>
								<input type="hidden" name="projectid" value="<%=projectid%>"/>	
								<input type="hidden" name="divisionid" value="<%=divisionid%>"/>	
								<input type="hidden" name="initiationid" value="<%=initiationid%>"/>	
							</form>
						</div>	

					</div>

				</div><!-- card header -->
				
			
				<div class="card-body">
					<div class="row">
						<div class="col-md-6">	
						
							<table class="scrolltable datatablex table table-bordered table-hover table-striped table-condensed table-sm">
								<thead>
									<tr class="tblTrStyle">
										<th class="text-left">Committee Name</th>
										<th class="text-left">Periodic Duration</th>
									</tr>
								</thead>
								<tbody>
								<%
									if (divisionmasterlist != null&&divisionmasterlist.size()>0) {
									for (Object[] obj : divisionmasterlist) {
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
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 


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

var fromDate=null;
$("#fdate").change( function(){	
	 fromDate = $("#fdate").val();
	 
	var date1=fromDate.split("-");
	var date= new Date(date1[1]+' '+date1[0]+' '+date1[2]);
	date.setDate(date.getDate() + 1);
	
		
		$('#tdate').daterangepicker({
			
			"singleDatePicker": true,
			"showDropdowns": true,
			"cancelClass": "btn-default",
			"minDate":fromDate,
			"startDate":date ,
			locale: {
		    	format: 'DD-MM-YYYY'
				}
		});
		
});

$('#fdate').daterangepicker({
	
	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	<%-- "mindate":"<%=startdate[0]%>",  --%>
	"startDate":new Date(), 
	locale: {
    	format: 'DD-MM-YYYY'
		}
});
</script>
	
		
		
</body>

</html>