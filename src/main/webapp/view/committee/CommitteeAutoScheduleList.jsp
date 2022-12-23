<%@page import="java.time.LocalDate,java.time.format.TextStyle"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>


<title>COMMITTEE AUTO SCHEDULE LIST </title>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
}

body {
	background-color: #f2edfa;
}

.table .font {
	font-family: 'Muli', sans-serif !important;
	font-style: normal;
	font-size: 13px;
	font-weight: 400 !important;
}

.table button {
	background-color: Transparent !important;
	background-repeat: no-repeat;
	border: none;
	cursor: pointer;
	overflow: hidden;
	outline: none;
	text-align: left !important;
}

.table td {
	padding: 5px !important;
}

.resubmitted {
	color: green;
}

.fa {
	font-size: 1.20rem;
}

.datatable-dashv1-list table tbody tr td {
	padding: 8px 10px !important;
}

.fa-exclamation-triangle {
	font-size: 2.5rem !important;
}

.table-project-n {
	color: #005086;
}

.right {
	text-align: right;
}

.center {
	text-align: center;
}

#table thead tr th {
	padding: 0px 0px !important;
	text-align:center;
}

#table tbody tr td {
	padding: 2px 3px !important;
	text-align:center;
}

/* icon styles */
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 30px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 157px;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 28px;
	height: 52px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
}

.cc-rockmenu .rolling .rolling_icon:hover .rolling {
	width: 312px;
}

.cc-rockmenu .rolling i.fa {
	font-size: 20px;
	padding: 6px;
}

.cc-rockmenu .rolling span {
	display: block;
	font-weight: bold;
	padding: 2px 0;
	font-size: 14px;
	font-family: 'Muli', sans-serif;
}

.cc-rockmenu .rolling p {
	margin: 0;
}

.width {
	width: 270px !important;
}



.table .font{
	  font-family:'Muli', sans-serif !important;
	  font-style: normal;
	  font-size: 13px;
	  font-weight: 400 !important;
	 
}



</style>
</head>
<body>

	<%
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
List<Object[]> CommitteeAutoScheduleList=(List<Object[]>)request.getAttribute("CommitteeAutoScheduleList");
String projectname=(String) request.getAttribute("ProjectName");
List<Object[]> committeelist=(List<Object[]>)request.getAttribute("committeelist");
List<Object[]> ProjectsList=(List<Object[]>)request.getAttribute("ProjectsList");
String committeeid=(String) request.getAttribute("committeeid");
String projectid=(String) request.getAttribute("projectid");
String divisionid=(String) request.getAttribute("divisionid");
String initiationid=(String) request.getAttribute("initiationid");
String projectstatus=(String) request.getAttribute("projectstatus");
%>

 <!-- ----------------------------------message ------------------------- -->

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

<!-- ----------------------------------message ------------------------- -->

	<br>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">				
					<div class="card-header ">
					<div class="row">
						<h5 class="col-md-4"> Auto-Scheduled List for <%=projectname%></h5>
						
						
						<div class="col-md-2"  >							
							<form class="form-inline" method="post" action="CommitteeAutoScheduleList.htm" id="myform">
								
									<h6 class="control-label" > Project : </h6> &nbsp;&nbsp;&nbsp;
			
					  				<select class="form-control" id="projectid" required="required" name="projectid" onchange='submitForm("myform");' >
						   						<% for (Object[] obj : ProjectsList) {%>
												<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(projectid)){ %>selected<%  } %> ><%=obj[4]%></option>
													
												<%} %>
						  			</select>
					  				<input type="hidden" name="projectname"	value="<%=projectname%>" />
						  			<input type="hidden" name="projectid"	value="<%=projectid%>" /> 
						  			<input type="hidden" name="divisionid"	value="<%=divisionid%>" /> 	
						  			<input type="hidden" name="initiationid" value="<%=initiationid%>" /> 
						  			<input type="hidden" name="projectstatus" value="<%=projectstatus%>" />  							
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
							</form>						
						</div>	
						
						<div class="col-md-2"  >							
							<form class="form-inline" method="post" action="CommitteeAutoScheduleList.htm" id="myform2">
								
									<h6 class="control-label" > Committee : </h6> &nbsp;&nbsp;&nbsp;
			
									 <select class="form-control"  id="committeeid" required="required" name="committeeid" onchange='submitForm("myform2");' >
					   						<option value="all" <%if(committeeid.equals("all")){ %>selected<% } %> >All</option>
					   						<% for (Object[] obj : committeelist) {%>					   						
											<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(committeeid)){ %>selected<% } %> ><%=obj[3]%></option>												
											<%} %>											
					  				</select>
					  				<input type="hidden" name="projectname"	value="<%=projectname%>" />
						  			<input type="hidden" name="projectid"	value="<%=projectid%>" /> 
						  			<input type="hidden" name="divisionid"	value="<%=divisionid%>" /> 	
						  			<input type="hidden" name="initiationid" value="<%=initiationid%>" /> 	
						  			<input type="hidden" name="projectstatus" value="<%=projectstatus%>" />  						
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
							</form>						
						</div>	
						
						<div class="col-md-3"  style="padding-left: 80px;">							
							<form class="form-inline" method="post" action="CommitteeAutoScheduleList.htm" id="myform1">
								
									<h6 class="control-label" > Status :  </h6> &nbsp;
			
					  				<select class="form-control" id="projectstatus" required="required" name="projectstatus" onchange='submitForm("myform1");' >
										<option value="A" <%if(projectstatus.equals("A")){ %>selected<% } %> >All</option>
										<option value="B" <%if(projectstatus.equals("B")){ %>selected<% } %>>Already Held</option>
										<option value="C" <%if(projectstatus.equals("C")){ %>selected<% } %>>To Be Held</option>
						  			</select>
					  				<input type="hidden" name="projectname"	value="<%=projectname%>" />
						  			<input type="hidden" name="projectid"	value="<%=projectid%>" /> 
						  			<input type="hidden" name="divisionid"	value="<%=divisionid%>" /> 	
						  			<input type="hidden" name="initiationid" value="<%=initiationid%>" />
						  			<input type="hidden" name="committeeid" value="<%=committeeid%>" />
						  			<%-- <input type="hidden" name="projectstatus" value="<%=projectstatus%>" />  	 --%>						
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
							</form>						
						</div>
						<div class="col-md-1">
							<%if(divisionid !=null && divisionid.equalsIgnoreCase("D")){ %>
							<form action="MainDashBoard.htm">
								<button type="submit" class="btn btn-primary btn-sm back"  style="margin-bottom: 2%">BACK</button>
							</form>
							
							<%}else { %>
							<%if(Long.parseLong(projectid)>0){ %>
							<form action="ProjectMaster.htm" method="post">
								<button type="submit" class="btn btn-primary btn-sm back"  style="margin-bottom: 2%">BACK</button>
								<input type="hidden" name="projectid"	value="<%=projectid%>" /> 
								<input type="hidden" name="divisionid"	value="<%=divisionid%>" /> 
								<input type="hidden" name="initiationid" value="<%=initiationid%>" /> 
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>
							<%}else if(Long.parseLong(divisionid)>0) {%>
								<form action="DivisionCommitteeMaster.htm" method="post">
								<button type="submit" class="btn btn-primary btn-sm back"  style="margin-bottom: 2%">BACK</button>
								<input type="hidden" name="projectid"	value="<%=projectid%>" /> 
								<input type="hidden" name="divisionid"	value="<%=divisionid%>" /> 
								<input type="hidden" name="initiationid" value="<%=initiationid%>" /> 
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>
							<%}else if(Long.parseLong(initiationid)>0) {%>
								<form action="InitiationCommitteeMaster.htm" method="post">
								<button type="submit" class="btn btn-primary btn-sm back"  style="margin-bottom: 2%">BACK</button>
								<input type="hidden" name="projectid"	value="<%=projectid%>" /> 
								<input type="hidden" name="divisionid"	value="<%=divisionid%>" /> 
								<input type="hidden" name="initiationid" value="<%=initiationid%>" /> 
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>
							<%}} %>	
						</div>
						</div>				
					</div>
					
					<div class="card-body">

						<div class="data-table-area mg-b-15">
							<div class="container-fluid">

								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">

										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												
												<table id="table" data-toggle="table" data-pagination="true" data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" data-show-refresh="true" data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true" data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar">
													<thead>

														<tr>
															<th>SN</th>		
															<%if(committeeid.equals("all")){ %>
																<th>Committee Short Name</th>															
															<%}else{ %>
																<th>Schedule No</th>		
															<%} %>							
															<th>Schedule Date</th>
															<th>Schedule Time</th>
															<th class="width" >Status</th>
															<th>Action</th>
															
														</tr>
													</thead>
													<tbody>
														<%int count=1;
															int count1=CommitteeAutoScheduleList.size();
										   					for (Object[] obj :CommitteeAutoScheduleList) {
										   					%>
														<tr>
															<td><%=count %></td>
															
															<%if(committeeid.equals("all")){ %>
																<td><%=obj[3] %></td>															
															<%}else{ %>
																<td><%=obj[3] %>&nbsp;<%=count1-- %></td>															
															<%} %>
																<%String day=LocalDate.parse(obj[0].toString()).getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.US);%>														
															<td   >	
																	<span<%if(day.equalsIgnoreCase("sunday") || day.equalsIgnoreCase("saturday")){ %> style="color: red" <%} %> > <%=day%> </span>&nbsp; 
																	- &nbsp;<%=LocalDate.parse(obj[0].toString()).getMonth().getDisplayName(TextStyle.FULL, Locale.US)%> &nbsp; 
																	- &nbsp; <%= sdf1.format(sdf.parse( obj[0].toString()))%>  
															</td>
															<td><%=obj[1] %></td>
															<td class="editable-click"><%if(obj[6]!=null){%>
																<a class="font" href="CommitteeScheduleView.htm?scheduleid=<%=obj[4]%>" target="_blank" 
																
																<%if(obj[5].toString().equalsIgnoreCase("MSC") || obj[5].toString().equalsIgnoreCase("MAF") || obj[5].toString().equalsIgnoreCase("MMF") || obj[5].toString().equalsIgnoreCase("MKO")  ){ %> style="color:#007bff"<%} %>
																<%if(obj[5].toString().equalsIgnoreCase("MAA") || obj[5].toString().equalsIgnoreCase("MKV") || obj[5].toString().equalsIgnoreCase("MMA") ){ %> style="color:green"<%} %>
																<%if(obj[5].toString().equalsIgnoreCase("MAR") || obj[5].toString().equalsIgnoreCase("MMR") ){ %> style="color:red"<%} %>
																<%if(obj[5].toString().equalsIgnoreCase("MAS") || obj[5].toString().equalsIgnoreCase("MMS") ){ %> style="color:orange"<%} %>
																
																 ><%=obj[6] %><%}else{ %>-<%} %></a>
															</td>
															<td class="left width" align="center" >
																<%if(Long.parseLong(obj[7].toString())<7){ %>
																		<form action="CommitteeAutoScheduleEdit.htm" method="post"  style="display: inline">
		
																			<button class="editable-click" name="sub"
																				value="Modify">
																				<div class="cc-rockmenu">
																					<div class="rolling">
																						<figure class="rolling_icon">
																							<img src="view/images/edit.png">
																						</figure>
																						<span>Modify</span>
																					</div>
																				</div>
																			</button>
																			<input type="hidden" name="projectname" value="<%=projectname%>" /> 	
																			<input type="hidden" name="scheduleid" value="<%=obj[4] %>" /> 
																			<input type="hidden" name="projectstatus" value="<%=projectstatus%>" /> 
																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		
																		</form> 		
																	<%}else if(Long.parseLong(obj[7].toString())>=7){ %>
																			<form class="form-inline" method="POST" action="CommitteeMinutesViewAll.htm" target="_blank" style="display: inline"> 
																				<!-- <button type="submit" class="btn btn-sm" style="font-size:12px;color: purple; " >VIEW MINUTES</button> -->
																				<button class="editable-click" name="sub"
																				value="Modify">
																				<div class="cc-rockmenu">
																					<div class="rolling">
																						<figure class="rolling_icon">
																							<img src="view/images/preview3.png">
																						</figure>
																						<span>Minutes</span>
																					</div>
																				</div>
																			</button>
																				<input type="hidden" name="committeescheduleid" value="<%=obj[4]%>">
																				<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
																			</form>
																	<%} %>
																
																<%-- <form action="CommitteeMainEdit.htm" method="post" name="myfrm"
																	style="display: inline">

																	<button class="editable-click" name="sub" value="Details" 	>
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>View Committees</span>
																			</div>
																		</div>
																	</button>

																	<input type="hidden" name="committeeid"	value="<%=obj[0] %>" />
																	
 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

																</form>  --%>
																	
															</td>
														</tr>
														
														<% count++; } %>

												</tbody>
												</table>
												
												<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />


											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					</div> <!-- card-body end  -->
				</div> <!-- card-end -->
			</div>
		</div>
	</div>



<script type='text/javascript'> 


function submitForm(value)
{ 
  document.getElementById(value).submit(); 
} 




</script>


	<script type="text/javascript">
	
	
	$("#fromyear,#toyear").datepicker({
		
		autoclose: true,
		 format: 'yyyy',
			 viewMode: "years", 
			    minViewMode: "years"
	});

	

	
	  $('#fromyear,#toyear').on('keyup', function() { 
	    if($(this).val().length > 3) {
	        $('#form1').submit();
	    }
	});  
	
	 
	 
	
	
	
	

$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
	 
	
	
		 
	
		  return true;
	 
			
	}

/* 
$(document).ready(function(){
	
	$("#table").DataTable({
		"pageLength": 5
	})
})
 */


</script>
</body>
</html>