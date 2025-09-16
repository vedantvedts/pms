<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
<spring:url value="/resources/css/admin/DesignationList.css" var="designationList" />
<link href="${designationList}" rel="stylesheet" />
<title>LOGIN LIST</title>
</head>
<body>


	<%List<Object[]> designationlist=(List<Object[]>)request.getAttribute("designationlist"); %>

	<% 
	    String ses = (String) request.getParameter("result");
	    String ses1 = (String) request.getParameter("resultfail");
	    if (ses1 != null) { %>
	    <div align="center">
	        <div class="alert alert-danger" role="alert">
	            <%=StringEscapeUtils.escapeHtml4(ses1) %>
	        </div>
	    </div>
	<% }if (ses != null) { %>
	    <div align="center">
	        <div class="alert alert-success" role="alert">
	            <%=StringEscapeUtils.escapeHtml4(ses) %>
	        </div>
	    </div>
	<% } %>
	
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
						<form action="DesignationEdit.htm" method="post" class="d-inline">
							<div class="table-responsive">
								<table
									class="table table-bordered table-hover table-striped table-condensed "
									id="myTable">
									<thead class="text-center">
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
									<tbody class="text-center">
										<% int count=0;
	   	 						for(Object[] obj:designationlist){ 
	   	 							count++; %>
										<tr>
											<td><%=count %></td>
											<td><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
											<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></td>
											<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
											<td><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></td>
											<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
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