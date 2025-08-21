<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>INTERFACE TYPE LIST</title>
<style type="text/css">
</style>
</head>
<body>

	<%
	List<Object[]> InterfaceTypeMasterList = (List<Object[]>) request.getAttribute("InterfaceTypeMasterList");
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
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row">
						<div class="col-md-3">
							<h4>
								<b>Interface Type List</b>
							</h4>
						</div>
					</div>
				</div>

				<form action="InterfaceTypeForm.htm" method="post"
					name="frm1">
					<div class="card-body">
						<div class="table-responsive">
							<table
								class="table table-bordered table-hover table-striped table-condensed"
								id="myTable">
								<thead style="text-align: center;">
									<tr>
										<th>Select</th>
										<th>Interface Type</th>
										<th>Interface Type Code</th>
									</tr>
								</thead>
								<tbody>
									<%
									for (Object[] obj : InterfaceTypeMasterList) {
									%>
									<tr>
										<td align="center"><input type="radio" name="interfaceTypeId"
											value=<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - "%>></td>
										<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></td>
										<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%></td>
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
									name="sub" value="Edit" onclick="Edit(frm1)">EDIT</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
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

		function Edit(myfrm) {
			var fields = $("input[name='interfaceTypeId']").serializeArray();

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