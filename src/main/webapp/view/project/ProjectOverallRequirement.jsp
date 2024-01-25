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
	<%
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	List<Object[]> ProjectIntiationList = (List<Object[]>) request.getAttribute("ProjectIntiationList");
	String projectshortName = (String) request.getAttribute("projectshortName");
	String initiationid = (String) request.getAttribute("initiationid");
	String projectTitle = (String) request.getAttribute("projectTitle");
	DecimalFormat df = new DecimalFormat("0.00");
	NFormatConvertion nfc = new NFormatConvertion();
	List<Object[]> RequirementList = (List<Object[]>) request.getAttribute("RequirementList");
	Object[] ProjectDetailes = (Object[]) request.getAttribute("ProjectDetailes");
	Object[]RequirementStatus=(Object[])request.getAttribute("RequirementStatus");
	List<String>Status=Arrays.asList("RIN","RID","RIP","RIA","RIT");
	List<Object[]>DocumentApprovalFlowData=(List<Object[]>)request.getAttribute("DocumentApprovalFlowData");
	List<Object[]> statuslist = (List<Object[]>)request.getAttribute("TrackingList");
	String pdf=(String)request.getAttribute("pdf");
	List<Object[]>EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");
	String projectName="";
	String classification="";
	
	LocalDate d = LocalDate.now();

	Month months= d.getMonth();
	int years=d.getYear();
	Object[]LabList=(Object[])request.getAttribute("LabList");
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
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" id="badge2" onclick="showSystemRequirements()"><img alt="" src="view/images/requirement.png" >&nbsp;System Requirements</span> 
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showOtherRequirements()"><img alt="" src="view/images/clipboard.png">&nbsp;Additional Requirements</span> 
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="showVerification()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Verification provisions</span>
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Requirement Traceability</span>
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Abbreviations</span>
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2"><img alt="" src="view/images/requirements.png"  >&nbsp;&nbsp; Appendices</span>
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" id="badgePara" onclick="showParaPage()" ><img alt="" src="view/images/Approval-check.png" >&nbsp;QR para</span> 
				    <span class="badge badge-light mt-2 sidebar pt-2 pb-2" id="showstatus" onclick="showStatus()"><img alt="" src="view/images/status.png" >&nbsp;Status</span> 
					<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="DownloadDoc()"><img alt="" src="view/images/pdf.png" >&nbsp;Requirement Document</span> 
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
									<textarea required="required" name="" class="form-control"
									id="additionalReq" maxlength="4000" rows="2" cols="53"
									placeholder="Maximum 4000 Chararcters" style="width:90%"></textarea>
					<button class="btn btn-sm btn-success" style="float:right;margin-right: 2%;margin-top:-4%;">SUBMIT</button>
					</td>
					</tr>
				     <tr>
					<td  class="text-primary" colspan="2">9.&nbsp; Project Number and Project Name: <span class="text-dark"><%=projectName %> ( &nbsp;<%= projectshortName %> &nbsp;) </span></td>
					</tr>
					<tr>
					<td  class="text-primary" colspan="2">10.&nbsp; Abstract:
						<textarea required="required" name="" class="form-control"
									id="Abstract" maxlength="4000" rows="2" cols="53"
									placeholder="Maximum 4000 Chararcters" style="width:90%"></textarea>
					<button class="btn btn-sm btn-success" style="float:right;margin-right: 2%;margin-top:-4%;">SUBMIT</button>
					</td>
					</tr>
					<tr>
					<td  class="text-primary" colspan="2">11.&nbsp; Keywords:</td>
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
					<td  class="text-primary" colspan="2">13.&nbsp; Distribution:</td>
					</tr>
					<tr>
					<td  class="text-primary" colspan="2">14.&nbsp; Revision:</td>
					</tr>
					<tr>
					<td  class="text-primary" colspan="2">15.&nbsp; Prepared by: <span class="text-dark">-</span> </td>
					</tr>
					<tr>
					<td  class="text-primary" colspan="2">16.&nbsp; Reviewed by: <span class="text-dark">-</span> </td>
					</tr>
					<tr>
					<td  class="text-primary" colspan="2">17.&nbsp; Approved by: <span class="text-dark">-</span> </td>
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
	
  <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="">
  <div class="modal-dialog modal-dialog-jump modal-lg ">
    <div class="modal-content" style="width:137%;margin-left:-21%;">
         <div class="modal-header" id="ModalHeader">
        <h5 class="modal-title" id="exampleModalLabel">Document Summary</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
   		<div class="modal-body">
   			<div class="row">
   			<div class="col-md-4">
   			<label class="text-primary" style="font-size: 1rem;font-weight: bold;">Additional Information:</label>
   			</div>
   			<div class="col-md-8">
   				<textarea required="required" name=""
				class="form-control" id="additionalReq" maxlength="4000"
				rows="3" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
   			</div>
   			</div>
   			<div class="row mt-2">
   			<div class="col-md-4">
   			<label class="text-primary" style="font-size: 1rem;font-weight: bold;">Abstract:</label>
   			</div>
   			<div class="col-md-8">
   				<textarea required="required" name=""
				class="form-control" id="Abstract" maxlength="4000"
				rows="3" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
   			</div>
   			</div>
  	 	</div>
    </div>
  </div>
</div>
	<!-- modal for Document Distribution -->
	<div class="modal fade" id="DistributionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document">
    <div class="modal-content">
      <div class="modal-header" id="ModalHeader">
        <h5 class="modal-title" >Document Sent to</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="row">
	<div class="col-md-10">
	<select class="form-control selectdee"name="Assignee" id="Assignee"data-width="100%" data-live-search="true" multiple>
        <%for(Object[]obj:EmployeeList){ %>
        <option value="<%=obj[0].toString()%>"> <%=obj[1].toString() %>,<%=(obj[2].toString()) %></option>
        <%} %>
        </select>
        </div>
      <div class="col-md-2" align="center">
      	<button class="btn btn-sm submit">SUBMIT</button>
      </div>
      </div>
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
	</script>
</body>
</html>
