<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.vts.pfms.documents.model.FieldGroupMaster"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">
.left {
	text-align: left;
}
.center {
	text-align: center;
}
.right {
	text-align: right;
}
	
.customtable{
	border-collapse: collapse;
	width: 100%;
	margin: 1.5rem 0.5rem 0.5rem 0.5rem;
	overflow-y: auto; 
	overflow-x: auto;  
}
.customtable th{
	border: 1px solid #0000002b; 
	padding: 10px;
		background-color: #2883c0;
}
.customtable td{
	border: 1px solid #0000002b; 
	padding: 5px;
}

.customtable thead {
	text-align: center;
	color: white;
	position: sticky;
	top: 0; /* Keeps the header at the top */
	z-index: 10; /* Ensure the header stays on top of the body */
	/* background-color: white; */ /* For visibility */
}

.table-wrapper {
    max-height: 500px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: hidden; /* Enable vertical scrolling */
}

.select2-container {
	width: 100% !important;
}

label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

</style>
</head>
<body>
	<%
		String docId = (String)request.getAttribute("docId");
		String irsDocId = (String)request.getAttribute("irsDocId");
		String docType = (String)request.getAttribute("docType");
		String documentNo = (String)request.getAttribute("documentNo");
		String projectId = (String)request.getAttribute("projectId");
		String logicalInterfaceId = (String)request.getAttribute("logicalInterfaceId");
		
		List<Object[]> irsSpecificationsList = (List<Object[]>)request.getAttribute("irsSpecificationsList");
		
		List<Object[]> fieldMasterList = (List<Object[]>)request.getAttribute("fieldMasterList");
		List<Object[]> dataTypeMasterList = (List<Object[]>)request.getAttribute("dataTypeMasterList");
		List<Object[]> fieldDescriptionList = (List<Object[]>)request.getAttribute("fieldDescriptionList");
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

		Set<Long> logicalInterfaceIds =  irsSpecificationsList.stream().map(e -> Long.parseLong(e[3].toString())).collect(Collectors.toSet());
		List<Object[]> fieldDescList =  fieldDescriptionList.stream().filter(e -> logicalInterfaceIds.contains(Long.parseLong(e[1].toString())) ).collect(Collectors.toList());
		fieldDescList = fieldDescriptionList.stream()
			    .collect(Collectors.groupingBy(e -> e[2]))
			    .values().stream()
			    .map(list -> list.get(0))
			    .collect(Collectors.toList());
		
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
    	<div class="card shadow-nohover" style="margin-top: -0.6pc">
        	<div class="card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
            	<div class="row">
               		<div class="col-md-6" class="left">
	                    <h5 id="text" style="margin-left: 1%; font-weight: 600">
	                      Field Description Details - <%=documentNo!=null?StringEscapeUtils.escapeHtml4(documentNo): " - " %>
	                    </h5>
                	</div>
                	
                	<div class="col-md-1" class="right">
                	</div>
                	
                	<div class="col-md-3" style="margin-top: -0.5rem;">
                	</div>
                	
                	<div class="col-md-1">
                	</div>
                    <div class="col-md-1 right">
	                    <form action="#" id="inlineapprform">
					        <button type="submit" class="btn btn-info btn-sm shadow-nohover back" data-toggle="tooltip" title="Back"
					        <%if(docType.equalsIgnoreCase("C")) { %> formaction="IRSSpecificationsDetails.htm" <%} else {%> formaction="IDDDesignDetails.htm" <%} %> >
					        	BACK
					        </button>
					       
					        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					        <input type="hidden" name="docId" value="<%=docId%>"> 
							<input type="hidden" name="docType" value="<%=docType%>"> 
							<input type="hidden" name="documentNo" value="<%=documentNo%>">
							<input type="hidden" name="projectId" value="<%=projectId%>">
							<input type="hidden" name="iddDocId" value="<%=docId%>">
							<input type="hidden" name="irsDocId" value="<%=irsDocId%>">
					    </form>
                    </div>
            	</div>
        	</div>
        	<div class="card-body">
				<div class="row">
               		<div class="col-md-6" style="text-align: left;">
                 		<label class="control-label" style="color: black;">Field Description :</label>
                	</div>
          		</div>
              				 	
			 	<div class="form-group">
              		<div class="row">
              			<div class="col-md-12">
              				<table id="fielddesctable" class="table table-bordered fielddesctable" style="width: 100%;" >
								<thead class="center" style="background: #055C9D;color: white;">
									<tr>
										<!-- <th >Group</th> -->
										<th >Field Name</th>
										<th >Data Type</th>
										<th >Typical Value</th>
										<th >Min Value</th>
										<th >Max Value</th>
										<th >Init Value</th>
										<th >Quantum</th>
										<th >Unit</th>
										<th >Description</th>
										<th >Remarks</th>
										<th >Action</th>
									</tr>
								</thead>
								<tbody>
									<%
									int slno1 = 1;
									if(fieldDescList!=null && fieldDescList.size()>0) {
										for(Object[] desc : fieldDescList) {
									%>
										<tr class="tr_clone_fielddesc">
											<%-- <td>
												<select class="form-control selectitem fieldGroupId" name="fieldGroupId" id="fieldGroupId_<%=slno1 %>" data-live-search="true" data-container="body" required disabled="disabled">
						               				<option value="" disabled selected>Choose...</option>
						               				<option value="0" <%if(desc[12]!=null && Long.parseLong(desc[12].toString())==0) {%>selected<%} %>>Not Applicable</option>
						               				<%for(FieldGroupMaster fieldGroup : fieldGroupList){
						                			 %>
														<option value="<%=fieldGroup.getFieldGroupId()%>" <%if(desc[12]!=null && Long.parseLong(desc[12].toString())==(fieldGroup.getFieldGroupId())) {%>selected<%} %> >
															<%=fieldGroup.getGroupName()+" ("+fieldGroup.getGroupCode()+")" %>
														</option>
													<%} %>
												</select>
												<input form="inlinesubform<%=slno1%>" type="hidden" name="fieldGroupId" value="<%=desc[12] != null ? desc[12] : "" %>"/>
											</td> --%>
											<td>
												<select class="form-control selectdee fieldMasterId" name="fieldMasterId" id="fieldMasterId_<%=slno1 %>" data-live-search="true" data-container="body" required disabled="disabled">
						               				<option value="" disabled selected>Choose...</option>
						               				<%for(Object[] obj : fieldMasterList ){
						                			 %>
														<option value="<%=obj[0]%>" <%if(desc[2]!=null && Long.parseLong(desc[2].toString())==Long.parseLong(obj[0].toString())) {%>selected<%} %> >
															<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>
														</option>
													<%} %>
												</select>
												<input form="inlinesubform<%=slno1%>" type="hidden" name="fieldMasterId" value="<%=desc[2] != null ? desc[2] : "" %>"/>
											</td>	
											<td>
												<input form="inlinesubform<%=slno1%>" type="text" class="form-control dataType" name="dataType" id="dataType_<%=slno1 %>" <%if(desc[27]!=null) {%> value="<%=StringEscapeUtils.escapeHtml4(desc[27].toString()) %>" <%} %> readonly>
											</td>	
											<td>
												<input form="inlinesubform<%=slno1%>" type="text" class="form-control typicalValue" name="typicalValue" id="typicalValue_<%=slno1 %>" value="<%=desc[13]!=null?StringEscapeUtils.escapeHtml4(desc[13].toString()): " - " %>" maxlength="255" required>
											</td>
											<td>
												<input form="inlinesubform<%=slno1%>" type="text" class="form-control minValue" name="minValue" id="minValue_<%=slno1 %>" value="<%=desc[14]!=null?StringEscapeUtils.escapeHtml4(desc[14].toString()): " - "  %>" maxlength="255" required>
											</td>
											<td>
												<input form="inlinesubform<%=slno1%>" type="text" class="form-control maxValue" name="maxValue" id="maxValue_<%=slno1 %>" value="<%=desc[15]!=null?StringEscapeUtils.escapeHtml4(desc[15].toString()): " - "  %>" maxlength="255" required>
											</td>
											<td>
												<input form="inlinesubform<%=slno1%>" type="text" class="form-control initValue" name="initValue" id="initValue_<%=slno1 %>" value="<%=desc[16]!=null?StringEscapeUtils.escapeHtml4(desc[16].toString()): " - "  %>" maxlength="255" required>
											</td>
											<td>
												<input form="inlinesubform<%=slno1%>" type="text" class="form-control quantum" name="quantum" id="quantum_<%=slno1 %>" value="<%=desc[6]!=null?StringEscapeUtils.escapeHtml4(desc[6].toString()): " - "  %>" maxlength="255" required>
											</td>
											<td>
												<input form="inlinesubform<%=slno1%>" type="text" class="form-control unit" name="unit" id="unit_<%=slno1 %>" value="<%=desc[18]!=null?StringEscapeUtils.escapeHtml4(desc[18].toString()): " - "  %>" maxlength="255" required>
											</td>	
											<td>
												<input form="inlinesubform<%=slno1%>" type="text" class="form-control description" name="description" id="description_<%=slno1 %>" value="<%=desc[5]!=null?StringEscapeUtils.escapeHtml4(desc[5].toString()): " - "  %>" maxlength="255" >
											</td>	
											<td>
												<input form="inlinesubform<%=slno1%>" type="text" class="form-control remarks" name="remarks" id="remarks_<%=slno1 %>" value="<%=desc[7]!=null?StringEscapeUtils.escapeHtml4(desc[7].toString()): " - "  %>" maxlength="500">
											</td>	
											<td class="center">
												<form action="IRSFieldDescModifySubmit.htm" method="post" id="inlinesubform<%=slno1%>">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									       			<input type="hidden" name="docId" value="<%=docId %>" />
									       			<input type="hidden" name="irsDocId" value="<%=docId %>" />
									       			<input type="hidden" name="docType" value="<%=docType %>" />
									       			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
									       			<input type="hidden" name="projectId" value="<%=projectId %>" />
									       			<input type="hidden" name="logicalInterfaceId" value="<%=logicalInterfaceId %>" />
									       			<input type="hidden" name="irsSpecificationId" value="<%=desc[19] %>" />
													<button type="submit" class="btn btn-sm" onclick="return confirm('Are you Sure to Update?')">
								   						<i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
								   					</button>
												</form>
												
											</td>		
										</tr>
									<%++slno1;} } else {%>
										<tr>
											<td colspan="11" class="center">No Data Available</td>
										</tr>
									<%} %>
								</tbody>
							</table>
              			</div>
              		</div>
              	</div>

        	</div>
        </div>
	</div>

   
</body>
</html>