<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Weekly Update Report</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}

.table button{
	
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
				<div class="card shadow-nohover">
					<div class="card-header ">  

					<div class="row">
						<h4 class="col-md-5">Weekly Update Report</h4>  
							<div class="col-md-7" style="float: right; margin-top: -8px;">
								<form method="POST" id='myform'>
									<table>
										<tr>
											<td style="max-width: 300px; padding-right: 50px"><select
												onchange="getdata();submitform()" name="getprojects"
												class="form-control" style="max-width: 250px" id="projectid">
													<option value="none" selected disabled hidden>
														Select Project</option>
													<%
													List<Object[]> projects = (List<Object[]>) request.getAttribute("projects");
													for (int i = 0; i < projects.size(); i++) {
													%>
													<option value="<%=projects.get(i)[0]%>">
														<%=projects.get(i)[4]%> (<%=projects.get(i)[17]%>)
													</option>
													<%
													}
													%>
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
												<div id="toolbar">
													
												</div>
												<% List<Object[]> data = (List<Object[]>) request.getAttribute("tabledata");if(request.getAttribute("tableshow").equals("yes")) {%>
												<div style="width: 95%;margin:auto;">
												<h3 style="text-align: center;">Weekly status of <%= request.getAttribute("projectname") %> <%= request.getAttribute("shortname") %> project</h3>
												<table id="table" data-toggle="table" data-pagination="true"
													data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" data-show-refresh="true"
													data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true"
													data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar">
													<thead>

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
				  <% 
				for(int i=0;i<data.size();i++){%>	
				    <tr >
				      <th scope="row"><%=i+1 %></th>
				      
				      
				      
				      <td><%= data.get(i)[3] %></td>
				      <td><%= data.get(i)[2] %></td>
				      <td><%= data.get(i)[7] %></td>
				      <td><%= data.get(i)[5] %></td>
				      <td><%= data.get(i)[4] %></td>	
				      <td><%= data.get(i)[9] %></td>			      
				      
				      <td id='trimname'><%= data.get(i)[1] %></td>
				      <td><%= data.get(i)[10] %></td>
				    </tr><%}} %>
				  </tbody>
												</table>												
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						
						
						<br>
						<div class="card-footer" align="right">&nbsp;</div>
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
			
			$("#table1").DataTable({
				"pageLength": 5
			});});
	function submitform(){
document.getElementById("myform").submit();}
</script>


</body>
</html>