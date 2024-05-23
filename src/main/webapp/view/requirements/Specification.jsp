<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/Overall.css" var="StyleCSS" />
<link href="${StyleCSS}" rel="stylesheet" />
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>
</head>
<body>
	<%
String projectType=(String)request.getAttribute("projectType");
String projectId = (String)request.getAttribute("projectId");
String initiationId=(String)request.getAttribute("initiationId");
String productTreeMainId=(String)request.getAttribute("productTreeMainId");
String SpecsInitiationId=(String)request.getAttribute("SpecsInitiationId");
List<Object[]>DocumentSummaryList=(List<Object[]>)request.getAttribute("DocumentSummary");
Object[]DocumentSummary=null;
if(DocumentSummaryList!=null && DocumentSummaryList.size()>0){
	DocumentSummary=DocumentSummaryList.get(0);
}
List<Object[]>EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");
List<Object[]>MemberList = (List<Object[]>)request.getAttribute("MemberList");
LocalDate d = LocalDate.now();
Month months= d.getMonth();
int years=d.getYear();
Object[]LabList=(Object[])request.getAttribute("LabList");
List<Object[]>TotalEmployeeList=(List<Object[]>)request.getAttribute("TotalEmployeeList");
%>

	<%String ses=(String)request.getParameter("result"); 
 	  String ses1=(String)request.getParameter("resultfail");
	  if(ses1!=null){
	%>
	<div align="center">

		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</div>
	<%} %>	
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0.6pc">
					<div class="row card-header"
						style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
						<div class="col-md-10" id="projecthead" align="left">
							<h5 id="text" style="margin-left: 1%; font-weight: 600">System
								Segment Specification</h5>
						</div>
						
							<div class="col-md-2" align="right">
							<form action="ProjectSpecification.htm" method="post">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								 <input type="hidden" name="projectType" value="<%=projectType%>">
								 <input type="hidden" name="projectId" value="<%=projectId%>">
								<input type="hidden" name="initiationId" value="<%=initiationId%>">
								<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>"> 
								<button type="submit" class="btn btn-primary btn-sm back">Back</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container" id="container" style="height: 80%;">
		<div class="row" style="display: inline;height: 90%;">
			<div class="requirementid mt-2 ml-2" style="height: 90%;">
				<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="DownloadDoc()"><img alt="" src="view/images/worddoc.png" >&nbsp;Specification Document</span> 
				<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="DownloadDocPDF()"><img alt="" src="view/images/pdf.png" >&nbsp;Specification Document</span> 
		        <span class="badge badge-light mt-2 sidebar pt-2 pb-2 btn-req" onclick="showSummaryModal()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Document Summary</span>
		        <span class="badge badge-light mt-2 sidebar pt-2 pb-2 btn-req" onclick="showAbbreviations()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Abbreviations</span>
		        <span class="badge badge-light mt-2 sidebar pt-2 pb-2 btn-req" onclick="showSentModal()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Document Distribution</span>
				<span class="badge badge-light mt-2 sidebar pt-2 pb-2 btn-req" onclick="showIntroudction()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Scope</span>
			</div>
			
				     	<div class="mt-2" id="reqdiv">
				<div style="margin-left: 5%;overflow:auto"id="scrollclass">
					<table class="table table-bordered">
						<tr class="table-warning">
							<td align="center" colspan="2" class="text-primary">DOCUMENT SUMMARY</td>
						</tr>
						<tr>
							<td  class="text-primary" colspan="2">1.&nbsp; Title: <span class="text-dark">System Sub System Test Plan Document Template</span></td>
						</tr>
						<tr >
							<td class="text-primary">2.&nbsp; Type of Document:<span class="text-dark">System Sub System Test Plan Document</span></td>
							<%-- <td class="text-primary">3.&nbsp; Classification: <span class="text-dark"><%=classification %></span></td> --%>
							<td class="text-primary">3.&nbsp; Classification: <span class="text-dark"></span></td>
						</tr>
					    <tr >
							<td class="text-primary">4.&nbsp; Document Number:</td>
							<td class="text-primary">5.&nbsp; Month Year: <span style="color:black;"><%=months.toString().substring(0,3) %>&nbsp;&nbsp;<%=years %></span></td>
						</tr>
						<tr>
							<td class="text-primary">6.&nbsp; Number of Pages:</td>
							<td class="text-primary">7.&nbsp; Related Document:</td>
						</tr>
						<tr>
							<td  class="text-primary" colspan="2">8.&nbsp; Additional Information:
								<%if(DocumentSummary!=null && DocumentSummary[0]!=null) {%><span class="text-dark"><%=DocumentSummary[0]%></span> <%} %>
							</td>
						</tr>
					    <tr>
							<td  class="text-primary" colspan="2">9.&nbsp; Project Number and Project Name: <span class="text-dark"> </span></td>
						</tr>
						<tr>
							<td  class="text-primary" colspan="2">10.&nbsp; Abstract:
								<%if(DocumentSummary!=null && DocumentSummary[1]!=null) {%> <span class="text-dark"><%=DocumentSummary[1]%></span><%} %>
							</td>
						</tr>
						<tr>
							<td  class="text-primary" colspan="2">11.&nbsp; Keywords:
								<%if(DocumentSummary!=null && DocumentSummary[2]!=null) {%> <span class="text-dark"><%=DocumentSummary[2]%></span><%} %>
							</td>
						</tr>
						<tr>
							<td  class="text-primary" colspan="2">12.&nbsp; Organization and address:
								<span class="text-dark">		
									<%if (LabList[1] != null) {%>
										<%=LabList[1].toString() + "(" + LabList[0].toString() + ")"%>
									<%} else {%>
										-
									<%}%>
									
									Government of India, Ministry of Defence,Defence
									Research & Development Organization
									<%if (LabList[2] != null && LabList[3] != null && LabList[5] != null) {%>
										<%=LabList[2] + " , " + LabList[3].toString() + ", PIN-" + LabList[5].toString()+"."%>
									<%}else{ %>
										-
									<%} %>
								</span>
							</td>
						</tr>
						<tr>
							<td  class="text-primary" colspan="2">13.&nbsp; Distribution:
								<%if(DocumentSummary!=null && DocumentSummary[3]!=null) {%> <span class="text-dark"><%=DocumentSummary[3]%></span><%} %>
							</td>
						</tr>
						<tr>
							<td  class="text-primary" colspan="2">14.&nbsp; Revision:</td>
						</tr>
						<tr>
							<td  class="text-primary" colspan="2">15.&nbsp; Prepared by:
								<%if(DocumentSummary!=null && DocumentSummary[10]!=null) {%> <span class="text-dark"><%=DocumentSummary[10]%></span><%}else {%><span class="text-dark">-</span>  <%} %> <span class="text-dark"></span> 
							</td>
						</tr>
						<tr>
							<td  class="text-primary" colspan="2">16.&nbsp; Reviewed by: 
								<%if(DocumentSummary!=null && DocumentSummary[7]!=null) {%> <span class="text-dark"><%=DocumentSummary[7]%></span><%}else {%><span class="text-dark">-</span>  <%} %> 
							</td>
						</tr>
						<tr>
							<td  class="text-primary" colspan="2">17.&nbsp; Approved by: 
								<%if(DocumentSummary!=null && DocumentSummary[6]!=null) {%> <span class="text-dark"><%=DocumentSummary[6]%></span><%}else {%><span class="text-dark">-</span>  <%} %> 
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			
		</div>
		</div>


<!-- Modal for Document summary  -->
<%
 %>
  	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="SummaryModal">
  		<div class="modal-dialog modal-dialog-jump modal-lg ">
    		<div class="modal-content" style="width:137%;margin-left:-21%;">
         		<div class="modal-header" id="ModalHeader">
			        <h5 class="modal-title" id="exampleModalLabel">Document Summary</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
      			</div>
      
   				<div class="modal-body">
   					<form action="SpecificationSummaryAdd.htm" method="post">
   						<div class="row">
   							<div class="col-md-4">
   								<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Additional Information:</label>
   							</div>
				   			<div class="col-md-8">
				   				<textarea required="required" name="information" class="form-control" id="additionalReq" maxlength="4000"
								rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[0]!=null){%><%=DocumentSummary[0]%><%}else{%><%}%></textarea>
				   			</div>
   						</div>
			   			<div class="row mt-2">
				   			<div class="col-md-4">
				   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Abstract:</label>
				   			</div>
				   			<div class="col-md-8">
				   				<textarea required="required" name="abstract" class="form-control" id="" maxlength="4000"
								rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[1]!=null){%><%=DocumentSummary[1]%><%}else{%><%}%></textarea>
				   			</div>
			   			</div>
   			
   						<div class="row mt-2">
				   			<div class="col-md-4">
				   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Keywords:</label>
				   			</div>
				   			<div class="col-md-8">
				   				<textarea required="required" name="keywords" class="form-control" id="" maxlength="4000"
								rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[2]!=null){%><%=DocumentSummary[2]%><%}else{%><%}%></textarea>
				   			</div>
   						</div>
   			
   		    			<div class="row mt-2">
				   			<div class="col-md-4">
				   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Distribution:</label>
				   			</div>
				   			<div class="col-md-8">
				   				<input required="required" name="distribution" class="form-control" id="" maxlength="255"
								 placeholder="Maximum 255 Chararcters" required value="<%if(DocumentSummary!=null && DocumentSummary[3]!=null){%><%=DocumentSummary[3]%><%}else{%><%}%>">
				   			</div>
   						</div>
   						
   						<div class="row mt-2">
   							<div class="col-md-2">
			   	 				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Prepared By:</label>
			   				</div>
			   				<div class="col-md-4">
	   							<select class="form-control selectdee"name="preparedBy" id=""data-width="100%" data-live-search="true"  required>
	          						<option value="" selected disabled>--SELECT--</option>
	        						<%for(Object[]obj:TotalEmployeeList){ %>
	        							<option value="<%=obj[0].toString()%>" <%if(DocumentSummary!=null && DocumentSummary[9]!=null && DocumentSummary[9].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
	        								<%=obj[1].toString() %>,<%=(obj[2].toString()) %>
	        							</option>
	        						<%} %>
	        					</select>
   							</div>
   						</div>
   						
   						<div class="row mt-2">
			   				<div class="col-md-2">
			   	 				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Reviewer:</label>
			   				</div>	
   				
   				 			<div class="col-md-4">
	   							<select class="form-control selectdee"name="reviewer" id=""data-width="100%" data-live-search="true" required>
	       		 					<option value="" selected disabled="disabled">--SELECT--</option>
	       		 					<%for(Object[]obj:TotalEmployeeList){ %>
	        							<option value="<%=obj[0].toString()%>" <%if(DocumentSummary!=null && DocumentSummary[4]!=null &&  DocumentSummary[4].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
	        								<%=obj[1].toString() %>,<%=(obj[2].toString()) %>
	        							</option>
	        						<%} %>
	        					</select>
   				
   							</div>
   				
			   				<div class="col-md-1">
						   		<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f;float:right;">Approver:</label>
						   	</div>	
   							<div class="col-md-4">
		   						<select class="form-control selectdee"name="approver" id=""data-width="100%" data-live-search="true"  required>
		       						<option value="" selected disabled="disabled">--SELECT--</option>
	        						<%for(Object[]obj:TotalEmployeeList){ %>
	       	 							<option value="<%=obj[0].toString()%>" <%if(DocumentSummary!=null && DocumentSummary[5]!=null && DocumentSummary[5].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
	        								<%=obj[1].toString() %>,<%=(obj[2].toString()) %>
	        							</option>
	        						<%} %>
		        				</select>
   							</div>
   						</div>
   						
   						<div class="mt-2" align="center">
   							<%if(DocumentSummaryList!=null && DocumentSummaryList.size()>0) {%>
   								<button class="btn btn-sm edit" name="action" value="Edit" onclick="return confirm ('Are you sure to submit?')">UPDATE</button>
   								<input type="hidden" name="summaryId" value="<%=DocumentSummary[8]%>"> 
   							<%}else{ %>
   								<button class="btn btn-sm submit" name="action" value="Add" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
   							<%} %>
   							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
							<input type="hidden" name="projectId" value="<%=projectId%>">
							<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
							<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>"> 
							<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>"> 
   						</div>
   					</form>
  	 			</div>
    		</div>
  		</div>
	</div> 	


<!-- Distribution Modal  -->

<div class="modal fade" id="DistributionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  		<div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document">
    		<div class="modal-content">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color:white;">
			        <h5 class="modal-title" >Document Sent to</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
      				<%if(MemberList!=null && !MemberList.isEmpty()) {%>
      					<div class="row mb-2">
							<div class="col-md-12">
								<table class="table table-bordered" id="myTables">
									<thead>
										<tr>
											<th  style="text-align: center;">SN</th>
											<th  style="text-align: center;">Name</th>
											<th  style="text-align: center;">Designation</th>
										</tr>
									</thead>
									<tbody>
										<%int rowCount=0;
										for(Object[]obj:MemberList) {%>
											<tr>
												<td style="text-align: center;width:10%;"><%=++rowCount %></td>
												<td style="width:50%;margin-left: 10px;"><%=obj[1].toString() %></td>
												<td style="width:40%;margin-left: 10px;"><%=obj[2].toString() %></td>
											</tr>
										<%} %>
									</tbody>
								</table>
							</div>      
      					</div>
      				<%} %>
      				
       				<form action="MemberSubmit.htm" method="post">
      					<div class="row">
							<div class="col-md-10">
								<select class="form-control selectdee"name="Assignee" id="Assignee"data-width="100%" data-live-search="true" multiple required>
							        <%for(Object[]obj:EmployeeList){ %>
							        	<option value="<%=obj[0].toString()%>"> <%=obj[1].toString() %>,<%=(obj[2].toString()) %></option>
							        <%} %>
        						</select>
        					</div>
					      	<div class="col-md-2" align="center">
					      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
								<input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
							<input type="hidden" name="projectId" value="<%=projectId%>">
							<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
							<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>"> 
							<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>"> 	
								<input type="hidden" name="MemberType" value="T">		 
					    		<button type="submit" class="btn btn-sm submit" onclick="return confirm ('Are you sure to submit?')"> SUBMIT</button>
					      	</div>
      					</div>
      				</form>
      			</div>
    		</div>
  		</div>
	</div>
<Script>
$(document).ready(function() {
	$('#projectType').on('change', function() {
		var temp = $(this).children("option:selected").val();
		$('#submit').click();
	});
	});
$(document).ready(function() {
	$('#project').on('change', function() {
		var temp = $(this).children("option:selected").val();
		$('#submit1').click();
	});
	});
	
function showSentModal(){
	$('#DistributionModal').modal('show');
}
function showSummaryModal(){
	$('#SummaryModal').modal('show');
}
</Script>
</body>
</html>