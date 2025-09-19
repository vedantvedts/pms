<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/committeeModule/MeetingReports.css" var="MeetingReports" />
<link href="${MeetingReports}" rel="stylesheet" />
<title>Meeting Reports</title>
</head>
 
<body>
  <%
  FormatConverter fc=new FormatConverter(); 
  SimpleDateFormat sdf=fc.getRegularDateFormat();
 
  String Term=(String)request.getAttribute("Term");
  String projectid=(String)request.getAttribute("projectid");
  String divisionid=(String)request.getAttribute("divisionid");
  String initiationid=(String)request.getAttribute("initiationid");
  String typeid=(String)request.getAttribute("typeid");
  
  List<Object[]> ProjectsList=(List<Object[]>) request.getAttribute("ProjectList");
  List<Object[]> initiationlist=(List<Object[]>) request.getAttribute("initiationlist");
  List<Object[]> divisionlist=(List<Object[]>) request.getAttribute("divisionlist");
  List<Object[]> MeetingReports=(List<Object[]>) request.getAttribute("MeetingReports");
  
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

    <br/>


<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header ">  

					<div class="row">
						<h4 class="col-md-3">Meeting Reports</h4>  
							<div class="col-md-9 float-right">
					   		
		   					</div>
		   				</div>	   							
					</div>
				
					<div class="card-body">
					
						<div class="row">
							
		   					<div class="col-md-3" >
		   					<form method="post" action="MeetingReports.htm"  id="fieldform">
	   							<label class="control-label fs-17px">Term: </label>
			   						
	                       	 	<select class="form-control items " name="term"  required="required" id="term" data-live-search="true"  onchange="changeterm()" >
										<option value="T" <%if("T".equalsIgnoreCase(Term)){ %> selected="selected" <%} %>>Today</option>	
										<option value="E" <%if("E".equalsIgnoreCase(Term)){ %> selected="selected" <%} %>>Tomorrow</option>	
										<option value="S" <%if("S".equalsIgnoreCase(Term)){ %> selected="selected" <%} %> >Next 7 Days</option>		
								</select>
                          	</div>
                          	<div class="col-md-3" >
					   			<label class="control-label fs-17px">Type: </label>
					   					
                                <select class="form-control items" id="typeid" required="required" name="typeid" onchange="projectfieldchange();" >
							   		<option value="A" <%if("A".equalsIgnoreCase(typeid)){ %> selected="selected" <%} %> >ALL</option>
							   		<option value="G" <%if("G".equalsIgnoreCase(typeid)){ %> selected="selected" <%} %> >General</option>
									<option value="P" <%if("P".equalsIgnoreCase(typeid)){ %> selected="selected" <%} %> >Project</option>
							   		<option value="D" <%if("D".equalsIgnoreCase(typeid)){ %> selected="selected" <%} %> >Division</option>
							   		<option value="I" <%if("I".equalsIgnoreCase(typeid)){ %> selected="selected" <%} %> >Initiated Project</option>
					  			</select>
					  			<input type="hidden" name="initiationid" value="0" />
								<input type="hidden" name="divisionid" value="0" />
								<input type="hidden" name="projectid" value="0" />
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					  		</form>
					  		</div>
					  		
                            <div class="col-md-3">
                            		<%if(typeid.equals("P")){ %>
		                            <div   id="projectdiv" class="width-100 projectDivBlock">
		                            <%}else{ %>
		                            <div   id="projectdiv" class="width-100 projectDivNone">
		                            <%} %>
			                            <form method="post" action="MeetingReports.htm"  id="proform">
								   			<label class="control-label fs-17px">Project: </label>
			                                <select class="form-control items width-100" id="projectid" name="projectid" required="required"  onchange="submitForm('proform');">
												<option value="" disabled="disabled" selected >Choose...</option>
												<option value="A" <%-- <%if(projectid.equalsIgnoreCase("A")){ %>selected<% }%> --%> >All</option>
										   		<% for (Object[] obj : ProjectsList) {%>
													<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(projectid)){ %>selected<%  } %>  ><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></option>
												<%} %>
								  			</select>
								  			<input type="hidden" name="initiationid" value="0" />
								  			<input type="hidden" name="divisionid" value="0" />
								  			<input type="hidden" name="term" id="termp" value="<%=Term %>" />
								  			<input type="hidden" name="typeid" id="typeidp" value="<%=typeid %>" />
								  			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								  		</form>
							  		</div>
							  		
							  		<%if(typeid.equals("D")){ %>
		                            <div   id="divisiondiv" class="width-100 projectDivBlock">
		                            <%}else{ %>
		                            <div   id="divisiondiv" class="width-100 projectDivNone">
		                            <%} %>
							  			<form method="post" action="MeetingReports.htm"  id="divform" > 	
								   			<label class="control-label fs-17px">Division: </label>
								   						
			                              	<select class="form-control items width-100" id="divisionid" name="divisionid" required="required"  onchange="submitForm('divform');">
												<option value="" disabled="disabled" selected >Choose...</option>
												<option value="A" <%-- <%if(divisionid.equalsIgnoreCase("A")){ %>selected<% }%> --%> >All</option>
										   		<% for (Object[] obj : divisionlist) {%>
													<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(divisionid)){ %>selected<% } %>  ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>(<%=obj[4] !=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%>)</option>
												<%} %>
								  			</select>
								  			<input type="hidden" name="initiationid" value="0" />
								  			<input type="hidden" name="projectid" value="0" />
								  			<input type="hidden" name="term" id="termd" value="<%=Term %>" />
								  			<input type="hidden" name="typeid" id="typeidd" value="<%=typeid %>" />
								  			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								  		</form>
							  		</div>
							  		<%if(typeid.equals("I")){ %>
		                            <div   id="initiationdiv" class="width-100 projectDivBlock">
		                            <%}else{ %>
		                            <div   id="initiationdiv" class="width-100 projectDivNone">
		                            <%} %>
							  			<form method="post" action="MeetingReports.htm"  id="initform">		
								   			<label class="control-label fs-17px">Initiation: </label>
								   					
			                               	<select class="form-control items width-100"  id="initiationid" name="initiationid" required="required"  onchange="submitForm('initform');" >
												<option value="" disabled="disabled" selected >Choose...</option>
												<option value="A" <%--  <%if(initiationid.equalsIgnoreCase("A")){ %>selected<% }%> --%> >All</option>
										   		<% for (Object[] obj : initiationlist ) {%>
												<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(initiationid)){ %>selected<% } %>  ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>(<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %>)</option>
												<%} %>
								  			</select>
								  			<input type="hidden" name="divisionid" value="0" />
								  			<input type="hidden" name="projectid" value="0" />
								  			<input type="hidden" name="typeid" id="typeidi" value="<%=typeid %>" />
								  			<input type="hidden" name="term" id="termi" value="<%=Term %>" />
								  			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							  			</form>
							  		</div>	
							  	</div>
					   		
					   	</div> 

					
    					<div class="data-table-area mg-b-15 mt-3">
							<div class="container-fluid">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">
										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<div id="toolbar">
													
												</div>
												<table class="table table-bordered table-hover table-striped table-condensed" id="myTable12" >

													<thead>

														<tr class="text-center">
															<th>SN </th>
															<th class="text-left">Meeting Id</th>
															<th>Date & Time</th>
															<th>Committee</th>																							
														 	<th >Venue</th>					 	
														 	<!-- <th >Role</th> -->
														</tr>
													</thead>
													<tbody>
														<%int count=1;
															if(MeetingReports!=null&&MeetingReports.size()>0)
															{
												   				for (Object[] obj :MeetingReports) 
												   				{ %>
																<tr>
																	<td class="center" ><%=count %></td>
																	<td>
																		<form action="CommitteeMinutesViewAll.htm" >
																			<button  type="submit" class="btn btn-outline-info" formtarget="_blank" ><%=obj[5] %></button>
																			<input type="hidden" name="committeescheduleid" value="<%=obj[0] %>" />
																		</form>
																	</td>
																	<td class="text-center"><%=obj[1]!=null?sdf.format(obj[1]): " - " %> - <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%></td>																		
																	<td class="text-center"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%></td>
																  	<td> <%if(obj[6]!=null){ %> <%=StringEscapeUtils.escapeHtml4(obj[6].toString())%><%}else{ %>-<%} %></td>
																	<%-- <td>
																		<%if("CS".equalsIgnoreCase(obj[6].toString())){ %> Member Secretary <%} %>
																		<%if("CC".equalsIgnoreCase(obj[6].toString())){ %> Chairperson <%} %>
																		<%if("P".equalsIgnoreCase(obj[6].toString())){ %> Presenter <%} %>
																		<%if("CI".equalsIgnoreCase(obj[6].toString())){ %> Committee Member <%} %>																		
																		<%if("I".equalsIgnoreCase(obj[6].toString())){ %> Internal Member<%} %>
																	</td>		 --%>
																</tr>
															<% count++;
																}									   					
														}%>
													</tbody>
												</table>												
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
						<br>
						<div class="card-footer" align="right">&nbsp;</div>
					</div>
				</div>
			</div>
		</div>

						
					<script type="text/javascript">
					
					function changeterm(){
						var term=$('#term').val();
						$("#termp").val(term);
						$("#termd").val(term);
						$("#termi").val(term);
						var typeid=$('#typeid').val();
						if(typeid=='A' || typeid=='G'){
							
							submitForm('fieldform');
						}
						
					}
					
					function projectfieldchange()
					{
						
						var typeid=$('#typeid').val();
						$("#typeidp").val(typeid);
						$("#typeidd").val(typeid);
						$("#typeidi").val(typeid);
													
											
						if(typeid=='A' || typeid=='G'){
							
							submitForm('fieldform');
						}
						
						if(typeid=='P'){
							console.log('P');
							$("#divisiondiv").hide();
							$("#initiationdiv").hide();
							$("#projectdiv").show();
						}		
						
						if(typeid=='D'){
							console.log('D');							
							$("#initiationdiv").hide();
							$("#projectdiv").hide();
							$("#divisiondiv").show();
						}	
						if(typeid=='I'){
							console.log('I');
							$("#divisiondiv").hide();
							$("#projectdiv").hide();
							$("#initiationdiv").show();
						}	
					}
					
													
				</script>
					
			
		

	
<script type='text/javascript'> 
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 
$('.items').select2();



$('#fdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	"maxDate" : new Date(),
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#tdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	"maxDate" : new Date(),
	
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});



function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
	 
	
		  return true;
	 
			
	}
	
	
$(document).ready(function(){
	  $("#myTable12").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 10

	});
});
</script>


</body>
</html>