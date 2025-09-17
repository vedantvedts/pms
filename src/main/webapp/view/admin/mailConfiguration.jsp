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
<title></title>
<spring:url value="/resources/css/admin/mailConfiguration.css" var="mailConfiguration" />
<link href="${mailConfiguration}" rel="stylesheet" />
</head>

<title></title>
</head>
<body>

	<%
	List<Object[]> MailConfigurationList = (List<Object[]>) request.getAttribute("mailConfigurationList");
	%>

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



	<div class="container-fluid w-70" >
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
						<tr class="text-center">
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
							<td class="text-center"><input type="radio"
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
								%><%=StringEscapeUtils.escapeHtml4(obj[1].toString())%>
								<%
								} else {
								%>-<%
								}
								%>
							</td>
							<td>
								<%
								if (obj[2] != null) {
								%><%=StringEscapeUtils.escapeHtml4(obj[2].toString())%>
								<%
								} else {
								%>-<%
								}
								%>
							</td>
							<td>
								<%
								if (obj[4] != null) {
								%><%=StringEscapeUtils.escapeHtml4(obj[4].toString())%>
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
							<td colspan="5" class="text-center">No records
								found.</td>
						</tr>
						<%
						}
						%>
					</tbody>

				</table>
				<div align="center">
					<button type="submit" formaction="MailConfigurationAdd.htm"
						class="btn btn-primary btn-sm add" id="MailConfigAddBtn">ADD</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


					<%
					if (MailConfigurationList != null && MailConfigurationList.size() > 0) {
					%>
					<button type="submit" formaction="MailConfigurationEdit.htm" class="btn btn-warning btn-sm edit" name="sub" value="edit" onclick="Edit(frm1)"  >EDIT</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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