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


	<%List<Object[]> designationlist=(List<Object[]>)request.getAttribute("designationlist"); %>

	<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%><div align="center">
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</div>
	<%} %>
	<br>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row">
							<div class="col-md-10">
								<h4>Designation List</h4>
							</div>
						</div>
					</div>

					<div class="card-body">
						<form action="DesignationEdit.htm" method="post"
							style="display: inline">
							<div class="table-responsive">
								<table
									class="table table-bordered table-hover table-striped table-condensed "
									id="myTable">
									<thead style=" text-align: center;">
										<tr>
											<th>SN</th>
											<th>SrNo</th>
											<th>Designation Code</th>
											<th>Designation</th>
											<th>Desig Cadre</th>
											<th>Limit</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody style=" text-align: center;">
										<% int count=0;
	   	 						for(Object[] obj:designationlist){ 
	   	 							count++; %>
										<tr>
											<td><%=count %></td>
											<td><%=obj[4] %></td>
											<td><%=obj[1] %></td>
											<td><%=obj[2] %></td>
											<td><%=obj[5]!=null?obj[5]:"-" %></td>
											<td><%=obj[3] %></td>
											<td>

												<button class="editable-click" name="desigid"
													value="<%=obj[0] %>">
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<img src="view/images/edit.png">
															</figure>
															<span>EDIT</span>
														</div>
													</div>
												</button>


											</td>
										</tr>
										<%} %>
									</tbody>
								</table>

							</div>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
						<div align="center">
							<a class="btn btn-info btn-sm add" href="DesignationAdd.htm">Add</a>
							<a class="btn btn-info btn-sm back" href="MainDashBoard.htm">Back</a>
						</div>
					</div>


				</div>

			</div>

		</div>

	</div>
	<script type="text/javascript">

$(document).ready(function(){


		  $("#myTable").DataTable({
		 "lengthMenu": [5,10,25, 50, 75, 100 ],
		 "pagingType": "simple",
			 "pageLength": 5
	});
	  });
	  
</script>
</body>
</html>