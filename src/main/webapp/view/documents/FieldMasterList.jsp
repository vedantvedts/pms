<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.vts.pfms.documents.model.FieldGroupMaster"%>
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
 
.container-fluid{
  overflow-x: hidden!important;
}
 
/* Container for the tabs */


/* Hover effect for tabs */
.tab:hover {
    background-color: #ddd;
}

/* Active tab styling */
.tab.active {
    background-color: #4CAF50;
    color: white;
    border-color: #4CAF50;
}

/* When clicked, show content */
.tab-content {
    display: none;
}

/* Display content of active tab */
.tab-content.active {
    display: block;
    margin-top: 20px;
}
.tab-content {
    display: none; /* Hide all tab contents initially */
    padding: 15px;
   
    margin-top: 10px;

}

/* Show the active content */
.tab-content.active {
    display: block;
}

/* New sytles for tabs */
.tabs-wrapper {
    /* display: flex;
    align-items: center;
    justify-content: center; */
    width: 118%;
    overflow: hidden;
    /* position: relative;
    padding: 10px 0; */
}

.tabs-container {
    overflow: hidden;
    flex-grow: 1;
    white-space: nowrap;
    max-width: 80%; /* Restrict width */
}

.tabs-track {
    display: flex;
    gap: 10px;
    transition: scroll-left 0.3s ease-in-out;
    overflow-x: auto;
    scrollbar-width: none; /* Hide scrollbar for Firefox */
}

.tabs-track::-webkit-scrollbar {
    display: none; /* Hide scrollbar for Chrome, Safari */
}

.tab {
    padding: 10px 15px;
    background: #f8f9fa;
    border: 1px solid #ddd;
    border-radius: 5px;
    cursor: pointer;
    flex: 0 0 auto; /* Prevent shrinking */
    text-align: center;
    min-width: 160px;
    font-weight: 500;
    transition: background 0.3s, color 0.3s;
}

.tab:hover {
    background: #007bff;
    color: white;
}

.tab.active {
    background: #007bff;
    color: white;
    border-color: #0056b3;
}

.tab-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    min-width: 40px;
    min-height: 40px;
    font-size: 18px;
    border-radius: 50%;
    transition: background 0.3s;
}

.tab-btn:hover {
    background: #0056b3 !important;
}
</style>
</head>
<body>

	<%
		String fieldGroupId = (String) request.getAttribute("fieldGroupId");
		fieldGroupId = fieldGroupId==null?"0":fieldGroupId;
		List<Object[]> fieldMasterList = (List<Object[]>) request.getAttribute("fieldMasterList");
		List<FieldGroupMaster> fieldGroupList = (List<FieldGroupMaster>) request.getAttribute("fieldGroupList");
		
		Map<String, List<Object[]>> fieldGroupMap = new LinkedHashMap<>();
		fieldGroupMap.put("0", fieldMasterList);
	    
		for(FieldGroupMaster fieldGroup : fieldGroupList) {
			
			List<Object[]> fieldMasterByType = fieldMasterList.stream()
											    .filter(e -> {
											    	if(e[18]!=null) {
											    		String fieldGroupIds = e[18].toString();
												        List<String> idList = Arrays.asList(fieldGroupIds.split(","));
												        return idList.contains(fieldGroup.getFieldGroupId()+"");
											    	}else{
											    		return false;
											    	}
											        
											    })
				    							.collect(Collectors.toList());
			
			fieldGroupMap.computeIfAbsent(fieldGroup.getFieldGroupId()+"", k -> new ArrayList<>()).addAll(fieldMasterByType);
		}
		//fieldMasterList.stream().filter(e -> e[18].toString().split(","))
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
								<b>Field Master List</b>
							</h4>
						</div>
					</div>
				</div>
				
				<div class="card-body">
				
					<div class="tabs-wrapper d-flex align-items-center mt-2">
				        <button class="tab-btn prev btn btn-primary mr-2" onclick="scrollTabs(-1)">
				            <i class="fa fa-chevron-left"></i>
				        </button> 
				        <div class="tabs-container">
				            <div class="tabs-track d-flex">
				                <div class="tab  <%if(Long.parseLong(fieldGroupId)==0) {%> active <%} %>" data-target="0" data-fieldgroupid="0">Total List</div>
				                <%
				                	if(fieldGroupList!=null && fieldGroupList.size()>0) {
										for(FieldGroupMaster fieldGroup : fieldGroupList) {
				                %>
				                	<div class="tab <%if(Long.parseLong(fieldGroupId)==fieldGroup.getFieldGroupId()) {%> active <%} %> " data-target="<%=fieldGroup.getFieldGroupId() %>" 
				                	 data-fieldgroupid="<%=fieldGroup.getFieldGroupId()%>">
				                		<%=fieldGroup.getGroupName()!=null?StringEscapeUtils.escapeHtml4(fieldGroup.getGroupName()): " - "%> <%=" ("+(fieldGroup.getGroupCode()!=null?StringEscapeUtils.escapeHtml4(fieldGroup.getGroupCode()): " - ")+")" %>
				                	</div>
				                <%} }%>
				            </div>
				        </div>
				        <button class="tab-btn next btn btn-primary ml-2" onclick="scrollTabs(1)">
				            <i class="fa fa-chevron-right"></i>
				        </button> 
				    </div>
				    
				    <%for(Map.Entry<String, List<Object[]>> entry : fieldGroupMap.entrySet()) { 
						String fieldGroupIdKey = entry.getKey();
						List<Object[]> fieldList = entry.getValue();
					%>
					    <div class="tab-content" id="<%=fieldGroupIdKey %>">
					    	<%if(Long.parseLong(fieldGroupIdKey)>0) { 
					    		FieldGroupMaster fieldGroup = fieldGroupList.stream().filter(e -> e.getFieldGroupId()==Long.parseLong(fieldGroupIdKey)).findFirst().orElse(null);
					    	%>
					    		<div class="border rounded shadow-sm mb-3 bg-light" style="border-color: #007bff !important;margin-top: -1rem;border-width: 0.15rem !important;">
							    	<form action="IGIFieldGroupEditSubmit.htm" method="post" id="editform_<%=fieldGroupIdKey%>">
							    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							    		<input type="hidden" name="fieldGroupId" id="fieldGroupId_<%=fieldGroupIdKey%>" value="<%=fieldGroupIdKey%>">
							    		<div class="form-group mt-4">
				       						<div class="row">
				       							<div class="col-md-1"></div>
				       							<div class="col-md-1 right">
				       								<label class="form-label">Group Name<span class="mandatory">*</span></label>
				       							</div>
				                    		    <div class="col-md-2">
			       									<input type="text" class="form-control field" name="groupName" id="groupName_<%=fieldGroupIdKey%>" <%if(fieldGroup!=null && fieldGroup.getGroupName()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(fieldGroup.getGroupName()) %>"<%} %> 
													onchange="return checkDuplicateGroupName('<%=fieldGroupIdKey%>')" placeholder="Enter Group Name" maxlength="255" required>
			       								</div>
			       								
			       								<div class="col-md-1 right">
			       									<label class="form-label">Group Code<span class="mandatory">*</span></label>
			       								</div>
				                    		    <div class="col-md-2">
			       									<input type="text" class="form-control field" name="groupCode" id="groupCode_<%=fieldGroupIdKey%>" <%if(fieldGroup!=null && fieldGroup.getGroupCode()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(fieldGroup.getGroupCode()) %>"<%} %> 
													onchange="return checkDuplicateGroupCode('<%=fieldGroupIdKey%>')" placeholder="Enter Group Code" maxlength="5" required>
			       								</div>
			       								
			       								<div class="col-md-1 right">
			       									<label class="form-label d-block">Group Type<span class="mandatory">*</span></label>
			       								</div>
				                    		    <div class="col-md-2">
												  <div class="form-check form-check-inline">
												    <input type="radio" class="form-check-input groupType" name="groupType" value="Class" <%if(fieldGroup!=null && fieldGroup.getGroupType()!=null && fieldGroup.getGroupType().equalsIgnoreCase("Class")) {%>checked<%} %> required>
												    <label class="form-check-label">Class</label>
												  </div>
												  
												  <div class="form-check form-check-inline">
												    <input type="radio" class="form-check-input groupType" name="groupType" value="Union" <%if(fieldGroup!=null && fieldGroup.getGroupType()!=null && fieldGroup.getGroupType().equalsIgnoreCase("Union")) {%>checked<%} %> required>
												    <label class="form-check-label">Union</label>
												  </div>
												  
												  <div class="form-check form-check-inline">
												    <input type="radio" class="form-check-input groupType" name="groupType" value="Structure" <%if(fieldGroup!=null && fieldGroup.getGroupType()!=null && fieldGroup.getGroupType().equalsIgnoreCase("Structure")) {%>checked<%} %> required>
												    <label class="form-check-label">Structure</label>
												  </div>
												</div>
												<div class="col-md-2 left">
													<button type="submit"class="btn btn-sm edit" onclick="return confirm('Are you sure to Update?')">UPDATE</button>
												</div>
		                  				 	</div>
		                 				</div>
							    	</form>
							    </div>	
					    	<%} %>
							<form action="FieldMaster.htm" method="post" name="frm1">
								<div class="table-responsive" >
									<table class="table table-bordered table-hover table-striped table-condensed dataTable">
										<thead class="center">
											<tr>
												<th width="8%">Select</th>
												<!-- <th width="10%">Field Code</th> -->
												<!-- <th width="12%">Field Short Name</th> -->
												<th width="20%">Field Name</th>
												<th width="10%">Typical Value</th>
												<th width="10%">Min Value</th>
												<th width="10%">Max Value</th>
												<th width="10%">Init Value</th>
												<th width="10%">Unit</th>
											</tr>
										</thead>
										<tbody>
											<%
											int slno = 0;
											for (Object[] obj : fieldList) { %>
											<tr>
												<td class="center">
													<input type="radio" name="fieldMasterId" value="<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): ""%>">
												</td>
												<%-- <td class="center"><%=obj[3]%></td> --%>
												<%-- <td><%=obj[2]%></td> --%>
												<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></td>
												<td class="center"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - "%></td>
												<td class="center"><%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - "%></td>
												<td class="center"><%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - "%></td>
												<td class="center"><%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - "%></td>
												<td><%=obj[12]!=null?StringEscapeUtils.escapeHtml4(obj[12].toString()): " - "%></td>
												<%-- <td><%=obj[19]!=null?StringEscapeUtils.escapeHtml4(obj[19].toString()) :"-" %> <%= obj[12]!=null?"("+StringEscapeUtils.escapeHtml4(obj[12].toString())+")": " - "%></td> --%>
											</tr>
											<%} %>
										</tbody>
									</table>
								</div>
		
								<div align="center">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<div class="button-group">
										<button type="submit" class="btn btn-sm add" name="action" value="Add" >ADD</button>
										<button type="submit" class="btn btn-sm edit" name="action" value="Edit" onclick="return validateEdit()" >EDIT</button>
									</div>
								</div>
							</form>
						</div>
					<%} %>		
				</div>
			</div>
		</div>
	</div>

	
<script type="text/javascript">

	$(document).ready(function() {
       $('.dataTable').DataTable({
           "lengthMenu": [10, 25, 50, 75, 100],
           "pagingType": "simple",
       });
	});
	
	function validateEdit() {
		var fields = $("input[name='fieldMasterId']:checked").serializeArray();

		if (fields.length === 0) {
			alert("Please select a record from the list.");
			event.preventDefault();
			return false;
		}
		return true;
	}
	

	$('.tab').on('click', function () {
	    // Remove 'active' class from all tabs
	    $('.tab').removeClass('active');
	    // Add 'active' class to the clicked tab
	    $(this).addClass('active');

	    // Hide all tab contents
	    $('.tab-content').removeClass('active');
	    // Show the content corresponding to the clicked tab
	    const targetId = $(this).data('target');
	    const fieldgroupid = $(this).data('fieldgroupid');
		
	    $('#groupName').val(targetId);
	    $('.fieldGroupId').val(fieldgroupid);
	    $('#' + targetId).addClass('active');
	});
	
	function scrollTabs(direction) {
	    const container = document.querySelector(".tabs-container");
	    const track = document.querySelector(".tabs-track");

	    const scrollAmount = container.clientWidth * 0.8;
	    track.scrollLeft += direction * scrollAmount;
	}

	$(document).ready(function() {
	    var activetab = $('.tab.active');
	    var datatarget = activetab.data('target');
	    
	    $('#' + datatarget).addClass('active');
	});
	
	// Group Name Duplicate Check
	function checkDuplicateGroupName(rowId){
		
		var groupName = $('#groupName_'+rowId).val();
		var fieldGroupId = $('#fieldGroupId_'+rowId).val();
		
		$.ajax({
            type: "GET",
            url: "GroupNameDuplicateCheck.htm",
            data: {
            	groupName: groupName,
            	fieldGroupId: fieldGroupId
            },
            datatype: 'json',
            success: function(result) {
                var ajaxresult = JSON.parse(result); 

                // Check if the Group Name already exists
                if (ajaxresult > 0) {
                	$('#groupName_'+rowId).val('');
                    alert('Group Name Already Exists');
                }
            },
            error: function() {
                alert('An error occurred while checking the Group Name.');
            }
        });
	}
	
	// Group Code Duplicate Check
	function checkDuplicateGroupCode(rowId){
		
		var groupCode = $('#groupCode_'+rowId).val();
		var fieldGroupId = $('#fieldGroupId_'+rowId).val();
		
		$.ajax({
            type: "GET",
            url: "GroupCodeDuplicateCheck.htm",
            data: {
            	groupCode: groupCode,
            	fieldGroupId: fieldGroupId
            },
            datatype: 'json',
            success: function(result) {
                var ajaxresult = JSON.parse(result); 

                // Check if the Group Code already exists
                if (ajaxresult > 0) {
                	$('#groupCode_'+rowId).val('');
                    alert('Group Code Already Exists');
                }
            },
            error: function() {
                alert('An error occurred while checking the Group Code.');
            }
        });
	}

</script>
</body>
</html>