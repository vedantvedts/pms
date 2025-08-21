<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.documents.model.ICDPurpose"%>
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
	List<ICDPurpose> purposeMasterList = (List<ICDPurpose>) request.getAttribute("purposeMasterList");
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
								<b>Purpose Master List</b>
							</h4>
						</div>
					</div>
				</div>

				<form action="#" method="post" name="frm1">
					<div class="card-body">
						<div class="table-responsive" style="width: 50%;margin-left: 28rem;">
							<table class="table table-bordered table-hover table-striped table-condensed dataTable" id="myTable">
								<thead class="center">
									<tr>
										<th width="20%">Select</th>
										<th width="30%">Purpose Code</th>
										<th width="50%">Purpose</th>
									</tr>
								</thead>
								<tbody>
									<%
									int slno = 0;
									for (ICDPurpose purp : purposeMasterList) { %>
									<tr>
										<td class="center">
											<input type="radio" name="purposeIdSelect" value="<%=purp.getPurposeId()!=null?StringEscapeUtils.escapeHtml4(purp.getPurposeId().toString()): ""%>">
											<input type="hidden" id="purpose_<%=purp.getPurposeId()%>" value="<%=purp.getPurpose()%>"> 
											<input type="hidden" id="purposeCode_<%=purp.getPurposeId()%>" value="<%=purp.getPurposeCode()%>"> 
										</td>
										<td class="center"><%=purp.getPurposeCode()!=null?StringEscapeUtils.escapeHtml4(purp.getPurposeCode()): " - "%></td>
										<td><%=purp.getPurpose()!=null?StringEscapeUtils.escapeHtml4(purp.getPurpose()): " - "%></td>
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

	<!-- -------------------------------------------- Purpose Master Modal -------------------------------------------- -->
	<div class="modal fade" id="purposeMasterModal" tabindex="-1" role="dialog" aria-labelledby="purposeMasterModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width:135%;margin-left:-20%;">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title">Purpose Master Add</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
      				
      				<div class="container-fluid mt-3">
      					<form action="PurposeMasterDetailsSubmit.htm" method="POST" id="myform">
      						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		       				<div class="row">
								<div class="col-md-4">
									<label class="form-label">Purpose<span class="mandatory">*</span></label> 
									<input type="text" class="form-control field" name="purpose" id="purpose" placeholder="Enter Purpose" required="required" maxlength="255" >
								</div>
									
								<div class="col-md-3">
									<label class="form-label">Purpose Code:<span class="mandatory" >*</span></label> 
									<input type="text" class="form-control field" name="purposeCode" id="purposeCode" placeholder="Enter Purpose Code" required="required"  maxlength="5" style="text-transform: uppercase;">
								</div>
									
								<div class="col-md-2" style="margin-top: auto;">
									<button type="submit" class="btn btn-sm submit" name="action" id="action" value="Add" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
								</div>
								<input type="hidden" name="purposeId" id="purposeId" value="0">
							</div>
						</form>
					</div>	
      			</div>
    		</div>
  		</div>
	</div>
	<!-- -------------------------------------------- Purpose Master Modal End -------------------------------------------- -->
	
<script type="text/javascript">

	$(document).ready(function() {
       $('#myTable').DataTable({
           "lengthMenu": [5, 10, 25, 50, 75, 100],
           "pagingType": "simple",
           "pageLength": 5
       });
	});
	
	
	function openAddModal() {
		$('.field').val('');
		$('#purposeId').val('0');
		$('#action').removeClass('edit').addClass('submit');
		$('#action').val('Add');
		$('#action').text('SUBMIT');
		$('#action').attr('onclick', "return confirm('Are you sure to Submit?')");
		$('.modal-title').text('Purpose Master Add');
		$('#purposeMasterModal').modal('show');
	}
	
	function openEditModal() {
		
		var fields = $("input[name='purposeIdSelect']:checked").serializeArray();

		if (fields.length === 0) {
			alert("Please select a record from the list.");
			event.preventDefault();
			return false;
		}
		
		var rowId = fields[0].value;
		
		$('#purpose').val($('#purpose_'+rowId).val());
		$('#purposeCode').val($('#purposeCode_'+rowId).val());
		$('#purposeId').val(rowId);
		
		$('#action').removeClass('submit').addClass('edit');
		$('#action').val('Edit');
		$('#action').text('UPDATE');
		$('#action').attr('onclick', "return confirm('Are you sure to Update?')");
		$('.modal-title').text('Purpose Master Edit');
		$('#purposeMasterModal').modal('show');
	}
</script>
</body>
</html>