<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<script src="./resources/js/multiselect.js"></script>
<link href="./resources/css/multiselect.css" rel="stylesheet"/>
 

<title>New FRACAS</title>

<title> ADD COMMITTEE</title>
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
	SimpleDateFormat sdf1=fc.getSqlDateFormat();
	
    List<Object[]>  employeelist=(List<Object[]>)request.getAttribute("employeelist");
    Object[]  fracasitemdata=(Object[])request.getAttribute("fracasitemdata");
    String fracasmainid=fracasitemdata[0].toString();
    List<Object[]>  fracasassignedlist=(List<Object[]>)request.getAttribute("fracasassignedlist");
    
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
  
    
    
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header">
					<h4 class="text-blue">Assign FRACAS Item</h4>
				</div>
				<div class="card-body">
					<form method="post" action="FracasAssignSubmit.htm" enctype="multipart/form-data" >
							<div class="row">		
							
							
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Assignee</label>
										<select class="form-control"  name="employeeid" id="employeeid"  data-live-search="true" required  data-placeholder="Select Members" multiple style="width:100%;">
											<%for(Object[] obj:employeelist){ %>																							
											<option value="<%=obj[0]%>"><%=obj[1]%>, <%=obj[2]%></option>																				
											<%} %>
										</select>
									</div>
								</div>
							
							
													
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">PDC</label>
										<input  class="form-control"  data-date-format="dd/mm/yyyy" id="pdc" name="pdc" readonly="readonly" required="required"   value="<%= sdf.format(sdf1.parse( LocalDate.now().toString()))%>">
									</div>
								</div>
										
								<div class="col-md-4">
									<label class="control-label">Remarks</label>
									<input type="text" class="form-control " name="remarks" maxlength="150"  >
								</div>
							</div>
							<br>
							<div class="row" style="">
								<div class="col-md-4"> </div>
								<div class="col-md-4" align="center">
									<button type="submit" class="btn btn-sm btn-primary submit"  onclick="return confirm('Are you Sure To Add this FRACAS Item?');">SUBMIT</button>
									<button type="button" class="btn btn-sm btn-primary back" onclick="submitForm()">BACK</button>
									<!-- <a class="btn btn-sm btn-primary  back"  href="MainDashBoard.htm" >BACK</a> -->
								 </div>
							</div>
							<input type="hidden" name="fracasmainid" value="<%=fracasmainid %>" >
							
							
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</div>
				<!-- <div class="card-footer"><br>
				</div> -->
				
				
				
			</div>
		</div>	
	</div>
</div>
 <br>
 
 <%if(fracasassignedlist.size()>0){ %>
 <div class="container-fluid" >
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header">
					<h4 class="text-blue">Assigned List</h4>
				</div>
				<div class="card-body">
						<div class="table-responsive">
	   					<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" > 
	   						<thead>
														<tr>
															<th>SN.</th>
															<th>Assignee</th>
															<th>Remarks</th>
															<th>PDC</th>
															<th>Progress</th>
															<th>Actions</th>
														</tr>
													</thead>   
													<%for(int i=0;i<fracasassignedlist.size();i++){ %>
														<tr>
															<td><%=i+1 %></td>
															<td><%=fracasassignedlist.get(i)[10] %>(<%=fracasassignedlist.get(i)[11] %>)</td>
															<td><%=fracasassignedlist.get(i)[2] %></td>
															<td><%= sdf.format(sdf1.parse( fracasassignedlist.get(i)[3].toString() ))%></td>
															<td style="width:15%;">									
																	<%if(fracasassignedlist.get(i)[13]!=null){ %>
															           <div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																            <div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=fracasassignedlist.get(i)[13]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																	            <%=fracasassignedlist.get(i)[13]%>
																	        </div> 
																	   </div> 
																	<%}else{ %>
																	   <div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																		   <div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																	             Not Yet Started .
																	   		</div>
																	   </div> <%} %>
															</td>	
															<td>
																 <form action="FracasToReviewDetails.htm" method="post" style="display: inline">
																	<button class="editable-click" name="sub" value="Modify">
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<i class="fa fa-window-close fa-lg" style="color: red;" aria-hidden="true"></i>
																				</figure>
																				<span>Close</span>
																			</div>
																		</div>
																	</button>															
																	<input type="hidden" name="forceclose"	value="Y" />
																	<input type="hidden" name="fracasassignid"	value="<%=fracasassignedlist.get(i)[0] %>" /> 
																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																</form>	
															</td>
														</tr>
													<%} %>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
  <%} %>
 				<form action="FracasMainItemsList.htm" method="post" id="backfrm">
					<input type="hidden" name="fracasmainid" value="<%=fracasmainid %>" >
					<input type="hidden" name="projectid" value="<%=fracasitemdata[4] %>" >
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />				
				</form>
</body>
<script type="text/javascript">
function submitForm()
{ 
  document.getElementById('backfrm').submit(); 
} 
</script>


<script type="text/javascript">
$('#employeeid').select2();
$('#pdc').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate":new Date(), */
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

</script>

 <script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
  });
  

</script>


</html>