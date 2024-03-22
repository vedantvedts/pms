<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>



<title>Weekly Update Report</title>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
}

body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}

h6 {
	text-decoration: none !important;
}

.table button {
	background-color: white !important;
	border: 3px solid #17a2b8;
	padding: .275rem .5rem !important;
}

.table button:hover {
	color: black !important;
}

#table tbody tr td {
	padding: 4px 3px !important;
}
</style>
</head>

<body>
	<%
  FormatConverter fc=new FormatConverter(); 
  SimpleDateFormat sdf=fc.getRegularDateFormat();
  List<Object[]> AssigneeList=(List<Object[]>)request.getAttribute("StatusList");
  String Position=(String)request.getAttribute("Position");
  
 %>



	<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getAttribute("resultfail");
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

	<br />
<% List<Object[]> data = (List<Object[]>) request.getAttribute("tabledata");%>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover"
					style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;">
					<div class="card-header ">

						<div class="row">
							<h4 class="col-md-5">Weekly Update Report</h4>
							<div class="col-md-7" style="float: right; margin-top: -8px;">
								<form method="POST" id='myform'>
									<table >
										<tr>
											<td style="max-width: 300px; padding-right: 50px"><select
												onchange="getdata();submitform()" name="getprojects"
												class="form-control" style="max-width: 250px" id="projectid">
												<% if(data.size()==0) {%>
													<option value="none" selected disabled hidden>
														Select Project</option><%} else{ %>
														<option value="none" selected disabled hidden>
														<%= request.getAttribute("selectedProject") %></option>
														<%} %>
													<%
													List<Object[]> projects = (List<Object[]>) request.getAttribute("projects");
													for (int i = 0; i < projects.size(); i++) {
													%>
													<option value="<%=projects.get(i)[0]%>">
														<%=projects.get(i)[4]%> (<%=projects.get(i)[17]%>)
													</option>
													<%}%>
											</select></td>


										</tr>
									</table>
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" />
								</form>
							</div>
						</div>

					</div>


					<div class="data-table-area mg-b-15">
						<div class="container-fluid">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="sparkline13-list">
									<div class="sparkline13-graph">
										<div class="datatable-dashv1-list custom-datatable-overright">
											<div id="toolbar"></div>
											
											<div style="width: 95%; margin: auto;">
												<h4 style="text-align: center;padding: 35px;">
													Weekly Status <%if(request.getAttribute("projectname")!=null){ %> of
													<%=request.getAttribute("projectname")%>
													<% if(request.getAttribute("shortname")!=null){ %>(
													<%=request.getAttribute("shortname")%>)<%} %><%} %>
													
												</h4>
												<table class="table table-bordered table-hover table-striped table-condensed " id="table" data-toggle="table"
													class="table table-bordered table-hover table-striped table-condensed "
													>
													<thead style="text-align: center;">

														<tr>
															<th scope="col">Date</th>
															<th scope="col">Action Point</th>
															<th scope="col">Meeting</th>
															<th scope="col">Milestone</th>
															<th scope="col">Procurement</th>
															<th scope="col">Risk Details</th>
															<th scope="col">Updated By</th>
															<th scope="col">Updated On</th>
														</tr>
													</thead>
													<tbody>
														<% for(int i=0;i<data.size();i++){%>
														<tr>
															<th scope="row"><%=i+1 %></th>



															<td ><div style="text-align: center;"><%= data.get(i)[3] %></div></td>
															<td ><div style="text-align: center;"><%= data.get(i)[2] %></div></td>
															<td ><div style="text-align: center;"><%= data.get(i)[7] %></div></td>
															<td ><div style="text-align: center;"><%= data.get(i)[5] %></div></td>
															<td><div style="text-align: center;"><%= data.get(i)[4] %></div></td>
															<td><div style="text-align: center;"><%= data.get(i)[9] %></div></td>

															<td id='trimname'><%= data.get(i)[1] %></td>
															<td><%= data.get(i)[10] %></td>
														</tr>
														<%} %>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>



						<br>

					</div>
				</div>
			</div>
		</div>







		<script>
	function getdata() {

		$.ajax({

			type : "GET",
			url : "GetUpdateReport.htm",
			data : {

				ProjectId : document.getElementById('projectid').value

			},
			datatype : 'json',
			success : function(result) {
				console.log(result);
			}
		});
	}
	 $(document).ready(function(){
		  $("#table").DataTable({
		 "lengthMenu": [  5,10,25, 50, 75, 100 ],
		 "pagingType": "simple"
		
	});

	  });
	 function submitform()
	 { 
	    document.getElementById('myform').submit(); 
	 }
	
	
	
</script>
</body>
</html>