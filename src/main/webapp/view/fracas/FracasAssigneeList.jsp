<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Assignee List</title>
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

a:hover {
	color: white;
}

</style>
</head>
 
<body>
  <%
  


  List<Object[]> AssigneeList=(List<Object[]>)request.getAttribute("fracasassigneelist");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
 
  
  
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

    <br />
    

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
				
					<h4 class="card-header">FRACAS Assigned List</h4>
					
					<div class="card-body">
						<div class="table-responsive">
	   					<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" > 
	   						<thead>

									<tr>
										<th>SN</th>															
										<th>FRACAS No</th>
										<th>FRACAS Item</th                                                               >
										<th class="width-110px">PDC</th>
										<th class="width-110px">Assigned Date</th>								
									 	<th style="">Assigner</th>	
									 	<th>Remarks</th>
									 	<th>Attachment</th>
									 	<th>Action</th>
									</tr>
							</thead>
							<tbody>
								<%int count=1;
									if(AssigneeList!=null && AssigneeList.size()>0){	
										for (Object[] obj :AssigneeList) {
								%>
								<tr>
									<td class="center"><%=count %></td>
									<td><%=obj[13]%></td>
									<td><%=obj[12] %></td>
									<td><%=sdf.format(obj[3])%></td>
									<td><%=sdf.format(obj[6])%></td>
									<td><%=obj[10]%>, <%=obj[11]%></td>
									<td><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></td>
									<td>
										<%if(obj[14]!=null){ %>
											<form action="FracasAttachDownload.htm" method="post" target="_blank" >
												<button class="btn" style="align: center;"><i class="fa fa-download"></i></button>																			<input type="hidden" name="fracasattachid" value="<%= obj[14] %>">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form>
										<%}else{ %>
											-
										<%} %>
									</td>
									<td>		
										<form name="myForm1" id="myForm1" action="FracasAssignDetails.htm" method="POST" style="display: inline">
											<button class="editable-click" name="sub" value="Details" 	>
												<div class="cc-rockmenu">
													<div class="rolling">
														<figure class="rolling_icon">
															<img src="view/images/preview3.png">
														</figure>
														<span>Details</span>
													</div>
												</div>
											</button>
						                    <input type="hidden" name="fracasassignid" value="<%=obj[0]%>"/>													
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form> 
									</td>
								</tr>
							<% count++; } }else{%>
								<tr>
									<td colspan="8" style="text-align: center">No List Found</td>
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




<script type="text/javascript">

	

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