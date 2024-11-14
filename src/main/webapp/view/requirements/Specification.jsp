<%@page import="java.util.stream.Collectors"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.File"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Path"%>
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

<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
<spring:url value="/resources/font/summernote.woff" var="Summernotewoff" />
<spring:url value="/resources/font/summernote.ttf" var="Summernotettf" />
<spring:url value="/resources/font/summernote.eot" var="Summernoteeot" />


<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />
<script src="${Summernotettf}"></script>
<script src="${Summernotettf}"></script>
<script src="${Summernoteeot}"></script>


<!-- Pdfmake  -->
<spring:url value="/resources/pdfmake/pdfmake.min.js" var="pdfmake" />
<script src="${pdfmake}"></script>
<spring:url value="/resources/pdfmake/vfs_fonts.js" var="pdfmakefont" />
<script src="${pdfmakefont}"></script>
<spring:url value="/resources/pdfmake/htmltopdf.js" var="htmltopdf" />
<script src="${htmltopdf}"></script>
<style>
.note-editing-area{

   height:320px;
} 


.note-frame{
margin-left:5%;
}
</style>
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

List<Object[]>AbbreviationDetails=(List<Object[]>)request.getAttribute("AbbreviationDetails");
String Conclusion = null;
String ConclusionContenId= null;
List<Object[]>SpecContentsDetails =(List<Object[]>)request.getAttribute("SpecContentsDetails");
if(SpecContentsDetails!=null && SpecContentsDetails.size()>0){
	for(Object[]obj:SpecContentsDetails){
		if(obj[1].toString().equalsIgnoreCase("Conclusion")){
			Conclusion=obj[2].toString();
			ConclusionContenId=obj[0].toString();
		}
	}
}

Object[] DocTempAtrr = (Object[])request.getAttribute("DocTempAttributes");
String projectShortName = (String)request.getAttribute("projectShortName");
String Classification = (String)request.getAttribute("Classification");
//String docnumber =(String)request.getAttribute("docnumber");
String version =(String)request.getAttribute("version");
String lablogo = (String)request.getAttribute("lablogo");

List<Object[]> SpecsIntro = (List<Object[]>)request.getAttribute("SpecsIntro");
List<Object[]> specsList = (List<Object[]>)request.getAttribute("specsList");
List<Object[]>RequirementList = (List<Object[]>)request.getAttribute("RequirementList");
List<Object[]>RequirementLists = new ArrayList<>();
if(RequirementList!=null && RequirementList.size()>0){
	RequirementLists=RequirementList.stream().filter(e->e[15]!=null && !e[15].toString().equalsIgnoreCase("0"))
			.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
			.collect(Collectors.toList());
			
}
String filePath=(String)request.getAttribute("filePath");
String labcode =(String ) session.getAttribute("labcode");
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
								<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
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
		        <span class="badge badge-light mt-2 sidebar pt-2 pb-2 btn-req" onclick="showProductTree()"><img alt="" src="view/images/tree.png" >&nbsp;&nbsp;Product Tree</span>
		       				<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showSpecification()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Specification</span>
		        <span class="badge badge-light mt-2 sidebar pt-2 pb-2 btn-req" onclick="showSentModal()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Document Distribution</span>
				<span class="badge badge-light mt-2 sidebar pt-2 pb-2 btn-req" onclick="showIntroudction()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Scope</span>
				<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showTestConclusionModal()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Conclusion</span>

			</div>
			
				     	<div class="mt-2" id="reqdiv">
				<div style="margin-left: 5%;overflow:auto">
					<table class="table table-bordered">
						<tr class="table-warning">
							<td align="center" colspan="2" class="text-primary">DOCUMENT SUMMARY</td>
						</tr>
						<tr>
							<td  class="text-primary" colspan="2">1.&nbsp; Title: <span class="text-dark">System Segment Specifications Document</span></td>
						</tr>
						<tr >
							<td class="text-primary">2.&nbsp; Type of Document:<span class="text-dark">System Segment Specifications Document</span></td>
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
												 <th  style="text-align: center;">Action</th> 
										</tr>
									</thead>
									<tbody>
										<%int rowCount=0;
										for(Object[]obj:MemberList) {%>
											<tr>
												<td style="text-align: center;width:10%;"><%=++rowCount %></td>
												<td style="width:50%;margin-left: 10px;"><%=obj[1].toString() %></td>
												<td style="width:40%;margin-left: 10px;"><%=obj[2].toString() %></td>
												  <td style="width:40%; margin-left: 10px;">
												    <form id="deleteForm_<%= obj[5] %>" action="#" method="POST" name="myfrm" style="display: inline">
												        <button type="submit" class="editable-clicko" formaction="DeleteSpecificationMembers.htm" onclick="return confirmDeletion('<%= obj[5] %>');">
												            <img src="view/images/delete.png" alt="Delete">
												        </button>
												        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
												        <input type="hidden" name="MemeberId" value="<%= obj[5] %>">
												        <input type="hidden" name="projectId" value="<%=projectId%>">
														<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
														<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>"> 
														<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">
														<input type="hidden" name="projectType" value="<%=projectType%>">
												    </form>
												</td>  
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
	<form action="SpecificaionDetails.htm" method="get">
	<button type="submit" style="display: none;" id="specId"></button>
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type="hidden" name="projectId"
			value="<%=projectId%>"> <input type="hidden"
			name="initiationId" value="<%=initiationId%>"> <input
			type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
		<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">

	</form>

	<!-- Conclusion Starts  -->		
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="Conclusion">
  		<div class="modal-dialog modal-dialog-jump modal-lg ">
    		<div class="modal-content" style="width:137%;margin-left:-21%;">
         		<div class="modal-header" id="ModalHeader">
			        <h5 class="modal-title" id="exampleModalLabel"> Conclusion</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
      			</div>
      			
   				<div class="modal-body">
   					<form action="SpecsContentSubmit.htm" method="post" id="Cform">
			   			<div class="col-md-2">
			   				<div class="row mt-2">
			   				</div>
			   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f"> Conclusion:</label>
			   			</div>
			   			  <div id="summernote" style="height: 500;">
					                <%if(Conclusion!=null) {%> <%=Conclusion %> <%} %>
					           </div>
			   			
   						<textarea name="Details" style="display: none;"  id="ConclusionDetails"></textarea>	
   		
   						<div class="mt-2" align="center">
   						<%if(ConclusionContenId!=null && Conclusion!=null) {%>
   						<button class="btn btn-sm btn-warning edit mt-2" name="Action" value="update" onclick="return confirm ('Are you sure to submit?')">UPDATE </button>
   						<input type="hidden" name="ContentId" value="<%=ConclusionContenId%>">
   						<%}else{ %>
   						  <button class="btn btn-sm btn-success submit mt-2" name="Action" value="Add" onclick="return confirm ('Are you sure to submit?')">SUBMIT </button>
   						
   					<%} %>
   							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
							<input type="hidden" name="projectId" value="<%=projectId%>">
							<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
							<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>"> 
							<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>"> 
							<input type="hidden" id="attributes" name="attributes" value="Conclusion">
						
						</div>
   					</form>
  	 			</div>
    		</div>
  		</div>
	</div>
	
		<!-- Modal  for Abbreviations-->
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="AbbreviationsModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content" style="width:135%;margin-left:-20%;">
				<div class="modal-header" id="ModalHeader" style="background: #055C9D;color:white;">
					<h5 class="modal-title" >Upload Abbreviations</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
				</div>
				<div class="modal-body">
					<form action ="AbbreviationExcelUploads.htm" method="post" id="excelForm" enctype="multipart/form-data">
				    	<div class="row">
							<div class="col-md-8">
								<input class="form-control" type="file" id="excel_file" name="filename" required="required"  accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">						
							</div>
							<div class="col-md-4">
								<span class="text-primary">Download format</span>
								<button class="btn btn-sm" type="submit" name="Action" value="GenerateExcel" formaction="ExcelUpload.htm" formmethod="post" formnovalidate="formnovalidate" ><i class="fa fa-file-excel-o" aria-hidden="true" style="color: green;"></i></button>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-md-12">
								<div style="overflow-y:auto" id="myDiv">
									<table class="table table-bordered table-hover table-striped table-condensed " id="myTable1" style="overflow: scroll;"> </table>
								</div>
							</div>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						<input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
						<input type="hidden" name="projectId" value="<%=projectId%>">
						<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
						<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
						<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">
						<input type="hidden" name="AbbType" value="T">					
						<div align="center" class="mt-2" id="uploadDiv" style="display:none;">
							<button type="submit" name="Action" value="UploadExcel" class="btn btn-sm btn-info"  onclick="return confirm('Are you sure to submit?')">Upload</button>
						</div>
					</form>
					
					<div  id="scrollclass" class="ExistingAbb" >
					<table class="table table-bordered table-hover table-striped table-condensed" id="myTable2" style="width:100%;">
							<thead>
					            <tr>
					                <td>SN</td>
					                <td>Abbreviations</td>
					                <td>Meaning</td>
					            </tr>
							</thead>
							<%  int counter = 1; 
								if (AbbreviationDetails != null) {
									for (Object[] AbbDetails : AbbreviationDetails) {%>
										<tr>
								            <td><%= counter %></td>
								            <td><%= AbbDetails[1] %></td>
								            <td><%= AbbDetails[2] %></td>
								        </tr>
							<% counter++;}} %>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>	
	<!-- Product tree Modal  -->
	<%
	List<Object[]>SpecProducTree=(List<Object[]>)request.getAttribute("SpecProducTree") ;
	%>
<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="productModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content" style="width:135%;margin-left:-20%;">
				<div class="modal-header" id="ModalHeader" style="background: #055C9D;color:white;">
					<h5 class="modal-title" >Upload ProductTree</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
				</div>
				<div class="modal-body">
					<form action ="SpecProductTreeUpload.htm" method="post" id="excelForm" enctype="multipart/form-data">
				    <div class="row">
				    <div class="col-md-3"><label style="font-size: 17px; color: #07689f;font-weight:bold">Comment 
					</label></div>
				    <div class="col-md-8">
				    <textarea name="description" class="form-control" id="descriptionadd" maxlength="4000" rows="5" cols="53" placeholder="Maximum 4000 Chararcters"><%if(SpecProducTree!=null && SpecProducTree.size()>0) {%> <%=SpecProducTree.get(0)[2].toString() %> <%} else{%> Guidance: 
The product Tree shall comprises the complete physical products / subsystems of the radar in the order of flow as a figure with unique ID 
				     <%} %> </textarea>
				    </div>
				    </div>
				    <div class="row mt-2">
				    <div class="col-md-3"><label style="font-size: 17px; color: #07689f;font-weight:bold">
				    Attachment<span class="mandatory" style="color: red;">*</span>
				    </label>
				    </div>
					<div class="col-md-8">
 					<input class="form-control" type="file" id="imageUpload" name="image" accept="image/*" required="required">					
					</div>
					<%if(SpecProducTree!=null && SpecProducTree.size()>0 && !projectId.equalsIgnoreCase("0")) {%>
					<div class="col-md-1">
					<a class="btn" target="blank" data-toggle="tooltip" data-placement="top" data-original-data="Tooltip on Top" title="Product Tree"    href="ProductTree.htm?ProjectId=<%=projectId%>"><img alt="" src="view/images/tree.png" ></a>
					</div>
					<%} %>
					</div>
					<div  class="mt-2" align="center">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						<%if(SpecProducTree!=null && SpecProducTree.size()>0) {%>
						<button type="submit" class="btn btn-sm edit" onclick="return confirm('Are you sure to submit?')">UPDATE</button>
						<%}else{ %>
						<button type="submit" class="btn btn-sm submit" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
						<%} %>
						<input type="hidden" name="projectId" value="<%=projectId%>">
						 <input type="hidden" name="projectType" value="<%=projectType%>">
						<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
						<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
						<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">
					</div>
					</form>
					</div>
				
				
				</div>
				</div>
				</div>
	
	<!-- IntroductionPage -->
	  	<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="projectId" value="<%=projectId%>">
			<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
			<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
						<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">
			<button class="btn bg-transparent" id="Introbtn" formaction="SpecificationScope.htm" formmethod="get" formnovalidate="formnovalidate"  style="display:none;">
				<i class="fa fa-download text-success" aria-hidden="true"></i>
			</button>
		</form>
		<!-- Introduction form end  -->	
		
		<!-- DocDownload -->
	  	<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="projectId" value="<%=projectId%>">
			<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
			<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
						<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">
			<button class="btn bg-transparent" id="docbtn" formaction="SpecificationDocumentDownlod.htm" formmethod="get" formnovalidate="formnovalidate" formtarget="_blank"  style="display:none;">
				<i class="fa fa-download text-success" aria-hidden="true"></i>
			</button>
		</form>
		<!--  -->	
		
			<!-- PDFDownload -->
	  	<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="projectId" value="<%=projectId%>">
			<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
			<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
						<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">
			<button class="btn bg-transparent" id="pdfbtn" formaction="SpecificationdPdf.htm" formmethod="get" formnovalidate="formnovalidate" formtarget="_blank"  style="display:none;">
				<i class="fa fa-download text-success" aria-hidden="true"></i>
			</button>
		</form>
		<!--  -->	
			 <script type="text/javascript">
    function confirmDeletion(memberId) {
        if (confirm('Are you sure you want to delete this member?')) {
            var form = $('#deleteForm_' + memberId);
            form.submit();
            return true;
        } else {
            return false;
        }
    }

   // $(document).ready(function() {
   

   $('#summernote').summernote({
       
	   width: 900,
	     toolbar: [
	         // Adding font-size, font-family, and font-color options along with other features
	         ['style', ['bold', 'italic', 'underline', 'clear']],
	         ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
	         ['insert', ['picture', 'table']],  // 'picture' for image upload, 'table' for table insertion
	         ['para', ['ul', 'ol', 'paragraph']],
	         ['height', ['height']]
	     ],
	     fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],  // Font size options
	     fontNames: ['Arial', 'Courier New', 'Helvetica', 'Times New Roman', 'Verdana'],  // Font family options
	     buttons: {
	         // Custom superscript and subscript buttons
	         superscript: function() {
	             return $.summernote.ui.button({
	                 contents: '<sup>S</sup>',
	                 tooltip: 'Superscript',
	                 click: function() {
	                     document.execCommand('superscript');
	                 }
	             }).render();
	         },
	         subscript: function() {
	             return $.summernote.ui.button({
	                 contents: '<sub>S</sub>',
	                 tooltip: 'Subscript',
	                 click: function() {
	                     document.execCommand('subscript');
	                 }
	             }).render();
	         }
	     },

	   	height:300
      });
      
   //});
    </script> 
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

function showTestConclusionModal() {
    $('#Conclusion').modal('show');
}

$('#Cform').submit(function() {
    
	  var codeee=$('#summernote').summernote('code');
	  $('textarea[name=Details]').val($('#summernote').summernote('code'));
});


function showSpecification(){
	$('#specId').click();
}

function showAbbreviations() {
    $('#AbbreviationsModal').modal('show');
}
function showProductTree() {
    $('#productModal').modal('show');
}



const excel_file = document.getElementById('excel_file');


excel_file.addEventListener('change', (event) => {
   
	$('.ExistingAbb').hide();	
	var reader = new FileReader();
    reader.readAsArrayBuffer(event.target.files[0]);

    reader.onload = function (event){
    
    	var data = new Uint8Array(reader.result);
    	
    	var work_book = XLSX.read(data, {type:'array'});
    	
    	 var sheet_name = work_book.SheetNames;
    	
    	var sheet_data = XLSX.utils.sheet_to_json(work_book.Sheets[sheet_name[0]],{header:1});
    	
    	const code = [];
    	const gname = [];
    	const abbreviationname1 = [];
    	var checkExcel = 0;
    	
    	if(sheet_data.length > 0){
    		var table_output = '<table class="table table-bordered table-hover table-striped table-condensed " id="myTable1" style="overflow: scroll;" > '
    		
    		table_output +='<thead><tr><th style=" text-align: center;width:10%;">SN</th><th style="text-align:center;width:30%;">Abbreviations</th><th style="text-align:center;">Meaning</th></tr>'
    		
	    		for(var row = 0; row < sheet_data.length ; row ++){
    			table_output += '<tbody><tr>'
    			
    			if(row>0){
    				table_output += '<td>'+row+'</td>';}
    				for(var cell = 0; cell <3;cell++)
    				{
    					
    					if(row==0){
    						if(cell==1 && "Abbreviation" != sheet_data[row][cell]){  checkExcel++;}
            				if(cell==2 && "Meaning" != sheet_data[row][cell]){  checkExcel++;}
            				console.log(sheet_data[row][cell]+cell)
            				
            			}	
    				
    				if(row>0 && cell == 2){
    			
    					table_output+='<td>'+sheet_data[row][cell]+'</td>';
    					var abbreviationnames = ""+sheet_data[row][cell]+"";
    					
    					if(abbreviationnames.trim().length>250){
    						gname.push(row);
    					}
    					if(abbreviationnames.trim()=='' || abbreviationnames.trim()=='undefined'){abbreviationname1.push(row);}	
    					
    				}
    				if(row>0 && cell == 1){
    					table_output += '<td>'+sheet_data[row][cell]+'</td>' 
    					var x = ""+sheet_data[row][cell]+"";
    					
    					if(x=='' ){
    						code.push(row)
    					}
    				}
    				
    				}
    		
    			
    		}  
    		 table_output += '</tr> <tbody></table>';
    		 
    		 
    		 
    		if(checkExcel>0){
    			$('#uploadDiv').hide();
    			console.log(AbbreviationDetailsList+"---")
    			alert("Please Upload  Abbreviation Excel ");
     			excel_file.value = '';
     			document.getElementById('myTable1').innerHTML = "";
    		}
    		else{
    			
		 var AbbreviationDetailsList=[<%int i=0; for (Object [] obj:AbbreviationDetails ) {%> "<%= obj[1] %>"<%= i+1 < AbbreviationDetails.size() ? ",":""%><%}%>];	
		
		var AbbreDetails = [];
		
		for(var i in sheet_data){
			AbbreDetails.push(sheet_data[i][1]+"");
		}
		const duplicates = AbbreDetails.filter((item,index) => index !== AbbreDetails.indexOf(item));
		const indexval = []             
        for(var i in duplicates){
         indexval.push(AbbreDetails.indexOf(duplicates[i]))
         }
		 var dbDuplicate = [];
		 AbbreviationDetailsList.forEach(function (item){ 
			 var isPresent = AbbreDetails.indexOf(item);
        	  if(isPresent !== -1){
        		  dbDuplicate.push(isPresent); 
        	  }
		 });
			var msg=""
			 if(indexval.length>0){
	       	 msg+="Duplicate Abbreviation Existed in Excel file at Serial No :"+ indexval+"\n";
	 		$('#uploadDiv').hide();
			console.log(AbbreviationDetailsList+"---")
			alert(msg);
 			excel_file.value = '';
 			document.getElementById('myTable1').innerHTML = "";
			 }
			 else if(dbDuplicate.length>0){
		       	 msg+=" Abbreviation already Existed in Excel file at Serial No :"+ dbDuplicate+"\n";
	    	 		$('#uploadDiv').hide();
	    			console.log(AbbreviationDetailsList+"---")
	    			alert(msg);
	     			excel_file.value = '';
	     			document.getElementById('myTable1').innerHTML = "";  
			 }
			 
			 else{
				 if(sheet_data.length>20){
		    		 var myDiv = document.getElementById("myDiv");
		    		  myDiv.style.height = "400px";
		    } 
			$('#uploadDiv').show();		    			
    		document.getElementById('myTable1').innerHTML = table_output;
	         }
    		}
    	}
    
    }});
    
    
$(document).ready(function(){
	 $("#myTable1").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
});
});

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
});

function showIntroudction(){
	$('#Introbtn').click();
}
function DownloadDoc(){
	$('#docbtn').click();
}


function DownloadDocPDF(){
	var chapterCount = 0;
    var mainContentCount = 0;
	var leftSideNote = '<%if(DocTempAtrr!=null && DocTempAtrr[12]!=null) {%><%=DocTempAtrr[12].toString() %> <%} else{%>-<%}%>';
	
	var docDefinition = {
            content: [
                // Cover Page with Project Name and Logo
                {
                    text: htmlToPdfmake('<h4 class="heading-color ">SYSTEM SPECIFICATIONS <br><br> FOR  <br><br>PROJECT <%=projectShortName %> </h4>'),
                    style: 'DocumentName',
                    alignment: 'center',
                    fontSize: 18,
                    margin: [0, 200, 0, 20]
                },
                <% if (lablogo != null) { %>
                {
                    image: 'data:image/png;base64,<%= lablogo %>',
                    width: 95,
                    height: 95,
                    alignment: 'center',
                    margin: [0, 20, 0, 30]
                },
                <% } %>
                
                {
                    text: htmlToPdfmake('<h5><% if (LabList != null && LabList[1] != null) { %> <%= LabList[1].toString() + "(" + LabList[0].toString() + ")" %> <% } else { %> '-' <% } %></h5>'),
                    alignment: 'center',
                    fontSize: 16,
                    bold: true,
                    margin: [0, 20, 0, 20]
                },
                {
                    text: htmlToPdfmake('<h6>Government of India, Ministry of Defence<br>Defence Research & Development Organization </h6>'),
                    alignment: 'center',
                    fontSize: 14,
                    bold: true,
                    margin: [0, 10, 0, 10]
                },
                {
                    text: htmlToPdfmake('<h6><%if(LabList!=null && LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %><%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %><%}else{ %>-<%} %></h6>'),
                    alignment: 'center',
                    fontSize: 14,
                    bold: true,
                    margin: [0, 10, 0, 10]
                },
                // Table of Contents
                {
                    toc: {
                        title: { text: 'INDEX', style: 'header', pageBreak: 'before' }
                    }
                },
                
                /* ************************************** Distribution List *********************************** */ 
                {
                    text: 'Distribution List',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before',
                    alignment: 'center'
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['15%', '35%', '25%', '25%'],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader' },
                                { text: 'Name', style: 'tableHeader' },
                                { text: 'Designation', style: 'tableHeader' },
                                { text: 'Division/Lab', style: 'tableHeader' }
                            ],
                            // Populate table rows
                            <% if (MemberList != null && MemberList.size()>0) { %>
	                            <% int slno = 0; for (Object[] obj : MemberList) { %>
	                            [
	                                { text: '<%= ++slno %>', style: 'tableData',alignment: 'center' },
	                                { text: '<%= obj[1] %>', style: 'tableData' },
	                                { text: '<%= obj[2] %>', style: 'tableData' },
	                                { text: '<%= obj[3] %>', style: 'tableData',alignment: 'center' }
	                            ],
	                            <% } %>
                            <% } else{%>
                            	[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 4 },]
                            <%} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                /* ************************************** Distribution List End*********************************** */

                /* ************************************** Document Summary *********************************** */
                {
                    text: 'Document Summary',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['10%', '30%', '60%'],
                        body: [
                            <% int docsn = 0; %>
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Title', style: 'tableData' },
                                { text: 'System Segment Specification Document For Project <%=projectShortName %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Type of Document', style: 'tableData' },
                                { text: 'System Segment Specification Document', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Classification', style: 'tableData' },
                                { text: '<%=Classification %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Document Number', style: 'tableData' },
                                { text: '', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Month Year', style: 'tableData' },
                                { text: '<%=months.toString().substring(0,3) %> <%= years %>', style: 'tableData' },
                            ],
                            
                            /* [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Number of Pages', style: 'tableData' },
                                { text: '', style: 'tableData' },
                            ], */
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Related Document', style: 'tableData' },
                                { text: '', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Additional Information', style: 'tableData' },
                                { text: '<% if(DocumentSummary!=null){%><%=DocumentSummary[0] %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Project Name', style: 'tableData' },
                                { text: '<%=projectShortName %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Abstract', style: 'tableData' },
                                { text: '<% if(DocumentSummary!=null){%><%=DocumentSummary[1] %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Keywords', style: 'tableData' },
                                { text: '<% if(DocumentSummary!=null){%><%=DocumentSummary[2] %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Organization and address', style: 'tableData' },
                                { text: '<% if (LabList!=null && LabList[1] != null) {%> <%=LabList[1].toString() + "(" + LabList[0].toString() + ")"%> <%} else {%> - <%}%>'
										+'Government of India, Ministry of Defence,Defence Research & Development Organization'
								+'<% if (LabList!=null && LabList[2] != null && LabList[3] != null && LabList[5] != null) { %>'
									+'<%=LabList[2] + " , " + LabList[3].toString() + ", PIN-" + LabList[5].toString()+"."%>'
								+'<%}else{ %> - <%} %>' , style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Distribution', style: 'tableData' },
                                { text: '<% if(DocumentSummary!=null){%><%=DocumentSummary[3] %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Revision', style: 'tableData' },
                                { text: '<%=version!=null ?version:"-" %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Prepared by', style: 'tableData' },
                                { text: '<% if(DocumentSummary!=null){%><%=DocumentSummary[10] %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Reviewed by', style: 'tableData' },
                                { text: '<% if(DocumentSummary!=null){%><%=DocumentSummary[7] %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Approved by', style: 'tableData' },
                                { text: '<% if(DocumentSummary!=null){%><%=DocumentSummary[6] %><%} %>', style: 'tableData' },
                            ],

                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
			
                /* ************************************** Document Summary End *********************************** */

                /* ************************************** Abbreviation *********************************** */
                {
                    text: 'Abbreviation',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before',
                    alignment: 'center'
                },
                {
                	text: 'Abbreviations used in the Manual to be listed and arranged in alphabetical order',	
                	style: 'chapterNote',
                    alignment: 'center'
                },
		
                {
                    table: {
                        headerRows: 1,
                        widths: ['20%', '30%', '50%'],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader' },
                                { text: 'Abbreviations', style: 'tableHeader' },
                                { text: 'Full Forms', style: 'tableHeader' },
                            ],
                            // Populate table rows
                            <% if (AbbreviationDetails != null && AbbreviationDetails.size()>0) { %>
		                        <% int slno = 0; for (Object[] obj : AbbreviationDetails) { %>
		                            [
		                                { text: '<%= ++slno %>', style: 'tableData',alignment: 'center' },
		                                { text: '<%= obj[1] %>', style: 'tableData',alignment: 'center' },
		                                { text: '<%= obj[2] %>', style: 'tableData' },
		                            ],
		                        <% } %>
                            <% } else{%>
                            	[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 3 },]
                            <%} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                /* ************************************** Abbreviation End *********************************** */
                
                /* ************************************** Scope *********************************** */
                {
                    text: (++mainContentCount)+'. Scope',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },

                <%if(SpecsIntro!=null && SpecsIntro.size()>0) {%>
	                <%int introCount=0;
	                for(Object[] obj: SpecsIntro) {%>
		                {
		                	text: mainContentCount+'.<%=++introCount %>. <%=obj[1].toString() %>',	
		                	style: 'chapterSubHeader',
		                    tocItem: true,
		                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.<%=introCount %>',
		                    tocMargin: [10, 0, 0, 0],
		                },
	                
		                {
		                	stack: [htmlToPdfmake(setImagesWidth('<%if(obj[2]!=null) {%><%=obj[2].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>'
		                		  +'<%}else {%> No Details Added! <%} %>', 500))],
		                    margin: [10, 0, 0, 0],
		                },
	                			
	            <%} }%>
                /* ************************************** Scope End *********************************** */
                
	            /* ************************************** Applicable Document *********************************** */
                {
                    text: (++mainContentCount)+'. Applicable Document',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                {
                	text: 'No Documents Applicable!',
                	style: 'chapterContent',
                },
                /* ************************************** Applicable Document End *********************************** */
                
	            /* ************************************** Product Tree *********************************** */
                {
                	text: (++mainContentCount)+'. Product Tree',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    margin: [0, 20, 0, 0],
                    /* pageBreak: 'before' */
                },
                {
                	<%if(SpecProducTree!=null && SpecProducTree.size()>0){ %>
                		stack: [htmlToPdfmake(setImagesWidth('<%=SpecProducTree.get(0)[2].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>', 500))],
                	<%} else{%>
                		text: 'Guidance: The product Tree shall comprises the complete physical products / subsystems of the radar in the order of flow as a figure with unique ID',
                		style: 'chapterContent',
                	<%} %>
                	margin: [0, 5, 0, 10],
                },
                
            	<%if(SpecProducTree!=null && SpecProducTree.size()>0) {
           			Path imagepath = Paths.get(filePath, labcode, "SpecificationProducTree", SpecProducTree.get(0)[3].toString());
           			File imagepathFile = imagepath.toFile();
           			if(imagepathFile.exists()){
           		%>
           			{
                    	image: 'data:image/png;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(imagepathFile))%>',
                    	width: 500,
                       	height: 500,
                       	alignment: 'center',
                       	margin: [0, 10, 0, 10]
                   	},
           													
           		<%} }%>
                
                /* ************************************** Product Tree End *********************************** */

	            /* ************************************** Specifications *********************************** */
                {
                    text: (++mainContentCount)+'. Specifications',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                <%if(specsList!=null && specsList.size()>0){ 
            		int specCount=0;
            		List<Object[]>specsListMain=specsList.stream().filter(e->e[7].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
            		for(Object[]obj:specsListMain){ %>
            		
	            		{
		                	text: mainContentCount+'.<%=++specCount %> <%=obj[1].toString() %>',	
		                	style: 'chapterSubHeader',
		                    tocItem: true,
		                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.<%=specCount %>',
		                    tocMargin: [10, 0, 0, 0],
		                },
            		
            			<% List<Object[]>specsListSub = new ArrayList<>();
            			specsListSub=specsList.stream().filter(e->e[7].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());
            			if(specsListSub!=null && specsListSub.size()>0) {
            				for(Object[]obj1:specsListSub){
	            				int snCount=0; %>
            					{
		            				table : {
		            					headerRows : 1,
		            					widths: ['20%', '30%', '50%'],
		    	                        body: [
		    	                            // Table header
		    	                            [
		    	                                { text: 'SN', style: 'tableHeader' },
		    	                                { text: 'Attribute', style: 'tableHeader' },
		    	                                { text: 'Content', style: 'tableHeader' },
		    	                            ],
		    	                         	// Populate table rows
		    	                            [
		    	                                { text: '<%=++snCount %>', style: 'tableData', alignment: 'center' },
		    	                                { text: 'Specification Id', style: 'tableData' },
		    	                                { text: '<%=obj1[1]!=null?obj1[1]:"-" %>', style: 'tableData' },
		    	                            ],
		    	                            
		    	                            [
		    	                                { text: '<%=++snCount %>', style: 'tableData', alignment: 'center' },
		    	                                { text: 'Linked Requirements', style: 'tableData' },
		    	                                { text: '<% List<String>linkedReq= new ArrayList<>(); List<String>tempReq = new ArrayList<>();%>'
				            						   +'<%if(obj1[4]!=null){ tempReq= Arrays.asList(obj1[4].toString().split(",")); }%>'
            										   +'<%if(RequirementLists!=null && RequirementLists.size()>0){ %>'
					            						+'<%for(Object[]obj2:RequirementLists){ if(tempReq.contains(obj2[0].toString())){ linkedReq.add(obj2[1].toString()); } }} %>'	
            											+'<%if(linkedReq.size()>0) {%> <%=linkedReq.toString().replace("[", "").replace("]", "") %> <%}else{ %> - <%} %>', style: 'tableData' },
		    	                            ],
		    	                            
		    	                            [
		    	                                { stack: [htmlToPdfmake(setImagesWidth('<%=++snCount %>.Description: <%if(obj1[2]!=null){ %> <%=obj1[2].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%}else{ %>-<%} %>', 500))], colSpan: 3 }
		    	                            ],
		    	                            
		    	                            [
		    	                                { text: '<%=++snCount %>', style: 'tableData', alignment: 'center' },
		    	                                { text: 'Specification Parameter', style: 'tableData' },
		    	                                { text: '<%=obj1[5]!=null?obj1[5]:"-" %>', style: 'tableData' },
		    	                            ],
		    	                            
		    	                            [
		    	                                { text: '<%=++snCount %>', style: 'tableData', alignment: 'center' },
		    	                                { text: 'Specification Unit', style: 'tableData' },
		    	                                { text: '<%=obj1[6]!=null?obj1[6]:"-" %>', style: 'tableData' },
		    	                            ],
		    	                            
		    	                            [
		    	                                { text: '<%=++snCount %>', style: 'tableData', alignment: 'center' },
		    	                                { text: 'Specification Value', style: 'tableData' },
		    	                                { text: '<%=obj1[9]!=null?obj1[9]:"-" %>', style: 'tableData' },
		    	                            ],
		    	                            
		    	                        ],
		    	                    },
		    	                    layout: {
	
		    	                        hLineWidth: function(i, node) {
		    	                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
		    	                        },
		    	                        vLineWidth: function(i) {
		    	                            return 0.5;
		    	                        },
		    	                        hLineColor: function(i) {
		    	                            return '#aaaaaa';
		    	                        },
		    	                        vLineColor: function(i) {
		    	                            return '#aaaaaa';
		    	                        }
		    	                    }
            					},
            					{ text: '\n',},
            	<%}}}} %>	
                /* ************************************** Specifications End *********************************** */
                
           		/* ************************************** Forward Traceability *********************************** */
                {
                    text: (++mainContentCount)+'. Forward Traceability',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['10%', '30%', '60%'],
                        body: [
                        	[
                        		{text: 'SN', style:'tableHeader'},
                        		{text: 'System SpecificationId', style:'tableHeader'},
                        		{text: 'System RequirementId', style:'tableHeader'},
                        	],
                            // Populate table rows
                        	<%if(specsList!=null && specsList.size()>0){
    							specsList=specsList.stream().filter(e->!e[7].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
    						}
    						if(specsList!=null && specsList.size()>0){
    							int slno=0;
    							for(Object[] obj:specsList) {%>
    							
    							[
	        						{text: '<%=++slno %>', style:'tableData', alignment: 'center'},
	        						{text: '<%=obj[1] %>', style:'tableData',},
	        						{text: '<% List<String>linkedReq= new ArrayList<>(); List<String>tempReq = new ArrayList<>(); %>'	
			    						  +'<%if(obj[4]!=null){ tempReq= Arrays.asList(obj[4].toString().split(",")); } %>'
			    						  +'<%if(RequirementLists!=null && RequirementLists.size()>0){ for(Object[]obj1:RequirementLists){ if(tempReq.contains(obj1[0].toString())){ linkedReq.add(obj1[1].toString()); } }} %>'	
    									  +'<%if(linkedReq.size()>0) { for(int reqi=0;reqi<linkedReq.size();reqi++){ %> <%=(reqi+1)%>. <%=linkedReq.get(reqi) %>\n<%}}else{ %> - <%} %>', style:'tableData', alignment: 'center'},
	        					],
	        					
    						<%}} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                /* ************************************** Forward Traceability End *********************************** */
                
           		/* ************************************** Backward Traceability *********************************** */
                {
                    text: (++mainContentCount)+'. Backward Traceability',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['10%', '30%', '60%'],
                        body: [
                        	[
                        		{text: 'SN', style:'tableHeader'},
                        		{text: 'System RequirementId', style:'tableHeader'},
                        		{text: 'System SpecificationId', style:'tableHeader'},
                        	],
                            // Populate table rows
                        	<%if(RequirementLists!=null && RequirementLists.size()>0){
								int slno=0;
								for(Object[]obj:RequirementLists) {
									List<String>specid = new ArrayList<>();
						
									for(Object[]obj1:specsList) {
										String spec=obj1[4]!=null?obj1[4].toString():""; 
										if(Arrays.asList(spec.split(",")).contains(obj[0].toString())){
											specid.add(obj1[1].toString());
										} } %>
    							
	    							[
		        						{text: '<%=++slno %>', style:'tableData', alignment: 'center'},
		        						{text: '<%=obj[1] %>', style:'tableData',},
		        						{text: '<%if(specid.size()>0) { for(String s:specid){ %> <%=s %> \n <%}}else{ %> - <%} %>', style:'tableData', alignment: 'center'},
		        					],
	        					
    						<%}} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                /* ************************************** Backward Traceability End *********************************** */

	            /* ************************************** Conclusion *********************************** */
                {
                    text: (++mainContentCount)+'. Conclusion',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                {
                	<%if(Conclusion!=null){ %>
                		stack: [htmlToPdfmake(setImagesWidth('<%=Conclusion.replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>', 500))],
                	<%} else{%>
                		text: 'No Details Added!',
                	<%} %>
                	style: 'chapterContent',
                },
                /* ************************************** Conclusion End *********************************** */
			],
            styles: {
                DocumentName: { fontSize: 18, bold: true, margin: [0, 0, 0, 10] },
                chapterHeader: { fontSize: 16, bold: true, margin: [0, 0, 0, 10] },
                chapterNote: { fontSize: 13, bold: true, margin: [0, 10, 0, 10]},
                chapterSubHeader: { fontSize: 13, bold: true, margin: [10, 10, 0, 10]},
                tableHeader: { fontSize: 12, bold: true, fillColor: '#f0f0f0', alignment: 'center', margin: [10, 5, 10, 5], fontWeight: 'bold' },
                tableData: { fontSize: 11.5, margin: [0, 5, 0, 5] },
                chapterSubSubHeader: { fontSize: 12, bold: true, margin: [15, 10, 10, 10] },
                subChapterNote: { margin: [15, 15, 0, 10] },
                header: { alignment: 'center', bold: true},
                chapterContent: {fontSize: 11.5, margin: [0, 5, 0, 5] },
            },
            footer: function(currentPage, pageCount) {
                if (currentPage > 2) {
                    return {
                        stack: [
                        	{
                                canvas: [{ type: 'line', x1: 30, y1: 0, x2: 565, y2: 0, lineWidth: 1 }]
                            },
                            {
                                columns: [
                                    { text: '', alignment: 'left', margin: [30, 0, 0, 0], fontSize: 8 },
                                    { text: currentPage.toString() + ' of ' + pageCount, alignment: 'right', margin: [0, 0, 30, 0], fontSize: 8 }
                                ]
                            },
                            { text: 'Restricted', alignment: 'center', fontSize: 8, margin: [0, 5, 0, 0], bold: true }
                        ]
                    };
                }
                return '';
            },
            header: function(currentPage) {
                return [
                    { text: 'Restricted', alignment: 'center', margin: [0, 10, 0, 0], fontSize: 8, bold: true },
                ];
            },
            pageMargins: [40, 40, 20, 40],
            
            background: function(currentPage) {
                return [
                    {
                        image: generateRotatedTextImage(leftSideNote),
                        width: 100, // Adjust as necessary for your content
                        absolutePosition: { x: -20, y: 50 }, // Position as needed
                    }
                ];
            },
           
            defaultStyle: { fontSize: 12, color: 'black', }
        };
		
        pdfMake.createPdf(docDefinition).open();
}

const setImagesWidth = (htmlString, width) => {
    const container = document.createElement('div');
    container.innerHTML = htmlString;
  
    const images = container.querySelectorAll('img');
    images.forEach(img => {
      img.style.width = width + 'px';
      img.style.textAlign = 'center';
    });
  
    const textElements = container.querySelectorAll('p, h1, h2, h3, h4, h5, h6, span, div, td, th, table, figure, hr, ul, li');
    textElements.forEach(element => {
      if (element.style) {
        element.style.fontFamily = '';
        element.style.margin = '';
        element.style.marginTop = '';
        element.style.marginRight = '';
        element.style.marginBottom = '';
        element.style.marginLeft = '';
        element.style.lineHeight = '';
        element.style.height = '';
        element.style.width = '';
        element.style.padding = '';
        element.style.paddingTop = '';
        element.style.paddingRight = '';
        element.style.paddingBottom = '';
        element.style.paddingLeft = '';
        element.style.fontSize = '';
        element.id = '';
      }
    });
  
    const tables = container.querySelectorAll('table');
    tables.forEach(table => {
      if (table.style) {
        table.style.borderCollapse = 'collapse';
        table.style.width = '100%';
      }
  
      const cells = table.querySelectorAll('th, td');
      cells.forEach(cell => {
        if (cell.style) {
          cell.style.border = '1px solid black';
  
          if (cell.tagName.toLowerCase() === 'th') {
            cell.style.textAlign = 'center';
          }
        }
      });
    });
  
    return container.innerHTML;
}; 
	
 
 
 
function splitTextIntoLines(text, maxLength) {
	const lines = [];
  	let currentLine = '';

	for (const word of text.split(' ')) {
		if ((currentLine + word).length > maxLength) {
	    	lines.push(currentLine.trim());
	    	currentLine = word + ' ';
		} else {
		  currentLine += word + ' ';
		}
	}
  	lines.push(currentLine.trim());
  	return lines;
}

// Generate rotated text image with line-wrapped text
function generateRotatedTextImage(text) {
	const maxLength = 260;
	const lines = splitTextIntoLines(text, maxLength);
	
	const canvas = document.createElement('canvas');
	const ctx = canvas.getContext('2d');
	
	// Set canvas dimensions based on anticipated text size and rotation
	canvas.width = 200;
	canvas.height = 1560;
	
	// Set text styling
	ctx.font = '14px Roboto';
	ctx.fillStyle = 'rgba(128, 128, 128, 1)'; // Gray color for watermark
	
	// Position and rotate canvas
	ctx.translate(80, 1480); // Adjust position as needed
	ctx.rotate(-Math.PI / 2); // Rotate 270 degrees
	
	// Draw each line with a fixed vertical gap
	const lineHeight = 20; // Adjust line height if needed
	lines.forEach((line, index) => {
	  ctx.fillText(line, 0, index * lineHeight); // Position each line below the previous
	});
	
	return canvas.toDataURL();
}
</Script>
</body>
</html>