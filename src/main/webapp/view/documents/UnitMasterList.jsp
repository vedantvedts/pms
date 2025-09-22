<%@page import="com.vts.pfms.documents.model.UnitMaster"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Unit Master</title>
</head>
<body>
		<%
			List<Object[]> unitMasterList = (List<Object[]>) request.getAttribute("unitMasterList");
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
								<b>Unit Master List</b>
							</h4>
						</div>
					</div>
				</div>

				<form action="#" method="post" name="frm1">
					<div class="card-body">
						<div class="table-responsive" style="width: 55%;margin: 0 auto;">
							<table class="table table-bordered table-hover table-striped table-condensed dataTable" id="myTable" >
								<thead class="center">
									<tr>
										<th width="15%">Select</th>
										<th width="40%">Unit</th>
										<th width="45%">Description</th> 
									</tr>
								</thead>
								<tbody>
									<%
									int slno = 0;
									for (Object[] obj : unitMasterList) { %>
									<tr>
										<td class="center">
											<input type="radio" name="UnitMasterIdSelect" value="<%=obj[0]%>">
											<input type="hidden" id="Unit_<%=obj[0]%>" value="<%=obj[1]%>"> 
											<input type="hidden" id="UnitDescription_<%=obj[0]%>" value="<%=obj[2] %>" /> 
										</td>
										<td class="center">
											<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-"%>
										</td>
										<td>
											<%=obj[2]!=null? StringEscapeUtils.escapeHtml4(obj[2].toString()):" - " %>
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
	
	<!-- -------------------------------------------- Unit Master Modal -------------------------------------------- -->
	<div class="modal fade" id="UnitMasterModal" tabindex="-1" role="dialog" aria-labelledby="UnitMasterModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width: 180%;margin-left: -40%;">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title">Unit Master Add</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
      				<div class="container-fluid mt-3" style="margin-left:16%; margin-bottom:30px;" >
      					<form action="UnitMasterDetailsSubmit.htm" method="POST" id="myform">
      						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		       				<div class="row" >
								<div class="col-md-4">
									<label class="form-label">Unit<span class="mandatory">*</span></label> 
									<input type="text" class="form-control field" name="Unit" id="Unit" placeholder="Enter Unit" required="required">
								</div>
								<div class="col-md-4">
									<label class="form-label">Description<span class="mandatory">*</span></label>
									<input type="text" class="form-control field" name="UnitDescription" id="UnitDescription" placeholder="Enter Description" required="required" />
								</div> 
								<div class="col-md-1" style="margin-top: auto; margin-bottom: 5px;">
									<button type="submit" class="btn btn-sm submit" name="action" id="action" value="Add" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
								</div>
								<input type="hidden" name="UnitMasterId" id="UnitMasterId" value="0">
							</div>
						</form>
					</div>	
      			</div>
    		</div>
  		</div>
	</div>
	
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
			$('#UnitMasterId').val('0');
			
			$('#action').removeClass('edit').addClass('submit');
			$('#action').val('Add');
			$('#action').text('SUBMIT');
			$('#action').attr('onclick', "return confirm('Are you sure to Submit?')");
			$('.modal-title').text('Unit Master Add');
			$('#UnitMasterModal').modal('show');
		}
		
		function openEditModal() {
			
			var fields = $("input[name='UnitMasterIdSelect']:checked").serializeArray();

			if (fields.length === 0) {
				alert("Please select a record from the list.");
				event.preventDefault();
				return false;
			}
			
			var rowId = fields[0].value;
			
			$('#Unit').val($('#Unit_'+rowId).val());
			$('#UnitMasterId').val(rowId);
			$('#UnitDescription').val($('#UnitDescription_'+rowId).val());
			
			$('#action').removeClass('submit').addClass('edit');
			$('#action').val('Edit');
			$('#action').text('UPDATE');
			$('#action').attr('onclick', "return confirm('Are you sure to Update?')");
			$('.modal-title').text('Unit Master Edit');
			$('#UnitMasterModal').modal('show');
		}
	</script>
</body>
</html>