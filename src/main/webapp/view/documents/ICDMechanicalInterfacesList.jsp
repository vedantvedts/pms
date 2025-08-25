<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.documents.model.ICDMechanicalInterfaces"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>


<style type="text/css">
label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

.card-body{
	padding: 0rem !important;
}

.navigation_btn{
	margin: 1%;
}

.b{
	background-color: #ebecf1;	
}

.a{
	background-color: #d6e0f0;
}

.center {
	text-align: center !important;
}

.right {
	text-align: right !important;
}

.left {
	text-align: left !important;
}

.fw-bold {
	font-weight: bold !important;
}
.select2-selection__rendered{
	text-align: left !important;
}

.customSidebar {
	min-height: 660px;
    max-height: 660px;
    overflow-y: auto;
    overflow-x: hidden;
    scrollbar-width: thin;
  	scrollbar-color: #007bff #f8f9fa;
}

.customeSidebarBtn {
	margin-right: 0.25rem;
	margin-left: 0.25rem;
	margin-top: 0.25rem;
	width: 97%;
	border-radius: 0.75rem;
}

.custom-container {
	display: flex;
	margin: 1rem;
}

/* Summer Note styles */
.note-editor {
	width: 100% !important;
	/* margin: 1rem 2.5rem; */
}
</style>
</head>
<body>
	<%
		String icdDocId = (String)request.getAttribute("icdDocId");
		String documentNo = (String)request.getAttribute("documentNo");
		String projectId = (String)request.getAttribute("projectId");
		String mechInterfaceId = (String)request.getAttribute("mechInterfaceId");
		List<ICDMechanicalInterfaces> mechanicalInterfacesList = (List<ICDMechanicalInterfaces>)request.getAttribute("mechanicalInterfacesList");
		ICDMechanicalInterfaces mechanicalInterface = (ICDMechanicalInterfaces)request.getAttribute("icdMechanicalInterfaceData");
		List<Object[]> productTreeAllList = (List<Object[]>)request.getAttribute("productTreeAllList"); 

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
	
	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
 			<div class="card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
            	<div class="row">
               		<div class="col-md-9" align="left">
	                    <h5 id="text" style="margin-left: 1%; font-weight: 600">
	                      Mechanical Interfaces - <%=documentNo!=null?StringEscapeUtils.escapeHtml4(documentNo): " - "  %>
	                    </h5>
                	</div>
                	<div class="col-md-2"  align="right">
                	</div>
                    <div class="col-md-1" align="right">
                        <a class="btn btn-info btn-sm shadow-nohover back" style="position: relative;" href="ICDDocumentDetails.htm?icdDocId=<%=icdDocId %>">Back</a>
                    </div>
            	</div>
        	</div>
       		
       		<div class="card-body">
				<div class="custom-container">
       				<div style="width: 18%;">
       					<div class="card" style="border-color: #007bff;">
     						<div class="card-header center" style="background-color: transparent;border-color: #007bff;">
     							<h5 class="" style="font-weight: bold;color: #8b550c;">List of Interfaces</h5>
     						</div>
   							<div class="card-body customSidebar">
								<div class="row">
  									<div class="col-md-12">
  										<form action="ICDMechanicalInterfacesList.htm" method="GET">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
											<input type="hidden" name="icdDocId" value="<%=icdDocId%>">
											<input type="hidden" name="documentNo" value="<%=documentNo%>">
     										<button type="submit" class="btn btn-outline-primary fw-bold customeSidebarBtn" <%if(0L==Long.parseLong(mechInterfaceId)) {%> style="background-color: green;color: white;border-color: green;padding: 0.2rem;" <%} else{%>style="padding: 0.2rem;"<%}%> data-toggle="tooltip" data-placement="top">
     											Add New Interface
     										</button>
	     								</form>		
  									</div>
   								</div> 
   								
   								<div>
   									<%
   									int interfaceCount = 0;
   									for (ICDMechanicalInterfaces iface : mechanicalInterfacesList) {
   									%>
								        <div class="row">
								            <div class="col-md-12 ml-4">
								                <form action="ICDMechanicalInterfacesList.htm" method="GET">
								                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								                    <input type="hidden" name="icdDocId" value="<%=icdDocId%>" />
								                    <input type="hidden" name="documentNo" value="<%=documentNo%>">
								                    <button type="submit" class="btn btn-sm btn-outline-primary fw-bold customeSidebarBtn left"
								                        name="mechInterfaceId" value="<%=iface.getMechInterfaceId()%>" 
								                        data-toggle="tooltip" data-placement="top" title="<%=iface.getInterfaceCode()%>" 
								                        <% if (iface.getMechInterfaceId().equals(Long.parseLong(mechInterfaceId))) { %>
								                        style="background-color: green; color: white; border-color: green; width: 86%;" 
								                        <% } else { %> style="width: 86%;" <% } %>>
								                        <%=(++interfaceCount) + ". " + iface.getInterfaceSeqId()!=null?StringEscapeUtils.escapeHtml4(iface.getInterfaceSeqId()): " - " %>
								                    </button>
								                </form>
								            </div>
								        </div>
							        <% } %>   
							    </div> 
							 </div>   
						</div>
					</div>
					
					<div style="width: 82%;">
       					<div class="card ml-3 mr-3">
       						<div class="card-header">
       							<h4 class="text-dark">Interface Details <%if(mechanicalInterface!=null) {%>- <%=StringEscapeUtils.escapeHtml4(mechanicalInterface.getInterfaceCode()) %><%} else{%>Add<%} %> </h4>
       						</div>
       						<div class="card-body m-2">
       							<form action="ICDMechanicalInterfaceDetailsSubmit.htm" method="post" id="myform" enctype="multipart/form-data">
       								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
       								<input type="hidden" name="icdDocId" value="<%=icdDocId%>">
       								<input type="hidden" name="documentNo" value="<%=documentNo%>">
       								<input type="hidden" name="mechInterfaceId" id="mechInterfaceId" value="<%=mechInterfaceId%>">
       								
       								<div class="form-group">
	        							<div class="row">
			        						<div class="col-md-2">
			        							<label class="form-lable">Sub-System 1<span class="mandatory">*</span></label>
			        							<select class="form-control selectdee subSystem1" name="subSystemOne" id="subSystem1"
				        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required <%if(mechanicalInterface!=null) {%> disabled="disabled" <%} %> >
										        	<option value="" disabled selected>Choose...</option>
											        <%
											        for(Object[] obj : productTreeAllList){ %>
											        	<option value="<%=obj[0]+"/"+obj[7] %>" <%if(mechanicalInterface!=null && mechanicalInterface.getSubSystemMainIdOne()==Long.parseLong(obj[0].toString())) {%>selected<%} %> >
											        		<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%> <%=" ("+(obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - ")+")" %>
											        	</option>
											        <%} %>
												</select>
			        						</div>
			        						<div class="col-md-2">
			        							<label class="form-lable">Sub-System 2<span class="mandatory">*</span></label>
				        						<select class="form-control selectdee subSystem2" name="subSystemTwo" id="subSystem2"
				        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required <%if(mechanicalInterface!=null) {%> disabled="disabled" <%} %>>
													<option value="" disabled selected>Choose...</option>
											        <% for(Object[] obj : productTreeAllList){ %>
											        	<option value="<%=obj[0]+"/"+obj[7] %>" <%if(mechanicalInterface!=null && mechanicalInterface.getSubSystemMainIdTwo()==Long.parseLong(obj[0].toString())) {%>selected<%} %> >
											        		<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%> <%=" ("+(obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - ")+")" %>
											        	</option>
											        <%} %>
												</select>
		        							</div>
		        							<div class="col-md-2">
       											<label class="form-lable">Interface Code <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="interfaceCode" <%if(mechanicalInterface!=null && mechanicalInterface.getInterfaceCode()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(mechanicalInterface.getInterfaceCode()) %>" readonly <%} %> placeholder="Enter Interface Code" maxlength="4" required>
       										</div>
       										<div class="col-md-2">
       											<label class="form-lable">Interface Name <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="interfaceName" <%if(mechanicalInterface!=null && mechanicalInterface.getInterfaceName()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(mechanicalInterface.getInterfaceName()) %>"<%} %> placeholder="Enter Interface Name" maxlength="500" required>
       										</div>
       										<div class="col-md-2">
       											<label class="form-lable">Drawing-1  <%if(mechanicalInterface==null) {%><span class="mandatory">*</span><%} %></label>
       											<%if(mechanicalInterface!=null && mechanicalInterface.getDrawingOne()!=null) {%>
													<button type="submit" class="btn btn-sm attachments" name="drawingAttach" value="<%=StringEscapeUtils.escapeHtml4(mechanicalInterface.getDrawingOne()) %>" formaction="ICDMechanicalDrawingAttachDownload.htm" formmethod="get" formnovalidate="formnovalidate" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
					                      				<i class="fa fa-download"></i>
					                      			</button>
				                      			<%} %>
        										<input type="file" class="form-control" name="drawingOne" id="drawingOne" accept="application/pdf" <%if(mechanicalInterface==null) {%>required<%} %> >       										
        									</div>
       										<div class="col-md-2">
       											<label class="form-lable">Drawing-2 <%if(mechanicalInterface==null) {%><span class="mandatory">*</span><%} %></label>
       											<%if(mechanicalInterface!=null && mechanicalInterface.getDrawingTwo()!=null) {%>
			       									<button type="submit" class="btn btn-sm attachments" name="drawingAttach" value="<%=StringEscapeUtils.escapeHtml4(mechanicalInterface.getDrawingTwo()) %>" formaction="ICDMechanicalDrawingAttachDownload.htm" formmethod="get" formnovalidate="formnovalidate" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
					                      				<i class="fa fa-download"></i>
					                      			</button>
				                      			<%} %>
        										<input type="file" class="form-control" name="drawingTwo" id="drawingTwo" accept="application/pdf" <%if(mechanicalInterface==null) {%>required<%} %> > 
       										</div>
		        						</div>	
	        						</div>	
       								
       								<div class="form-group">
       									<div class="row">
       										<div class="col-md-6">
       											<label class="form-lable">Part-1 <span class="mandatory">*</span></label>
		       									<textarea rows="3" class="form-control" name="partOne" placeholder="Enter Part-1 Details" maxlength="500" required><%if(mechanicalInterface!=null && mechanicalInterface.getPartOne()!=null) {%><%=StringEscapeUtils.escapeHtml4(mechanicalInterface.getPartOne()) %><%} %></textarea>
       										</div>
       										<div class="col-md-6">
       											<label class="form-lable">Part-2 <span class="mandatory">*</span></label>
		       									<textarea rows="3" class="form-control" name="partTwo" placeholder="Enter Part-2 Details" maxlength="500" required><%if(mechanicalInterface!=null && mechanicalInterface.getPartTwo()!=null) {%><%=StringEscapeUtils.escapeHtml4(mechanicalInterface.getPartTwo()) %><%} %></textarea>
       										</div>
       									</div>
       								</div>
       								
       								<div class="form-group">
       									<div class="row">
       										<div class="col-md-6">
       											<label class="form-lable">Description <span class="mandatory">*</span></label>
		       									<textarea rows="3" class="form-control" name="description" placeholder="Enter Description" maxlength="500" required><%if(mechanicalInterface!=null && mechanicalInterface.getDescription()!=null) {%><%=StringEscapeUtils.escapeHtml4(mechanicalInterface.getDescription()) %><%} %></textarea>
       										</div>
       										<div class="col-md-6">
       											<label class="form-lable">Applicable Standards <span class="mandatory">*</span></label>
		       									<textarea rows="3" class="form-control" name="standards" placeholder="Enter Applicable Standards" maxlength="500" required><%if(mechanicalInterface!=null && mechanicalInterface.getStandards()!=null) {%><%=StringEscapeUtils.escapeHtml4(mechanicalInterface.getStandards()) %><%} %></textarea>
       										</div>
       									</div>
       								</div>
       								
       								<div class="form-group">
       									<div class="row">
       										<div class="col-md-6">
       											<label class="form-lable">Precautions <span class="mandatory">*</span></label>
		       									<textarea rows="3" class="form-control" name="precautions" placeholder="Enter Precautions" maxlength="500" required><%if(mechanicalInterface!=null && mechanicalInterface.getPrecautions()!=null) {%><%=StringEscapeUtils.escapeHtml4(mechanicalInterface.getPrecautions()) %><%} %></textarea>
       										</div>
       										<div class="col-md-6">
       											<label class="form-lable">Handling Instructions <span class="mandatory">*</span></label>
		       									<textarea rows="3" class="form-control" name="instructions" placeholder="Enter Handling Instructions" maxlength="500" required><%if(mechanicalInterface!=null && mechanicalInterface.getInstructions()!=null) {%><%=StringEscapeUtils.escapeHtml4(mechanicalInterface.getInstructions()) %><%} %></textarea>
       										</div>
       									</div>
       								</div>
       								
       								<div class="form-group">
       									<div class="row">
       										<div class="col-md-6">
       											<label class="form-lable">Remarks</label>
		       									<textarea rows="3" class="form-control" name="remarks" placeholder="Enter Remarks" maxlength="500"><%if(mechanicalInterface!=null && mechanicalInterface.getRemarks()!=null) {%><%=StringEscapeUtils.escapeHtml4(mechanicalInterface.getRemarks()) %><%} %></textarea>
       										</div>
       										<div class="col-md-6">
       										</div>
       									</div>
       								</div>
       								
       								<div class="form-group">
	       								<div class="center">
	       									<%if(mechanicalInterface!=null){ %>
												<button type="submit" class="btn btn-sm btn-warning edit btn-soc" name="action" value="Edit" onclick="return confirm('Are you sure to Update?')" >UPDATE</button>
											<%}else{ %>
												<button type="submit" class="btn btn-sm btn-success submit btn-soc" name="action" value="Add" onclick="return confirm('Are you sure to Submit?')" >SUBMIT</button>
											<%} %>
	       								</div>
	       							</div>	
	       								
	       						</form>
	       					</div>
	       				</div>
	       			</div>				
				</div>		     		
       		</div>
       	</div>
	</div> 		
</body>
</html>