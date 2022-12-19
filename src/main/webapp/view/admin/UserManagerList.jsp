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

<title>LOGIN LIST</title>
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


	<%List<Object[]> UserManagerList=(List<Object[]>)request.getAttribute("UserManagerList"); %>



	<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%><center>
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


	<div class="container-fluid">
		<div class="row">

			<div class="col-md-12">



				<div class="card shadow-nohover">
					<h3 class="card-header">
						Login List <a class="btn btn-info btn-sm shadow-nohover back"
							style="margin-left: 83%;" href="MainDashBoard.htm">Back</a>
					</h3>

					<div class="card-body">

						<form action="UserManager.htm" method="POST" name="frm1">
							<div class="table-responsive">
								<table
									class="table table-bordered table-hover table-striped table-condensed "
									id="myTable">
									<thead>
										<tr>
											<th>Select</th>
											<th>Employee</th>
											<th>User Name</th>
											<th>Division Name</th>
											<th style="width: 10%;">PFMS Login</th>
											<th>Login type</th>
										</tr>
									</thead>
									<tbody>
										<%for(Object[] obj:UserManagerList){ %>
										<tr>
											<td style="text-align: center; " ><input type="radio" name="Lid" value=<%=obj[0]%>></td>
											<td><%=obj[5] %>(<%=obj[6] %>)</td>
											<td><%=obj[1] %></td>
											<td><%=obj[2] %></td>
											<%-- <td><%=obj[3] %></td> --%>
											<td style="text-align: center;">
												<%if(obj[4].equals("N")){%><span class="badge badge-warning">No</span>
												<%}else{ %><span class="badge badge-success">Yes</span>
												<%} %>
											</td>
											<td><%=obj[7] %></td>
										</tr>
										<%} %>
									</tbody>
								</table>
							</div>

							<div align="center">
								<button type="submit" class="btn btn-primary btn-sm add"
									name="sub" value="add">ADD</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

								<%if(UserManagerList!=null){ %>
								<button type="submit" class="btn btn-warning btn-sm edit"  name="sub" value="edit" onclick="Edit(frm1)">EDIT</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="submit" class="btn btn-danger btn-sm delete" name="sub" value="delete" onclick="Delete(frm1)">DELETE</button>
								<%} %>

							</div>

							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
					</div>


				</div>

			</div>

		</div>

	</div>

	<script type="text/javascript">

function Edit(myfrm){
	
	 var fields = $("input[name='Lid']").serializeArray();

	  if (fields.length === 0){
	alert("PLESE SELECT ONE RECORD");
	 event.preventDefault();
	return false;
	}
	 
	
	
		 
	
		  return true;
	 
			
	}
function Delete(myfrm){
	

	var fields = $("input[name='Lid']").serializeArray();

	  if (fields.length === 0){
	alert("PLESE SELECT ONE RECORD");
	 event.preventDefault();
	return false;
	}
	  var cnf=confirm("Are U Sure To Delete!");
	  if(cnf){
	
	return true;
	
	}
	  else{
		  event.preventDefault();
			return false;
			}
	
	}

</script>


	<script type="text/javascript">

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


		  $("#myTable").DataTable({
		 "lengthMenu": [10,25, 50, 75, 100 ],
		 "pagingType": "simple",
			 "pageLength": 10
	});
	  });
	  


	


</script>
</body>
</html>