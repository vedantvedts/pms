<%-- <%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PMS</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/Overall.css" var="StyleCSS" />
<link href="${StyleCSS}" rel="stylesheet" />
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>
	<%
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	List<Object[]> ProjectIntiationList = (List<Object[]>) request.getAttribute("ProjectIntiationList");
	String projectshortName = (String) request.getAttribute("projectshortName");
	String initiationid = (String) request.getAttribute("initiationid");
	DecimalFormat df = new DecimalFormat("0.00");
	String project = (String)request.getAttribute("project");
	NFormatConvertion nfc = new NFormatConvertion();
	List<Object[]> RequirementList = (List<Object[]>) request.getAttribute("RequirementList");
	Object[] ProjectDetailes = (Object[]) request.getAttribute("ProjectDetailes");
	Object[]RequirementStatus=(Object[])request.getAttribute("RequirementStatus");
	List<String>Status=Arrays.asList("RIN","RID","RIP","RIA","RIT");
	List<Object[]>DocumentApprovalFlowData=(List<Object[]>)request.getAttribute("DocumentApprovalFlowData");
	List<Object[]> statuslist = (List<Object[]>)request.getAttribute("TrackingList");
	String pdf=(String)request.getAttribute("pdf");
	List<Object[]>EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");
	List<Object[]>TotalEmployeeList=(List<Object[]>)request.getAttribute("TotalEmployeeList");
	String projectName="";
	String classification="";
	List<Object[]>AbbreviationDetails=(List<Object[]>)request.getAttribute("AbbreviationDetails");
	LocalDate d = LocalDate.now();
	List<Object[]>MemberList = (List<Object[]>)request.getAttribute("MemberList");
	Month months= d.getMonth();
	int years=d.getYear();
	Object[]LabList=(Object[])request.getAttribute("LabList");
	List<Object[]>DocumentSummaryList=(List<Object[]>)request.getAttribute("DocumentSummary");
	Object[]DocumentSummary=null;
	
	if(DocumentSummaryList.size()>0){
		DocumentSummary=DocumentSummaryList.get(0);
	}
	
	%>
<style type="text/css">
  <%if(statuslist!=null&&!statuslist.isEmpty()){%>
    section#timeline:before {
    content: '';
    display: block;
    position: absolute;
    left: 50%;
    top: 0;
    margin: 0 0 0 -1px;
    width: 2px;
    height: 100%;
    background:black;
  }
  <%}%>
</style>
</head>
<body>
	<%
	if (ProjectIntiationList .isEmpty()) {
	%>
	<div
		style="; display: flex; justify-content: center; align-items: center;">
		<h3 class="text-animation"">No Data Available!</h3>
	</div>
	<%
	} else {
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
	<%if(ProjectIntiationList.isEmpty()) {%>
	No Data Available;
	<%}else{ %>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0.6pc">
					<div class="row card-header"
						style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
						<div class="col-md-9" id="projecthead" align="left">
							<h5 id="text" style="margin-left: 1%; font-weight: 600">Project Requirements</h5>
							</div>
							<div class="col-md-2" style="margin-left:8%;">
							<form class="form-inline" method="POST" action="ProjectOverAllRequirement.htm">
								<div class="row W-100" style="width: 100%; margin-top: -3.5%;">
								<div class="col-md-4" id="div1">
								<label class="control-label"
								style="font-size: 15px; color: #07689f;"><b>Project:</b></label>
								</div>
								<div class="col-md-8" style="" id="projectname">
								<select class="form-control selectdee" id="project"
								required="required" name="project">
								<%
								if (!ProjectIntiationList.isEmpty()) {
								for (Object[] obj : ProjectIntiationList) {
								%>
								<option value="<%=obj[0] + "/" + obj[4] + "/" + obj[5]%>"
								<%if (obj[4].toString().equalsIgnoreCase(projectshortName)) {
									projectName=obj[5].toString();
									classification=obj[3].toString();
								%>
								selected <%} else {%> <%}%>><%=obj[4]%></option>
								<%
								}}%>
								</select>
								</div>
								<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input id="submit" type="submit"
								name="submit" value="Submit" hidden="hidden">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
					<div class="container" id="container">
					<div class="row" style="display: inline">
					<div class="requirementid mt-2 ml-2">
			        <span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showSummaryModal()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Document Summary</span>
			        <span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showSentModal()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Document Distribution</span>
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showIntroudction()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Scope</span>
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" id="badgePara" onclick="showParaPage()" ><img alt="" src="view/images/Approval-check.png" >&nbsp;QR para</span> 
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" id="badge2" onclick="showSystemRequirements()"><img alt="" src="view/images/requirement.png" >&nbsp;System Requirements</span> 
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showOtherRequirements()"><img alt="" src="view/images/clipboard.png">&nbsp;Additional Requirements</span> 
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showVerification()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Verification provisions</span>
<!-- 					<span class="badge badge-light mt-2 sidebar pt-2 pb-2"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Requirement Traceability</span>
 -->							
 		<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showAbbreviations()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Abbreviations</span>
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showAppendices()"><img alt="" src="view/images/requirements.png"  >&nbsp;&nbsp; Appendices</span>
		<!-- 			 <span class="badge badge-light mt-2 sidebar pt-2 pb-2" id="showstatus" onclick="showStatus()"><img alt="" src="view/images/status.png" >&nbsp;Status</span>  -->
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="DownloadDoc()"><img alt="" src="view/images/worddoc.png" >&nbsp;Requirement Document</span> 
				<!-- 	<span class="badge badge-light mt-2 sidebar pt-2 pb-2"><img alt="" src="view/images/requirement.png">&nbsp;System Requirements</span>  -->
					 
					</div>
					</div>
			<div class="row" style="display: inline">
		
			<!--Downlaod Document  -->
			<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<button class="btn bg-transparent" id="Downloadbtn" formaction="RequirementDocumentDownlod.htm" formmethod="get" formnovalidate="formnovalidate" formtarget="_blank" style="display:none;">
			<i class="fa fa-download text-success" aria-hidden="true"></i></button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
			</form>
			<!-- End -->
			<!-- IntroductionPage -->
	  			<form action="#">
	   			<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
				<button class="btn bg-transparent" id="Introbtn" formaction="ProjectRequiremntIntroduction.htm" formmethod="get" formnovalidate="formnovalidate"  style="display:none;">
				<i class="fa fa-download text-success" aria-hidden="true"></i></button>
				</form>
			<!-- Introduction form end  -->
				<div class="" id="reqdiv">
					<div style="height:420px;margin-left: 1%;overflow:auto"id="scrollclass">
					<table class="table table-bordered">
					<tr class="table-warning"><td align="center" colspan="2" class="text-primary">DOCUMENT SUMMARY</td></tr>
					<tr>
					<td  class="text-primary" colspan="2">1.&nbsp; Title: <span class="text-dark">System Requirements Document Template</span></td>
					</tr>
					<tr >
					<td class="text-primary">2.&nbsp; Type of Document:<span class="text-dark">System Requirements Document</span></td>
					<td class="text-primary">3.&nbsp; Classification: <span class="text-dark"><%=classification %></span></td>
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
					<td  class="text-primary" colspan="2">9.&nbsp; Project Number and Project Name: <span class="text-dark"><%=projectName %> ( &nbsp;<%= projectshortName %> &nbsp;) </span></td>
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
								<span class="text-dark">		<%
										if (LabList[1] != null) {
										%><%=LabList[1].toString() + "(" + LabList[0].toString() + ")"%>

										<%
										} else {
										%>-<%
										}
										%>
								
									
										Government of India, Ministry of Defence,Defence
										Research & Development Organization
										<%
									if (LabList[2] != null && LabList[3] != null && LabList[5] != null) {
									%>
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
					<td  class="text-primary" colspan="2">15.&nbsp; Prepared by: <span class="text-dark"></span> </td>
					</tr>
					<tr>
					<td  class="text-primary" colspan="2">16.&nbsp; Reviewed by: <%if(DocumentSummary!=null && DocumentSummary[7]!=null) {%> <span class="text-dark"><%=DocumentSummary[7]%></span><%}else {%><span class="text-dark">-</span>  <%} %> </td>
					</tr>
					<tr>
					<td  class="text-primary" colspan="2">17.&nbsp; Approved by: <%if(DocumentSummary!=null && DocumentSummary[6]!=null) {%> <span class="text-dark"><%=DocumentSummary[6]%></span><%}else {%><span class="text-dark">-</span>  <%} %> </td>
					</tr>
					</table>
					</div>
					
					<div class="card-body" id="cardbody2" style="display: block;">
					<%if(!RequirementList.isEmpty()) {%>
						<%if(RequirementStatus!=null && RequirementStatus[1].toString().equalsIgnoreCase("RFP")){ %>
						<span  class="badge badge-warning" id="DocDownload">Requirements approved</span>
						<form action="#" style="display: inline;">
											<input type="hidden" name="_csrf"
												value="50354352-6cae-46da-bad1-c79a69ae2f31"> <input
												type="hidden" name="projectshortName" value="AMND">
											<input type="hidden" name="IntiationId" value="<%%>"> <span
												id="downloadform">
												<button type="button" class="btn btn-sm" formmethod="GET"
													style=" display: inline-block;"
													formtarget="_blank"
													formaction="RequirementDocumentDownlod.htm"
													data-toggle="tooltip" data-placement="top" title=""
													data-original-title="Download file">
													<i class="fa fa-download fa-sm" aria-hidden="true"></i>
												</button>
											</span>
										</form>
						<%} %>
						<div class="mt-2" align="right" style="display: none;;float: right;" >
						<form action="#">
						<button class="btn btn-sm btn-info" formmethod="GET" formaction="ProjectRequirement.htm" formnovalidate="formnovalidate" id="systemReq">&nbsp;View Details
						</button>
						<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
						</form>
					</div>
					<div class="mt-2"align="center">
					<%if(RequirementStatus!=null){ 
					if(Status.contains(RequirementStatus[1].toString())){
					if(!DocumentApprovalFlowData.isEmpty()){
					%>
					<form action="RequirementForward.htm" method="post">
					<input  type="hidden" name="status" value="<%=RequirementStatus[1].toString()%>">
					<input  type="hidden" name="initiationid" value="<%=initiationid%>">
					<input  type="hidden" name="pdd" value="<%=ProjectDetailes[1].toString() %>" >
					<input  type="hidden" name="projectcode" value="<%=ProjectDetailes[6].toString()%>" >
					<input  type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
					<input  type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" name="option" value="A" class="btn btn-sm btn-success submit" onclick="return confirm('Are You Sure To Forward this Project Requirement?');" >Forward</button>
					</form>
					<%}}}%>
					</div>
				</div>
				
					<form action="OtherRequirement.htm" method="GET" id="myStatus">
					<input type="hidden" name="initiationid" value="<%=initiationid%>">
					<input type="hidden" name="pdd" value="<%=ProjectDetailes[1].toString() %>" >
					<input type="hidden" name="projectcode" value="<%=ProjectDetailes[6].toString()%>" >
					<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" id="sub" style="display:none"></button>
					</form>
					
					
					<!-- Verification Provision -->
					
					<form action="RequirementVerify.htm" method="GET" id="myStatus1">
					<input type="hidden" name="initiationid" value="<%=initiationid%>">
					<input type="hidden" name="pdd" value="<%=ProjectDetailes[1].toString() %>" >
					<input type="hidden" name="projectcode" value="<%=ProjectDetailes[6].toString()%>" >
					<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" id="verification" style="display:none"></button>
					</form>
					
					<!--  -->
					
					<!--  Appedices-->
					
					<form action="RequirementAppendix.htm" method="GET" id="myStatus">
					<input type="hidden" name="initiationid" value="<%=initiationid%>">
					<input type="hidden" name="pdd" value="<%=ProjectDetailes[1].toString() %>" >
					<input type="hidden" name="projectcode" value="<%=ProjectDetailes[6].toString()%>" >
					<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" id="Appendix" style="display:none"></button>
					</form>
					
					
					<!--  -->
					
					<form action="RequirementPara.htm" method="GET" id="">
					<input type="hidden" name="initiationid" value="<%=initiationid%>">
					<input type="hidden" name="pdd" value="<%=ProjectDetailes[1].toString() %>" >
					<input type="hidden" name="projectcode" value="<%=ProjectDetailes[6].toString()%>" >
					<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" id="parareq" style="display:none"></button>
					</form>	
				
				
			</div>
		</div>
			<div class="row mt-2" style="border-top:1px solid lightslategrey;">
			<div class="col-md-12" style="text-align: center;">
				<b>Approval Flow</b>
			</div>
			</div> 
			<div class="row" style="text-align: center; padding-bottom: 15px;">
			<table align="center">
				<tr>
					<td class="trup" style="background: #B5EAEA;">Creator &nbsp;-
					<%=ProjectDetailes[1].toString() %>
					</td>
					<td rowspan="2"><i class="fa fa-long-arrow-right "
						aria-hidden="true"></i></td>
					<td class="trup" style="background: #E2435B;">Reviewer &nbsp;
					<%if(!DocumentApprovalFlowData.isEmpty()) {
					for(Object[]obj:DocumentApprovalFlowData){
					if(obj[3].toString().equalsIgnoreCase("Reviewer"))	{%>
					<%=	obj[1].toString()+","+obj[2].toString()%>
					<%}} }else{%>
					-
					<%} %>
					</td>
					<td rowspan="2"><i class="fa fa-long-arrow-right "
						aria-hidden="true"></i></td>
					<td class="trup" style="background: #E8E46E;">Approver &nbsp;
					<%if(!DocumentApprovalFlowData.isEmpty()) {
					for(Object[]obj:DocumentApprovalFlowData){
					if(obj[3].toString().equalsIgnoreCase("Approver"))	{%>
					<%=	obj[1].toString()+","+obj[2].toString()%>
					<%}} }else{%>
					-
					<%} %>
					</td></tr>
				<tr>
				</tr>
			</table>
		</div>  
	</div>
	<%
	}
	%>
	
	<!-- statusmodal-->
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" id="statusModal" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  	<div class="modal-dialog modal-dialog-jump modal-lg <%if(statuslist.isEmpty()){%>modal-dialog-centered<%} %>">
    <div class="modal-content" <%if(!statuslist.isEmpty()){%>style="width:165%;margin-left: -30%"<%} %>>
     <!-- <div class="modal-header" style="background: #145374;color:white; height:50px;">
        <h5 class="modal-title" id="exampleModalLabel" >Status</h5>
      </div> -->
  		<div <%if(!statuslist.isEmpty()){%>id="scrollclass" style="height:600px;overflow-y:auto"<%}%>>
 		 <div class="page card dashboard-card" >
 		 <button type="button" class="close" data-dismiss="modal"  aria-label="Close" id="closeStatus">
         <span aria-hidden="true">&times;</span>
        </button>
	      <section id="timeline">
	       <%if(!statuslist.isEmpty()){ int count=1;
	       	 SimpleDateFormat month=new SimpleDateFormat("MMM");
			 SimpleDateFormat day=new SimpleDateFormat("dd");
			 SimpleDateFormat year=new SimpleDateFormat("yyyy");
			 SimpleDateFormat time=new SimpleDateFormat("HH:mm");
			 for(Object[] object:statuslist){
			 %>
	     	<article>
				<div class="inner">
					<span class="date">
					<span class="day"><%=day.format(object[3]) %></span>
					<span class="month"><%=month.format(object[3]) %></span>
					<span class="year"><%=year.format(object[3]) %></span>
					</span>
				<h2 style="background-color: <%=object[7]%>;--my-color-var: <%=object[7]%>;" ><%=object[6] %> at <%=time.format(object[3]) %></h2> 
				<p style="background-color:  #f0f2f5;">
					<span class="remarks_title">Action By : </span>
					<%=object[2] %>,<%=object[8].toString() %><br>
					<%if(!object[5].toString().equalsIgnoreCase("")) { %>
					<span class="remarks_title">Remarks : </span>
					<%=object[5] %>
					<%}else{ %> 
					<span class="remarks_title">No Remarks! </span> 
					<%} %>
				</p>
			    </div>
			</article>
			<%count++;
			 }
			 }else{%>
			<article id="emptyArticle">
			    <div class="inner" style="width: 60%;">
				<h2 style="background-color: coral;" >Requirements Not forwarded till yet</h2> 
				<p style="background-color:coral;"><span class="remarks_title">Action By : &nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;</span></p>
				</div>
			</article>
			<%}%> 		
			</section>
    		</div>
   			</div>
		</div>
		</div>
		</div>
	<%} %>
	<!-- Modal for Document summary  -->
	
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
   			<form action="RequirementSummaryAdd.htm" method="post">
   			<div class="row">
   			<div class="col-md-4">
   			<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Additional Information:</label>
   			</div>
   			<div class="col-md-8">
   				<textarea required="required" name="information"
				class="form-control" id="additionalReq" maxlength="4000"
				rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[0]!=null){%><%=DocumentSummary[0]%><%}else{%><%}%></textarea>
   			</div>
   			</div>
   			<div class="row mt-2">
   			<div class="col-md-4">
   			<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Abstract:</label>
   			</div>
   			<div class="col-md-8">
   				<textarea required="required" name="abstract"
				class="form-control" id="" maxlength="4000"
				rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[1]!=null){%><%=DocumentSummary[1]%><%}else{%><%}%></textarea>
   			</div>
   			</div>
   			
   				<div class="row mt-2">
   			<div class="col-md-4">
   			<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Keywords:</label>
   			</div>
   			<div class="col-md-8">
   				<textarea required="required" name="keywords"
				class="form-control" id="" maxlength="4000"
				rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[2]!=null){%><%=DocumentSummary[2]%><%}else{%><%}%></textarea>
   			</div>
   			</div>
   			
   		    <div class="row mt-2">
   			<div class="col-md-4">
   			<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Distribution:</label>
   			</div>
   			<div class="col-md-8">
   				<input required="required" name="distribution"
				class="form-control" id="" maxlength="255"
				 placeholder="Maximum 255 Chararcters" required value="<%if(DocumentSummary!=null && DocumentSummary[3]!=null){%><%=DocumentSummary[3]%><%}else{%><%}%>">
   			</div>
   			</div>
   			
   			<div class="row mt-2">
			   	<div class="col-md-2">
			   	 <label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Reviewer:</label>
			   	</div>	
   				<div class="col-md-4">
	   		<select class="form-control selectdee"name="Reviewer" id=""data-width="100%" data-live-search="true"  required>
	          <option value="" selected>--SELECT--</option>
	        <%for(Object[]obj:TotalEmployeeList){ %>
	        <option value="<%=obj[0].toString()%>"
	        <%if(DocumentSummary!=null && DocumentSummary[4]!=null && DocumentSummary[4].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
	        <%=obj[1].toString() %>,<%=(obj[2].toString()) %></option>
	        <%} %>
	        </select>
   				
   				</div>
   				
   				<div class="col-md-2">
			   	<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Approver:</label>
			   	</div>	
   				<div class="col-md-4">
		   				<select class="form-control selectdee"name="Approver" id=""data-width="100%" data-live-search="true"  required>
		       <option value="" selected>--SELECT--</option>
		        <%for(Object[]obj:TotalEmployeeList){ %>
		        <option value="<%=obj[0].toString()%>"
		        <%if(DocumentSummary!=null && DocumentSummary[5]!=null && DocumentSummary[5].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
		        <%=obj[1].toString() %>,<%=(obj[2].toString()) %></option>
		        <%} %>
		        </select>
   				
   				</div>
   			</div>
   			
   	<div class="mt-2" align="center">
   <%if(DocumentSummaryList.size()>0) {%>
   <button class="btn btn-sm edit" value="edit" name="btn" onclick="return confirm ('Are you sure to submit?')">UPDATE</button>
   	<input type="hidden" name="summaryid" value="<%=DocumentSummary[8]%>"> 
   <%}else{ %>
   	<button class="btn btn-sm submit" name="btn" value="submit" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
   
   	<%} %>
   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	<input type="hidden" name="project" value="<%=project%>">
	<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
   			
   			</div>
   			</form>
  	 	</div>
    </div>
  </div>
</div> 
	<!-- modal for Document Distribution -->
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
      <%if(!MemberList.isEmpty()) {%>
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
       <form action="RequirementMemberSubmit.htm" method="post">
      <div class="row">
	<div class="col-md-10">
	<select class="form-control selectdee"name="Assignee" id="Assignee"data-width="100%" data-live-search="true" multiple required>
        <%for(Object[]obj:EmployeeList){ %>
        <option value="<%=obj[0].toString()%>"> <%=obj[1].toString() %>,<%=(obj[2].toString()) %></option>
        <%} %>
        </select>
        </div>
      <div class="col-md-2" align="center">
      	<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input id="submit" type="submit"
								name="submit" value="Submit" hidden="hidden">
	<input type="hidden" name="project" value="<%=project%>">
	<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
    <button type="submit" class="btn btn-sm submit" onclick="return confirm ('Are you sure to submit?')"> SUBMIT</button>
      </div>
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
        <form action ="ExcelUpload.htm" method="post" enctype="multipart/form-data">
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
	<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input id="submit" type="submit"
								name="submit" value="Submit" hidden="hidden">
	<input type="hidden" name="project" value="<%=project%>">
	<input type="hidden" name="initiationid" value="<%=initiationid%>"> 					
	<div align="center" class="mt-2" id="uploadDiv" style="display:none;">
	<button type="submit" name="Action" value="UploadExcel" class="btn btn-sm btn-info"  onclick="return confirm('Are you sure to submit?')">Upload</button>
	</div>
	</form>
	</div>
    </div>
  </div>
</div>
	
	<!--  -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('#project').on('change', function() {
				var temp = $(this).children("option:selected").val();
				$('#submit').click();
			});
			});
		$(function() {
			$('[data-toggle="tooltip"]').tooltip()
			})
		/* on docunment ready we want that data table to be imported for the table */
		$(document).ready(function() {
			
				$("#table1").DataTable({
				"lengthMenu" : [ 5, 10, 25, 50, 75, 100 ],
				"pagingType" : "simple",
				"pageLength" : 5,
				"language" : {
					"emptyTable" : "Files not Found"
				}
				});
				}) 
			/*parameters are passed as number to identified the elements according to class and id  */
			function showSystemRequirements() {
			$('#systemReq').click();
			}
		
			function showStatus(){
			$('#statusModal').modal('show');
			}
			function showOtherRequirements(){
			$('#sub').click();
			}
			
			function DownloadDoc(){
			$('#Downloadbtn').click();
			}
			
			function showIntroudction(){
				$('#Introbtn').click();
			}
			function showParaPage(){
				$('#parareq').click();
			}
			
			
			function showSummaryModal(){
				$('#SummaryModal').modal('show');
			}
			
			function showSentModal(){
				$('#DistributionModal').modal('show');
			}
			
			function showVerification(){
				$('#verification').click();
			}
	
		function showAbbreviations(){
			$('#AbbreviationsModal').modal('show');
		}
		
		function showAppendices(){
			$('#Appendix').click();
		}
			
		const excel_file = document.getElementById('excel_file');
		
		excel_file.addEventListener('change', (event) => {
		   
			
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
		    }
		});
		$(document).ready(function(){
			 $("#myTable1").DataTable({
			 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
			 "pagingType": "simple",
			 "pageLength": 5
		});
		});
		$(document).ready(function(){
			 $("#myTables").DataTable({
			 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
			 "pagingType": "simple",
			 "pageLength": 5
		});
		});
		$(document).ready(function(){
			 $("#myTables1").DataTable({
			 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
			 "pagingType": "simple",
			 "pageLength": 5
		});
		});
	</script>
	
</body>
</html>
 --%>
 
 
 
 <%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PMS</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/Overall.css" var="StyleCSS" />
<link href="${StyleCSS}" rel="stylesheet" />
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>
	<%
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	List<Object[]> ProjectIntiationList = (List<Object[]>) request.getAttribute("ProjectIntiationList");
	String projectshortName = (String) request.getAttribute("projectshortName");
	String initiationid = (String) request.getAttribute("initiationid");
	DecimalFormat df = new DecimalFormat("0.00");
	String project = (String)request.getAttribute("project");
	NFormatConvertion nfc = new NFormatConvertion();
	List<Object[]> RequirementList = (List<Object[]>) request.getAttribute("RequirementList");
	Object[] ProjectDetailes = (Object[]) request.getAttribute("ProjectDetailes");
	Object[]RequirementStatus=(Object[])request.getAttribute("RequirementStatus");
	List<String>Status=Arrays.asList("RIN","RID","RIP","RIA","RIT");
	List<Object[]>DocumentApprovalFlowData=(List<Object[]>)request.getAttribute("DocumentApprovalFlowData");
	List<Object[]> statuslist = (List<Object[]>)request.getAttribute("TrackingList");
	String pdf=(String)request.getAttribute("pdf");
	List<Object[]>EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");
	List<Object[]>TotalEmployeeList=(List<Object[]>)request.getAttribute("TotalEmployeeList");
	String projectName="";
	String classification="";
	List<Object[]>AbbreviationDetails=(List<Object[]>)request.getAttribute("AbbreviationDetails");
	LocalDate d = LocalDate.now();
	List<Object[]>MemberList = (List<Object[]>)request.getAttribute("MemberList");
	Month months= d.getMonth();
	int years=d.getYear();
	Object[]LabList=(Object[])request.getAttribute("LabList");
	List<Object[]>DocumentSummaryList=(List<Object[]>)request.getAttribute("DocumentSummary");
	Object[]DocumentSummary=null;
	
	if(DocumentSummaryList!=null && DocumentSummaryList.size()>0){
		DocumentSummary=DocumentSummaryList.get(0);
	}
	
	String projectType = (String)request.getAttribute("ProjectType");
	List<Object[]>ApplicableDocumentList=(List<Object[]>)request.getAttribute("ApplicableDocumentList");
	List<Object[]>ApplicableTotalDocumentList=(List<Object[]>)request.getAttribute("ApplicableTotalDocumentList");

	%>
<style type="text/css">
  <%if(statuslist!=null&&!statuslist.isEmpty()){%>
    section#timeline:before {
    content: '';
    display: block;
    position: absolute;
    left: 50%;
    top: 0;
    margin: 0 0 0 -1px;
    width: 2px;
    height: 100%;
    background:black;
  }
  <%}%>
</style>
</head>
<body>
	<%
	if (ProjectIntiationList .isEmpty()) {
	%>
	<div
		style="; display: flex; justify-content: center; align-items: center;">
		<h3 class="text-animation"">No Data Available!</h3>
	</div>
	<%
	} else {
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
	<%if(ProjectIntiationList.isEmpty()) { %>
	No Data Available;
	<%}else{ %>
		 <div class="row">
   <%--  <div class="col-md-2">
        <div class="form-group">
            <label class="control-label" style="font-weight: bolder;font-size: 15px;margin-left: 39px">Project Type</label>
        </div>
    </div>
    <div class="col-md-2">
  
            <select class="form-control custom-select" id="projectType"  name="ismain" style=" margin-left: -85px; margin-top:-6px"">
                <option disabled="true" selected value="">Choose...</option>
                <option value="M" <%if(projectType.equalsIgnoreCase("M")){ %> selected="selected" <% }%>>Main Project</option>
                <option value="I" <%if(projectType.equalsIgnoreCase("I")){ %> selected="selected" <% }%>>Initiation Project</option>
            </select>
 
    </div> --%>
</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0.6pc">
						
					<div class="row card-header"
						style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
						<div class="col-md-5" id="projecthead" align="left">
							<h5 id="text" style="margin-left: 1%; font-weight: 600">Project Requirements</h5>
							</div>
						<div class="col-md-2" >
							<label class="control-label"
								style="font-weight: bolder; font-size: 15px; margin-left: 39px">Project
								Type</label>
						</div>
						<div class="col-md-2" style="margin-top:-4px;">
  
            <select class="form-control custom-select" id="projectType"  name="ismain" style=" margin-left: -85px; margin-top:-6px"">
                <option disabled="true" selected value="">Choose...</option>
                <option value="M" <%if(projectType.equalsIgnoreCase("M")){ %> selected="selected" <% }%>>Main Project</option>
                <option value="I" <%if(projectType.equalsIgnoreCase("I")){ %> selected="selected" <% }%>>Initiation Project</option>
            </select>
 
    </div>
							<div class="col-md-2" style="margin-left:8%;">
							<form class="form-inline" method="POST" action="ProjectOverAllRequirement.htm">
								<div class="row W-100" style="width: 100%; margin-top: -3.5%;">
								<div class="col-md-4" id="div1">
								<label class="control-label"
								style="font-size: 15px; color: #07689f;"><b>Project:</b></label>
								</div>
								<div class="col-md-8" style="" id="projectname">
								<select class="form-control selectdee" id="project"
								required="required" name="project">
								<%
								if (!ProjectIntiationList.isEmpty()) {
								for (Object[] obj : ProjectIntiationList) {
								%>
								<option value="<%=obj[0] + "/" + obj[4] + "/" + obj[5]%>"
								<%if (obj[4].toString().equalsIgnoreCase(projectshortName)) {
									projectName=obj[5].toString();
									classification=obj[3].toString();
								%>
								selected <%} else {%> <%}%>><%=obj[4]%></option>
								<%
								}}%>
								</select>
								</div>
								<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input id="submit" type="submit"
								name="submit" value="Submit" hidden="hidden">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
					<div class="container" id="container">
					<div class="row" style="display: inline">
					<div class="requirementid mt-2 ml-2">
				    <span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="DownloadDoc()"><img alt="" src="view/images/worddoc.png" >&nbsp;Requirement Document</span> 
			       					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="DownloadDocPDF()"><img alt="" src="view/images/pdf.png" >&nbsp;Requirement Document</span> 
	
			       	<span class="badge badge-light mt-2 sidebar pt-2 pb-2" id="badgePara" onclick="showParaPage()" ><img alt="" src="view/images/Approval-check.png" >&nbsp;QR para</span> 
			        <span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showSummaryModal()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Document Summary</span>
			         		<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showAbbreviations()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Abbreviations</span>
			        <span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showSentModal()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Document Distribution</span>
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showIntroudction()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Scope</span>
<!-- 					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" id="badge2" onclick="showSystemRequirements()"><img alt="" src="view/images/requirement.png" >&nbsp;System Requirements</span> 
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showOtherRequirements()"><img alt="" src="view/images/clipboard.png">&nbsp;Additional Requirements</span>  -->
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showApplicableDoc()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Applicable Document</span>
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showReq()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Requirements</span>
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showVerification()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Verification provisions</span>

					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showAppendices()"><img alt="" src="view/images/requirements.png"  >&nbsp;&nbsp; Appendices</span>
		<!-- 			 <span class="badge badge-light mt-2 sidebar pt-2 pb-2" id="showstatus" onclick="showStatus()"><img alt="" src="view/images/status.png" >&nbsp;Status</span>  -->


				<!-- 	<span class="badge badge-light mt-2 sidebar pt-2 pb-2"><img alt="" src="view/images/requirement.png">&nbsp;System Requirements</span>  -->
							
					 
					</div>
					</div>
			<div class="row" style="display: inline">
		
			<!--Downlaod Document  -->
			<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<button class="btn bg-transparent" id="Downloadbtn" formaction="RequirementDocumentDownlod.htm" formmethod="get" formnovalidate="formnovalidate" formtarget="_blank" style="display:none;">
			<i class="fa fa-download text-success" aria-hidden="true"></i></button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
			</form>
			<!-- End -->
			
				<form action="#">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<button class="btn bg-transparent" id="Downloadbtnpdf" formaction="RequirementDocumentDownlodPdf.htm" formmethod="get" formnovalidate="formnovalidate" formtarget="_blank" style="display:none;">
			<i class="fa fa-download text-success" aria-hidden="true"></i></button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
			</form>
			<!-- IntroductionPage -->
	  			<form action="#">
	   			<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
				<button class="btn bg-transparent" id="Introbtn" formaction="ProjectRequiremntIntroduction.htm" formmethod="get" formnovalidate="formnovalidate"  style="display:none;">
				<i class="fa fa-download text-success" aria-hidden="true"></i></button>
				</form>
			<!-- Introduction form end  -->
				<div class="" id="reqdiv">
					<div style="height:500px;margin-left: 1%;overflow:auto"id="scrollclass">
					<table class="table table-bordered">
					<tr class="table-warning"><td align="center" colspan="2" class="text-primary">DOCUMENT SUMMARY</td></tr>
					<tr>
					<td  class="text-primary" colspan="2">1.&nbsp; Title: <span class="text-dark">System Requirements Document Template</span></td>
					</tr>
					<tr >
					<td class="text-primary">2.&nbsp; Type of Document:<span class="text-dark">System Requirements Document</span></td>
					<td class="text-primary">3.&nbsp; Classification: <span class="text-dark"><%=classification %></span></td>
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
					<td  class="text-primary" colspan="2">9.&nbsp; Project Number and Project Name: <span class="text-dark"><%=projectName %> ( &nbsp;<%= projectshortName %> &nbsp;) </span></td>
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
								<span class="text-dark">		<%
										if (LabList[1] != null) {
										%><%=LabList[1].toString() + "(" + LabList[0].toString() + ")"%>

										<%
										} else {
										%>-<%
										}
										%>
								
									
										Government of India, Ministry of Defence,Defence
										Research & Development Organization
										<%
									if (LabList[2] != null && LabList[3] != null && LabList[5] != null) {
									%>
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
					<td  class="text-primary" colspan="2">15.&nbsp; Prepared by: <%if(DocumentSummary!=null && DocumentSummary[10]!=null) {%> <span class="text-dark"><%=DocumentSummary[10]%></span><%}else {%><span class="text-dark">-</span>  <%} %> </td>
					</tr>
					<tr>
					<td  class="text-primary" colspan="2">16.&nbsp; Reviewed by: <%if(DocumentSummary!=null && DocumentSummary[7]!=null) {%> <span class="text-dark"><%=DocumentSummary[7]%></span><%}else {%><span class="text-dark">-</span>  <%} %> </td>
					</tr>
					<tr>
					<td  class="text-primary" colspan="2">17.&nbsp; Approved by: <%if(DocumentSummary!=null && DocumentSummary[6]!=null) {%> <span class="text-dark"><%=DocumentSummary[6]%></span><%}else {%><span class="text-dark">-</span>  <%} %> </td>
					</tr>
					</table>
					</div>
					
					<div class="card-body" id="cardbody2" style="display: block;">
					<%-- <%if(!RequirementList.isEmpty()) {%> --%>
						<%if(RequirementStatus!=null && RequirementStatus[1].toString().equalsIgnoreCase("RFP")){ %>
						<span  class="badge badge-warning" id="DocDownload">Requirements approved</span>
						<form action="#" style="display: inline;">
											<input type="hidden" name="_csrf"
												value="50354352-6cae-46da-bad1-c79a69ae2f31"> <input
												type="hidden" name="projectshortName" value="AMND">
											<input type="hidden" name="IntiationId" value="<%%>"> <span
												id="downloadform">
												<button type="button" class="btn btn-sm" formmethod="GET"
													style=" display: inline-block;"
													formtarget="_blank"
													formaction="RequirementDocumentDownlod.htm"
													data-toggle="tooltip" data-placement="top" title=""
													data-original-title="Download file">
													<i class="fa fa-download fa-sm" aria-hidden="true"></i>
												</button>
											</span>
										</form>
						<%} %>
						<div class="mt-2" align="right" style="display: none;;float: right;" >
						<form action="#">
						<button class="btn btn-sm btn-info" formmethod="GET" formaction="ProjectRequirement.htm" formnovalidate="formnovalidate" id="systemReq">&nbsp;View Details
						</button>
						<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
						</form>
					</div>
					<div class="mt-2"align="center">
					<%if(RequirementStatus!=null){ 
					if(Status.contains(RequirementStatus[1].toString())){
					if(!DocumentApprovalFlowData.isEmpty()){
					%>
					<form action="RequirementForward.htm" method="post">
					<input  type="hidden" name="status" value="<%=RequirementStatus[1].toString()%>">
					<input  type="hidden" name="initiationid" value="<%=initiationid%>">
					<input  type="hidden" name="pdd" value="<%=ProjectDetailes[1].toString() %>" >
					<input  type="hidden" name="projectcode" value="<%=ProjectDetailes[6].toString()%>" >
					<input  type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
					<input  type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" name="option" value="A" class="btn btn-sm btn-success submit" onclick="return confirm('Are You Sure To Forward this Project Requirement?');" >Forward</button>
					</form>
					<%}}}%>
					</div>
				</div>
				
					<form action="OtherRequirement.htm" method="GET" id="myStatus">
					<input type="hidden" name="initiationid" value="<%=initiationid%>">
					<input type="hidden" name="pdd" value="<%=ProjectDetailes[1].toString() %>" >
					<input type="hidden" name="projectcode" value="<%=ProjectDetailes[6].toString()%>" >
					<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" id="sub" style="display:none"></button>
					</form>
					
					<!-- Verification Provision -->
					
					<form action="RequirementVerify.htm" method="GET" id="myStatus1">
					<input type="hidden" name="initiationid" value="<%=initiationid%>">
					<input type="hidden" name="pdd" value="<%=ProjectDetailes[1].toString() %>" >
					<input type="hidden" name="projectcode" value="<%=ProjectDetailes[6].toString()%>" >
					<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" id="verification" style="display:none"></button>
					</form>
					
					<!--  -->
					
					<!--  Appedices-->
					
					<form action="RequirementAppendix.htm" method="GET" id="myStatus">
					<input type="hidden" name="initiationid" value="<%=initiationid%>">
					<input type="hidden" name="pdd" value="<%=ProjectDetailes[1].toString() %>" >
					<input type="hidden" name="projectcode" value="<%=ProjectDetailes[6].toString()%>" >
					<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" id="Appendix" style="display:none"></button>
					</form>
					
					
					<!--  -->
					
					<form action="RequirementPara.htm" method="GET" id="">
					<input type="hidden" name="initiationid" value="<%=initiationid%>">
					<input type="hidden" name="pdd" value="<%=ProjectDetailes[1].toString() %>" >
					<input type="hidden" name="projectcode" value="<%=ProjectDetailes[6].toString()%>" >
					<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" id="parareq" style="display:none"></button>
					</form>	
				
				
			</div>
		</div>
<%-- 			<div class="row mt-2" style="border-top:1px solid lightslategrey;">
			<div class="col-md-12" style="text-align: center;">
				<b>Approval Flow</b>
			</div>
			</div> 
			<div class="row" style="text-align: center; padding-bottom: 15px;">
			<table align="center">
				<tr>
					<td class="trup" style="background: #B5EAEA;">Creator &nbsp;-
					<%=ProjectDetailes[1].toString() %>
					</td>
					<td rowspan="2"><i class="fa fa-long-arrow-right "
						aria-hidden="true"></i></td>
					<td class="trup" style="background: #E2435B;">Reviewer &nbsp;
					<%if(!DocumentApprovalFlowData.isEmpty()) {
					for(Object[]obj:DocumentApprovalFlowData){
					if(obj[3].toString().equalsIgnoreCase("Reviewer"))	{%>
					<%=	obj[1].toString()+","+obj[2].toString()%>
					<%}} }else{%>
					-
					<%} %>
					</td>
					<td rowspan="2"><i class="fa fa-long-arrow-right "
						aria-hidden="true"></i></td>
					<td class="trup" style="background: #E8E46E;">Approver &nbsp;
					<%if(!DocumentApprovalFlowData.isEmpty()) {
					for(Object[]obj:DocumentApprovalFlowData){
					if(obj[3].toString().equalsIgnoreCase("Approver"))	{%>
					<%=	obj[1].toString()+","+obj[2].toString()%>
					<%}} }else{%>
					-
					<%} %>
					</td></tr>
				<tr>
				</tr>
			</table> --%>
		</div>  
	</div>
	<%
	}
	%>
	
	<!-- statusmodal-->
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" id="statusModal" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  	<div class="modal-dialog modal-dialog-jump modal-lg <%if(statuslist.isEmpty()){%>modal-dialog-centered<%} %>">
    <div class="modal-content" <%if(!statuslist.isEmpty()){%>style="width:165%;margin-left: -30%"<%} %>>
     <!-- <div class="modal-header" style="background: #145374;color:white; height:50px;">
        <h5 class="modal-title" id="exampleModalLabel" >Status</h5>
      </div> -->
  		<div <%if(!statuslist.isEmpty()){%>id="scrollclass" style="height:600px;overflow-y:auto"<%}%>>
 		 <div class="page card dashboard-card" >
 		 <button type="button" class="close" data-dismiss="modal"  aria-label="Close" id="closeStatus">
         <span aria-hidden="true">&times;</span>
        </button>
	      <section id="timeline">
	       <%if(!statuslist.isEmpty()){ int count=1;
	       	 SimpleDateFormat month=new SimpleDateFormat("MMM");
			 SimpleDateFormat day=new SimpleDateFormat("dd");
			 SimpleDateFormat year=new SimpleDateFormat("yyyy");
			 SimpleDateFormat time=new SimpleDateFormat("HH:mm");
			 for(Object[] object:statuslist){
			 %>
	     	<article>
				<div class="inner">
					<span class="date">
					<span class="day"><%=day.format(object[3]) %></span>
					<span class="month"><%=month.format(object[3]) %></span>
					<span class="year"><%=year.format(object[3]) %></span>
					</span>
				<h2 style="background-color: <%=object[7]%>;--my-color-var: <%=object[7]%>;" ><%=object[6] %> at <%=time.format(object[3]) %></h2> 
				<p style="background-color:  #f0f2f5;">
					<span class="remarks_title">Action By : </span>
					<%=object[2] %>,<%=object[8].toString() %><br>
					<%if(!object[5].toString().equalsIgnoreCase("")) { %>
					<span class="remarks_title">Remarks : </span>
					<%=object[5] %>
					<%}else{ %> 
					<span class="remarks_title">No Remarks! </span> 
					<%} %>
				</p>
			    </div>
			</article>
			<%count++;
			 }
			 }else{%>
			<article id="emptyArticle">
			    <div class="inner" style="width: 60%;">
				<h2 style="background-color: coral;" >Requirements Not forwarded till yet</h2> 
				<p style="background-color:coral;"><span class="remarks_title">Action By : &nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;</span></p>
				</div>
			</article>
			<%}%> 		
			</section>
    		</div>
   			</div>
		</div>
		</div>
		</div>
	<%} %>
	
	<!--ApplicableDoc  -->	
	<div class="modal fade" id="docs" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Applicable Document</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
      <table class="table table-bordered table-hover table-striped table-condensed" >
      <thead>
      <tr>
      <td>SN</td>
      <td>Document Name</td>
      <td>Action</td>
      </tr>
      </thead>
      
      <tbody>
      <%if(ApplicableTotalDocumentList!=null && ApplicableTotalDocumentList.size()>0) {
      int snCount=0;
    for(Object[]obj:ApplicableTotalDocumentList){
      %>
      <tr>
      <td style="text-align: center"><%=++snCount %></td>
      <td><%=obj[1].toString() %></td>
      <td></td>
      </tr>
      <%}}else{ %>
      <tr><td colspan="3" style="text-align: center">No Documents Merged!</tr>
      <%} %>
      </tbody>
      </table>
<hr>
      <div>
      	<%if(ApplicableDocumentList!=null && ApplicableDocumentList.size()>0) {
      	for(Object[]obj:ApplicableDocumentList){
      	%>
      
      	<div>
      	<input class="form-control" name="addDoc" type="checkbox" value="<%=obj[0].toString()%>"style="width:50%;display:inline">
      	
      	<span><%=obj[1].toString() %></span>
      	</div>
      
      <%}} %>
      </div>
      	<%if(ApplicableDocumentList!=null && ApplicableDocumentList.size()>0) {%>
      <div align="center" class="mt-2" onclick="getValues()">
      <button class="btn btn-sm submit">SUBMIT</button>
      </div>
      <%} %>
      
      </div>
    
    </div>
  </div>
</div>
	
	<!--  -->
	
	
	<!-- Modal for Document summary  -->
	
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
   			<form action="RequirementSummaryAdd.htm" method="post">
   			<div class="row">
   			<div class="col-md-4">
   			<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Additional Information:</label>
   			</div>
   			<div class="col-md-8">
   				<textarea required="required" name="information"
				class="form-control" id="additionalReq" maxlength="4000"
				rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[0]!=null){%><%=DocumentSummary[0]%><%}else{%><%}%></textarea>
   			</div>
   			</div>
   			<div class="row mt-2">
   			<div class="col-md-4">
   			<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Abstract:</label>
   			</div>
   			<div class="col-md-8">
   				<textarea required="required" name="abstract"
				class="form-control" id="" maxlength="4000"
				rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[1]!=null){%><%=DocumentSummary[1]%><%}else{%><%}%></textarea>
   			</div>
   			</div>
   			
   				<div class="row mt-2">
   			<div class="col-md-4">
   			<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Keywords:</label>
   			</div>
   			<div class="col-md-8">
   				<textarea required="required" name="keywords"
				class="form-control" id="" maxlength="4000"
				rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(DocumentSummary!=null && DocumentSummary[2]!=null){%><%=DocumentSummary[2]%><%}else{%><%}%></textarea>
   			</div>
   			</div>
   			
   		    <div class="row mt-2">
   			<div class="col-md-4">
   			<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Distribution:</label>
   			</div>
   			<div class="col-md-8">
   				<input required="required" name="distribution"
				class="form-control" id="" maxlength="255"
				 placeholder="Maximum 255 Chararcters" required value="<%if(DocumentSummary!=null && DocumentSummary[3]!=null){%><%=DocumentSummary[3]%><%}else{%><%}%>">
   			</div>
   			</div>
   				<div class="row mt-2">
   			<div class="col-md-2">
			   	 <label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Prepared By:</label>
			   	</div>
			   <div class="col-md-4">
	   		<select class="form-control selectdee"name="preparer" id=""data-width="100%" data-live-search="true"  required>
	          <option value="" selected>--SELECT--</option>
	        <%for(Object[]obj:TotalEmployeeList){ %>
	        <option value="<%=obj[0].toString()%>"
	        <%if(DocumentSummary!=null && DocumentSummary[9]!=null && DocumentSummary[9].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
	        <%=obj[1].toString() %>,<%=(obj[2].toString()) %></option>
	        <%} %>
	        </select>
   				
   				</div>
   			</div>
   			<div class="row mt-2">
			   	<div class="col-md-2">
			   	 <label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Reviewer:</label>
			   	</div>	
   				<div class="col-md-4">
	   		<select class="form-control selectdee"name="Reviewer" id=""data-width="100%" data-live-search="true"  required>
	          <option value="" selected>--SELECT--</option>
	        <%for(Object[]obj:TotalEmployeeList){ %>
	        <option value="<%=obj[0].toString()%>"
	        <%if(DocumentSummary!=null && DocumentSummary[4]!=null && DocumentSummary[4].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
	        <%=obj[1].toString() %>,<%=(obj[2].toString()) %></option>
	        <%} %>
	        </select>
   				
   				</div>
   				
   				<div class="col-md-2">
			   	<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Approver:</label>
			   	</div>	
   				<div class="col-md-4">
		   				<select class="form-control selectdee"name="Approver" id=""data-width="100%" data-live-search="true"  required>
		       <option value="" selected>--SELECT--</option>
		        <%for(Object[]obj:TotalEmployeeList){ %>
		        <option value="<%=obj[0].toString()%>"
		        <%if(DocumentSummary!=null && DocumentSummary[5]!=null && DocumentSummary[5].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
		        <%=obj[1].toString() %>,<%=(obj[2].toString()) %></option>
		        <%} %>
		        </select>
   				
   				</div>
   			</div>
   			
   	<div class="mt-2" align="center">
   <%if(DocumentSummaryList!=null && DocumentSummaryList.size()>0) {%>
   <button class="btn btn-sm edit" value="edit" name="btn" onclick="return confirm ('Are you sure to submit?')">UPDATE</button>
   	<input type="hidden" name="summaryid" value="<%=DocumentSummary[8]%>"> 
   <%}else{ %>
   	<button class="btn btn-sm submit" name="btn" value="submit" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
   
   	<%} %>
   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	<input type="hidden" name="project" value="<%=project%>">
	<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
   			
   			</div>
   			</form>
  	 	</div>
    </div>
  </div>
</div> 
	<!-- modal for Document Distribution -->
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
      <%if(!MemberList.isEmpty()) {%>
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
       <form action="RequirementMemberSubmit.htm" method="post">
      <div class="row">
	<div class="col-md-10">
	<select class="form-control selectdee"name="Assignee" id="Assignee"data-width="100%" data-live-search="true" multiple required>
        <%for(Object[]obj:EmployeeList){ %>
        <option value="<%=obj[0].toString()%>"> <%=obj[1].toString() %>,<%=(obj[2].toString()) %></option>
        <%} %>
        </select>
        </div>
      <div class="col-md-2" align="center">
      	<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input id="submit" type="submit"
								name="submit" value="Submit" hidden="hidden">
	<input type="hidden" name="project" value="<%=project%>">
	<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
    <button type="submit" class="btn btn-sm submit" onclick="return confirm ('Are you sure to submit?')"> SUBMIT</button>
      </div>
      </div>
      </form>
      </div>
    </div>
  </div>
</div>
	
	<!--  -->
		<form action="RequirementList.htm" method="GET" id="myStatus">
					<input type="hidden" name="initiationid" value="<%=initiationid%>">
					<input type="hidden" name="pdd" value="<%=ProjectDetailes[1].toString() %>" >
					<input type="hidden" name="projectcode" value="<%=ProjectDetailes[6].toString()%>" >
					<input type="hidden" name="project" value="<%=ProjectDetailes[0] + "/" + ProjectDetailes[6] + "/" + ProjectDetailes[7]%>">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" id="reqList" style="display:none"></button>
					</form>
	
	
	
	
	<!--  -->
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
        <form action ="ExcelUpload.htm" method="post" id="excelForm" enctype="multipart/form-data">
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
	<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input id="submit" type="submit"
								name="submit" value="Submit" hidden="hidden">
	<input type="hidden" name="project" value="<%=project%>">
	<input type="hidden" name="initiationid" value="<%=initiationid%>"> 					
	<div align="center" class="mt-2" id="uploadDiv" style="display:none;">
	<button type="submit" name="Action" value="UploadExcel" class="btn btn-sm btn-info"  onclick="return confirm('Are you sure to submit?')">Upload</button>
	</div>
	</form>
	
<div id="ExistingAbb">
				<table class="table table-bordered table-hover table-striped table-condensed "id="myTable2" style="width:100%;">
				<thead >
				<tr>
					<td>SN</td>
					<td>Abbreviations</td>
					<td>Meaning</td>
				</tr>
				</thead>
				<% if(AbbreviationDetails!=null){
					int count=0;
			
					for(Object[] AbbDetails:AbbreviationDetails){
				%>
				<tr>
					<td><%=++count %></td>
					<td><%=AbbDetails[1]%></td>
					<td><%=AbbDetails[2]%></td>
				</tr>
				<% }}%>
				</table>
				</div>
			
	</div>
			
    </div>
  </div>
</div>
	<form action="ProjectOverAllRequirement.htm" id="form1">
	<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
	</form>
	
	<form action="Requirements.htm" id="form2">
		<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
	</form>
	
	<!--  -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('#project').on('change', function() {
				var temp = $(this).children("option:selected").val();
				$('#submit').click();
			});
			});
		$(function() {
			$('[data-toggle="tooltip"]').tooltip()
			})
		/* on docunment ready we want that data table to be imported for the table */
		$(document).ready(function() {
			
				$("#table1").DataTable({
				"lengthMenu" : [ 5, 10, 25, 50, 75, 100 ],
				"pagingType" : "simple",
				"pageLength" : 5,
				"language" : {
					"emptyTable" : "Files not Found"
				}
				});
				}) 
			/*parameters are passed as number to identified the elements according to class and id  */
			function showSystemRequirements() {
			$('#systemReq').click();
			}
		
			function showStatus(){
			$('#statusModal').modal('show');
			}
			function showOtherRequirements(){
			$('#sub').click();
			}
			
			function DownloadDoc(){
			$('#Downloadbtn').click();
			}
			
			function showIntroudction(){
				$('#Introbtn').click();
			}
			function showParaPage(){
				$('#parareq').click();
			}
			
			
			function showSummaryModal(){
				$('#SummaryModal').modal('show');
			}
			
			function showSentModal(){
				$('#DistributionModal').modal('show');
			}
			
			function showVerification(){
				$('#verification').click();
			}
	
		function showAbbreviations(){
			$('#AbbreviationsModal').modal('show');
		}
		
		function showAppendices(){
			$('#Appendix').click();
		}
			
		const excel_file = document.getElementById('excel_file');
		
		
		excel_file.addEventListener('change', (event) => {
		   
			$('#ExistingAbb').hide();	
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
		    }
		});
		$(document).ready(function(){
			 $("#myTable1").DataTable({
			 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
			 "pagingType": "simple",
			 "pageLength": 5
		});
		});
		$(document).ready(function(){
			 $("#myTables").DataTable({
			 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
			 "pagingType": "simple",
			 "pageLength": 5
		});
		});
		$(document).ready(function(){
			 $("#myTables1").DataTable({
			 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
			 "pagingType": "simple",
			 "pageLength": 5
		});
		});
		$(document).ready(function(){
		    $("#myTable2").DataTable({
		        "lengthMenu": [5, 10, 25, 50, 75, 100],
		        "pagingType": "simple",
		        "pageLength": 5
		    });
		});

		 
		
	</script>
	<script type="text/javascript">
$("#projectType").on('change', function() {
    var value = $("#projectType").val();
   if(value==="M"){
	var form= $("#form2");
	form.submit();
	console.log(form);
   }else{
	   var form= $("#form1"); 
	   form.submit();
   }
});

function showReq(){
	$('#reqList').click();
}

function DownloadDocPDF(){
$('#Downloadbtnpdf').click();
}
			
function showApplicableDoc(){
$('#docs').modal('show');
}


function getValues(){
    var checkboxes = document.getElementsByName("addDoc");
    var checkedValues = [];

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            checkedValues.push(checkboxes[i].value);
        }
    }

    $.ajax({
		url:'AddDocs.htm',
		datatype:'json',
		data:{
			checkedValues:checkedValues.toString(),
			initiationid:<%=initiationid%>
		},
		success:function(result){
			var ajaxresult=JSON.parse(result);
			console.log("ajaxresult---"+ajaxresult)
			if(ajaxresult>0){
				alert("Applicable Dcouments Linked successfully !");
			}
			location.reload();
		}

    })
}
</script>
	
</body>
</html>
 