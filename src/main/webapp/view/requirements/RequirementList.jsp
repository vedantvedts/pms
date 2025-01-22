 <%@page import="com.vts.pfms.requirements.model.RequirementInitiation"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.util.stream.Collectors"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PMS</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>
<link href="${contentCss}" rel="stylesheet" /> --%>
<spring:url value="/resources/js/FileSaver.min.js" var="FileSaver" />
<script src="${FileSaver}"></script>
<spring:url value="/resources/js/jquery.wordexport.js" var="wordexport" />
<script src="${wordexport}"></script>
<spring:url value="/resources/pdfmake/pdfmake.min.js" var="pdfmake" />
<script src="${pdfmake}"></script>
<spring:url value="/resources/pdfmake/vfs_fonts.js" var="pdfmakefont" />
<script src="${pdfmakefont}"></script>
<spring:url value="/resources/pdfmake/htmltopdf.js" var="htmltopdf" />
<script src="${htmltopdf}"></script>
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />
<style type="text/css">
label {
	font-weight: bold;
	font-size: 14px;
}

.table thead tr, tbody tr {
	font-size: 14px;
}

body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}

#scrollButton {
	display: none; /* Hide the button by default */
	position: fixed;
	/* Fixed position to appear in the same place regardless of scrolling */
	bottom: 20px;
	right: 30px;
	z-index: 99; /* Ensure it appears above other elements */
	font-size: 18px;
	border: none;
	outline: none;
	background-color: #007bff;
	color: white;
	cursor: pointer;
	padding: 15px;
	border-radius: 4px;
}

h6 {
	text-decoration: none !important;
}

.multiselect-container>li>a>label {
	padding: 4px 20px 3px 20px;
}

.width {
	width: 210px !important;
}

.bootstrap-select {
	width: 400px !important;
}

#projectname {
	display: flex;
	align-items: center;
	justify-content: flex-start;
}

#div1 {
	display: flex;
	align-items: center;
	justify-content: center;
}

select:-webkit-scrollbar { /*For WebKit Browsers*/
	width: 0;
	height: 0;
}

.requirementid {
	border-radius: 5px;
	box-shadow: 10px 10px 5px lightgrey;
	margin: 1% 0% 3% 2%;
	padding: 5px;
	padding-bottom: 10px;
	display: inline-grid;
	width: 25%;
	background-color: antiquewhite;
	float: left;
	align-items: center;
	justify-content: center;
	overflow: auto;
	position: stickey;
}

.requirementid::-webkit-scrollbar {
	display: none;
}

.requirementid:hover {
	padding: 13px;
}

.viewbtn {
	width: 80%;
	margin-top: 4%;
	background: #055C9D;
	font-size: 15px;
	font-family: font-family : 'Muli';
	text-align: justify
}

.viewbtn:hover {
	cursor: pointer !important;
	background-color: #22c8e5 !important;
	border: none !important;
	box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0
		rgba(0, 0, 0, 0.19) !important;
}

.viewbtn1 {
	width: 100%;
	margin-top: 4%;
	background: #055C9D;
	font-size: 13px;
	font-family: font-family : 'Muli';
}

.viewbtn1:hover {
	background: green;
}

#container {
	background-color: white;
	display: inline-block;
	margin-left: 2%;
	margin-top: 1%;
	box-shadow: 8px 8px 5px lightgrey;
	max-width: 70%;
}

hr {
	margin-left: 0px !important;
	margin-bottom: 0px;
	!
	important;
}

.addreq {
	margin-left: -20%;
	margin-top: 5%;
}

#modalreqheader {
	background: #145374;
	height: 44px;
	display: flex;
	font-family: 'Muli';
	align-items: center;
	color: white;
}

#code {
	padding: 0px;
	width: 64%;
	font-size: 12px;
	margin-left: 2%;
	margin-bottom: 7%;
}

#addReqButton {
	display: flex;
	align-items: center;
	justify-content: center;
}

#modaal-A {
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
	font-family: sans-serif;
}

#editreq {
	margin-bottom: 5px;
	display: flex;
	align-items: center;
	justify-content: flex-end;
}

#reqbtns {
	box-shadow: 2px 2px 2px;
	font-size: 15px;
	font-weight: 500;
}

#attachadd, #viewattach {
	margin-left: 1%;
	box-shadow: 2px 2px 2px black;
	font-size: 15px;
	font-weight: 500;
}

/* #reqName {
	font-size: 20px;
	background: #f5f5dc;
	font-family: inherit;
	color: darkslategrey;
	font-weight: 500;
	display: flex;
	border-radius: 8px;
	align-items: center;
	box-shadow: 4px 4px 4px gray;
} */

@
keyframes blinker { 20% {
	opacity: 0.65;
}

}
#attachmentadd, #attachmentaddedit {
	display: flex;
	margin-top: 2%;
}

#download, #deletedownload {
	box-shadow: 2px 2px 2px grey;
	margin-left: 1%;
	margin-top: 1%;
	margin-right: 1%;
}

#headerid, #headeridedit {
	margin-top: 1%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 1%;
}
/* #reqdiv{
    background-image: url(view/images/background.jpg);
    background-repeat: no-repeat;
    background-size: cover;

} */
#reqdiv:hover {
	box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0
		rgba(0, 0, 0, 0.19) !important;
}

#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px;
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}

#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px;
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}

.multiselect {
	padding: 4px 90px;
	background-color: white;
	border: 1px solid #ced4da;
	height: calc(2.25rem + 2px);
}
.modal-dialog-jump-pop {
	animation: jumpIn .5s ease;
}
.modal-dialog-jump {
	animation: jumpIn 1.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.3);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}

.spnaclick{
padding:5px;
float: right;
}

#description li{
list-style: inherit !important;
}

/*    .open-modal-button {
      position: fixed;
      bottom: 10px;
      right: 10px;
      background-color: #007bff;
      color: #fff;
      padding: 5px;
      border: none;
      border-radius: 5px;
      font-weight:bold;
      cursor: pointer;
      z-index: 1001; /* Make sure the button is above the modal */
    } */
</style>
</head>
<body>
<%
String initiationId = (String)request.getAttribute("initiationId");
String project = (String)request.getAttribute("project");
String projectId = (String)request.getAttribute("projectId");
String productTreeMainId = (String)request.getAttribute("productTreeMainId");
String reqInitiationId = (String)request.getAttribute("reqInitiationId");

String subId=(String)request.getAttribute("subId");

List<Object[]>requirementTypeList=(List<Object[]>)request.getAttribute("requirementTypeList");
List<Object[]>RequirementList = (List<Object[]>)request.getAttribute("RequirementList");

List<Object[]>subReqList = new ArrayList<>();
String InitiationReqId=(String)request.getAttribute("InitiationReqId");

if(InitiationReqId==null && RequirementList!=null){
	InitiationReqId = RequirementList.get(0)[0].toString();
}
if(RequirementList!=null && RequirementList.size()>0){
	subReqList=RequirementList.stream().filter(e->e[15]!=null && e[15].toString().equalsIgnoreCase("0"))
			.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
			.collect(Collectors.toList());
}

List<Object[]>VerificationMethodList = (List<Object[]>)request.getAttribute("VerificationMethodList");
List<Object[]>productTreeList = (List<Object[]>)request.getAttribute("productTreeList");

List<Object[]>DemonstrationList = new ArrayList<>();
List<Object[]>TestList = new ArrayList<>();
List<Object[]>DesignList = new ArrayList<>();
List<Object[]>InspectionList = new ArrayList<>();
List<Object[]>specialMethods = new ArrayList<>();

if(VerificationMethodList!=null && !VerificationMethodList.isEmpty()){
	DemonstrationList = VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("1")).collect(Collectors.toList());
	TestList = VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("2")).collect(Collectors.toList());
	DesignList = VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("3")).collect(Collectors.toList());
	InspectionList = VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("4")).collect(Collectors.toList());
	specialMethods = VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("5")).collect(Collectors.toList());
}
List<Object[]>ProjectParaDetails=(List<Object[]>)request.getAttribute("ProjectParaDetails");
List<Object[]>ReqSubSystemList=(List<Object[]>)request.getAttribute("ReqSubSystemList");
List<Object[]>RequirementMainList=(List<Object[]>)request.getAttribute("RequirementMainList");


Object[] projectDetails = (Object[]) request.getAttribute("projectDetails");
%>
	<%String ses=(String)request.getParameter("result"); 
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){ %>
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
	
		<!-- Verification Master -->
					<form action="RequirementVerifyMaster.htm" method="GET" id="myStatus1">
					<input type="hidden" name="project" value="<%=project%>">
					<input type="hidden" name="projectId" value=<%=projectId %>>
					<input type="hidden" name="initiationId" value=<%=initiationId %>>
					<input type="hidden" name="reqInitiationId" value=<%=reqInitiationId %>>
					<input type="hidden" name="productTreeMainId" value=<%=productTreeMainId %>>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" id="verificationMaster" style="display:none"></button>
					</form>
					<!--  -->
	<div id="reqmain" class="card-slider">
		<div class="container-fluid" style="" id="main">
			<div class="row">
				<div class="col-md-12">
					<div class="card shadow-nohover" style="margin-top: -0px;">
						<div class="row card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
							<div class="col-md-5" id="projecthead">
								<h5 style="margin-left: 1%;">
									Requirements - 
									<small>
										<%if(projectDetails!=null) {%>
											<%=projectDetails[2]!=null?projectDetails[2]:"-" %>
											(<%=projectDetails[1]!=null?projectDetails[1]:"-" %>)
										<%} %>
									</small>
								</h5>
							</div>
							<div class="col-md-7" id="addReqButton">
								<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
								<button class="btn btn-success btn-sm submit" style=""
										type="button" onclick='showdata()' data-toggle="tooltip"
										data-placement="top" data-original-data=""
										title="Link REQUIREMENTS">ADD HEADINGS</button>
								&nbsp;&nbsp;<span class="badge badge-light  sidebar pt-2 pb-2" style="cursor:pointer;" onclick="showVerificationMaster()">&nbsp;&nbsp;Verification Master</span>
								<%if(!initiationId.equalsIgnoreCase("0")){ %>
								<form action="#">
										<input type="hidden" name="project" value="<%=project%>">
										<input type="hidden" name="initiationId" value=<%=initiationId %>>
										<input type="hidden" name="reqInitiationId" value=<%=reqInitiationId %>>
										<input type="hidden" name="productTreeMainId" value=<%=productTreeMainId %>>
										<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
										<button class="btn btn-info btn-sm  back ml-2"
										formaction="ProjectOverAllRequirement.htm" formmethod="get"
										formnovalidate="formnovalidate" style="margin-top: -3%;">BACK</button>
								</form>
								<%} %>
								
								<%if(!projectId.equalsIgnoreCase("0")){ %>
								<form action="#">
									
									<input type="hidden" name="projectId" value=<%=projectId %>>
									<input type="hidden" name="productTreeMainId" value=<%=productTreeMainId %>>
									<input type="hidden" name="reqInitiationId" value=<%=reqInitiationId %>>
										<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
									<button class="btn btn-info btn-sm  back ml-2"
										formaction="ProjectRequirementDetails.htm" formmethod="get"
										formnovalidate="formnovalidate" style="margin-top: -3%;">BACK</button>
								</form>
								<%} %>
								&nbsp;&nbsp;&nbsp; <!-- <button class="btn btn-sm" onclick="getFunctionalRequirements()">Functional Requirements</button> -->
								
									<%if(RequirementList!=null && RequirementList.size()>0){ %>
								 <button class="btn btn-sm open-modal-button" id="modalbtn" onclick="getFunctionalRequirements()">
								<i class="fa fa-download" aria-hidden="true" style="color:green;"></i> FR
								 </button>&nbsp;&nbsp;
								 <button class="btn btn-sm open-modal-button" id="modalbtn" onclick="getPerformanceRequirements()">
								<i class="fa fa-download" aria-hidden="true" style="color:green;"></i> PR
								 </button>&nbsp;&nbsp;
								 <button class="btn btn-sm open-modal-button " id="modalbtn" onclick="getOperationalRequirements()">
								<i class="fa fa-download" aria-hidden="true" style="color:green;"></i> OR
								 </button>
						
									<%} %>
							
							</div>	
								
						</div>
					</div>
				</div>
			</div>
		</div>
		<%if((subReqList!=null) &&(!subReqList.isEmpty())){ %>
		<div class="requirementid" style="display:block;<%if(subReqList.size()>9){%>height:500px;<%}%>">

			<%int count=0;
				for(Object []obj:subReqList) {%>
				<div>	<button  type="button" class="btn btn-secondary  mt-2" style="width:84%;font-size: 13px;" id="<%=obj[0] %>" value="<%=obj[14].toString()%>"  onclick="showDetails(<%=obj[0].toString()%>,'M')">
						 <%=(++count)+". "+ obj[3] %>
					</button>&nbsp;
					<button style="width:10%;background: white;" class="btn btn-sm" onclick="openSubReqModal(<%=obj[14].toString()%>,<%=obj[0].toString()%>)" data-toggle="tooltip" data-placement="top" data-original-data="" title="">
						<i class="fa fa-plus-square" aria-hidden="true"></i>
					</button> </div>
					<div class="col-md-10 subDiv" id="subDiv<%=obj[0].toString()%>" style="display:none;" >
					
						<% List<Object[]>subList=RequirementList.stream().filter(e->e[15].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());
							if(subList!=null && subList.size()>0){
								subList = subList.stream().sorted(Comparator.comparingInt(e -> Integer.parseInt(e[14].toString()))).collect(Collectors.toList());
								int subcount=0;
									for(Object[] obj1:subList){
						%>	
			
				
							<button type="button" class="btn btn-secondary viewbtn mt-2" id="<%=obj1[0] %>" value="<%=obj1[0]%>/<%=obj[0].toString()%>"  <%-- onclick="showDetailss(<%=obj1[0].toString()%>,<%=obj[0].toString()%>)"  --%>>
								<i class="fa fa-caret-right" aria-hidden="true" style="color:white;"></i> &nbsp;  
								<%=count+"."+(++subcount)+". "+  obj1[1] %>
							</button>
							<button class="btn btn-sm bg-transparent" type="button" onclick="deleteReq(<%=obj1[0] %>)">
							<i class="fa fa-trash-o" aria-hidden="true" style="color:red;"></i>
							</button>
						<%} }%>
					</div>
			<%} %>
		</div>	
		
		<div class="container" id="container">
			<div class="row" id="row1">
				<div class="col-md-12" id="reqdiv">
					<div class="card-body" id="cardbody">
						<div class="row">
							<div class="col-md-12">
								<div class="row">
							<div class="col-md-4" id="reqName" style="font-size: 1.4rem;font-weight: 600;"></div>
								</div> 
							</div>
							
							<div class="col-md-9" style="margin-top: 1%">
								<h5 style="font-size: 22px; color: #005086; width: fit-content">Brief
								</h5>

							</div>
							<div class="col-md-3" style="" id="editreq"></div>
							<div class="col-md-12" style="">
								<p id="brief" style="font-size: 18px;"></p>
								<hr>
							</div>
							<div class="col-md-12" id="subDivs" style="display:none;">
								<div class="row">
								

									<div class="col-md-4" style="">
										<div class="row">
											<div class="col-md-4">
												<h5 style="font-size: 22px; color: #005086;" id="priority">Priority
													:</h5>
											</div>
											<div class="col-md-6"><p id="Prioritytext" style="font-size: 18px;"></p>
											</div>
										</div>
									</div>
									<div class="col-md-3" style="">
										<div class="row">
											<div class="col-md-6">
												<h5 style="font-size: 22px; color: #005086;" id="priority">Criticality
													:</h5>
											</div>
											<div class="col-md-6"><p id="CriticalityText" style="font-size: 18px;"></p>
											</div>
										</div>
									</div>
									<hr>
									<div class="col-md-4">
										<div class="row">
											<div class="col-md-5"
												style="padding-left: 0px; padding-right: 0px;">
												<h5 style="font-size: 22px; color: #005086;" id="priority">Need
													Type :</h5>
											</div>
											<div class="col-md-5">	<p id="needtypetext" style="font-size: 18px;"></p></div>
										</div>
									</div>
								</div>
								<hr>
							</div>
			

							<div class="col-md-12" style="">
								<h5 style="font-size: 22px; color: #005086; width: fit-content">Description</h5>
							</div>
							<div class="col-md-12" style="">
								<p id="description" style="font-size: 18px;"></p>
								<hr>
							</div>

		 					<div class="col-md-12" id="RemarksId">
								<div class="row">
									<div class="col-md-2" style="margin-top: 1%">
										<h5
											style="font-size: 20px; color: #005086; width: fit-content">Remarks:
										</h5>
									</div>

									<div class="col-md-10" style="margin-top: 1%;">
										<p id="remarksshow" style="font-size: 18px;"></p>
										
									</div>

								</div>
								<hr>
												<div class="row">
									<div class="col-md-2" style="margin-top: 1%">
										<h5
											style="font-size: 20px; color: #005086; width: fit-content">Demonstration:
										</h5>
									</div>

									<div class="col-md-10" style="margin-top: 1%;">
										<p id="DemonstrationShow" style="font-size: 18px;"></p>
									</div>

								</div>
								<hr>
								<div class="row">
								<div class="col-md-2" style="margin-top: 1%">
										<h5
											style="font-size: 20px; color: #005086; width: fit-content">Test Type:
										</h5>
									</div>

									<div class="col-md-10" style="margin-top: 1%;">
										<p id="testTypeshow" style="font-size: 18px;"></p>
									</div>

								</div>
														<hr>
								<div class="row">
								<div class="col-md-2" style="margin-top: 1%">
										<h5
											style="font-size: 20px; color: #005086; width: fit-content">Test Stage:
										</h5>
									</div>

									<div class="col-md-10" style="margin-top: 1%;">
										<p id="TestStageShow" style="font-size: 18px;"></p>
									</div>

								</div>
																			<hr>
								<div class="row">
								<div class="col-md-2" style="margin-top: 1%">
										<h5
											style="font-size: 20px; color: #005086; width: fit-content">Analysis:
										</h5>
									</div>

									<div class="col-md-10" style="margin-top: 1%;">
										<p id="AnalysisShow" style="font-size: 18px;"></p>
									</div>

								</div>
																			<hr>
								<div class="row">
								<div class="col-md-2" style="margin-top: 1%">
										<h5
											style="font-size: 20px; color: #005086; width: fit-content">Inspection:
										</h5>
									</div>

									<div class="col-md-10" style="margin-top: 1%;">
										<p id="InspectionShow" style="font-size: 18px;"></p>
									</div>

								</div>
																			<hr>
								<div class="row">
								<div class="col-md-2" style="margin-top: 1%">
										<h5
											style="font-size: 20px; color: #005086; width: fit-content">Special Methods:
										</h5>
									</div>

									<div class="col-md-10" style="margin-top: 1%;">
										<p id="specialshow" style="font-size: 18px;"></p>
									</div>

								</div>
								
		<%-- 						<%if(productTreeMainId.equalsIgnoreCase("0")){ %>
								<hr>
								<div class="row">
								<div class="col-md-2" style="margin-top: 1%">
										<h5
											style="font-size: 20px; color: #005086; width: fit-content">Linked SubSystem:
										</h5>
									</div>

									<div class="col-md-10" style="margin-top: 1%;">
										<p id="subsytemshow" style="font-size: 18px;"></p>
									</div>
								</div>
								<%} %> --%>
							</div> 

						
						</div>

					</div>
				</div>
			</div>
			
			
			
			<!-- requirement Adding Row -->
			
					<form  role="form" action="RequirementSubAdd.htm" method="POST" id="">
			<div class="row" id="row2" style="display:none;">
	
				
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-3">
										<label style="font-size: 17px; margin-top: 5%; color: #07689f">
											Linked Para
										</label>
									</div>
									<div class="col-md-7" style="margin-top: 1%;">
										<div class="form-group">
											<%if ((ProjectParaDetails != null) && (!ProjectParaDetails.isEmpty())) {%>
												<select class="form-control selectdee" name="LinkedPara" id="LinkedPara" data-width="80%" data-live-search="true" multiple onchange="getParaDetails()">
													<option value="" disabled="disabled">---Choose----</option>
													<%for (Object[] obj : ProjectParaDetails) {%>
														<option value="<%=obj[0]%>"><%=obj[3]%></option>
													<%}%>
												</select>
											<%} else {%>
												<input class="form-control" name="" id="LinkedPara"  readonly placeholder="No para specified for Project">
											<%} %>
										</div>
									</div>
								</div>
							</div>
						<div class="col-md-12">
						<div class="row mt-2">
						<div class="col-md-6 mt-2 mb-2">
										<label style="font-size: 17px;  color: #07689f">
											IS Derived?<span class="mandatory" style="color: red;">*</span>
										</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;&nbsp;<input name="derivedtype"  type="radio" value="Y" >&nbsp;&nbsp; YES&nbsp;&nbsp;
										&nbsp;&nbsp;<input name="derivedtype" type="radio" value="N" checked>&nbsp;&nbsp; NO&nbsp;&nbsp;
									</div>
							</div>
							</div>
							<div class="col-md-12">
								<div class="row mt-2">
									<div class=col-md-3>
										<label style="font-size: 17px; margin-top: 7%;  color: #07689f">
											Requirement Type:<span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-4">
										<select required="required"  class="form-control" data-width="100%" id="reqType" name="reqType" ></select>
									</div>
									<div class="col-md-6 mt-2 mb-2">
										<label style="font-size: 17px;  color: #07689f">
											Need Type<span class="mandatory" style="color: red;">*</span>
										</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;&nbsp;<input name="needtype"  type="radio" value="E" checked>&nbsp;&nbsp; Essential&nbsp;&nbsp;
										&nbsp;&nbsp;<input name="needtype" type="radio" value="D">&nbsp;&nbsp; Desirable&nbsp;&nbsp;
									</div>
								
								</div>
								
								<div class="row mt-2">
									<div class=col-md-3>
										<label style="font-size: 17px; margin-top: 7%;  color: #07689f;">
											Priority<span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class=col-md-2>
										<select id="priorityAdd" name="priority" class="form-control" data-width="80%" data-live-search="true" style="margin-top: 5%">
											<option disabled="disabled" value="" selected="selected">Choose..</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
										</select>
									</div>
									<div class=col-md-2>
										<label style="font-size: 17px; margin-top: 7%;  color: #07689f;float:right;">
											Criticality
										</label>
									</div>
									<div class=col-md-2>
										<select id="" name="criticality" class="form-control" data-width="80%" data-live-search="true" style="margin-top: 5%">
											<option disabled="disabled" value="" selected="selected">Choose..</option>
											<option value="Very Low">Very Low</option>
											<option value="Low">Low</option>
											<option value="Medium">Medium</option>
											<option value="High">High</option>
											<option value="Very High">Very High</option>
										</select>
									</div>
										
								</div>
							</div>
							
							<div class="col-md-12" style="margin-top: 1%">
								<div class="row">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Constraints :<span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-7">  
										<input type="text" class="form-control" name="Constraints" required maxlength="255" placeholder="max 255 characters">
									</div>
								</div>
							</div>
									
							<div class="col-md-12 mt-2">
								<div class="row mt-2">
									<div class="col-md-6">
										<label style="margin: 0px; font-size: 17px; color: #07689f">
											Requirement Description:<span class="mandatory" style="color: red;">*</span> 
										</label>
									</div>
								</div>
							</div>
							
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-12" id="textarea" style="">
										<div class="form-group">
										<div id="Editor" class="center"></div>
										</div>
								<textarea  name="description" style="display: none;" class="form-control" id="descriptionadds" maxlength="4000" rows="5" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
									</div>
								</div>
							</div>
									
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Demonstration:
										</label>
									</div>
									
									<div class="col-md-9" style="margin-top: 1%;">
										<div class="form-group">
											<select class="form-control selectdee" name="Demonstration" id="Demonstration" data-width="80%" data-live-search="true" multiple>
												<option value="" disabled="disabled">---Choose----</option>
												<!-- <option value="0">NA ( Not Applicable )</option> -->
												<%if((DemonstrationList!=null) &&(!DemonstrationList.isEmpty())){
													int count1=0;
													for(Object[] obj:DemonstrationList){ %>
														<option value="<%="D"+(++count1) %>" title=<%=obj[3] %>><%=obj[3]%></option>
													<%}%>
												<%}%>
											</select>
										</div>
									</div>
								</div>
							</div>
								
					
							<div class="col-md-12">
								<div class="row ">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Test Type:
										</label>
									</div>
									
									<div class="col-md-9" style="margin-top: 1%;">
										<div class="form-group">
											<select class="form-control selectdee" name="TestPlan" id="TestPlan" data-width="80%" data-live-search="true" multiple>
												<option value="" disabled="disabled">---Choose----</option>
												<!-- <option value="0">NA ( Not Applicable )</option> -->
												<%if((TestList!=null) &&(!TestList.isEmpty())){
													int count1=0;
													for(Object[] obj:TestList){ %>
														<option value="T<%=++count1 %>" title=<%=obj[3] %>><%=obj[3]%></option>
													<%}%>
												<%}%>
											</select>
										</div>
									</div>
									
								</div>
							</div>	
							
							<div class="col-md-12">
								<div class="row ">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Test Stage:
										</label>
									</div>
									
										<div class="col-md-9" style="margin-top: 1%;">
										<div class="form-group">
											<select class="form-control selectdee" name="TestStage" id="TestStageAdd" data-width="80%" data-live-search="true" >
												<option value="" disabled="disabled" selected>---Choose----</option>
												<!-- <option value="0">NA ( Not Applicable )</option> -->
												<option value="ATP">ATP</option>
												<option value="QTP">QTP</option>
												<option value="Verification">Verification</option>
												<option value="Validation">Validation</option>
												<option value="FAT">FAT</option>
												<option value="SITE">SITE</option>
												
											</select>
										</div>
									</div>
									</div>
									</div>
										
									
									
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Analysis:
										</label>
									</div>
									
									<div class="col-md-9" style="margin-top: 1%;">
										<div class="form-group">
											<select class="form-control selectdee" name="Analysis" id="Analysis" data-width="80%" data-live-search="true" multiple >
												<option value="" disabled="disabled">---Choose----</option>
												<!-- 	<option value="0">NA ( Not Applicable )</option> -->
												<%if((DesignList!=null) &&(!DesignList.isEmpty())){
													int count1=0;
													for(Object[] obj:DesignList){ %>
														<option value="A<%=++count1%>" title=<%=obj[3] %>><%=obj[3]%></option>
													<%}%>
												<%}%>
											</select>
										</div>
									</div>
									
								</div>
							</div>
									
						
							<div class="col-md-12">
								<div class="row ">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Inspection:
										</label>
									</div>
								
									<div class="col-md-9" style="margin-top: 1%;">
										<div class="form-group">
											<select class="form-control selectdee" name="Inspection" id="Inspection" data-width="80%" data-live-search="true" multiple>
												<option value="" disabled="disabled">---Choose----</option>
												<!-- <option value="0">NA ( Not Applicable )</option> -->
												<%if((InspectionList!=null) &&(!InspectionList.isEmpty())){
													int count1=0;
													for(Object[] obj:InspectionList){ %>
														<option value="I<%=++count1%>" title=<%=obj[3] %>><%=obj[3]%></option>
													<%}%>
												<%}%>
											</select>
										</div>
									</div>
									
									
								</div>
							</div>	
						
						
							<div class="col-md-12">
								<div class="row ">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Special Methods:
										</label>
									</div>
									
									<div class="col-md-9" style="margin-top: 1%;">
										<div class="form-group">
											<select class="form-control selectdee" name="specialMethods" id="specialMethods" data-width="80%" data-live-search="true" multiple onchange="checkValue('specialMethods')">
												<option value="" disabled="disabled">---Choose----</option>
												<!-- <option value="0">NA ( Not Applicable )</option> -->
												<%if((specialMethods!=null) &&(!specialMethods.isEmpty())){
													int count1=0;
													for(Object[] obj:specialMethods){ %>
														<option value="S<%=++count1%>" title=<%=obj[3] %>><%=obj[3]%></option>
													<%}%>
												<%}%>
											</select>
										</div>
									</div>
									
								</div>
							</div>
					<%-- 			<%if(productTreeMainId.equalsIgnoreCase("0")){ %>
								<div class="col-md-12">
								<div class="row">
									<div class="col-md-3">
										<label style="font-size: 17px; margin-top: 5%; color: #07689f">
											Linked subsystem
										</label>
									</div>
									<div class="col-md-7" style="margin-top: 1%;">
										<div class="form-group">
											<%if ((productTreeList != null) && (!productTreeList.isEmpty())) {%>
												<select class="form-control selectdee" name="LinkedSub" id="LinkedSub" data-width="80%" data-live-search="true" multiple >
													<option value="" disabled="disabled">---Choose----</option>
													<%for (Object[] obj : productTreeList) {%>
														<option value="<%=obj[0]%>"><%=obj[1]+" "+obj[2] %></option>
													<%}%>
												</select>
											<%} else {%>
												<input class="form-control" name="" id="LinkedSub"  readonly placeholder="No para specified for Project">
											<%} %>
										</div>
									</div>
								</div>
							</div>	
								<%} %> --%>
								
								
									
							<div class="col-md-12" style="margin-top: 1%">
								<div class="row">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Remarks :<span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-7">  
										<input type="text" class="form-control" name="remarks" required maxlength="255" placeholder="max 255 characters">
									</div>
								</div>
							</div>
						
							<div class="col-md-12" align="center" style="margin-top: 3%;">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<button type="submit" class="btn btn-primary btn-sm submit btn-req" id="add" name="action" value="SUBMIT" onclick="submitReq()">SUBMIT</button>
							<input type="hidden" name="projectId" value=<%=projectId %>>
							<input type="hidden" name="initiationId" value=<%=initiationId %>>
							<input type="hidden" name="project" value=<%=project %>>
							<input type="hidden" id="InitiationReqIdAdd" name="InitiationReqId" value="">
							<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
							<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
						</div>
			
			</div>
			</form>
			<!-- body for Edit  -->
			<form class="form-horizontal" role="form"action="RequirementUpdate.htm" method="POST" id="myform2">
			<div class="row" id="row3" style="display:none;">
							<div id="ReqTypeName" style="font-size: 1.5rem;margin-left: 10px;font-weight: 600;"></div>
								
						
									
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-3">
										<label style="font-size: 17px; margin-top: 5%; color: #07689f">
											Linked Para
										</label>
									</div>
									<div class="col-md-7" style="margin-top: 1%;">
										<div class="form-group">
											<%if ((ProjectParaDetails != null) && (!ProjectParaDetails.isEmpty())) {%>
												<select class="form-control selectdee" name="LinkedPara" id="LinkedParaEdit" data-width="80%" data-live-search="true" multiple onchange="getParaDetailsEdit()">
													<option value="" disabled="disabled">---Choose----</option>
													<%for (Object[] obj : ProjectParaDetails) {%>
														<option value="<%=obj[0]%>"><%=obj[3]%></option>
													<%}%>
												</select>
											<%} else {%>
												<input class="form-control" name=""id="LinkedParaEdit" readonly placeholder="No para specified for Project">
											<%} %>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-12">
						<div class="row mt-2">
						<div class="col-md-6 mt-2 mb-2">
										<label style="font-size: 17px;  color: #07689f">
											IS Derived?<span class="mandatory" style="color: red;">*</span>
										</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;&nbsp;<input name="derivedtype"  type="radio" value="Y" id="derivedY">&nbsp;&nbsp; YES&nbsp;&nbsp;
										&nbsp;&nbsp;<input name="derivedtype" type="radio" value="N"  id="derivedN">&nbsp;&nbsp; NO&nbsp;&nbsp;
									</div>
							</div>
							</div>
									<div class="col-md-12">
								<div class="row mt-2">
									<div class=col-md-3>
										<label style="font-size: 17px; margin-top: 7%;  color: #07689f">
											Requirement Type:<span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-4">
										<select required="required"  class="form-control" data-width="100%" id="reqTypeedit" name="reqType" ></select>
									</div>
									</div>
									</div>
							<div class="col-md-12">
								<div class="row">
									<div class=col-md-3>
										<label style="font-size: 17px; margin-top: 7%;  color: #07689f">
											Priority<span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class=col-md-3>
										<select id="priorityedit" name="priority" class="form-control" data-width="80%" data-live-search="true" style="margin-top: 5%">
											<option disabled="disabled" value="" selected="selected">Choose..</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
										</select>
									</div>
										
											
									<div class="col-md-4 mt-3">
										<label style="font-size: 17px;  color: #07689f">
											Need Type<span class="mandatory" style="color: red;">*</span>
										</label>
										&nbsp;&nbsp;<input name="needtype"  type="radio" value="E" id="essentialRadio">&nbsp;&nbsp; Essential&nbsp;&nbsp;
										&nbsp;&nbsp;<input name="needtype" type="radio" value="D" id="desirableRadio">&nbsp;&nbsp; Desirable&nbsp;&nbsp;
									</div>
										
								</div>
							</div>
									
							<div class="col-md-12">	
								<div class="row">
									<div class=col-md-3>
										<label style="font-size: 17px; margin-top: 7%;  color: #07689f;">
											Criticality<span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class=col-md-2>
										<select  name="criticality" id="criticalityedit" class="form-control" data-width="80%" data-live-search="true" style="margin-top: 5%">
											<option disabled="disabled" value="" selected="selected">Choose..</option>
											<option value="Very Low">Very Low</option>
											<option value="Low">Low</option>
											<option value="Medium">Medium</option>
											<option value="High">High</option>
											<option value="Very High">Very High</option>
										</select>
									</div>
								</div>
							</div>
									
							<div class="col-md-12" style="margin-top: 1%">
								<div class="row">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Constraints :<span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-7">  
										<input type="text" class="form-control" name="Constraints"  id="Constraintsedit" required maxlength="255" placeholder="max 255 characters">
									</div>
								</div>
							</div>
									
									
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-6">
										<label style="margin: 0px; font-size: 17px; color: #07689f">Requirement
											Description:<span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
								</div>
							</div>
							
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-12" id="textarea" style="">
										<div class="form-group">
											<div id="Editor1" class="center"></div>
										</div>
										<textarea  name="description" style="display: none;" class="form-control" id="descriptionedit" maxlength="4000" rows="5" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
									</div>
								</div>
							</div>
									
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Demonstration:
										</label>
									</div>
									
									<div class="col-md-7" style="margin-top: 1%;">
										<div class="form-group">
											<select class="form-control selectdee" name="Demonstration" id="Demonstrationedit" data-width="80%" data-live-search="true" multiple>
												<option value="" disabled="disabled">---Choose----</option>
													<!-- <option value="0">NA ( Not Applicable )</option> -->
												<%if((DemonstrationList!=null) &&(!DemonstrationList.isEmpty())){
													int count2=0;
													for(Object[] obj:DemonstrationList){ %>
													<option value="<%="D"+(++count2) %>" title=<%=obj[3] %>><%=obj[3]%></option>
													<%}%>
												<%}%>
											</select>
										</div>
									</div>
								</div>
							</div>
								
					
							<div class="col-md-12">
								<div class="row ">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Test Type:
										</label>
									</div>
									
									<div class="col-md-7" style="margin-top: 1%;">
										<div class="form-group">
											<select class="form-control selectdee" name="TestPlan" id="TestPlanedit" data-width="80%" data-live-search="true" multiple>
												<option value="" disabled="disabled">---Choose----</option>
													<!-- <option value="0">NA ( Not Applicable )</option> -->
												<%if((TestList!=null) &&(!TestList.isEmpty())){
													int count2=0;
													for(Object[] obj:TestList){ %>
														<option value="T<%=++count2 %>" title=<%=obj[3] %>><%=obj[3]%></option>
													<%}%>
												<%}%>
											</select>
										</div>
									</div>
								</div>
							</div>	
													<div class="col-md-12">
								<div class="row ">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Test Stage:
										</label>
									</div>
									
										<div class="col-md-9" style="margin-top: 1%;">
										<div class="form-group">
											<select class="form-control selectdee" name="TestStage" id="TestStageedit" data-width="80%" data-live-search="true" >
												<option value="" disabled="disabled">---Choose----</option>
												<!-- <option value="0">NA ( Not Applicable )</option> -->
													<option value="ATP">ATP</option>
												<option value="QTP">QTP</option>
												<option value="Verification">Verification</option>
												<option value="Validation">Validation</option>
												<option value="FAT">FAT</option>
												<option value="SITE">SITE</option>
											</select>
										</div>
									</div>
									</div>
									</div>	
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Analysis:
										</label>
									</div>
									
									<div class="col-md-7" style="margin-top: 1%;">
										<div class="form-group">
											<select class="form-control selectdee" name="Analysis" id="Analysisedit" data-width="80%" data-live-search="true" multiple>
												<option value="" disabled="disabled">---Choose----</option>
												<!-- 	<option value="0">NA ( Not Applicable )</option> -->
												<%if((DesignList!=null) &&(!DesignList.isEmpty())){
													int count2=0;
													for(Object[] obj:DesignList){ %>
														<option value="A<%=++count2%>" title=<%=obj[3] %>><%=obj[3]%></option>
													<%}%>
												<%}%>
											</select>
										</div>
									</div>
									
								</div>
							</div>
									
						
							<div class="col-md-12">
								<div class="row ">
									<div class="col-md-3">
									<label style="margin-top: 15px; font-size: 17px; color: #07689f">
										Inspection:
									</label>
									</div>
									
									<div class="col-md-7" style="margin-top: 1%;">
										<div class="form-group">
											<select class="form-control selectdee" name="Inspection" id="Inspectionedit" data-width="80%" data-live-search="true" multiple>
												<option value="" disabled="disabled">---Choose----</option>
												<!-- <option value="0">NA ( Not Applicable )</option> -->
												<%if((InspectionList!=null) &&(!InspectionList.isEmpty())){
													int count2=0;
													for(Object[] obj:InspectionList){ %>
														<option value="I<%=++count2%>" title=<%=obj[3] %>><%=obj[3]%></option>
													<%}%>
												<%}%>
											</select>
										</div>
									</div>
								</div>
							</div>	
						
							<div class="col-md-12">
								<div class="row ">
									<div class="col-md-3">
									<label style="margin-top: 15px; font-size: 17px; color: #07689f">
										Special Methods:
									</label>
									</div>
										<div class="col-md-7" style="margin-top: 1%;">
											<div class="form-group">
												<select class="form-control selectdee" name="specialMethods" id="specialMethodsedit" data-width="80%" data-live-search="true" multiple onchange="checkValue('specialMethods')">
													<option value="" disabled="disabled">---Choose----</option>
													<!-- <option value="0">NA ( Not Applicable )</option> -->
													<%if((specialMethods!=null) &&(!specialMethods.isEmpty())){
														int count2=0;
														for(Object[] obj:specialMethods){ %>
															<option value="S<%=++count2%>" title=<%=obj[3] %>><%=obj[3]%></option>
														<%}%>
											       <%}%>
												</select>
											</div>
										</div>
								</div>
							</div>
				<%-- 	<%
					if (productTreeMainId.equalsIgnoreCase("0")) {
					%>
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-3">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">
									Linked subsystem </label>
							</div>
							<div class="col-md-7" style="margin-top: 1%;">
								<div class="form-group">
									<%
									if ((productTreeList != null) && (!productTreeList.isEmpty())) {
									%>
									<select class="form-control selectdee" name="LinkedSub"
										id="LinkedSubedit" data-width="80%" data-live-search="true"
										multiple>
										<option value="" disabled="disabled">---Choose----</option>
										<%
										for (Object[] obj : productTreeList) {
										%>
										<option value="<%=obj[0]%>"><%=obj[1] + " " + obj[2]%></option>
										<%
										}
										%>
									</select>
									<%
									} else {
									%>
									<input class="form-control" name="" id="LinkedSub" readonly
										placeholder="No para specified for Project">
									<%
									}
									%>
								</div>
							</div>
						</div>
					</div>
					<%}%> --%>


					<div class=col-md-12>
								<div class="row">
									<div class="col-md-3">
										<label style="font-size: 17px; margin-top: 5%; color: #07689f; margin-left: 0.1rem">
											Remarks <span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-8" style="margin-top: 10px">
										<div class="form-group">
											<input type="text" name="remarks" class="form-control" id="remarksedit" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
										</div>
									</div>
								</div>
							</div> 
						
	
							
						<div class="col-md-12" align="center" style="margin-top: 3%;">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<button type="submit" class="btn btn-primary btn-sm edit btn-req" id="add" name="action" value="SUBMIT" onclick="updateReq()">UPDATE</button>
							<input type="hidden" name="projectId" value=<%=projectId %>>
							<input type="hidden" name="initiationId" value=<%=initiationId %>>
							<input type="hidden" name="project" value=<%=project %>>
							<input type="hidden" id="InitiationReqIdedit" name="InitiationReqId" value="">
							<input type="hidden" id="InitiationtempId" name="MainInitiationReqId" value="">
							<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
							<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
						</div>
						</div>
				</form>

			<%} %>		
								
		</div>
		
		
		<jsp:include page="../requirements/RequirementPdfs.jsp"></jsp:include></div>  
	</div>


	<!--  Modal for Selecting Requirements -->
	<form action="#" method="POST">	         	  	
  		<div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  			<div class="modal-dialog modal-dialog-jump" role="document">
    			<div class="modal-content mt-5" style="width:120%; margin-left:-10%;">
      				<div class="modal-header p-1 pl-3" style="background: #C4DDFF">
        				<h5 class="modal-title font-weight-bold" id="exampleModalLongTitle" style="color: #31708f">
        					Choose Requirements - 
        					<small>
								<%if(projectDetails!=null) {%>
									<%=projectDetails[2]!=null?projectDetails[2]:"-" %>
									(<%=projectDetails[1]!=null?projectDetails[1]:"-" %>)
								<%} %>
							</small>
        				</h5>
				        <button type="button" class="close text-danger mr-1" data-dismiss="modal" aria-label="Close">
				          <span class="font-weight-bolder" aria-hidden="true" style="opacity:1;">&times;</span>
				        </button>
      				</div>
         			<hr class="mt-2">
     				<%if(!requirementTypeList.isEmpty()){ %>
       					<div class="modal-body" style="display:flex;justify-content: center;align-items:center;">
       						<div>
    							<%for(Object[]obj:requirementTypeList){ %>
						       		<input name="ReqValue" type="checkbox" value="<%=obj[0].toString()+"/"+obj[1].toString()+"/"+obj[3].toString()%>">
						       		<input name="ReqNames" type="hidden" value="<%=obj[1].toString()%>">
						       		<span class="ml-1 mt-2 text-primary" style="font-weight: 600"><%=obj[1].toString() %></span><br>
       							<%}%>
       
						      	<!--  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
						  			ADD NEW
								</button> -->
       						</div>
    					</div>
   					<%}else{ %>
        				<div class="modal-body" style="display:flex;justify-content: center;align-items:center;">
       						<span class="text-primary">No system requirements to Add</span>
         				</div>
       				<%} %>
        				<div align="center" class="mb-2"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#staticBackdrop">ADD NEW</button></div>
    				<hr class="mb-2">
      				<div class="p-2" align="center">
	      			    <input type="hidden" name="project" value="<%=project%>">
		    			<input type="hidden" name="initiationId" value="<%=initiationId%>">
		    			<input type="hidden" name="projectId" value="<%=projectId%>">
		    			<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
		    			<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
        				<%if(!requirementTypeList.isEmpty()){ %>	
        					<button type="button" class="btn btn-sm btn-success submit btn-req" onclick="reqSubmit()">SUBMIT</button>
        				<%} %>
      				</div>
				</div>
			</div>
		</div>   	
	</form> 



	<!-- modal for Description Edit  -->

	<form class="form-horizontal" role="form" action="RequirementEdit.htm" method="POST" id="myform1">
		<div class="modal fade bd-example-modal-lg" id="AddReqModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-jump">
				<div class="modal-content addreq" style="width: 150%;">
					<div class="modal-header" id="modalreqheader">
						<h5 class="modal-title" id="exampleModalLabel">Requirements</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				
					<div class="modal-body">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-6">
									<label style="margin: 0px; font-size: 17px; color: #07689f">Requirement
										Description:<span class="mandatory" style="color: red;">*</span>
									</label>
								</div>
							</div>
						</div>
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12" id="textarea" style="">
									<div class="form-group">
										<textarea  name="description"
											class="form-control" id="descriptionadd" maxlength="4000"
											rows="5" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
									</div>
								</div>
							</div>
						</div>

		

							
						<div class="form-group" align="center" style="margin-top: 3%;">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<button type="submit" class="btn btn-primary btn-sm edit btn-req" id="add" name="action" value="SUBMIT" onclick="return confirm('Are you sure to submit?');">UPDATE</button>
							<input type="hidden" name="projectId" value=<%=projectId %>>
							<input type="hidden" name="initiationId" value=<%=initiationId %>>
							<input type="hidden" name="project" value=<%=project %>>
							<input type="hidden" id="InitiationReqId" name="InitiationReqId" value="">
							<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
							<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
						</div>
					</div>
				</div>
			</div>
		</div>

				<!-- </div> -->
		
	</form>


	<form action="RequirementAddList.htm" id="reqlist">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="projectId" value=<%=projectId %>>
		<input type="hidden" name="initiationId" value=<%=initiationId %>>
		<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
		<input type="hidden" name="project" value=<%=project %>>
		<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
		<input type="hidden" name="selectedValues" id="selectedValues" value="">
	</form>

<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel" style="font-weight:bold;">Add Requirement Type</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <label> Requirement Code:</label>
        <input type="text" class="form-control" name="ReqCode" id="ReqCode" maxlength="3">
        <br>
          <label> Requirement Name:</label>
        <input type="text" class="form-control" name="ReqCodeName" id="ReqCodeName" maxlength="250" placeholder="Max 250 Characters">
      </div>
      <div class="mt-2 mb-2">
        <div align="center"><button type="button" class="btn btn-sm submit" onclick="submitReqType()">submit</button></div>
       
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
function showdata(){
	$('#exampleModalLong').modal('show');
}
var productreelist = [];

<%if(productTreeList!= null &&  productTreeList.size()>0){ 
	for(Object[]obj:productTreeList){
	%>
	productreelist.push(['<%= obj[0].toString() %>', '<%= obj[2].toString() %>']);

<%}}%>



function reqSubmit(){
		var checkboxes = document.querySelectorAll('input[name="ReqValue"]');

		var selectedValues=[];
	    checkboxes.forEach(function(checkbox) {
	        // If checkbox is checked, add its value to the array
	        if (checkbox.checked) {
	        	
	            selectedValues.push(checkbox.value);
	        }
	    });
	    
	    $('#selectedValues').val(selectedValues.toString());
	    
	    $('#reqlist').submit();
	    <%-- $.ajax({
	    	url:'RequirementAddList.htm',
	    	datatype:'json',
	    	data:{
	    		projectId:<%=projectId%>,
	    		initiationId:<%=initiationId%>,
	    		productTreeMainId:<%=productTreeMainId%>,
	    		reqInitiationId:<%=reqInitiationId%>,
	    		selectedValues:selectedValues.toString(),
	    	},
	    	success:function (result){
	    		var ajaxresult = JSON.parse(result);
	    	
	    		
	    		if(ajaxresult>0){
	    			alert("Requirements Added successfully");
	    		}
	    		window.location.reload();
	    	}
			    	
	    	
	    	
	    }) --%>
	    
	    
	   
}

var isOpen=false;
var tempVal=0;
function showDetails(InitiationReqId,type){
	 $('.viewbtn').css("background","#055C9D"); 
	/* $('#'+InitiationReqId).css("background","green"); */
	
	$('#row1').show();
	$('#row2').hide();
	$('#row3').hide();
	$('#RemarksId').hide();
	if(tempVal!=InitiationReqId){
		isOpen=false;
		tempVal=InitiationReqId;

		
	}else{
		isOpen=true;
		tempVal=0;
	

	}
	
	
	if(!isOpen ){
	$('.subDiv').hide();
	$('#subDiv'+InitiationReqId).show();
	isOpen=true;
	
	}else{
		$('#subDiv'+InitiationReqId).hide();
		isOpen=false;
		
	}
	
	 
	var ReqMainId= $('#'+InitiationReqId).val();

	
	
	$.ajax({
			url:'RequirementJsonValue.htm',
			datatype:'json',
			data:{
				inititationReqId:InitiationReqId
			},
			success:function(result){
				 var ajaxresult=JSON.parse(result);
				$('#brief').html(ajaxresult[2]);
				$('#reqName').html("")
				if(ajaxresult[5]==null){
					$('#Prioritytext').html("-");
				}else{
				if(ajaxresult[5]==="L"){
					$('#Prioritytext').html("Low");
					 }else if(ajaxresult[5]==="M"){
							$('#Prioritytext').html("Medium"); 
					 }else{
						 $('#Prioritytext').html("High"); 
					 }
				}
				
				if(ajaxresult[8]==="E"){
					$('#needtypetext').html("Essential");
				}else if(ajaxresult[8]==="D"){
					$('#needtypetext').html("Deliverable");
				}else{
					$('#needtypetext').html("-");
				}
				if(ajaxresult[3]===null){
					$('#description').html("-");	
				}else {
					$('#description').html(ajaxresult[3]);
				}
				if(ajaxresult[9]!=null){
					$('#remarksshow').html(ajaxresult[9]);
				}else{
					$('#remarksshow').html("-");
				}
				
		$('#editreq').html('<button type="button"  class="btn btn-sm" onclick="edit('+ajaxresult[7]+')"  data-toggle="tooltip" data-placement="right" data-original-data="Tooltip on right" title="EDIT" name="action" value="'+ajaxresult[7] +'"id="reqbtns" ><i class="fa fa-pencil-square-o fa-lg" style="color:orange" aria-hidden="true"></i></button> ');
			}
		})
	$('#subDivs').hide();
	
}
var templengthEdit=0;
var map = new Map();
$('.viewbtn').click(function() {
    var subId = $(this).val().split("/")[0];
    var Id = $(this).val().split("/")[1];
    
    
    showDetailss(subId, Id);
});
function showDetailss(subId,Id){
	$('.viewbtn').css("background","#055C9D");
	$('#'+subId).css("background","green");
	/* $('#'+Id).css("background","green"); */
	$('#subDivs').show();
	$('#row1').show();
	$('#row2').hide();
	$('#row3').hide();
	$('#RemarksId').show();

	$.ajax({
		url:'RequirementJsonValue.htm',
		datatype:'json',
		data:{
			inititationReqId:subId
		},
		success:function(result){
			 var ajaxresult=JSON.parse(result);
			
			$('#brief').html(ajaxresult[2]+" (" +ajaxresult[4]+" )");
				$('#reqName').html("Requirement Id - "+ajaxresult[4])
			if(ajaxresult[5]!=null){
				$('#Prioritytext').html(ajaxresult[5]);
			}else{
				$('#Prioritytext').html("-");
			}
			
		
			if(ajaxresult[19]!=null){
				$('#CriticalityText').html(ajaxresult[19]);
			}else{
				$('#CriticalityText').html("-");
			}
			
			if(ajaxresult[9]!=null){
				$('#remarksshow').html(ajaxresult[9]);
			}else{
				$('#remarksshow').html("-");
			}
			
			
			if(ajaxresult[8]==="E"){
				$('#needtypetext').html("Essential");
			}else if(ajaxresult[8]==="D"){
				$('#needtypetext').html("Deliverable");
			}else{
				$('#needtypetext').html("-");
			}
			if(ajaxresult[3]===null){
				$('#description').html("-");	
			}else {
				$('#description').html(ajaxresult[3]);
			}
			if(ajaxresult[14]===null){
				$('#DemonstrationShow').html("-");	
			}else {
				$('#DemonstrationShow').html(ajaxresult[14]);
			}
			if(ajaxresult[15]===null){
				$('#testTypeshow').html("-");	
			}else {
				$('#testTypeshow').html(ajaxresult[15]);
			}
			if(ajaxresult[20]===null){
				$('#TestStageShow').html("-");	
			}else {
				$('#TestStageShow').html(ajaxresult[20]);
			}
			if(ajaxresult[16]===null){
				$('#AnalysisShow').html("-");	
			}else {
				$('#AnalysisShow').html(ajaxresult[16]);
			}
			if(ajaxresult[18]===null){
				$('#specialshow').html("-");	
			}else {
				$('#specialshow').html(ajaxresult[18]);
			}
			if(ajaxresult[17]===null){
				$('#InspectionShow').html("-");	
		
			}else {
				$('#InspectionShow').html(ajaxresult[17]);
			}

			
			var Linkesubsystem = "";
			
			var LinkedSubArray = [];
			
			if(ajaxresult[21]===null){
				LinkedSubArray = [];
			}else{
				LinkedSubArray = ajaxresult[21].split(", ");
			}
			if(LinkedSubArray.length==0){
				$('#subsytemshow').html("-");	
			
			}else{
				
				for(var i =0;i<LinkedSubArray.length;i++){
					for(var j=0;j< productreelist.length;j++){
						
						if(LinkedSubArray[i]===productreelist[j][0]){
							Linkesubsystem = Linkesubsystem+productreelist[j][1]+'<br>'
						}
						
					}
				}
				
				$('#subsytemshow').html(Linkesubsystem);	
			}
			
			
			
			
	$('#editreq').html('<button type="button"  class="btn btn-sm" onclick="edit1('+ajaxresult[7]+')"  data-toggle="tooltip" data-placement="right" data-original-data="Tooltip on right" title="EDIT" name="action" value="'+ajaxresult[7] +'"id="reqbtns" ><i class="fa fa-pencil-square-o fa-lg" style="color:orange" aria-hidden="true"></i></button>');
		
		var value = $('#'+Id).val();
		
		map = new Map();
		$.ajax({
			type:'GET',
			url:'RequirementMainJsonValue.htm',
			datatype:'json',
			data:{
				ReqMainId:value,
			},
			success:function(result){
				 var ajaxresult=JSON.parse(result);
			
		
				var html='<option disabled="disabled" value="" selected="selected">Choose..</option>';
				for(var i=0;i<ajaxresult.length;i++){
					
					map.set(ajaxresult[i][0]+"/"+ajaxresult[i][3]+"/"+ajaxresult[i][1], ajaxresult[i][3]);
					html=html+'<option value="'+ajaxresult[i][0]+"/"+ajaxresult[i][3]+"/"+ajaxresult[i][1]+'">'+ajaxresult[i][1]+'   ('+ajaxresult[i][3]+') </option>'
				}
				$('#reqTypeedit').html(html);
				
			}
		})
	
		}
	})
}


function edit(InitiationReqId){
	$('#AddReqModal').modal('show');
	$('#InitiationReqId').val(InitiationReqId);

	$.ajax({
			url:'RequirementJsonValue.htm',
			datatype:'json',
			data:{
				inititationReqId:InitiationReqId
			},
			success:function(result){
				 var ajaxresult=JSON.parse(result);
				
				 $('#descriptionadd').val(ajaxresult[3])
				 $('#needtypeadd').val(ajaxresult[8])
				 $('#priorityAdd').val(ajaxresult[5])
			}
		})
	
}

function edit1(InitiationReqId){
	$('#row3').show();
	$('#row1').hide();
	$('#row2').hide();


	$('#InitiationReqIdedit').val(InitiationReqId);
	$('#InitiationtempId').val(tempVal);
	
	$.ajax({
			url:'RequirementJsonValue.htm',
			datatype:'json',
			data:{
				inititationReqId:InitiationReqId
			},
			success:function(result){
				 var ajaxresult=JSON.parse(result);
					console.log("ajaxresult[22]-->"+ajaxresult[22])
				 $('#descriptionedit').val(ajaxresult[3])
				/*  CKEDITOR.instances['Editor1'].setData(ajaxresult[3]);
				 CKEDITOR.instances['Editor1'].setData(ajaxresult[3]); */
				   $('#Editor1').summernote('code', ajaxresult[3]);
				 $('#needtypeedit').val(ajaxresult[8])
				 $('#priorityedit').val(ajaxresult[5])
				 $('#remarksedit').val(ajaxresult[9])
				 $('#Constraintsedit').val(ajaxresult[12])
				 $('#criticalityedit').val(ajaxresult[19])
				 document.getElementById('ReqTypeName').innerHTML ="Requirement No.- "+ ajaxresult[4]
				 
				 if(ajaxresult[8]==="E"){
					 $('#essentialRadio').prop('checked', true);
				 }else if(ajaxresult[8]==="D"){
					  $('#desirableRadio').prop('checked', true);
				 }
				 if(ajaxresult[22]==="N"){
					 $('#derivedN').prop('checked', true);
				 }else if(ajaxresult[22]==="Y"){
					  $('#derivedY').prop('checked', true);
				 }
				
				 if(ajaxresult[13]!=null){
					 var para = ajaxresult[13].toString().split(", ");
					
					 $('#LinkedParaEdit').val(para).trigger('change');
				 }
				 if(ajaxresult[14]!=null){
					 var Demonstration = ajaxresult[14].toString().split(", ");
			
					 $('#Demonstrationedit').val(Demonstration).trigger('change');
				 }
				 
				 if(ajaxresult[15]!=null){
					 var test = ajaxresult[15].toString().split(", ");
				
					 $('#TestPlanedit').val(test).trigger('change');
				 }
				 if(ajaxresult[16]!=null){
					 var analysis = ajaxresult[16].toString().split(", ");
				
					 $('#Analysisedit').val(analysis).trigger('change');
				 }
				 if(ajaxresult[17]!=null){
					 var inspection = ajaxresult[17].toString().split(", ");
				
					 $('#Inspectionedit').val(inspection).trigger('change');
				 }
				 if(ajaxresult[18]!=null){
					 var methods = ajaxresult[18].toString().split(", ");
				
					 $('#specialMethodsedit').val(methods).trigger('change');
				 }
				 templengthEdit=$('#LinkedParaEdit').val().length
			 var reqtypeName ="";  
		      if(ajaxresult[4].split("_").length>=3){
		    	  reqtypeName=ajaxresult[4].split("_")[0]+"_"+ajaxresult[4].split("_")[1];
		      }else{
		    	  reqtypeName=ajaxresult[4].split("_")[0]
		      }
		        var matchingKey = null;
			
		        map.forEach((value, key) => {
		            if (value === reqtypeName) {
		                matchingKey = key;
		            }
		        });
		    	
		        if(ajaxresult[20]!=null){
					 $('#TestStageedit').val(ajaxresult[20]).trigger('change');
				}
		        
				$('#reqTypeedit').val(matchingKey)
		    
				var LinkedSubArray = [];
				
				if(ajaxresult[21]===null){
					LinkedSubArray = [];
				}else{
					
					LinkedSubArray = ajaxresult[21].split(", ");
					 $('#LinkedSubedit').val(LinkedSubArray).trigger('change');
				}
				
				
			}
		})

}





function openSubReqModal(ReqMainId,InitiationReqId){
	$('#row1').hide();
	$('#row2').show();
	$('#row3').hide();
	$.ajax({
		type:'GET',
		url:'RequirementMainJsonValue.htm',
		datatype:'json',
		data:{
			ReqMainId:ReqMainId,
		},
		success:function(result){
			 var ajaxresult=JSON.parse(result);
			
			var html='<option disabled="disabled" value="" selected="selected">Choose..</option>';
			for(var i=0;i<ajaxresult.length;i++){
				html=html+'<option value="'+ajaxresult[i][0]+"/"+ajaxresult[i][3]+"/"+ajaxresult[i][1]+'">'+ajaxresult[i][1]+'   ('+ajaxresult[i][3]+') </option>'
			}
			$('#reqType').html(html);
			
		}
	})
	
	$('#InitiationReqIdAdd').val(InitiationReqId);
	/* $('#subModal').modal('show'); */
}

function checkValue(value){
	
	
	
	
	/* var values = $('#'+value).val();
	
	var options =$("#"+value).find("option");
	
	
	if(values.length>0 && !values.includes("0")){
		
		$('#'+value).find("option:eq(1)").prop("disabled", true);
	}else{
		$('#'+value).find("option:eq(1)").prop("disabled", false);
	}
	
	if(values.length==1 && values.includes("0")){
		 $('#'+value).find("option").not(":selected").prop("disabled", true);
	}else{
		$('#'+value).find("option:eq(0)").prop("disabled", true);
		 $('#'+value).find("option").not(":selected").prop("disabled", false);
	}
	
	/* $(this).find("option").not(":selected").prop("disabled", naSelected); */
}
$(function () {
	$('[data-toggle="tooltip"]').tooltip()
	})

<%if(InitiationReqId!=null){%>
$( document ).ready(function() {
	showDetails(<%=InitiationReqId%>,'M')
});
<%}%>
<%if(InitiationReqId!=null && subId!=null){%>
$(document).ready(function() {
<%-- 	showDetails(<%=InitiationReqId%>,'M') --%>
	showDetailss(<%=subId%>,<%=InitiationReqId%>)
});
<%}%>


<%if(RequirementList==null || RequirementList.isEmpty()){%>
$( document ).ready(function() {
	showdata()
});
<%}%>
	$('#Editor').summernote({
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
$('#Editor1').summernote({
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
/* var editor_config = {
		toolbar : [
			
				{
					name : 'basicstyles',
					items : [ 'Bold', 'Italic', 'Underline', 'Strike',
							'RemoveFormat', 'Subscript', 'Superscript' ]
				},
			
				{
					name : 'paragraph',
					items : [ 'NumberedList', 'BulletedList', '-',
							'Outdent', 'Indent', '-', 'Blockquote' ]
				},
			
			
		

				{
					name : 'styles',
					items : [ 'Format', 'Font', 'FontSize' ]
				},
				{
					name : 'colors',
					items : [ 'TextColor', 'BGColor', 'CopyFormatting' ]
				},
				{
					name : 'align',
					items : [ 'JustifyLeft', 'JustifyCenter',
							'JustifyRight', 'JustifyBlock' ]
				} ],

		removeButtons : 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

		customConfig : '',

		disallowedContent : 'img{width,height,float}',
		extraAllowedContent : 'img[width,height,align]',

		height : 280,

		contentsCss : [ CKEDITOR.basePath + 'mystyles.css' ],

		bodyClass : 'document-editor',

		format_tags : 'p;h1;h2;h3;pre',

		removeDialogTabs : 'image:advanced;link:advanced',

		stylesSet : [

		{
			name : 'Marker',
			element : 'span',
			attributes : {
				'class' : 'marker'
			}
		}, {
			name : 'Cited Work',
			element : 'cite'
		}, {
			name : 'Inline Quotation',
			element : 'q'
		},

		{
			name : 'Special Container',
			element : 'div',
			styles : {
				padding : '5px 10px',
				background : '#eee',
				border : '1px solid #ccc'
			}
		}, {
			name : 'Compact table',
			element : 'table',
			attributes : {
				cellpadding : '5',
				cellspacing : '0',
				border : '1',
				bordercolor : '#ccc'
			},
			styles : {
				'border-collapse' : 'collapse'
			}
		}, {
			name : 'Borderless Table',
			element : 'table',
			styles : {
				'border-style' : 'hidden',
				'background-color' : '#E6E6FA'
			}
		}, {
			name : 'Square Bulleted List',
			element : 'ul',
			styles : {
				'list-style-type' : 'square'
			}
		}, {
			filebrowserUploadUrl : '/path/to/upload-handler'
		}, ],
	    enterMode: CKEDITOR.ENTER_BR,
	    shiftEnterMode: CKEDITOR.ENTER_P,
	    on: {
	        instanceReady: function() {
	            this.dataProcessor.htmlFilter.addRules({
	                elements: {
	                    p: function(element) {
	                        if (element.children.length == 1 && element.children[0].name == 'br') {
	                            return false;
	                        }
	                    }
	                }
	            });
	        }
	    }
	};

CKEDITOR.replace('Editor', editor_config);
CKEDITOR.replace('Editor1', editor_config); */
var list=[];
$( document ).ready(function() {

	   $.ajax({
        type: 'GET',
        url: 'RequirementParaDetails.htm',
        datatype: 'json',
        data: {
            reqInitiationId: <%=reqInitiationId%>,
        },
        success: function(result) {
            list = JSON.parse(result);
        }
    });
	   
});


var templength=0;
var currentLength =0;
function getParaDetails(){

	  var selectedOptions=$('#LinkedPara').val()
	   
	   var html="";
   for (var j = 0; j < selectedOptions.length; j++) {
		 for(var i=0;i<list.length;i++){
			 if(list[i][0]==selectedOptions[j]){
				 
				 html=html+ '<span style="font-weight:600;font-size:1rem;"> ' +list[i][3]+'</span> - ' +list[i][4]+'<br>'
			 }
		 }
		     
	} 

  /*  CKEDITOR.instances['Editor'].setData(html);
	var data =  CKEDITOR.instances['Editor'].getData(); */
	   $('#Editor').summernote('code', html);
	$('#descriptionadds').val($('#Editor').summernote('code'))
}

function getParaDetailsEdit(){
	
	
	var curLength = $('#LinkedParaEdit').val().length;
	
	
	
	if(curLength>templengthEdit){
		 $.ajax({
			   type:'GET',
				url:'RequirementParaDetails.htm',
				datatype:'json',
				data:{
					reqInitiationId:<%=reqInitiationId%>,
				},
				success:function(result){
					var ajaxresult=JSON.parse(result);
				/* 
					var html="";
					for(var i=0;i<ajaxresult.length;i++){
						if(ajaxresult[i][0]==latestSelectedValue && ajaxresult[i][4]!=null){
							html=ajaxresult[i][4];
							html=currentLength+"."+html+'<br>'
						}
					}
					
					var editorData = CKEDITOR.instances['Editor1'].getData();
					CKEDITOR.instances['Editor1'].setData(editorData+html);
					var data =CKEDITOR.instances['Editor'1].getData();
					
					$('#descriptionedit').val(data); */
			
				}
				
			
		   })
	}
}


function submitReq(){
/* 	var data =CKEDITOR.instances['Editor'].getData(); */
	
	$('#descriptionadds').val($('#Editor').summernote('code'));
	
	if(confirm('Are you sure to submit?')){
		
	}else{
		event.preventDefault();
		return false;
	}
}


function updateReq(){
/* 	var data =CKEDITOR.instances['Editor1'].getData(); */
	$('#descriptionedit').val($('#Editor1').summernote('code'));
	if(confirm('Are you sure to submit?')){
		
	}else{
		event.preventDefault();
		return false;
	}
}


function submitReqType(){
	var ReqCode = $('#ReqCode').val().trim();
	
	var ReqCodeName = $('#ReqCodeName').val().trim();
	
	
	if(ReqCode.length==0||ReqCodeName.length==0){
		alert("Please fill all the Details !")
	}else{
		if(confirm('Are you sure to submit?')){
			$.ajax({
				type:'GET',
				url:'AddReqType.htm',
				datatype:'json',
				data:{
					ReqCode:ReqCode,
					ReqCodeName:ReqCodeName,
				},
				success:function(result){
					
					if(Number(JSON.parse(result))>0){
						alert("Requirement Type Added successfully.")
					}
					location.reload();
				}
			})
			
			
			
		}else{
			event.preventDefault();
			return false;
		}
	}
}

function deleteReq(a){

	if(confirm('Are you sure to delete?')){
		$.ajax({
			type:'GET',
			url:'deleteInitiationReq.htm',
			datatype:'json',
			data:{
				InitiationReqId:a,
			},
			success:function(result){
				
				var ajaxresult = JSON.parse(result);
				
				if(Number(ajaxresult)>0){
					alert("Requirement Deleted Successfully!")
				}
				window.location.reload();
			}
			
		})
		
	}else{
		event.preventDefault();
		return false;
	}
}

function showVerificationMaster(){
	$('#verificationMaster').click();
}

var RequirementMainList = [];
<%
if(RequirementMainList!=null && RequirementMainList.size()>0){
for(Object[]obj:RequirementMainList){
%>
RequirementMainList.push(['<%=obj[0].toString()%>','<%=obj[1].toString()%>','<%=obj[4]%>'])
<%} }%>

function getReqDetails(){
	
	  var selectedOptions=$('#LinkedPara').val()
	   
	   var html="";
  for (var j = 0; j < selectedOptions.length; j++) {
		 for(var i=0;i<RequirementMainList.length;i++){
			 if(RequirementMainList[i][0]==selectedOptions[j]){
				 var data=  RequirementMainList[i][2];
				 console.log(typeof data+data)
				 if(data!=='null'){
					 html=html+ '<span style="font-weight:600;font-size:1rem;">' +RequirementMainList[i][1]+'</span> - '  +RequirementMainList[i][2]+'\n'
				 }
				 
			 }
		 }
		     
	} 

 /*  CKEDITOR.instances['Editor'].setData(html);
	var data =  CKEDITOR.instances['Editor'].getData(); */
	   $('#Editor').summernote('code', html);
	$('#descriptionadds').val($('#Editor').summernote('code'))
}


</script>

</body>
</html>