<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.documents.model.IGIConstants"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
.form-label {
	font-weight: bold;
}
</style>
</head>
<body>

	<%
	List<IGIConstants> constantsMasterList = (List<IGIConstants>) request.getAttribute("constantsMasterList");
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
								<b>Constants List</b>
							</h4>
						</div>
					</div>
				</div>

				<form action="#" method="post" name="frm1">
					<div class="card-body">
						<div class="table-responsive" style="width: 80%;margin-left: 11.5rem">
							<table class="table table-bordered table-hover table-striped table-condensed dataTable" id="myTable" >
								<thead class="center">
									<tr>
										<th width="10%">Select</th>
										<th width="30%">Group Name</th>
										<th width="30%">Constant Name</th>
										<th width="30%">Constant Value</th>
									</tr>
								</thead>
								<tbody>
									<%
									int slno = 0;
									for (IGIConstants con : constantsMasterList) { %>
									<tr>
										<td class="center">
											<input type="radio" name="constantIdSelect" value="<%=con.getConstantId()%>">
											<input type="hidden" id="groupName_<%=con.getConstantId()%>" value="<%=con.getGroupName()%>"> 
											<input type="hidden" id="constantName_<%=con.getConstantId()%>" value="<%=con.getConstantName()%>"> 
											<input type="hidden" id="constantValue_<%=con.getConstantId()%>" value="<%=con.getConstantValue()%>"> 
										</td>
										<td><%=con.getGroupName()!=null?StringEscapeUtils.escapeHtml4(con.getGroupName()): " - "%></td>
										<td><%=con.getConstantName()!=null?StringEscapeUtils.escapeHtml4(con.getConstantName()): " - "%></td>
										<td class="center"><%=con.getConstantValue()!=null?StringEscapeUtils.escapeHtml4(con.getConstantValue()): " - "%></td>
									</tr>
									<% } %>
								</tbody>
							</table>
						</div>

						<div align="center">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<div class="button-group">
								<button type="button" class="btn btn-sm add" onclick="openAddModal()">ADD</button>
								<button type="button" class="btn btn-sm edit" onclick="openEditModal()">EDIT</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- -------------------------------------------- Constants Details Modal -------------------------------------------- -->
	<div class="modal fade" id="constantMasterModal" tabindex="-1" role="dialog" aria-labelledby="constantMasterModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width: 180%;margin-left: -40%;">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title">Constants Details Add</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
      				
      				<div class="container-fluid mt-3">
      					<form action="ConstantsMasterDetailsSubmit.htm" method="POST" id="myform">
      						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      						<div class="form-group">
			       				<div class="row">
									<div class="col-md-4">
										<label class="form-label">Group Name<span class="mandatory">*</span></label> 
										<input type="text" class="form-control field" name="groupName" id="groupName" placeholder="Enter Group Name" required="required" maxlength="255" >
									</div>
									<div class="col-md-4">
										<label class="form-label">Constant Name<span class="mandatory">*</span></label> 
										<input type="text" class="form-control field" name="constantName" id="constantName" placeholder="Enter Constant Name" required="required" maxlength="255" >
									</div>
									<div class="col-md-3">
										<label class="form-label">Constant Value<span class="mandatory">*</span></label> 
										<input type="text" class="form-control field" name="constantValue" id="constantValue" placeholder="Enter Constant Value" required="required" maxlength="255" >
									</div>
									<div class="col-md-1" style="margin-top: auto;">
										<button type="submit" class="btn btn-sm submit" name="action" id="action" value="Add" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
									</div>
									<input type="hidden" name="constantId" id="constantId" value="0">
								</div>
							</div>
							
						</form>
					</div>	
      			</div>
    		</div>
  		</div>
	</div>
	<!-- -------------------------------------------- Constants Details Modal End -------------------------------------------- -->
	
<script type="text/javascript">

	$(document).ready(function() {
       $('#myTable').DataTable({
           "lengthMenu": [10, 25, 50, 75, 100],
           "pagingType": "simple",
           "pageLength": 10
       });
	});
	
	
	function openAddModal() {
		$('.field').val('');
		$('#constantId').val('0');
		
		$('#action').removeClass('edit').addClass('submit');
		$('#action').val('Add');
		$('#action').text('SUBMIT');
		$('#action').attr('onclick', "return confirm('Are you sure to Submit?')");
		$('.modal-title').text('Constants Details Add');
		$('#constantMasterModal').modal('show');
	}
	
	function openEditModal() {
		
		var fields = $("input[name='constantIdSelect']:checked").serializeArray();

		if (fields.length === 0) {
			alert("Please select a record from the list.");
			event.preventDefault();
			return false;
		}
		
		var rowId = fields[0].value;
		
		$('#groupName').val($('#groupName_'+rowId).val());
		$('#constantName').val($('#constantName_'+rowId).val());
		$('#constantValue').val($('#constantValue_'+rowId).val());
		$('#constantId').val(rowId);
		
		$('#action').removeClass('submit').addClass('edit');
		$('#action').val('Edit');
		$('#action').text('UPDATE');
		$('#action').attr('onclick', "return confirm('Are you sure to Update?')");
		$('.modal-title').text('Constants Details Edit');
		$('#constantMasterModal').modal('show');
	}
</script>
</body>
</html>