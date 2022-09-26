<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>NOTICE LIST</title>
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
	width: 33px;
	height: 30px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 120px;
}

.cc-rockmenu .viewcommittees:hover {
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
</head>
<body>
<%
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
String empid=(String) request.getAttribute("empid");
List<Object[]> ActionSelfList=(List<Object[]>)request.getAttribute("actionselflist");
String fromdate=(String)request.getAttribute("fromdate");
String todate=(String)request.getAttribute("todate");
%>

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
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

    <br/>


	

	
<div class="container-fluid">		
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -25px;">					
						<div class="card-header">
						<h4>Add Action Reminders 
																
									<a href="MainDashBoard.htm"  class="btn btn-sm back"  style="margin-left :25px ; float: right;"> Back</a>
								
						</h4>
						</div>						
						<div class="card-body">
							<form action="ActionSelfReminderAddSubmit.htm" method="POST" name="myfrm" id="myfrm">
								<div class="row">
                               
									<div class="col-md-2">
										<div class="form-group">
											<label class="control-label">Action Date </label>
											<input  class="form-control "  data-date-format="dd/mm/yyyy" id="actiondate" name="actiondate"  required="required" readonly >		                    
										</div>
									</div>

									<div class="col-md-2">
										<div class="form-group">
											<label class="control-label">Action Time </label> 
											<input  class="form-control" type="text" id="actiontime" name="actiontime"  required="required" value="<%=LocalTime.now() %>" readonly>
										</div>
									</div>									
									
									<div class="col-md-2">
										<div class="form-group">
											<label class="control-label">Action Type </label> 
											<select class="custom-select" id="actiontype" required="required" name="actiontype" >
												<option disabled="true"  selected value="">Choose...</option>
												<option  value="M" >Meeting</option>
												<option  value="N" >Normal</option>												
											</select>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label">Action Item</label> 
										    <textarea class="form-control" name="actionitem" maxlength="255" placeholder="Action Item 255 characters Max" required="required"></textarea>
										</div>
									</div>
								</div>
								<div class="form-group" align="center" style="margin-bottom: 10px;">
									<input type="submit" class="btn btn-primary btn-sm submit "	id="sub" value="SUBMIT" name="sub" onclick="return confirm('Are you sure To Add this Reminder?')" />
									<input type="hidden" name="empid" value="<%=empid %>"	 />								
								</div>
								<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
							</form>
						</div>			
				</div>
				<!--Notice Add From  End  -->

			</div>
		</div>

	</div>	
	
	
	<div class="container-fluid">		
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -25px;">					
					<div class="card-header">
						<div class="row">
							<div class="col-md-4">
								<h4>Action Reminder List</h4>
							</div>
							<div class="col-md-4"></div>
							<div class="col-md-4">
								<form action="ActionSelfReminderAdd.htm" method="post" name="remfrm" id="remfrm">
									<table>
										<tr >
											<td style="padding: 10px;">From</td>
											<td><input class="form-control" data-date-format="dd/mm/yyyy" id="fromdate" name="fromdate" required="required" value="<%=fromdate%>"></td>
											<td style="padding: 10px;" >To</td>
											<td><input class="form-control" data-date-format="dd/mm/yyyy" id="todate" name="todate" required="required" value="<%=todate%>"></td>
											<td style="padding-left : 10px;" ><input class="btn btn-sm submit" type="submit" name="submit" value="SUBMIT"/></td>										
										</tr>
									</table>
									<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />								
								</form>							
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
												<div id="toolbar">
													
												</div>
									   <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
													<thead>
														<tr>
															<th>SN.</th>															
															<th class="width-400px">Action Item</th>
															<th>Action Date</th>
															<th>Action Time</th>
															<th>Action Type</th>
															<th>Remove</th>							 	
														</tr>
													</thead>
													<tbody>
														<%if(ActionSelfList!=null && ActionSelfList.size()>0){
															long count=1;
															for(Object[] obj : ActionSelfList){%>
																<tr>
																	<td ><%=count%></td>
																	<td><span  <%if(LocalDate.now().toString().equals(obj[3].toString())){ %>style="color: red;font-weight: bold; " <%} %> ><%=obj[2] %></span></td>
																	<td><span  <%if(LocalDate.now().toString().equals(obj[3].toString())){ %>style="color: red;font-weight: bold; " <%} %> ><%=sdf.format(obj[3])%></span></td>
																	<td><%=obj[4] %></td>
																	<td><%if(obj[5].toString().equals("M")){ %> Meeting<%}else if(obj[5].toString().equals("N")){ %> Normal <%} %>  </td>
																	<td> 
																		<form action="ActionSelfReminderDelete.htm" method="Post">
																			<button type="submit" class="btn btn-danger btn-sm" name="action" value="delete" onclick="return confirm('Are you sure To Delete this Reminder?')" > <i class="fa fa-trash" aria-hidden="true" ></i></button>
																			<input type="hidden" name="actionid" value="<%=obj[0] %>" />
																			<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
																		</form>						
																	</td>	
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
						
				</div>
			</div>
		</div>
	</div>
	
	
	<script type="text/javascript">

	
	</script>
	
	
	
	
<script type="text/javascript">
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
	
	$("#myTable").DataTable({
		"pageLength": 10;
	})
})

</script>

<script type="text/javascript">

var fromDate=null;
$("#fromdate").change(function(){
	
	 fromDate = $("#fromdate").val();


$('#todate').daterangepicker({

	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	"minDate":fromDate,
	
	locale: {
    	format: 'DD-MM-YYYY'
		}
		
});
});
$('#fromdate').daterangepicker({
	
	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	
	locale: {
    	format: 'DD-MM-YYYY'
		}
});


$(document).ready(
		function(){
			
			 fromDate = $("#fromdate").val();


		$('#todate').daterangepicker({

			"singleDatePicker": true,
			"showDropdowns": true,
			"cancelClass": "btn-default",
			"minDate":fromDate,
			
			locale: {
		    	format: 'DD-MM-YYYY'
				}
				
		});
		});



</script>



<script type="text/javascript">   

$('#actiondate').daterangepicker({
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
	   $('#actiontime').daterangepicker({
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


<div class="modal" id="loader">
					<!-- Place at bottom of page -->
				</div>
</body>
</html>