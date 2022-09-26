<%@page import="java.time.format.TextStyle"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    <%@page import="java.time.LocalTime"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<jsp:include page="../static/header.jsp"></jsp:include>

<title> AUTO SCHEDULE</title>

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

a:hover {
	color: white;
}



</style>
<style type="text/css">
		.input-group-text {
			font-weight: bold;
		}

		label {
			font-weight: 800;
			font-size: 16px;
			color: #07689f;
		}

		hr {
			margin-top: -2px;
			margin-bottom: 12px;
		}

		.card b {
			font-size: 20px;
		}
		
		#content {
    	 margin-bottom: 0%; 
		}
		
	</style>
</head>

<body>

<% 

SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
Object[] committeedata=(Object[])request.getAttribute("committeedata");
Object[] startdate=(Object[])request.getAttribute("startdate");
List<Object[]> CommitteeAutoScheduleList=(List<Object[]>)request.getAttribute("CommitteeAutoScheduleList");
String Dashboard= (String)request.getAttribute("dashboard");
List<Object[]> committeelist=(List<Object[]>)request.getAttribute("committeelist");
String committeeid=(String)request.getAttribute("committeeid");
%>

<%String ses=(String)request.getAttribute("result"); 
 String ses1=(String)request.getAttribute("resultfail");
	if(ses1!=null){
	%>
	<center>
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></center>
                    <%} %>

    <br />
    
    
    <div class="container-fluid">
		
	<div class="row">
		<div class="col-md-12">	
				
			<%if(Dashboard.equalsIgnoreCase("nondashboard")){ %>	
				
			<div class="card shadow-nohover">
				<div class="card-header">
					
					<div class="row">
					
						<div class="col-md-4">	
							<h3 class="control-label" > <%=committeedata[1] %> Auto Schedule </h3> 
						</div>
						
						<div class="col-md-5">	</div>
						
					
							<div class="col-md-3">	
							
							<!-- <form method="get" action="CommitteeAutoScheduleList.htm" id="form" >
								<button type="submit" name="" value="" class="btn btn-sm viewall" style="float:right" >AUTO-SCHEDULED LIST</button>
							</form>	 -->						
						</div>		
						
					</div>
				</div>
				
		
				<form action="NonProjectCommitteeAutoSchedule.htm" method="post" id="myfrm" >
				<div class="card-body">
						
							<div class="row">
							
									<div class="col-md-2">
										<div class="form-group">
											<label class="control-label">From </label>
											 <input  class="form-control"  data-date-format="dd/mm/yyyy" readonly="readonly" id="fdate" name="fromdate"  required="required" value="<%=startdate[0]%>">
										</div>
									</div>

									<div class="col-md-2">
										<div class="form-group">
											<label class="control-label">To </label> 
											<input  class="form-control"  data-date-format="dd/mm/yyyy" readonly="readonly" id="tdate" name="todate"  required="required" value="">
										</div>
									</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Time : </label>
										<input  class="form-control" type="text" id="starttime" name="starttime"  required="required"  readonly="readonly" value="<%=LocalTime.now() %>" >
									</div>
								</div>

							</div>
							<input type="hidden" name="committeeid" value="<%=committeedata[0]%>"/>												
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
				</form>	
				
				<form action="CommitteeList.htm" method="post" id="backfrm">
					<input type="hidden" name="id" value="N" />
					<input type="hidden" name="projectid" value="0" />
					<input type="hidden" name="npc" value="Y" />
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				
				</form>
				
				
				
			</div>		
			
			<%} %>
				
		</div>
	</div>
	
	<br>
	
	<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" <%if(!Dashboard.equalsIgnoreCase("nondashboard")){ %>	style="margin-top:-2%;" <%} %> >
				
					<div class="card-header ">
					<div class="row">
					
						<%if(Dashboard.equalsIgnoreCase("nondashboard")){ %>	
					
						<h3 class="col-md-7">Previous Schedules List</h3>
					
						<%} %>
						
						<%if(!Dashboard.equalsIgnoreCase("nondashboard")){ %>	
						
						<h3 class="col-md-7">General Schedules List <%if(!committeeid.equals("A")){ %> (<%=committeedata[1] %> )  <%} %></h3>
					
						<%} %>
					
						<%if(!Dashboard.equalsIgnoreCase("nondashboard")){ %>	
					
						<div class="col-md-5"  style="float: right;">							
							<form class="form-inline" method="post" action="NonProjectCommitteeAutoSchedule.htm" id="myform">
								
									<h4 class="control-label" > Committee : </h4> &nbsp;&nbsp;&nbsp;
			
									 <select class="form-control selectdee"  id="committeeid" required="required" name="committeeid" onchange='submitdropdown();' >
					   						 <option value="all" <%if(committeeid.equals("A")){ %>selected<% } %> >All</option> 
					   						<% for (Object[] obj : committeelist) {%>					   						
											<option value="<%=obj[1]%>" <%if(obj[1].toString().equals(committeeid)){ %>selected<% } %> ><%=obj[4]%>(<%=obj[5] %>)</option>												
											<%} %>											
					  				</select>
					  				
					  				<input type="hidden" name="dashboardlink" value="dashboard" id="dashboardlink" />							
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
							</form>		 				
						</div>	
						
						<%} %>
						
						
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
															<th>Serial No</th>		
															<%-- <%if(committeeid.equals("all")){ %>
																<th>Committee Shortname</th>															
															<%} %> --%>							
															<th>Schedule Date</th>
															<th>Schedule Time</th>
															<th>Status</th>
															<th>Action</th>
														</tr>
													</thead>
													<tbody>
														<%int count=1;
										   					for (Object[] obj :CommitteeAutoScheduleList) {
										   					%>
														<tr>
															<td><%=count %></td>
															
															<%-- <%if(committeeid.equals("all")){ %>
																<td><%=obj[3] %></td>															
															<%} %> --%>
																														
															
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
															
															<td class="left width" style="text-align: left">

																<form action="CommitteeAutoScheduleEdit.htm" method="post" name="myfrm"
																	style="display: inline">

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
																
																<input type="hidden" name="scheduleid" value="<%=obj[4] %>" /> 
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

																</form> 		
																
																
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
    

<script type="text/javascript">   
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 

function submitdropdown(){
	
	$('#myform').submit();
	
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
	fromDate= fromDate.split('-');
	var fDate = new Date (Number(fromDate[2]), Number(fromDate[1])-1,Number(fromDate[0] )); 
	fDate.setDate( fDate.getDate() +1 );
	
	
$('#tdate').daterangepicker({

	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	"minDate":fDate,
	
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
	<%if(startdate!=null && startdate[0]!=null){%>
		"startDate":"<%= sdf1.format(sdf.parse( startdate[0].toString()))%>", 
	<%}else{%>
		"startDate" : new Date(),
	<%}%>
	locale: {
    	format: 'DD-MM-YYYY'
		}
});
</script>

	
		
		
</body>

</html>