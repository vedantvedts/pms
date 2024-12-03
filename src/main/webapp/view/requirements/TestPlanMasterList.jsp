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
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>
<title>OFFICER DETAILS</title>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
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

.table-project-n {
	color: #005086;
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
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	List<Object[]> TestPlanMasterList = (List<Object[]>) request.getAttribute("TestPlanMasterList");
	%>


	<%
	String ses = (String) request.getParameter("result");
	String ses1 = (String) request.getParameter("resultfail");
	if (ses1 != null) {
	%>


	<center>

		<div class="alert alert-danger" role="alert">
			<%=ses1%>
		</div>
	</center>
	<%
	}
	if (ses != null) {
	%>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses%>
		</div>

	</center>


	<%
	}
	%>

	<div class="container-fluid">
		<div class="col-md-12">

			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row">
						<div class="col-md-3">
							<h4>
								<b>TestPlan Master List</b>
							</h4>
						</div>
					</div>
				</div>

				<form action="TestPlanMasterAdd.htm" method="post" name="frm1">
					<div class="card-body">
						<div class="table-responsive">
							<table
								class="table table-bordered table-hover table-striped table-condensed"
								id="myTable">
								<thead style="text-align: center;">
									<tr>
										<th>Select</th>
										<th>Test Name</th>
										<th>Objective</th>
									
										 <th>Created By</th> 
									</tr>
								</thead>
								<tbody>
									<%
									for (Object[] obj : TestPlanMasterList) {
									%>
									<tr>
										<td align="center"><input type="radio" name="Did"
											value=<%=obj[0]%>></td>
										<td><%=obj[1]%></td>
										<td><%=obj[2]%></td>
										<td> <%=obj[4] %></td>
										<%-- <td><%=obj[7]%></td> --%>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>

						<div align="center">

							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
							<div class="button-group">
								<button type="submit" class="btn btn-primary btn-sm add"
									name="sub" value="add">ADD</button>
								<button type="submit" class="btn btn-primary btn-sm edit"
									name="sub" value="edit" onclick="Edit(frm1)">EDIT</button>
								<a class="btn btn-info btn-sm back" href="MainDashBoard.htm">Back</a>
							</div>
						</div>
					</div>
				</form>






			</div>
		</div>

	</div>






	<div class="modal" id="loader">
		<!-- Place at bottom of page -->
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#myTable").DataTable({
				'aoColumnDefs' : [ {
					'bSortable' : false,

					'aTargets' : [ -1 ]
				/* 1st one, start by the right */
				} ]
			});
		});
		
		function Edit(myfrm){

			 var fields = $("input[name='Did']").serializeArray();

			  if (fields.length === 0){
			alert("Please Select A Record");
			 event.preventDefault();
			return false;
			}
				  return true;	
			}
	</script>
</body>
</html>