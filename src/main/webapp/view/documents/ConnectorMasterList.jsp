<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.documents.model.IGIConnectorAttach"%>
<%@page import="com.vts.pfms.documents.model.IGIConnector"%>
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

.fw-bold {
	font-weight: bold;
}
</style>
</head>
<body>

	<%
	List<IGIConnector> connectorMasterList = (List<IGIConnector>) request.getAttribute("connectorMasterList");
	List<IGIConnectorAttach> connectorAttachList = (List<IGIConnectorAttach>) request.getAttribute("connectorAttachList");
	%>
	<% String ses = (String) request.getParameter("result"); 
       String ses1 = (String) request.getParameter("resultfail");
       if (ses1 != null) { %>
        <div align="center">
            <div class="alert alert-danger" role="alert">
                <%= ses1 %>
            </div>
        </div>
    <% } if (ses != null) { %>
        <div align="center">
            <div class="alert alert-success" role="alert">
                <%= ses %>
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
								<b>Connector List</b>
							</h4>
						</div>
					</div>
				</div>


				<div class="card-body">
					<div class="table-responsive" style="width: 100%;">
						<table class="table table-bordered table-hover table-striped table-condensed dataTable" id="myTable" >
							<thead class="center">
								<tr>
									<th width="5%">Select</th>
									<th width="15%">Part No</th>
									<th width="15%">Connector Make</th>
									<th width="15%">Standard</th>
									<th width="15%">Protection</th>
									<th width="15%">Ref Info</th>
									<th width="10%">Remarks</th>
									<th width="10%">Pin Count</th>
								</tr>
							</thead>
							<tbody>
								<%
								if(connectorMasterList!=null && connectorMasterList.size()>0) {
								int slno = 0;
								for (IGIConnector con : connectorMasterList) { 
									List<IGIConnectorAttach> connectorAttachListByConnectorId = connectorAttachList.stream().filter(e -> e.getConnectorId().equals(con.getConnectorId())).collect(Collectors.toList());
								%>
								<tr>
									<td class="center">
										<input type="radio" name="connectorIdSelect" value="<%=con.getConnectorId()%>">
										<input type="hidden" id="partNo_<%=con.getConnectorId()%>" value="<%=con.getPartNo()%>"> 
										<input type="hidden" id="connectorMake_<%=con.getConnectorId()%>" value="<%=con.getConnectorMake()%>"> 
										<input type="hidden" id="standardName_<%=con.getConnectorId()%>" value="<%=con.getStandardName()%>"> 
										<input type="hidden" id="protection_<%=con.getConnectorId()%>" value="<%=con.getProtection()%>"> 
										<input type="hidden" id="refInfo_<%=con.getConnectorId()%>" value="<%=con.getRefInfo()%>"> 
										<input type="hidden" id="remarks_<%=con.getConnectorId()%>" value="<%=con.getRemarks()%>"> 
										<input type="hidden" id="pinCount_<%=con.getConnectorId()%>" value="<%=con.getPinCount()%>"> 
										<table class="table table-bordered" style="display: none;" id="attachmentstable_<%=con.getConnectorId()%>">
											<thead class="center">
												<tr>
													<th>SN</th>
													<th>Attachment</th>
													<th>Action</th>
												</tr>
											</thead>
											<tbody>
												<%if(connectorAttachListByConnectorId!=null && connectorAttachListByConnectorId.size()>0) {
													int sn = 0;
													for(IGIConnectorAttach attach : connectorAttachListByConnectorId) {
												%>
													<tr>
														<td class="center"><%=++sn %></td>
														<td><%=attach.getAttachment() %></td>
														<td class="center">
															<form action="#" method="post">
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																<input type="hidden" name="connectorAttachId" value="<%=attach.getConnectorAttachId()%>">
																<button type="submit" class="btn btn-sm" name="drawingAttach" value="<%=attach.getAttachment() %>" formaction="IGIConnectorDrawingAttachDownload.htm" formmethod="get" formnovalidate="formnovalidate" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
								                      				<i class="fa fa-download fa-lg"></i>
								                      			</button>
								                      			<button type="submit" class="btn btn-sm delete" formaction="IGIConnectorAttachmentDelete.htm" onclick="return confirm('Are you Sure to Delete?')">
								                      				<i class="fa fa-trash fa-lg"></i>
								                      			</button>
															</form>
														</td>
													</tr>
												<%} } else{ %>
													<tr>
														<td class="center" colspan="3">No Attachments Added</td>
													</tr>
												<%} %>
											</tbody>
										</table>
									</td>
									<td><%=con.getPartNo()%></td>
									<td><%=con.getConnectorMake()%></td>
									<td><%=con.getStandardName()%></td>
									<td><%=con.getProtection()%></td>
									<td><%=con.getRefInfo()%></td>
									<td><%=con.getRemarks()%></td>
									<td class="center"><%=con.getPinCount()%></td>
								</tr>
								<% } }%>
							</tbody>
						</table>
					</div>

					<div align="center">
						<div class="button-group">
							<button type="button" class="btn btn-sm add" onclick="openAddModal()">ADD</button>
							<button type="button" class="btn btn-sm edit" onclick="openEditModal()">EDIT</button>
							<button type="button" class="btn btn-sm back" onclick="openAttachmentsModal()" style="background-color: #7CD1B8;color: black; border-color: #7CD1B8;">ATTACHMENTS</button>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- -------------------------------------------- Connector Details Modal -------------------------------------------- -->
	<div class="modal fade" id="connectorMasterModal" tabindex="-1" role="dialog" aria-labelledby="connectorMasterModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width: 180%;margin-left: -40%;">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title">Connector Details Add</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
      				
      				<div class="container-fluid mt-3">
      					<form action="ConnectorMasterDetailsSubmit.htm" method="POST" id="myform">
      						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      						<div class="form-group">
			       				<div class="row">
									<div class="col-md-3">
										<label class="form-label">Part No<span class="mandatory">*</span></label> 
										<input type="text" class="form-control field" name="partNo" id="partNo" placeholder="Enter Part No" required="required" maxlength="255" >
									</div>
									<div class="col-md-3">
										<label class="form-label">Connector Make<span class="mandatory">*</span></label> 
										<input type="text" class="form-control field" name="connectorMake" id="connectorMake" placeholder="Enter Connector Make" required="required" maxlength="255" >
									</div>
									<div class="col-md-3">
										<label class="form-label">Standard Name<span class="mandatory">*</span></label> 
										<input type="text" class="form-control field" name="standardName" id="standardName" placeholder="Enter Standard Name" required="required" maxlength="255" >
									</div>
									<div class="col-md-3">
										<label class="form-label">Protection</label> 
										<input type="text" class="form-control field" name="protection" id="protection" placeholder="Enter Protection Details" maxlength="255" >
									</div>
								</div>
							</div>
							
							<div class="form-group">
			       				<div class="row">
									<div class="col-md-3">
										<label class="form-label">Ref Info</label> 
										<input type="text" class="form-control field" name="refInfo" id="refInfo" placeholder="Enter Ref Info" maxlength="255" >
									</div>
									<div class="col-md-3">
										<label class="form-label">Remarks</label> 
										<input type="text" class="form-control field" name="remarks" id="remarks" placeholder="Enter Remarks" maxlength="255" >
									</div>
									<div class="col-md-2">
										<label class="form-label">Pin Count<span class="mandatory">*</span></label> 
										<input type="number" class="form-control field" name="pinCount" id="pinCount" placeholder="Enter Pin Count" required="required" min="1" max="1000">
									</div>
									<div class="col-md-1" style="margin-top: auto;">
										<button type="submit" class="btn btn-sm submit" name="action" id="action" value="Add" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
									</div>
									<input type="hidden" name="connectorId" id="connectorId" value="0">
								</div>
							</div>	
						</form>
					</div>	
      			</div>
    		</div>
  		</div>
	</div>
	<!-- -------------------------------------------- Connector Details Modal End -------------------------------------------- -->
	
	<!-- -------------------------------------------- Connector Attachment Details Modal -------------------------------------------- -->
	<div class="modal fade" id="connectorAttachModal" tabindex="-1" role="dialog" aria-labelledby="connectorAttachModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width: 180%;margin-left: -40%;">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title">Connector Attachments</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
      				
      				<div class="container-fluid mt-3">
      					<div class="row">
      						<div class="col-md-6 attachlist"></div>
      						<div class="col-md-6">
      							<form action="IGIConnectorAttachmentSubmit.htm" method="post" enctype="multipart/form-data">
      								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      								<input type="hidden" name="connectorId" id="connectorIdAttachTable">
	      							<div class="row">
	      								<div class="col-md-12">
		      								<table style="width: 100%;margin-left: 3%;" id="attachuploadtable">
												<thead style="background-color: #055C9D; color: white;text-align: center;">
													<tr>
												    	<th style="width: 45%;">Attachment</th>
														<td style="width: 5%;">
															<button type="button" class=" btn btn-sm btn_add_attachments "><i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
														</td>
													</tr>
												</thead>
												<tbody>
													<tr class="tr_clone_attachments">
														<td>
															<input type="file" class="form-control" name="attachment" accept="image/png, image/jpeg" required>
														</td>	
														<td class="center">
															<button type="button" class=" btn btn-sm btn_rem_attachments "> <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
														</td>	
													</tr>
												</tbody>
											</table>
										</div>	
	      							</div>
	      							<div class="center mt-2">
	      								<button type="submit" class="btn btn-sm submit" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
	      							</div>
	      						</form>
      						</div>
      					</div>
					</div>	
      			</div>
    		</div>
  		</div>
	</div>
	<!-- -------------------------------------------- Connector Details Modal End -------------------------------------------- -->
	
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
		$('#connectorId').val('0');
		
		$('#action').removeClass('edit').addClass('submit');
		$('#action').val('Add');
		$('#action').text('SUBMIT');
		$('#action').attr('onclick', "return confirm('Are you sure to Submit?')");
		$('.modal-title').text('Connector Details Add');
		$('#connectorMasterModal').modal('show');
	}
	
	function openEditModal() {
		
		var fields = $("input[name='connectorIdSelect']:checked").serializeArray();

		if (fields.length === 0) {
			alert("Please select a record from the list.");
			event.preventDefault();
			return false;
		}
		
		var rowId = fields[0].value;
		
		$('#partNo').val($('#partNo_'+rowId).val());
		$('#connectorMake').val($('#connectorMake_'+rowId).val());
		$('#standardName').val($('#standardName_'+rowId).val());
		$('#protection').val($('#protection_'+rowId).val());
		$('#refInfo').val($('#refInfo_'+rowId).val());
		$('#remarks').val($('#remarks_'+rowId).val());
		$('#pinCount').val($('#pinCount_'+rowId).val());
		$('#connectorId').val(rowId);
		
		$('#action').removeClass('submit').addClass('edit');
		$('#action').val('Edit');
		$('#action').text('UPDATE');
		$('#action').attr('onclick', "return confirm('Are you sure to Update?')");
		$('.modal-title').text('Connector Details Edit');
		$('#connectorMasterModal').modal('show');
	}
	
	function openAttachmentsModal() {
		var fields = $("input[name='connectorIdSelect']:checked").serializeArray();

		if (fields.length === 0) {
			alert("Please select a record from the list.");
			event.preventDefault();
			return false;
		}
		
		var rowId = fields[0].value;
		$('#connectorIdAttachTable').val(rowId);
		var attachtable = document.getElementById("attachmentstable_"+rowId);
		if (attachtable) {
	        var clonedTable = attachtable.cloneNode(true);
	        clonedTable.style.display = "table";
	        $('.attachlist').html(clonedTable);
	        $('#connectorAttachModal').modal('show');
	    }

	}
	

	/* ----------------------------------- Attachments -------------------------- */
	/* Cloning (Adding) the table body rows for Attachments */
	$("#attachuploadtable").on('click','.btn_add_attachments' ,function() {
		
		var $tr = $('.tr_clone_attachments').last('.tr_clone_attachments');
		var $clone = $tr.clone();
		
		$tr.after($clone);
		
		$clone.find("input").val("").end();
		
	});


	/* Cloning (Removing) the table body rows for Attachments */
	$("#attachuploadtable").on('click','.btn_rem_attachments' ,function() {
		
		var cl=$('.tr_clone_attachments').length;
			
		if(cl>1){
		   var $tr = $(this).closest('.tr_clone_attachments');
		  
		   var $clone = $tr.remove();
		   $tr.after($clone);
		   
		}
	   
	});

</script>
</body>
</html>