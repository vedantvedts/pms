<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.master.model.Employee"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/css/master/programMasterList.css" var="programMasterList" />     
<link href="${programMasterList}" rel="stylesheet" />


</head>
<body>
	<%
		FormatConverter fc = new FormatConverter();
		List<Object[]> programeMasterList = (List<Object[]>) request.getAttribute("programeMasterList");
		List<Object[]> directorsList = (List<Object[]>) request.getAttribute("directorsList");
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
    
	<div class="container-fluid">
			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row">
						<div class="col-md">
							<h4>
								<b>Programme Master List</b>
							</h4>
						</div>
					</div>
				</div>
				
				<div class="card-body">
					<form method="post" action="ProgrammeMaster.htm" name="programform">
						<div class="table-responsive masterTableDiv"  >
							<table class="table table-bordered table-hovered table-striped table-condensed datatable" id="myTable" >
								<thead class="center">
									<tr>
										<td  class="selectTd">Select</td>
										<td  class="programmeCodeTd" >Programme Code</td>
										<td  class="programmeName" >Programme Name</td>
										<td  class="programmeDirector" >Programme Director</td>
										<td   class="sanctionedOn">Sanctioned On</td>
									</tr>
								</thead>
								<tbody>
									<%
									for(Object[] obj : programeMasterList ){ %>
										<tr>
											<td class="text-center"><input type="radio" id="ProgrammeId" name="ProgrammeId" value=<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):"" %> /></td>
											<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-" %></td>
											<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-" %></td>
											<td><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()):"-" %>, <%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()):"-" %></td>
											<td class="text-center"><%=obj[4]!=null?fc.sdfTordf(obj[4].toString()):"-" %></td>
										</tr>	
									<%}%>
								</tbody>
							</table>
						</div>
						<div align="center" class="mb-5">
							<button type="submit" class="btn btn-primary btn-sm add" name="action" value="Add">Add</button>&nbsp;&nbsp;
							<% if(programeMasterList!=null && programeMasterList.size()>0){%>
								<button type="submit" class="btn btn-warning btn-sm edit" name="action" value="Edit" onclick="validateEdit()" >EDIT</button> &nbsp;&nbsp;
							<%} %>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</div>
					</form>
				</div>
			</div>
		</div>
	
	<script>
	$(document).ready(function() {
	       $('#myTable').DataTable({
	           "lengthMenu": [10, 25, 50, 75, 100],
	           "pagingType": "simple",
	           "pageLength": 10
	       });
	});
		
	function validateEdit() {
		var fields = $("input[name='ProgrammeId']:checked").serializeArray();

		if (fields.length === 0) {
			alert("Please select a record from the list.");
			event.preventDefault();
			return false;
		}
		return true;
	}
	</script>
</body>
</html>