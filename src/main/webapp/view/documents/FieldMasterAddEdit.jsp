<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.documents.model.FieldGroupLinked"%>
<%@page import="com.vts.pfms.documents.model.FieldGroupMaster"%>
<%@page import="com.vts.pfms.documents.model.FieldMaster"%>
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
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}
</style>
</head>
<body>

	<%
		List<Object[]> dataTypeMasterList = (List<Object[]>) request.getAttribute("dataTypeMasterList");
		List<FieldGroupMaster> fieldGroupList = (List<FieldGroupMaster>) request.getAttribute("fieldGroupList");
		List<FieldGroupLinked> fieldGroupLinkedList = (List<FieldGroupLinked>) request.getAttribute("fieldGroupLinkedList");
		List<Long> likedGroupIds = fieldGroupLinkedList!=null?fieldGroupLinkedList.stream().map(e -> e.getFieldGroupId()).collect(Collectors.toList()): new ArrayList<>();
		FieldMaster fieldMaster = (FieldMaster) request.getAttribute("fieldMaster");
	%>
	<div class="container-fluid">

		<div class="card shadow-nohover">
			<div class="card-header" style="background-color: #055C9D; margin-top:">
				<div class="row">
					<div class="col-md-10">
						<b class="text-white">Field Master <%=fieldMaster != null?"Edit":"Add" %></b>
					</div>
					<div class="col-md-2"></div>
				</div>
			</div>
			
			<div class="card-body">
				<form name="myfrm" action="FieldMasterDetailsSubmit.htm" method="POST">
					<div class="form-group">
						<div class="row">
							<div class="col-md-3">
								<label class="form-label">Field Name:<span class="mandatory">*</span></label> 
								<input class="form-control" type="text" name="fieldName" <%if(fieldMaster!=null && fieldMaster.getFieldName()!=null) {%>value="<%=fieldMaster.getFieldName()%>" <%}%> placeholder="Enter Field Name" maxlength="255" required>
							</div>
							<%-- <div class="col-md-3">
								<label class="form-label">Field Short Name:<span class="mandatory">*</span></label> 
								<input class="form-control" type="text" name="fieldShortName" <%if(fieldMaster!=null && fieldMaster.getFieldShortName()!=null) {%>value="<%=fieldMaster.getFieldShortName()%>" <%}%> placeholder="Enter Field Short Name" maxlength="100" required>
							</div> --%>
							<%-- <div class="col-md-3">
								<label class="form-label">Field Code:<span class="mandatory">*</span></label> 
								<input class="form-control" type="text" name="fieldCode" <%if(fieldMaster!=null && fieldMaster.getFieldCode()!=null) {%>value="<%=fieldMaster.getFieldCode()%>" <%}%> placeholder="Enter Field Code" maxlength="5" required style="text-transform: uppercase;">
							</div> --%>
							<div class="col-md-3">
								<label class="form-label">Data Type:<span class="mandatory">*</span></label> 
								<select class="form-control selectdee" name="dataTypeMasterId" data-live-search="true" data-container="body" required>
		               				<option value="" disabled selected>Choose...</option>
		               				<%for(Object[] obj : dataTypeMasterList ){
		                			 %>
										<option value="<%=obj[0]%>" <%if(fieldMaster!=null && fieldMaster.getDataTypeMasterId()!=null && fieldMaster.getDataTypeMasterId()==Long.parseLong(obj[0].toString())) {%>selected<%} %> ><%=obj[3] %></option>
									<%} %>
								</select>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<div class="row">
							<div class="col-md-3">
								<label class="form-label">Typical Value:<span class="mandatory">*</span></label> 
								<input class="form-control" type="text" name="typicalValue" <%if(fieldMaster!=null && fieldMaster.getTypicalValue()!=null) {%>value="<%=fieldMaster.getTypicalValue()%>" <%}%> placeholder="Enter Typical Value" maxlength="255" required>
							</div>
							<div class="col-md-3">
								<label class="form-label">Min Value:<span class="mandatory">*</span></label> 
								<input class="form-control" type="text" name="minValue" <%if(fieldMaster!=null && fieldMaster.getFieldMinValue()!=null) {%>value="<%=fieldMaster.getFieldMinValue()%>" <%}%> placeholder="Enter Min Value" maxlength="255" required>
							</div>
							<div class="col-md-3">
								<label class="form-label">Max Value:<span class="mandatory">*</span></label> 
								<input class="form-control" type="text" name="maxValue" <%if(fieldMaster!=null && fieldMaster.getFieldMaxValue()!=null) {%>value="<%=fieldMaster.getFieldMaxValue()%>" <%}%> placeholder="Enter Max Value" maxlength="255" required>
							</div>
							<div class="col-md-3">
								<label class="form-label">Init Value:<span class="mandatory">*</span></label> 
								<input class="form-control" type="text" name="initValue" <%if(fieldMaster!=null && fieldMaster.getInitValue()!=null) {%>value="<%=fieldMaster.getInitValue()%>" <%}%> placeholder="Enter Init Value" maxlength="255" required>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<div class="row">
							<div class="col-md-3">
								<label class="form-label">Quantum:<span class="mandatory">*</span></label> 
								<input class="form-control" type="text" name="quantum" <%if(fieldMaster!=null && fieldMaster.getQuantum()!=null) {%>value="<%=fieldMaster.getQuantum()%>" <%}%> placeholder="Enter Quantum" maxlength="255" required>
							</div>
							<div class="col-md-3">
								<label class="form-label">Unit:<span class="mandatory">*</span></label> 
								<input class="form-control" type="text" name="unit" <%if(fieldMaster!=null && fieldMaster.getFieldUnit()!=null) {%>value="<%=fieldMaster.getFieldUnit()%>" <%}%> placeholder="Enter Unit" maxlength="255" required>
							</div>
							<div class="col-md-3">
								<label class="form-label">Description:</label> 
								<input class="form-control" type="text" name="fieldDesc" <%if(fieldMaster!=null && fieldMaster.getFieldDesc()!=null) {%>value="<%=fieldMaster.getFieldDesc()%>" <%}%> placeholder="Enter Field Description" maxlength="255" >
							</div>
							<div class="col-md-3">
								<label class="form-label">Remarks:</label> 
								<input class="form-control" type="text" name="remarks" <%if(fieldMaster!=null && fieldMaster.getRemarks()!=null) {%>value="<%=fieldMaster.getRemarks()%>" <%}%> placeholder="Enter Remarks" maxlength="255" >
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<div class="row">
							<div class="col-md-6">
								<label class="form-label">Groups:</label>
								<select class="form-control selectdee fieldGroupId" name="fieldGroupId" id="fieldGroupId" data-placeholder="Choose..." multiple="multiple">
									<option value="0">Add New Group</option>
							        <% for(FieldGroupMaster group : fieldGroupList){ %>
							        	<option value="<%=group.getFieldGroupId() %>" <%if(likedGroupIds!=null && likedGroupIds.contains(group.getFieldGroupId())) {%>selected<%} %> >
							        		<%=group.getGroupName()+" ("+group.getGroupCode()+")" %>
							        	</option>
							        <%} %>
								</select>
							</div>
						</div>
					</div>
											
					<div class="center">
						<%if (fieldMaster!= null) { %>
							<button type="submit" class="btn btn-sm btn-warning edit" name="action" value="Edit" onclick="return confirm('Are you sure to Update?')" >UPDATE</button>
							<input type="hidden" name="fieldMasterId" value="<%=fieldMaster.getFieldMasterId()%>" />
						<% } else { %>
							<button type="submit" class="btn btn-sm submit" name="action" value="Add" onclick="return confirm('Are you sure to Submit?')" >SUBMIT</button>
							<input type="hidden" name="fieldMasterId" value="0" />
						<% } %>
						
						<a class="btn  btn-sm  back" href="FieldMaster.htm">BACK</a>
					</div>

					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
		</div>
	</div>


	<!-- ----------------------------------------------- Add New Group Modal --------------------------------------------------------------- -->
	<div class="modal fade bd-example-modal-lg center" id="addNewFieldGroupModal" tabindex="-1" role="dialog" aria-labelledby="addNewFieldGroupModal" aria-hidden="true" style="margin-top: 10%;">
		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
			<div class="modal-content" style="width: 150%;margin-left: -27%;">
				<div class="modal-header" style="background: #055C9D;color: white;">
		        	<h5 class="modal-title ">Add New Group</h5>
			        <button type="button" class="close" style="text-shadow: none !important" data-dismiss="modal" aria-label="Close">
			          <span class="text-light" aria-hidden="true">&times;</span>
			        </button>
		      	</div>
     			<div class="modal-body">
     				<div class="container-fluid mt-3">
     					<div class="row">
							<div class="col-md-12 " align="left">
								<form action="#" method="POST" id="myform">
									<div class="form-group">
			       						<div class="row">
			                    		    <div class="col-md-4">
		       									<label class="form-label">Group Name <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control field" name="groupName" id="groupName" placeholder="Enter Group Name" maxlength="255" required>
		       								</div>
			                    		    <div class="col-md-3">
		       									<label class="form-label">Group Code <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control field" name="groupCode" id="groupCode" placeholder="Enter Group Code" maxlength="5" required>
		       								</div>
			                    		    <div class="col-md-5">
											  <label class="form-label d-block">Group Type <span class="mandatory">*</span></label>
											  
											  <div class="form-check form-check-inline">
											    <input type="radio" class="form-check-input groupType" name="groupType" value="Class" checked required>
											    <label class="form-check-label">Class</label>
											  </div>
											  
											  <div class="form-check form-check-inline">
											    <input type="radio" class="form-check-input groupType" name="groupType" value="Union" required>
											    <label class="form-check-label">Union</label>
											  </div>
											  
											  <div class="form-check form-check-inline">
											    <input type="radio" class="form-check-input groupType" name="groupType" value="Structure" required>
											    <label class="form-check-label">Structure</label>
											  </div>
											</div>
	                  				 	</div>
                  				 	</div>
									
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<div class="center mt-2">
										<button type="button"class="btn btn-sm submit" onclick="addNewFieldGroups()">SUBMIT</button>
									</div>
								</form>
							</div>
						</div>
     				</div>
     			</div>
     		</div>
		</div>
	</div>	
	<!-- ----------------------------------------------- Add New Group Modal End --------------------------------------------------------------- -->
	
<script type="text/javascript">
	$('#fieldGroupId').on('change', function(){
		var selectedValues = $(this).val() || []; // Get selected values or an empty array if nothing is selected
		if(selectedValues.includes('0')) {
			$('.field').val('');
			$("input[name='groupType'][value='Class']").prop("checked", true);
			$('#addNewFieldGroupModal').modal('show');
		}
	});
	
	function addNewFieldGroups() {
		if(confirm('Are you sure to Add?')){
			
			var groupName = $('#groupName').val();
			var groupCode = $('#groupCode').val();
			var groupTypeArray = $("input[name='groupType']:checked").serializeArray();
			var groupType = groupTypeArray[0].value;
			
			if(groupName==null || groupName =="null" || groupName=='') {
				alert('Please fill Group Name');
				return false;
			}else if(groupCode==null || groupCode =="null" || groupCode=='') {
				alert('Please fill Group Code');
				return false;
			}else if(groupType==null || groupType =="null" || groupType=='') {
				alert('Please fill Group Type');
				return false;
			}else {
				$.ajax({
					Type:'GET',
					url:'IGIFieldGroupDetailsSubmit.htm',
					datatype:'json',
					data:{
						groupName : groupName,
						groupCode : groupCode,
						groupType : groupType,
					},
					success:function(result){
						var values = JSON.parse(result);
						var x="<option value="+values[0]+" selected='selected'>"+ values[1] + " (" + values[2] + ")" + "</option>";     
						$('#fieldGroupId option[value="0"]').prop('selected', false);
						$('#fieldGroupId').append(x);
						$('.close').click();
					}
				});
				
				return true;
			}
			 
			return true;
		}else{
			event.PreventDefault();
			return false;
		}
	}
</script>
</body>

</html>

