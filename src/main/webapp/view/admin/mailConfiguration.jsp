<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title></title>
</head>

<title></title>
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
	List<Object[]> MailConfigurationList = (List<Object[]>) request.getAttribute("mailConfigurationList");
	%>

	<%
	String ses = (String) request.getParameter("result");
	String ses1 = (String) request.getParameter("resultfail");
	if (ses1 != null) {
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
			<%=ses1%>
		</div>
	</div>
	<%
	}
	if (ses != null) {
	%>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses%>
		</div>
	</div>
	<%
	}
	%>
	<br>



	<div class="container-fluid" style="width:70%">
		<div class="row">

			<div class="col-md-12">
				<div class="card shadow-nohover">
					<h4 class="card-header">Mail Configuration List</h4>
				</div>
			</div>

			<div class="card-body bg-light ml-3 mr-3">
			<form method="POST" name="frm1">
				<table
					class="table table-bordered table-hover table-striped table-condensed "
					id="myTable">
					<thead>
						<tr style="text-align: center;">
							<th>Select</th>
							 <th>Type Of Mail</th>
							<th>User Name</th>
							<th>Host</th>
							<th>Port</th>
						</tr>
					</thead>
					<tbody>
						<%
						if (MailConfigurationList != null && MailConfigurationList.size() > 0) {
							String TypeOfHost = null;
							for (Object[] obj : MailConfigurationList) {
								if (obj[3] != null) {
							if ("L".equalsIgnoreCase(obj[3].toString())) {
								TypeOfHost = "Lab Email";
							} else if ("D".equalsIgnoreCase(obj[3].toString())) {
								TypeOfHost = "Drona Email";
							} 
								}
						%>
						<tr>
							<td style="text-align: center;"><input type="radio"
								name="Lid" value=<%=obj[0]%>></td>
						 	<td>
								<%
								if (obj[3] != null) {
								%><%=TypeOfHost%>
								<%
								} else {
								%>-<%
								}
								%>
							</td> 
							<td>
								<%
								if (obj[1] != null) {
								%><%=obj[1].toString()%>
								<%
								} else {
								%>-<%
								}
								%>
							</td>
							<td>
								<%
								if (obj[2] != null) {
								%><%=obj[2].toString()%>
								<%
								} else {
								%>-<%
								}
								%>
							</td>
							<td>
								<%
								if (obj[4] != null) {
								%><%=obj[4].toString()%>
								<%
								} else {
								%>-<%
								}
								%>
							</td>
						</tr>
						<%
						}
						%>
						<%
						} else {
						%>
						<tr>
							<td colspan="5" style="text-align: center;">No records
								found.</td>
						</tr>
						<%
						}
						%>
					</tbody>

				</table>
				<div align="center">
					<button type="submit" formaction="MailConfigurationAdd.htm"
						class="btn btn-primary btn-sm add" id="MailConfigAddBtn">ADD</button>


					<%
					if (MailConfigurationList != null && MailConfigurationList.size() > 0) {
					%>
					<button type="submit" formaction="MailConfigurationDelete.htm"
						class="btn btn-danger btn-sm delete" onclick="Delete(frm1)">DELETE</button>
					<%
					}
					%>
				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
		</div>



	</div>




	<script type="text/javascript">
		$(function() {
			$('[data-toggle="tooltip"]').tooltip()
		})

function Edit(myfrm){
	
	 var fields = $("input[name='Lid']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select a Record");
	 event.preventDefault();
	return false;
	}
		  return true;
	 
			
	}
	
	
function Delete(myfrm){
	
	 var fields = $("input[name='Lid']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select a Record");
	 event.preventDefault();
	return false;
	}
	  var isConfirmed = confirm("Are you sure you want to delete?");
	    
	    if (isConfirmed) {
	        return true;
	    } else {
	        event.preventDefault();
	        return false;
	    }
	 
			
	}

		/* 
		 $(document).ready(function(){
		
		 $("#table").DataTable({
		 "pageLength": 5
		 })
		 })
		 */
		$(document).ready(function() {
			$("#myTable").DataTable({
				"lengthMenu" : [ 10, 25, 50, 75, 100 ],
				"pagingType" : "simple",
				"pageLength" : 10
			});
		});

		$(document).ready(function() {
			$("#myTable1").DataTable({
				"lengthMenu" : [ 10, 25, 50, 75, 100 ],
				"pagingType" : "simple",
				"pageLength" : 10
			});
		})
	</script>
</body>
</html>