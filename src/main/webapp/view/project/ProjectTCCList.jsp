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


<title>PROJECT TCC LIST</title>
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
}

#table tbody tr td {
	padding: 2px 3px !important;
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
	width: 108px;
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



</style>
</head>
<body>

	<%
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
List<Object[]> TCCList=(List<Object[]>) request.getAttribute("TCCList");
String fromyear=(String)request.getAttribute("fromyear");
String toyear=(String)request.getAttribute("toyear");

%>



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



	<br>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<h3 class="card-header">Technology Council Committee List</h3>

					<div class="card-body">

						<div class="data-table-area mg-b-15">
							<div class="container-fluid">


								<!-- <form action="ProjectIntiationListSubmit.htm" method="POST" name="myfrm" > -->

								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">

										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<div id="toolbar">
													<select class="form-control dt-tb">
														<option value="">Export Basic</option>
														<option value="all">Export All</option>
														<option value="selected">Export Selected</option>
													</select>
												</div>
												<table id="table" data-toggle="table" data-pagination="true"
													data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" data-show-refresh="true"
													data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true"
													data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar">
													<thead>

														<tr>
															<th>From Date</th>
															<th>To Date</th>
															<th>Chairperson</th>
															<th>Secretary</th>
															<th>Modify</th>
														</tr>
													</thead>
													<tbody>
														<%
										   	for (Object[] obj : TCCList) {
										   %>
														<tr>
															<td><%=sdf1.format(sdf.parse(obj[1].toString()))%></td>
															<td><%=sdf1.format(sdf.parse(obj[2].toString()))%></td>
															<td><%=obj[3]%>&nbsp;(<%=obj[6] %>)</td>
															<td><%=obj[4]%>&nbsp;(<%=obj[7] %>)</td>
															
															<td class="left width">


															<% if(obj[5].toString().equals("1")){%>
																<form action="TCCModify.htm" method="POST" name="myfrm"
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

																	<input type="hidden" name="Pfmstccid"
																		value="<%=obj[0] %>" /> <input type="hidden"
																		name="${_csrf.parameterName}" value="${_csrf.token}" />

																</form><%} %>
																
																
																<% if(obj[5].toString().equals("0")){%>
																<form action="AllTccDetails.htm" method="POST" name="myfrm"
																	style="display: inline">

																	<button class="editable-click" name="sub"
																		value="Modify">
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Details</span>
																			</div>
																		</div>
																	</button>

																	<input type="hidden" name="Pfmstccid" value="<%=obj[0] %>" /> <input type="hidden"
																		name="${_csrf.parameterName}" value="${_csrf.token}" />

																</form><%} %>
																</td>
																</tr>
												<%} %>

												</tbody>
												</table>
												
				<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />


											</div>
										</div>
									</div>
								</div>



								<!--    </form> -->


							</div>
						</div>

					</div>
				
				
				<div class="card-footer" align="right">
				<form method="get" id="form1" action="TechnicalCommeetList.htm" >
					<table border="0">
						<td><b>From &emsp; :</b></td>
						<td><input type="text"  class="form-control" id="fromyear" name="fromyear" onkeypress='validate(event)' value="<%= fromyear %>" minlength=4 maxlength=4 ></td>
						<td><b>To &emsp; : </b></td>
						<td><input type="text"  class="form-control" id="toyear" name="toyear" onkeypress='validate(event)' value="<%= toyear %>" minlength=4 maxlength=4 ></td> 
						
					
								
					</table>		
					</form>				
				</div>
				
				
				</div>

	
			</div>

		</div>

	</div>




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


$(document).ready(function(){
	
	$("#table").DataTable({
		"pageLength": 5
	})
})



</script>
</body>
</html>