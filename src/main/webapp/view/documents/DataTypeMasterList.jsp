<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
	List<Object[]> dataTypeMasterList = (List<Object[]>) request.getAttribute("dataTypeMasterList");
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
								<b>Data Type Master List</b>
							</h4>
						</div>
					</div>
				</div>

				<form action="#" method="post" name="frm1">
					<div class="card-body">
						<div class="table-responsive" style="width: 80%;margin-left: 11.5rem;">
							<table class="table table-bordered table-hover table-striped table-condensed dataTable" id="myTable" >
								<thead class="center">
									<tr>
										<th width="10%">Select</th>
										<th width="20%">Standard Name</th>
										<th width="30%">Prefix</th>
										<th width="20%">Alias Name</th>
										<th width="20%">Data Length (bits / bytes)</th>
									</tr>
								</thead>
								<tbody>
									<%
									int slno = 0;
									for (Object[] obj : dataTypeMasterList) { %>
									<tr>
										<td class="center">
											<input type="radio" name="dataTypeMasterIdSelect" value="<%=obj[0]%>">
											<input type="hidden" id="dataTypePrefix_<%=obj[0]%>" value="<%=obj[1]%>"> 
											<input type="hidden" id="dataLength_<%=obj[0]%>" value="<%=obj[2]%>"> 
											<input type="hidden" id="aliasName_<%=obj[0]%>" value="<%=obj[3]%>"> 
											<input type="hidden" id="dataStandardName_<%=obj[0]%>" value="<%=obj[4]%>"> 
										</td>
										<td class="center"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%></td>
										<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></td>
										<td class="center"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%></td>
										<td class="center">
											<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()) + (Integer.parseInt(obj[2].toString()) * 0.125 ): " - "%>
											
										</td>
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

	<!-- -------------------------------------------- Data Type Master Modal -------------------------------------------- -->
	<div class="modal fade" id="dataTypeMasterModal" tabindex="-1" role="dialog" aria-labelledby="dataTypeMasterModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width: 180%;margin-left: -40%;">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title">Data Type Master Add</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
      				
      				<div class="container-fluid mt-3">
      					<form action="DataTypeMasterDetailsSubmit.htm" method="POST" id="myform">
      						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		       				<div class="row">
		       				
								<div class="col-md-3">
									<label class="form-label">Standard Name<span class="mandatory">*</span></label> 
									<input type="text" class="form-control field" name="dataStandardName" id="dataStandardName" placeholder="Enter Standard Name" required="required" maxlength="255" >
								</div>
									
								<div class="col-md-3">
									<label class="form-label">Prefix<span class="mandatory">*</span></label> 
									<input type="text" class="form-control field" name="dataTypePrefix" id="dataTypePrefix" placeholder="Enter Data Type" required="required" maxlength="255" >
								</div>
								
								<div class="col-md-3">
									<label class="form-label">Alias Name<span class="mandatory">*</span></label> 
									<input type="text" class="form-control field" name="aliasName" id="aliasName" placeholder="Enter Short Name" required="required" maxlength="255" >
								</div>
									
								<div class="col-md-2">
									<label class="form-label">Data Length (bit)<span class="mandatory">*</span></label> 
									<input type="number" class="form-control field" name="dataLength" id="dataLength" placeholder="Enter Data Length" required="required" min="0" max="9999999999">
								</div>
	
								<div class="col-md-1" style="margin-top: auto;">
									<button type="submit" class="btn btn-sm submit" name="action" id="action" value="Add" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
								</div>
								<input type="hidden" name="dataTypeMasterId" id="dataTypeMasterId" value="0">
							</div>
						</form>
					</div>	
      			</div>
    		</div>
  		</div>
	</div>
	<!-- -------------------------------------------- Data Type Master Modal End -------------------------------------------- -->
	
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
		$('#dataTypeMasterId').val('0');
		
		$('#action').removeClass('edit').addClass('submit');
		$('#action').val('Add');
		$('#action').text('SUBMIT');
		$('#action').attr('onclick', "return confirm('Are you sure to Submit?')");
		$('.modal-title').text('Data Type Master Add');
		$('#dataTypeMasterModal').modal('show');
	}
	
	function openEditModal() {
		
		var fields = $("input[name='dataTypeMasterIdSelect']:checked").serializeArray();

		if (fields.length === 0) {
			alert("Please select a record from the list.");
			event.preventDefault();
			return false;
		}
		
		var rowId = fields[0].value;
		
		$('#dataTypePrefix').val($('#dataTypePrefix_'+rowId).val());
		$('#dataLength').val($('#dataLength_'+rowId).val());
		$('#aliasName').val($('#aliasName_'+rowId).val());
		$('#dataStandardName').val($('#dataStandardName_'+rowId).val());
		$('#dataTypeMasterId').val(rowId);
		
		$('#action').removeClass('submit').addClass('edit');
		$('#action').val('Edit');
		$('#action').text('UPDATE');
		$('#action').attr('onclick', "return confirm('Are you sure to Update?')");
		$('.modal-title').text('Data Type Master Edit');
		$('#dataTypeMasterModal').modal('show');
	}
</script>
</body>
</html>