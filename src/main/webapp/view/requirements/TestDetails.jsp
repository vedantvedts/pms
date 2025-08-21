<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.requirements.model.TestPlanMaster"%>
<%@page import="com.vts.pfms.requirements.model.TestSetupMaster"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.util.stream.Collectors"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PMS</title>

<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
<spring:url value="/resources/css/sweetalert2.min.css" var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
	<link href="${sweetalertCss}" rel="stylesheet" />
	<script src="${sweetalertJs}"></script>

<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />

<spring:url value="/resources/pdfmake/pdfmake.min.js" var="pdfmake" />
<script src="${pdfmake}"></script>
<spring:url value="/resources/pdfmake/vfs_fonts.js" var="pdfmakefont" />
<script src="${pdfmakefont}"></script>
<spring:url value="/resources/pdfmake/htmltopdf.js" var="htmltopdf" />
<script src="${htmltopdf}"></script>
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
.multiselect-view>li>a>label {
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
	width: 10%;
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
	width: 100%;
	margin-top: 4%;
	background: #055C9D;
	font-size: 13px;
	font-family: font-family : 'Muli';
}

/* .viewbtn:hover {
	cursor: pointer !important;
	background-color: #22c8e5 !important;
	border: none !important;
	box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0
		rgba(0, 0, 0, 0.19) !important;
} */

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

#view {
	background-color: white;
	display: inline-block;
	margin-left: 2%;
	margin-top: 1%;
	box-shadow: 8px 8px 5px lightgrey;
	max-width: 85%;
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

#reqName {
	font-size: 20px;
	background: #f5f5dc;
	font-family: inherit;
	color: darkslategrey;
	font-weight: 500;
	display: flex;
	border-radius: 8px;
	align-items: center;
	box-shadow: 4px 4px 4px gray;
}
#reqName1 {
	font-size: 20px;
	background: #f5f5dc;
	font-family: inherit;
	color: darkslategrey;
	font-weight: 500;
	display: flex;
	border-radius: 8px;
	align-items: center;
	box-shadow: 4px 4px 4px gray;
	margin-bottom: 20px;
}

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

#SafetyRequirements li{
list-style-type: decimal;
margin-left: -21px;
}
#PostConditionsView li{
list-style-type: decimal;
margin-left: -21px;
}
#PreConditionsView li{
margin-left: -21px;
list-style-type: decimal;
}
#PersonnelResourcesView li{
list-style-type: decimal;
margin-left: -21px;
}
</style>
</head>
<%
	String initiationId = (String)request.getAttribute("initiationId");
	String projectId = (String)request.getAttribute("projectId");
	String productTreeMainId = (String)request.getAttribute("productTreeMainId");
	String testPlanInitiationId = (String)request.getAttribute("testPlanInitiationId");

 	List<Object[]>TestDetailsList=(List<Object[]>)request.getAttribute("TestDetailsList");
 	
 	
	Object[] DocTempAtrr = (Object[])request.getAttribute("DocTempAttributes");
	Object[]LabList=(Object[])request.getAttribute("LabList");
	String lablogo = (String)request.getAttribute("lablogo");
	String drdologo = (String)request.getAttribute("drdologo");

 	
 	List<Object[]>TestTypeList=(List<Object[]>)request.getAttribute("TestTypeList");
 	String TestReqId=(String)request.getAttribute("TestReqId");
 	List<Object[]>StagesApplicable=(List<Object[]>)request.getAttribute("StagesApplicable");
 	List<Object[]>VerificationMethodList = (List<Object[]>)request.getAttribute("VerificationMethodList");
 	List<Object[]>DemonstrationList = new ArrayList<>();
 	DemonstrationList = VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("1")).collect(Collectors.toList());
	ObjectMapper objectMapper = new ObjectMapper();
	String jsonArray = objectMapper.writeValueAsString(StagesApplicable);
	String jsonArrayTestTool =objectMapper.writeValueAsString(TestTypeList);
	
	List<Object[]> specificationList = (List<Object[]>)request.getAttribute("specificationList");
	//List<Object[]> TestPlanMasterList = (List<Object[]>)request.getAttribute("TestPlanMasterList");
	List<TestPlanMaster>TestPlanMasterList=(List<TestPlanMaster>)request.getAttribute("TestPlanMasterList");
	
	if(!TestPlanMasterList.isEmpty()){
		List<String>presentMainIds = presentMainIds = TestDetailsList.stream().filter(e->e[24]!=null).map(e->e[24].toString())
				.collect(Collectors.toList());
		TestPlanMasterList = TestPlanMasterList.stream().
				filter(e->!presentMainIds.contains(e.getTestMasterId()+"")).collect(Collectors.toList());
	}
	
	/* if(specificationList!=null && specificationList.size()>0){
		specificationList=specificationList.stream().filter(e->!e[7].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
	} */
	Integer nextCount=0;
	if(TestDetailsList!=null && TestDetailsList.size()>0){
		
		nextCount=Integer.parseInt(TestDetailsList.get(TestDetailsList.size()-1)[1].toString().substring(4)); 
	}
	
	Object[] projectDetails = (Object[]) request.getAttribute("projectDetails");
	
	List<TestSetupMaster>master = (List<TestSetupMaster>)request.getAttribute("testSetupMasterMaster");
%>

<body style="background-color: white;">

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

	<%if(TestDetailsList==null ) {%>
		<div
			style="margin-top: 20%; display: flex; justify-content: center; align-items: center;">
			<h3>No Data Available!</h3>
		</div>
	<%}else{ %>
		<div id="reqmain" class="card-slider">
		
			<div class="container-fluid" style="display: none;" id="main">
				<div class="row">
					<div class="col-md-12">
						<div class="card shadow-nohover" style="margin-top: -0px;">
							<div class="row card-header"
								style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
								<div class="col-md-7" id="projecthead">
									<h5 style="margin-left: 1%;">
										Test Details - 
										<small>
											<%if(projectDetails!=null) {%>
												<%=projectDetails[2]!=null?StringEscapeUtils.escapeHtml4(projectDetails[2].toString()):"-" %>
												(<%=projectDetails[1]!=null?StringEscapeUtils.escapeHtml4(projectDetails[1].toString()):"-" %>)
											<%} %>
										</small>
									</h5>
								</div>
								<%if(TestPlanMasterList!=null && TestPlanMasterList.size()>0){ %>
								<div class="col-md-2">
								<button class="btn btn-sm submit" type="button" style="margin-top: -3%;" onclick="showMasterModal()">TESTPLAN MASTER</button>
								</div>
								<%} %>
								<div class="col-md-3" id="addReqButton">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
									<input type="hidden" name="projectId" value="<%=projectId%>">
									<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
									<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
									<input type="hidden" name="testPlanInitiationId" value="<%=testPlanInitiationId%>">	
									<form action="#">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
										<input type="hidden" name="projectId" value="<%=projectId%>">
										<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
										<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
										<input type="hidden" name="testPlanInitiationId" value="<%=testPlanInitiationId%>">	
										<button class="btn btn-success btn-sm submit" style="margin-top: -3%;"
											type="button" onclick='showdata("Add")' data-toggle="tooltip"
											data-placement="top" data-original-data=""
											title="ADD TEST DETAILS">ADD TEST DETAILS</button>
										<button class="btn btn-info btn-sm  back ml-2"
											formaction="ProjectTestPlanDetails.htm" formmethod="get"
											formnovalidate="formnovalidate" style="margin-top: -3%;">BACK</button>
									</form>
									
									
								</div>
					
							</div>
						</div>
					</div>
				
				</div>
					<%if((TestDetailsList!=null) &&(!TestDetailsList.isEmpty())){ %>
								<div class="row">
								<div class="col-md-6"></div>
								<div class="col-md-6 mt-2 mb-2"  style="display: flex;">
									<div style="font-size: 20px; color: #005086; width: 100%;text-align: right;font-weight: 600">Stage PDF:</div>&nbsp;&nbsp;
									<select required="required"
												class="form-control selectItem StageApplicableEdit" name=""
												id="StageApplicablePDF" data-width="100%"
												data-live-search="true" data-placeholder="Choose" onchange="createTestStagePDF(this)">
													<option val="" selected disabled>Choose...</option>
													<%for (Object[] obj : StagesApplicable) {%>
													<option value="<%=obj[3]%>"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%></option>
													<%}%>
											</select>
								</div>
								</div>
							<%} %>
				
				<div class="row">
					<div class="col-md-2" >
						<%if((TestDetailsList!=null) &&(!TestDetailsList.isEmpty())){ %>
							<div class="cardbody" id="" style="display:block;<%if(TestDetailsList.size()>9){%>height:1000px;overflow-y:auto;<%}%>background:antiquewhite;padding:5px">
								<%int count=1;
									for(Object []obj:TestDetailsList) {%>
										<button type="button" style="width:80%" class="btn btn-primary viewbtn mt-2" id="Test<%=obj[0] %>" value="<%=obj[0]%>" onclick="TestDetailsShow('<%=obj[0]%>')">
											<span style="font-weight: bold;;"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></span>
										</button>
								<button class="btn btn-sm mt-2 " onclick="deleteTestPlan(<%=obj[0].toString()%>)">
							<i class="fa fa-trash" aria-hidden="true" style="color:red;"></i>
							</button>
										<!-- <button></button> -->
									<%count++;} %>
							</div>
						<%} else{%>
							<script type="text/javascript">
				             
	            			</script>
	            			<button type="button" class="btn btn-secondary viewbtn mt-2">
								<span style="font-weight: bold;;">No Data</span>
							</button>
	           				
						<%} %>
					</div>
					<div class="col-md-10">
						<div class="card">
							<div class="card-body mt-2" id="cardbody">
								<div id="viewcard">
									<div class="row">
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-12">
													<div class="row">
														<div class="col-md-2" id="reqName"></div>
														<div class="col-md-10" style="" id="editreq"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Spec ID:</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="specidview" style="font-size: 17px;"></p>
												</div>
											</div>
											<hr>
										</div>
										<div class="col-md-12">
											<div class="row">
										<div class="col-md-3" style="margin-top: 1%">
											<h5 style="font-size: 20px; color: #005086; width: fit-content">Test Name</h5>
										</div>
										<div class="col-md-2" style="margin-top: 1%">
											<p id="name" style="font-size: 17px;"></p>
										</div>
										</div>
											<hr>
										</div>
											<div class="col-md-12">
											<div class="row">
										<div class="col-md-3" style="margin-top: 1%">
											<h5 style="font-size: 20px; color: #005086; width: fit-content">Objective</h5>
										</div>
										<div class="col-md-4" style="margin-top: 1%">
											<p id="Objective" style="font-size: 17px;"></p>
										</div> 
										</div>
										<hr>
										</div>
										<!-- category -->
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Description:</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="Description" style="font-size: 17x;"></p>
												</div>
											</div>
											<hr>
										</div>
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Pre-Conditions:</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
												<div id="PreConditionsView" style="font-size: 17px;">
													</div>
												</div>
											</div>
											<hr>
										</div>
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Post-Conditions:</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<div id="PostConditionsView" style="font-size: 17px;">
													
													</div>
												</div>
											</div>
											<hr>
										</div>
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Constraints:</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="Constraints" style="font-size: 17px;"></p>
												</div>
											</div>
											<hr>
										</div>
								
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Safety Requirements:</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="SafetyRequirements" style="font-size: 17px;"></p>
												</div>
											</div>
											<hr>
										</div>
						
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Methodology:</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="Methodology" style="font-size: 17px;"></p>
												</div>
											</div>
											<hr>
										</div>
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Test Setup:</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="ToolsSetupView" style="font-size: 17px;"></p>
												</div>
											</div>
											<hr>
										</div>
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Personnel Resources:</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="PersonnelResourcesView" style="font-size: 17px;"></p>
												</div>
											</div>
											<hr>
										</div>
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Estimated Time / Iteration:</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="EstimatedTimeIteration" style="font-size: 17px;"></p>
												</div>
											</div>
											<hr>
										</div>
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Iterations</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="Iterations" style="font-size: 17px;"></p>
												</div>
											</div>
											<hr>
										</div>
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Schedule</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="Schedule" style="font-size: 17px;"></p>
												</div>
											</div>
											<hr>
										</div>
					
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Pass Fail Criteria</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="PassFailCriteria" style="font-size: 17px;"></p>
												</div>
											</div>
											<hr>
										</div>
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5 style="font-size: 20px; color: #005086; width: fit-content">Stage Applicable</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="StageApplicableView" style="font-size: 17px;"></p>
												</div>
											</div>
											<hr>
										</div>
										
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-3" style="margin-top: 1%">
													<h5
														style="font-size: 20px; color: #005086; width: fit-content">Remarks:</h5>
												</div>
												<div class="col-md-9" style="margin-top: 1%;">
													<p id="Remarks" style="font-size: 17px;"></p>
												</div>
											</div>
											<hr>
										</div>
								
									</div>
								</div>
								<button onclick="scrollToTop()" id="scrollButton" data-toggle="tooltip" data-placement="top" data-original-data="" title="Go to Top">
									<i class="fa fa-arrow-up" aria-hidden="true"></i>
								</button>
									
								
								<!--*********************** TEST add **************************-->
			
								<div id="AddTestDetails">
									<form class="form-horizontal" role="form" action="TestDetailsAddSubmit.htm" method="POST" id="myform1">
										<div class="row">
											<div class="col-md-12">
												<div class="form-group row">
													<div class="col-md-1">
														<label style="font-size: 17px;color: #07689f">
															Spec ID <span class="mandatory" style="color: red;"></span>
														</label>
													</div>
									
													<div class="col-md-4">
														<%if ((specificationList != null) && specificationList.size()>0 ) {
														
														%>
															<select required="required" class="form-control selectdee" name="SpecId" id="select" data-width="80%" data-live-search="true" multiple onchange="onchangeSpec()">
																<option value="" disabled="disabled">---Choose----</option>
																<%for (Object[] obj : specificationList) {%>
																	<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
																<%}%>
															</select>
														<%} else {%>
															<input class="form-control" name="" id="linkedRequirements"  readonly placeholder="No requirements specified for Project">
														<%} %>
													</div>
													
												
														
													<div class="col-md-2">
														<label style="font-size: 17px;  margin-left: 0.1rem; color: #07689f">Test Name<span	class="mandatory" style="color: red;">*</span></label>
													</div>
													<div class="col-md-5">
														<input type="text" name="name" class="form-control"id="NameAdd" maxlength="255" required="required" placeholder="Maximum 250 Chararcters" >
													</div>
													
												</div>
										
			
										
										
												<div class="form-group row">
													<div class="col-md-6">
														<div class="row">
															<div class="col-md-2">
																<label style="font-size: 17px; color: #07689f">
																	Objective <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-10">
																<input type="text" name="Objective" class="form-control" id="ObjectiveAdd" maxlength="255" required="required" placeholder="Maximum 250 Chararcters" style="line-height: 3rem !important">
															</div>
														</div>
													</div>
									
													<div class="col-md-6">
														<div class="row">
															<div class="col-md-2">
																<label style="font-size: 17px; color: #07689f;">
																	Description <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-10" style="">
																<div class="form-group">
																	<div id="descriptioneditor" class="center">
														</div>
													<textarea name="Description"  id="DescriptionAdd" style="display: none;"></textarea>
																</div>
															</div>
														</div>
													</div>	
												</div>
												
												<div class="form-group row">
													<div class="col-md-6">
														<div class="row">
															<div class="col-md-2">
																<label style="font-size: 17px;color: #07689f;width: 120%;">
																		Methodology <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-10" style="">
																<select class="form-control selectdee" name="Methodology" id="MethodologyAdd" data-width="100%" data-placeholder="Select Methodology" data-live-search="true"   required onchange="AddData('1',this)">
																	<option value="" disabled="disabled">---Choose----</option>
																	<option value="" disabled="disabled" selected="selected">SELECT</option>
																	<option value="D" >Demonstration</option>
																	<option value="T" >Test</option>
																	<option value="A" >Analysis/Design</option>
																	<option value="I">Inspection</option>
																	<option value="S" >Special Verification Methods </option>
																	<!-- <option value="0">ADD NEW</option> -->
																</select>
															</div>
														</div>
													</div>
												
													<div class="col-md-6">
														<div class="row">
															<div class="col-md-2">
																<label style="font-size: 17px; color: #07689f;">
																	Test-Setup <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-10">
																<select class="form-control selectdee" id="select1" name="ToolsSetup" onchange="AddTestSetUp('select1')" data-width="100%"
																	data-live-search="true" style=""  data-placeholder="Choose"  required="required">
																	<!-- <option disabled="disabled" value="" selected="selected">Choose..</option> -->
																	<option value="" >---Choose----</option>
																	<%for (TestSetupMaster t :master) {%>
																<option value="<%=t.getSetupId()%>"   ><%=t.getTestSetUpId()!=null?StringEscapeUtils.escapeHtml4(t.getTestSetUpId()): " - " %></option>
																	<%} %>
																	
																</select>
															</div>
														</div>
													</div>
												</div>	
													
												<div class="form-group row">
													<div class="col-md-6">
														<div class="row">
															<div class="col-md-2">
																<label
																	style="font-size: 17px; color: #07689f;">
																	Constraints <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-10" style="">
																<input type="text" name="Constraints" class="form-control" id="ConstraintsAdd" maxlength="255" required placeholder="Maximum 250 Chararcters">
															</div>
														</div>
													</div>
													
													<div class="col-md-6">
														<div class="row">
														
															
															<div class="col-md-3">
																<label style="font-size: 17px;color: #07689f;">
																	Schedule <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-9" style="">
																<input type="text" name="Schedule" class="form-control" id="ScheduleAdd" maxlength="255" required="required" min="1">
															</div>
														</div>
													</div>
												</div>
									
												<div class="form-group row">	
													<div class="col-md-6">
														<div class="row">
															<div class="col-md-2">
																<label style="font-size: 17px;color: #07689f;">
																	Iterations <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-10" style="">
																<input type="text" name="Iterations" class="form-control" id="IterationsAdd" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
															</div>
														</div>
													</div>
									
													<div class="col-md-6">
														<div class="row">
																<div class="col-md-2">
																<label style="font-size: 17px;color: #07689f;">
																	Est Time <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-2" style="">
																<input type="text" name="EstimatedTimeIteration" class="form-control" id="EstimatedTimeIterationAdd" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
															</div>
															<div class="col-md-4" style="">
															<select class="form-control" required="required" name="timeType">
															<option value="" selected  disabled="disabled">SELECT</option>
															<option value="D">Day</option>
															<option value="M">Minute</option>
															<option value="H">Hour</option>
															
															</select>
															</div>
														</div>
													</div>
												</div>
										
												<div class="form-group row">
													<div class="col-md-6">
														<div class="row">
															<div class="col-md-2">
																<label style="font-size: 17px; color: #07689f;">
																	Criteria <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-10" style="">
																<input type="text" name="PassFailCriteria" class="form-control" id="PassFailCriteriaAdd" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
															</div>
														</div>
													</div>		
										
											<%-- 		<div class="col-md-6">
														<div class="row">
															<div class="col-md-2">
																<label style="font-size: 17px;color: #07689f;">
																	Stage <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-10" style="">
				
																<%if(!StagesApplicable.isEmpty()){ %>
																	<select required="required" class="form-control selectdee"	name="StageApplicable" id="StageApplicable"	data-width="100%" data-live-search="true" data-placeholder="Choose" multiple>
																		<%for(Object[] obj:StagesApplicable){ %>
																		<option value="<%=obj[0]%>"><%=obj[3]%></option>
																		<%}%>
																	</select>
																<%} else{%>
																	<input class="form-control" readonly name="StageApplicable" id="StageApplicable" placeholder="No files found">
																<%} %>
																
															</div>
														</div>
													</div> --%>
												</div>
												
												<div class="form-group row">
													<div class="col-md-6">
														<label style="font-size: 17px; color: #07689f">
															Pre Conditions <span class="mandatory" style="color: red;">*</span>
														</label>
														
														<div id="EditorPreConditions" class="center">
															
														</div>
														<textarea name="PreConditions"  id="PreConditionsAdd" style="display: none" ></textarea>
													</div>
													
													<div class="col-md-6" id="textarea" style="">
														<label style="font-size: 17px; color: #07689f">
															Post Conditions <span class="mandatory" style="color: red;">*</span>
														</label>
														<div id="EditorPostConditions" class="center">
														
														</div>
															<textarea name="PostConditions"  id="PostConditionsAdd" style="display: none;"></textarea>
													</div>
												</div>
												
												<div class="form-group row">
													<div class="col-md-6">
														<label style="font-size: 17px;color: #07689f;">
															Safety Requirements <span class="mandatory" style="color: red;">*</span>
														</label>

														<div id="EditorSafetyReq" class="center">
															
														</div>
														<textarea name="SafetyReq"  id="SafetyReqAdd" style="display: none;"></textarea>
													</div>	
													
													<div class="col-md-6">
														<label style="font-size: 17px;color: #07689f;">
															Personnel Resources <span class="mandatory" style="color: red;">*</span>
														</label>
															
														<div id="EditorPersonnelResources" class="center">
														</div>
													<textarea name="PersonnelResources"  id="PersonnelResourcesAdd" style="display:none;"></textarea>
														
													</div>											
												</div>	
												
												<div class="form-group row">
													<div class="col-md-6">
														<div class="row">
															<div class="col-md-2">
																<label
																	style="font-size: 17px;color: #07689f;">
																	Remarks <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-10" style="">
																<input type="text" name="remarks" class="form-control" id="remarksAdd" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
															</div>
														</div>
													</div>
													<div class="col-md-6">
														<table class="table table-bordered">
									<thead style=" background: #055C9D; color: white;">
										<tr>
											<th>Stage</th>
											<th>Number of rows</th>
											<th>Number of cycles</th>
											<th>Action</th>
											
										</tr>
									</thead>
									<tbody id="specificationTable">
										<tr>
											<td><select required="required"
												class="form-control selectItem StageApplicable" name="StageApplicable"
												id="StageApplicable" data-width="100%"
												data-live-search="true" data-placeholder="Choose">
													<option val="" selected disabled>Choose...</option>
													<%
													for (Object[] obj : StagesApplicable) {
													
													%>
													<option value="<%=obj[3]%>"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%></option>
													<%
													}
													%>
											</select></td>
											<td style="width: 30%;"><input type="number" name="rows"
												class="form-control" maxlength="5" required
												placeholder="Max 5 Characters" value="0"></td>
											<td><input type="number" name="cycle" class="form-control"
												maxlength="250" required placeholder="Max 250 Characters" value="0"></td>
											<td><button type="button" class="btn btn-sm"
													id="plusbutton">
													<i class="fa fa-plus" aria-hidden="true"></i>
												</button></td>
										</tr>
									</tbody>
								</table>
													
													</div>
												</div>
												<input type="hidden" name="projectId" value="<%=projectId%>">
												<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
												<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
												<input type="hidden" name="testPlanInitiationId" value="<%=testPlanInitiationId%>">	 
												<div class="form-group" align="center" style="margin-top: 3%;">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													<button type="submit" class="btn btn-primary btn-sm submit" id="add" name="action" value="Add" onclick="return confirm('Are You Sure to Submit?');">SUBMIT</button>
												</div>
											</div>
										</div>
									</form>
								</div>
								<!--  TEST ADD END-->
									
								<!-- Test EDIT  Start-->
									
								<div id="EditTestDetails">
									<div class="">
										<form class="form-horizontal" role="form" action="TestDetailsAddSubmit.htm" method="POST" id="myform2">
											<div class="row">
												<div class="col-md-12">
													<div class="form-group row">
														<div class="col-md-12">
															<div class="row">
											    				<div class="col-md-1">
											       					 <label style="font-size: 17px;  color: #07689f">Spec Id <span class="mandatory" style="color: red;">*</span></label>
											   					</div>
											    			
											    					<div class="col-md-4">
														<%if ((specificationList != null) && specificationList.size()>0 ) {%>
															<select required="required" class="form-control selectdee" name="SpecId" id="SpecIdEdit" data-width="80%" data-live-search="true" multiple onchange="">
																<option value="" disabled="disabled">---Choose----</option>
																<%for (Object[] obj : specificationList) {%>
																	<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
																<%}%>
															</select>
														<%} else {%>
															<input class="form-control" name="" id="linkedRequirements"  readonly placeholder="No requirements specified for Project">
														<%} %>
													</div>
											    			
											    				
											    				<div class="col-md-2">
											        				<label style="font-size: 17px; margin-top: 7%;  color: #07689f">Test Name <span class="mandatory" style="color: red;">*</span></label>
											    				</div>
													   			 <div class="col-md-4">
													        		<input type="text" name="name" class="form-control" id="EName" maxlength="255" required="required" placeholder="Maximum 250 Characters" >
													    		</div>
															</div>
														</div>
													</div>
												
													<div class="form-group row">
														<div class="col-md-6">
															<div class="row">
																<div class="col-md-2">
																	<label style="font-size: 17px;color: #07689f">
																		Objective <span class="mandatory" style="color: red;">*</span>
																	</label>
																</div>
																<div class="col-md-10">
																	<input type="text" name="Objective" class="form-control"id="EditObjective" maxlength="255" required="required" placeholder="Maximum 250 Chararcters"style="line-height: 3rem !important">
																</div>
															</div>
														</div>
														
														<div class="col-md-6">
															<div class="row">
																<div class="col-md-2">
																	<label style="font-size: 17px;color: #07689f;">
																		Description <span class="mandatory" style="color: red;">*</span>
																	</label>
																</div>
																<div class="col-md-10" style="">
																	<div class="form-group">
<!-- 																		<input type="text" name="Description" class="form-control"id="EditDescription" maxlength="255" required="required"	placeholder="Maximum 250 Chararcters"style="line-height: 3rem !important">
 -->																	
 												<div id="descriptioneditoredit" class="center">
														</div>
													<textarea name="Description"  id="EditDescription" style="display: none;"></textarea>
 
 </div>
																</div>
															</div>
														</div>
													</div>
													
													<div class="form-group row">
														<div class="col-md-6">
															<div class="row">
																<div class="col-md-2">
																	<label style="font-size: 17px;color: #07689f;width: 120%;">
																		Methodology <span class="mandatory" style="color: red;">*</span>
																	</label>
																</div>
																<div class="col-md-10" style="">
																	<div class="form-group">
																		<select required="required" class="form-control selectdee" name="Methodology" id="EditMethodology"data-width="100%" data-live-search="true" >
																			<option value="" disabled="disabled">---Choose----</option>

																	<option value="D" >Demonstration</option>
																	<option value="T" >Test</option>
																	<option value="A" >Analysis/Design</option>
																	<option value="I">Inspection</option>
																	<option value="S" >Special Verification Methods </option>
																	
																		</select>
																	</div>
																</div>
															</div>
														</div>
														
														<div class="col-md-6">
															<div class="row">
																<div class="col-md-2">
																	<label style="font-size: 17px;color: #07689f;">
																		Test-Setup <span class="mandatory" style="color: red;">*</span>
																	</label>
																</div>
																								
																<div class="col-md-10" style="">
																	<select required="required" id="EditToolsSetup" name="ToolsSetup"
																		onchange="AddTestSetUp('EditToolsSetup')" class="form-control selectdee" data-width="80%"
																		data-live-search="true" style="margin-top: 5%"  >
																		<option value="" disabled="disabled">---Choose----</option>
																				<%for (TestSetupMaster t :master) {%>
																<option value="<%=t.getSetupId()%>"   ><%=t.getTestSetUpId()!=null?StringEscapeUtils.escapeHtml4(t.getTestSetUpId()): " - " %></option>
																	<%} %>
																		
																	</select>
																</div>
															</div>						
														</div>
													</div>	
																				
													<div class="form-group row">
														<div class="col-md-6">
															<div class="row">
																<div class="col-md-2">
																	<label style="font-size: 17px;color: #07689f;">
																		Constraints <span class="mandatory" style="color: red;">*</span>
																	</label>
																</div>
																<div class="col-md-10" style="">
																	<input type="text" name="Constraints" class="form-control"	id="EditConstraints" maxlength="255" required="required"placeholder="Maximum 250 Chararcters">
																</div>
															</div>
														</div>
														
														<div class="col-md-6">
															<div class="row">
																<div class="col-md-2">
																	<label style="font-size: 17px;color: #07689f;">
																		Est Time <span class="mandatory" style="color: red;">*</span>
																	</label>
																</div>
																<div class="col-md-4" style="">
																	<input type="text" name="EstimatedTimeIteration" class="form-control"id="EditEstimatedTimeIteration" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
																</div>
																
																<div class="col-md-4" style="">
															<select class="form-control" required="required" name="timeType" id="edittimeType">
															<option value="" selected  disabled="disabled">SELECT</option>
															<option value="D">Day</option>
															<option value="M">Minute</option>
															<option value="H">Hour</option>
															
															</select>
															</div>
															</div>
														</div>
													</div>	
													
													<div class="form-group row">
														<div class="col-md-6">
															<div class="row">
																<div class="col-md-2">
																	<label	style="font-size: 17px;color: #07689f;">
																		Iterations <span class="mandatory" style="color: red;">*</span>
																	</label>
																</div>
																<div class="col-md-10" style="">
																	<input type="text" name="Iterations" class="form-control"	id="EditIterations" maxlength="255" required="required"placeholder="Maximum 250 Chararcters">
																</div>
															</div>
														</div>
														
														<div class="col-md-6">
															<div class="row">
																<div class="col-md-2">
																	<label
																		style="font-size: 17px; color: #07689f;">
																			Schedule <span class="mandatory" style="color: red;">*</span>
																	</label>
																</div>
																<div class="col-md-10" style="">
																	<input type="text" name="Schedule" class="form-control"	id="EditSchedule" maxlength="255" required="required"	placeholder="Maximum 250 Chararcters">
																</div>
															</div>
														</div>
													</div>
												
													<div class="form-group row">
														<div class="col-md-6">
															<div class="row">
																<div class="col-md-2">
																	<label style="font-size: 17px;color: #07689f;">
																		 Criteria <span class="mandatory" style="color: red;">*</span>
																	</label>
																</div>
																<div class="col-md-10" style="margin-top: 10px">
																	<input type="text" name="PassFailCriteria" class="form-control"	id="EditPassFailCriteria" maxlength="255" required="required"	placeholder="Maximum 250 Chararcters">
																</div>
															</div>
														</div>
														
													<%-- 	<div class="col-md-6">
															<div class="row">
																<div class="col-md-2">
																	<label style="font-size: 17px; color: #07689f;">
																		Stage <span class="mandatory" style="color: red;">*</span>
																	</label>
																</div>
																<div class="col-md-10" style="">
																	<select required="required" class="form-control selectdee" name="StageApplicable" id="StageApplicableedit"  data-width="100%" data-live-search="true" data-placeholder="Choose" multiple>
																		<%for(Object[] obj:StagesApplicable){ %>
																		<option value="<%=obj[0]%>"><%=obj[3]%></option>
																		<%}%>
																	</select>
																</div>
															</div>
														</div> --%>
													</div>
														
													<div class="form-group row">
														<div class="col-md-6">
															<label style="margin: 0px; font-size: 17px; color: #07689f">
																Pre Conditions <span class="mandatory" style="color: red;">*</span>
															</label>
															<div id="EditorPreConditionsForEdit" class="center">
																
															</div>
															<textarea name="PreConditions"  id="EditPreConditions" style="display:none"></textarea>
														</div>
														
														<div class="col-md-6">
															<label style="margin: 0px; font-size: 17px; color: #07689f">
																Post Conditions <span class="mandatory" style="color: red;">*</span>
															</label>
															<div id="EditorPostConditionsForEdit" class="center">
															</div>
																				<textarea name="PostConditions"  id="EditPostConditions" style="display:none"></textarea>
														</div>
													</div>
														
													<div class="form-group row">
														<div class="col-md-6">
															<label style="font-size: 17px;color: #07689f;">
																Safety Requirements <span class="mandatory" style="color: red;">*</span>
															</label>
															<div id="EditorSafetyReqforEdit" class="center">
																
															</div>
															<textarea name="SafetyReq"  id="EditSafetyRequirements" style="display: none"></textarea>
														</div>
														
														<div class="col-md-6">
															<label 	style="font-size: 17px;color: #07689f;">
																Personnel Resources <span class="mandatory" style="color: red;">*</span>
															</label>
															<div id="EditorPersonnelResourcesForEdit" class="center">
																
															</div>
															
															<textarea name="PersonnelResources"  id="EditPersonnelResources" style="display: none"></textarea>
														</div>
													</div>
													
													<div class="form-group row">
														<div class="col-md-6">
															<div class="row">
																<div class="col-md-2">
																	<label style="font-size: 17px;color: #07689f;">
																		Remarks <span class="mandatory" style="color: red;">*</span>
																	</label>
																</div>
																<div class="col-md-10" style="margin-top: 10px">
																	<input type="text" name="remarks" class="form-control" id="EditRemarks" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
																</div>
															</div>
														</div>
																	<div class="col-md-6">
														<table class="table table-bordered">
									<thead style=" background: #055C9D; color: white;">
										<tr>
											<th>Stage</th>
											<th>Number of rows</th>
											<th>Number of cycles</th>
											<th>Action</th>
											
										</tr>
									</thead>
									<tbody id="stageEditTable">
										<tr>
											<td><select required="required"
												class="form-control selectItem StageApplicableEdit" name="StageApplicable"
												id="StageApplicableEdit" data-width="100%"
												data-live-search="true" data-placeholder="Choose">
													<option val="" selected disabled>Choose...</option>
													<%
													for (Object[] obj : StagesApplicable) {
													
													%>
													<option value="<%=obj[3]%>"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%></option>
													<%
													}
													%>
											</select></td>
											<td style="width: 30%;"><input type="number" name="rows"
												class="form-control" maxlength="5" required
												placeholder="Max 5 Characters" value="0"></td>
											<td><input type="number" name="cycle" class="form-control"
												maxlength="250" required placeholder="Max 250 Characters" value="0"></td>
											<td><button type="button" class="btn btn-sm"
													id="plusbutton">
													<i class="fa fa-plus" aria-hidden="true"></i>
												</button></td>
										</tr>
									</tbody>
								</table>
													
													</div>
													</div>	
																
												
												<div class="col-md-12">
													<input type="hidden" name="projectId" value="<%=projectId%>">
													<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
													<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
													<input type="hidden" name="testPlanInitiationId" value="<%=testPlanInitiationId%>">	
													<input type="hidden" name="testId" id="edittestId" value="">  
													<div class="form-group" align="center" style="margin-top: 3%;">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
														<button type="submit" class="btn btn-sm btn-warning edit mt-2" id="add" name="action" value="edit" onclick="return confirm('Are you sure to submit?')">UPDATE</button>
													</div>
												</div>
												
												</div>
											</div>
										</form>
									</div>
								</div>
								<!-- Test EDIT End -->
							</div>
						
						
						</div>
					</div>
				
				</div>
			</div>
		</div>
	<%} %>
		
	
		
	<!-- Test Type Model Starts -->
	<div class="modal fade mt-4" id="TestSetUp" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog " role="document">
	    	<div class="modal-content">
	      		<div class="modal-header">
			        <h5 class="modal-title text-primary" id="exampleModalLongTitle">Test Setup</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true" class="text-danger">&times;</span>
			        </button>
	      		</div>
	      		<div class="modal-body">
	      	 		<label>Test Setup Name  :</label>&nbsp;<span class="mandatory" style="color: red;">*</span> <br>
	            	<input class="form-control" id="TestSetupName" style="display: inline-block;width:70%"> <br>
	            	
	       			<label>Test Type :</label>&nbsp;<span class="mandatory" style="color: red;">*</span><br>
	        		<input class="form-control" id="TestTypes" style="display: inline-block;width:70%"><br>
	        		
	          		<label>Test Tools  :</label>&nbsp;<span class="mandatory" style="color: red;"></span> <br>
	        		<input class="form-control" id="TestTools" style="display: inline-block;width:70%">
	        		
			        <div align="center" class="mt-2">
			        	<button type="button" class="btn btn-sm btn-success" onclick="submitTestType()">SUBMIT</button>
			        </div>
	      		</div>
	    	</div>
	  	</div>
	</div>
	<!-- Test Type Model End -->
	
	<!-- No data available Model -->
	<div class="modal fade" id="noDataModal" tabindex="-1" role="dialog" aria-labelledby="noDataModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
	    	<div class="modal-content">
	        	<div class="modal-header">
	                <h5 class="modal-title" id="noDataModalLabel">Please Add Test Details</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Add">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                No Data Available
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-primary" data-dismiss="modal">ADD</button>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- No data available Model -->
<div class="modal fade" id="exampleModalCenter1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content" style="width:150%;">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle1">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modal-body1">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

	<!-- Modal for choosing from Master -->

		
	  <div class="modal fade bd-example-modal-lg" id="dataModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg modal-dialog-jump-pop">
	  <div class="modal-content" style="margin-left:-30%;width: 170%;">
	        <div class="modal-header bg-primary text-light">
        <h5 class="modal-title" id="exampleModalLongTitle"> Tests Available</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
       <div class="modal-body">
       	<table class="table table-bordered table-striped">
       		<thead>
       		<tr style="font-size: 1rem">
       		<td style="width: 5%;text-align: center;">
       		 <input type="checkbox" id="ALLTestMasterIds">
       		</td>
       		
       		<td>Test Name</td>
       		<td style="width: 60%;">Test Description</td>
       		</tr>
       		</thead>
       		<tbody>
       		<%if(TestPlanMasterList!=null && !TestPlanMasterList.isEmpty()) {
       		for(TestPlanMaster tp:TestPlanMasterList){
       		%>
       		<tr style="font-size: 1rem !important;">
       		<td style="text-align: center;"> <input type="checkbox" class="TestMasterIds" name="TestMasterIds" value="<%=tp.getTestMasterId()!=null?StringEscapeUtils.escapeHtml4(tp.getTestMasterId().toString()): " - " %>"></td>
       		<td><%=tp.getName()!=null?StringEscapeUtils.escapeHtml4(tp.getName()): " - " %></td>
       		<td><%=tp.getDescription()!=null?StringEscapeUtils.escapeHtml4(tp.getDescription()): " - " %></td>
       		</tr>
       		<%}} %>
       		</tbody>
       	</table>
       	<div align="center">
       	<button type="button" class="btn btn-sm submit mt-2" onclick="submitTestMaster()">SUBMIT</button>
       	</div>
      </div>
	  </div>
	  </div>
	  </div>

<script>
	function showdata(TestId)
		{
			if(TestId!=null && TestId=='Add')
				{
					$("#AddTestDetails").show();
					$('#viewcard').hide();
					$("#EditTestDetails").hide();
				}
			else if(TestId!=null && parseFloat(TestId) > 0)
				{
					$("#AddTestDetails").hide();
					$('#viewcard').hide();
					$("#EditTestDetails").show();
					edit(TestId);
				}
			else
				{
					$("#AddTestDetails").hide();
					$('#viewcard').show();
					$("#EditTestDetails").hide();
				}
		}
	</script>
		<script>
$(document).ready(function() {
	   $('#project').on('change', function() {
		   var temp=$(this).children("option:selected").val();
		   $('#submit').click(); 
	   });
	});
	 <%if(TestDetailsList!=null){%>
$(document).ajaxComplete(function(){
	$('#main').css("display", "inline-block");
	$('#main').css("margin-top", "0.5%");
	$('#message').css("display","block");

});
<%}%> 
$("#MyTable1").DataTable({		 
		 "lengthMenu": [5,10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 5,
		 "language": {
		      "emptyTable": "Files not Found"
		    }
	});

</script>
		<script type="text/javascript">
function reqCheck(frmid){
	var Name=$('#NameAdd').val();
	var Objective=$('#ObjectiveAdd').val();
	var Description=$('#DescriptionAdd').val();
	//var PreConditionsAdd=$('#PreConditionsAdd').val();
	//var PostConditionsid=$('#PostConditionsid').val();
	var Constraints=$('#ConstraintsAdd').val();
	var SafetyReq=$('#SafetyReqAdd').val();
	var Methodology=$('#MethodologyAdd').val();
	//var PersonnelResources=$('#PersonnelResourcesAdd').val();
	var EstimatedTimeIteration=$('#EstimatedTimeIterationAdd').val();
	var Iterations=$('#IterationsAdd').val();
	var Schedule=$('#ScheduleAdd').val();
	var StageApplicable=$('#StageApplicable').val();
	var PassFailCriteria=$('#PassFailCriteriaAdd').val();
	var remarks=$('#remarksAdd').val();
	if(Name===null|| Name==="" || Objective===null || Objective===""||Description===null|| Description==="" ||Constraints===null || Constraints===""|| Methodology===null || Methodology==="" ||EstimatedTimeIteration==null || EstimatedTimeIteration===""||Iterations==null|| Iterations==="" || Schedule==null || Schedule==="" || StageApplicable==null || StageApplicable==="" ||PassFailCriteria==null || PassFailCriteria==="" || remarks==null|| remarks===""){
// 		if(false){

		window.alert('Please fill all the fields');
		 event.preventDefault();
		 return false;
	} else {
	    if (window.confirm('Are you sure to save?')) {
	        document.getElementById(frmid).submit(); 
	        return true;
	    } else {
	        event.preventDefault();
	        return false;
    }
}
}
function editCheck(event, frmid) {
    var EditName = $('#EName').val();
    var EditObjective=$('#EditObjective').val();
    var EditDescription = $('#EditDescription').val();
    //var EditPreConditions = $('#EditPreConditions').val();
    //var EditPostConditions = $('#EditPostConditions').val();
    var EditConstraints = $('#EditConstraints').val();
   // var EditSafetyRequirements = $('#EditSafetyRequirements').val();
    var EditMethodology = $('#EditMethodology').val();
    var EditToolsSetup = $('#EditToolsSetup').val();
    //var EditPersonnelResources = $('#EditPersonnelResources').val();
    var EditEstimatedTimeIteration = $('#EditEstimatedTimeIteration').val();
    var EditIterations = $('#EditIterations').val();
    var EditSchedule = $('#EditSchedule').val();
    var EditPassFailCriteria = $('#EditPassFailCriteria').val();
    var StageApplicableedit = $('#StageApplicableedit').val();
    var EditRemarks = $('#EditRemarks').val();
    if (EditName === "" || EditObjective==="" || EditDescription === "" ||
        EditConstraints === ""|| EditMethodology === "" ||
        EditToolsSetup === "" || EditEstimatedTimeIteration === "" ||
        EditIterations === "" || EditSchedule === "" || EditPassFailCriteria === "" ||
        StageApplicableedit === "" || EditRemarks === "") {
        window.alert('Please fill all the fields');
        event.preventDefault();
        return false;
    } else {
        if (confirm('Are you sure to save?')) {
        
            document.getElementById(frmid).submit();
            return true;
        } else {
            event.preventDefault();
            return false;
        }
    }
}

<%if((TestDetailsList!=null) &&(!TestDetailsList.isEmpty())){ %>
 $(document).ready(function(){
	 TestDetailsShow('<%=TestReqId%>');
});
 
 
 var jsList = [];

 <%
     if (specificationList != null) {
         for (Object[] spec : specificationList) {
             // Assuming spec[0] and spec[1] are the values you want
             if (spec.length > 1) { // Ensure there are at least 2 elements
 %>
             jsList.push([ "<%= spec[0] %>", "<%= spec[1] %>" ]);
 <%
             }
         }
     }
 %>
 
 var objArray = [
	  { code: "D", name: "Demonstration" },
	  { code: "T", name: "Test" },
	  { code: "A", name: "Analysis/Design" },
	  { code: "I", name: "Inspection" },
	  { code: "S", name: "Special Verification Methods " },
	];
 
 
 var objArray1 = [
	 <%
	     if (master != null) {
	         int count = 0;
	         for (TestSetupMaster tsm : master) {
	             String setupId = tsm.getSetupId()+"";
	             String testSetUpId = tsm.getTestSetUpId();
	 %>
	         {
	             setupId: "<%= setupId %>",
	             testSetUpId: "<%= testSetUpId %>"
	         }<%= (++count < master.size()) ? "," : "" %>
	 <%
	         }
	     }
	 %>
	     ];
 

	 function TestDetailsShow(TestReqId)
	 {
		 $('.viewbtn').css("background","#055C9D");
			 $('#Test'+TestReqId).css("background","green"); 
			var value=TestReqId;
			$.ajax({
				url:'TestDetailsJson.htm',
				datatype:'json',
				data:{
					testId:value
				},
			success:function(result){
				 var ajaxresult=JSON.parse(result); 
				
			console.log(ajaxresult[25]+"---"+ajaxresult[26])
				 
						var rowSplit = ajaxresult[25].split(", ");
						var cycleSplit = ajaxresult[26].split(", ");
						var stageApplicable=ajaxresult[21].split(", ");
						var stageData="";
				for(var i=0;i<stageApplicable.length;i++){
					stageData= stageData+stageApplicable[i]+ " (row = "+rowSplit[i]+", cycle = "+cycleSplit[i]+") <br>";
				}
						
				 var s="";
				 var specid = [];
				 if(ajaxresult[19]!==null){
					 specid=ajaxresult[19].split(",");
				 }
				
				 var specName="";
				 for (var i=0;i<specid.length;i++){
					 for(var j=0;j<jsList.length;j++){
						 if((jsList[j][0]+"")===(specid[i]+"")){
							 specName = specName+ jsList[i][1]+"<br>"
						 }
					 }
				 }
				 
				$('#specidview').html(specName);
				$('#name').html(ajaxresult[2]); 
				$('#Objective').html(ajaxresult[3]);
				$('#Description').html(ajaxresult[4]);
		 		$('#PreConditionsView').html(ajaxresult[5]);
				$('#PostConditionsView').html(ajaxresult[6]);
				$('#Constraints').html(ajaxresult[7]);
				$('#SafetyRequirements').html(ajaxresult[8]);
				var methodology = objArray.find(obj => obj.code === ajaxresult[9]+"")
				$('#Methodology').html(methodology ? methodology.name : "-");
				$('#ToolsSetup').html(ajaxresult[10]);
				$('#PersonnelResourcesView').html(ajaxresult[11]);
				$('#EstimatedTimeIteration').html(ajaxresult[12]);
				$('#reqName').html(ajaxresult[1]);	 	 
				$('#Iterations').html(ajaxresult[13]);
				$('#Schedule').html(ajaxresult[14]);
				$('#PassFailCriteria').html(ajaxresult[15]);
				$('#Remarks').html(ajaxresult[16]);
				//$('#ToolsSetupname').html(ajaxresult[23]);
				var tempArray=ajaxresult[21];
			
				
				$('#StageApplicableView').html(stageData);
				var tempArrayToolsSetup=ajaxresult[10]!=null? ajaxresult[10].split(","):[];
			
			 	var tempsubArrayToolsSetup="";
					for(var i=0;i<objArray1.length;i++){
						if(tempArrayToolsSetup.includes(objArray1[i].setupId+"")){ 
							tempsubArrayToolsSetup=tempsubArrayToolsSetup+objArray1[i].testSetUpId+",";
						}
					}
					tempsubArrayToolsSetup=tempsubArrayToolsSetup.substring(0,tempsubArrayToolsSetup.length-1); 
					
				$('#ToolsSetupView').html(tempsubArrayToolsSetup.toString());
				
				
				
				/*  fsfsd    remove try*/
				/* var tempPreArray = ajaxresult[5].split("#");
var tempPreSubArray = [];

for (var j = 0; j < jsObjectList.length; j++) {
    var currentItem = jsObjectList[j];
    var currentItemData = currentItem.by.split("#"); // Assuming "by" holds the data

    for (var k = 0; k < currentItemData.length; k++) {
        // Example condition: Check if the current data contains #
        if (currentItemData[k].includes("#")) {
            var splitData = currentItemData[k].split("#");
            tempPreSubArray.push(splitData);
            console.log(tempPreSubArray);
        }
    }
} */

// Now tempPreSubArray contains the values split by #

				
				
				
				/*  truy*/
				$('#editreq').html('<button type="button"  class="btn btn-sm  btn-warning edit " onclick="showdata('+ajaxresult[0]+')"  data-toggle="tooltip" data-placement="right" data-original-data="Tooltip on right" title="EDIT" name="action" value="" id="reqbtns" >EDIT</button>');
				$("#AddTestDetails").hide();
				$('#viewcard').show();
				$("#EditTestDetails").hide();
			}
	 });
	 }
<% }%>
function edit(value){
	/* $('#exampleModalLongedit').modal('show'); */
	$.ajax({
		type:'GET',
		url:'TestDetailsJson.htm',
		datatype:'json',
		data:{
			testId:value
		},
	success:function(result){
		 var ajaxresult=JSON.parse(result);
		 
		 if(ajaxresult!=null){
		$('#edittestId').val(ajaxresult[0]);
		var specid= [];
		if(ajaxresult[19]!=null){
			specid=ajaxresult[19].split(", ");
		}
		
		$('#SpecIdEdit').val(specid).trigger('change');
		$('#reqName1').val(ajaxresult[1]);
		$('#EName').val(ajaxresult[2]);
		$('#EditObjective').val(ajaxresult[3]);
		$('#EditConstraints').val(ajaxresult[7]);
/* 		CKEDITOR.instances['EditorSafetyReqforEdit'].setData(ajaxresult[8]);
		CKEDITOR.instances['EditorPersonnelResourcesForEdit'].setData(ajaxresult[11]);
		CKEDITOR.instances['EditorPostConditionsForEdit'].setData(ajaxresult[6]);
		CKEDITOR.instances['EditorPreConditionsForEdit'].setData(ajaxresult[5]); */
		   $('#EditorSafetyReqforEdit').summernote('code', ajaxresult[8]);		
		   $('#EditorPersonnelResourcesForEdit').summernote('code', ajaxresult[11]);		
		   $('#EditorPostConditionsForEdit').summernote('code', ajaxresult[6]);		
		   $('#EditorPreConditionsForEdit').summernote('code', ajaxresult[5]);		
		   $('#descriptioneditoredit').summernote('code', ajaxresult[4]);		
		
		/* $('#EditSafetyRequirements').val(ajaxresult[8]); */
		//$('#EditToolsSetup').val(ajaxresult[10]);
		$('#EditEstimatedTimeIteration').val(ajaxresult[12]);
		$('#EditIterations').val(ajaxresult[13]);
		$('#EditSchedule').val(ajaxresult[14]);
		$('#EditPassFailCriteria').val(ajaxresult[15]);
		$('#EditRemarks').val(ajaxresult[16]);
		$('#edittimeType').val(ajaxresult[24]);
		const StageApplicable=ajaxresult[21].split(",");
		$('#StageApplicableedit').val(StageApplicable).trigger('change');
		const EditMethodology=ajaxresult[9].split(",");
		$('#EditMethodology').val(EditMethodology).trigger('change');
		const EditToolsSetup= ajaxresult[10]!=null?ajaxresult[10].split(","):"";
		$('#EditToolsSetup').val(EditToolsSetup).trigger('change');
		
		 }
		
			 
		 $("#AddTestDetails").hide();
			$('#viewcard').hide();
			$("#EditTestDetails").show();
	}
	})  
}
<%if(TestDetailsList.isEmpty()){%>
$(document).ready(function(){
	$('.show').click();
	});
<%}%>
</script>
<script type="text/javascript">

$(document).on("click", ".removebtn", function() {
    $(this).parent("div").remove();
  });

$(function () {
    $('#reqbtns[data-toggle="tooltip"]').tooltip({
        animated: 'fade',
        placement: 'top',
        html : true,
    });
});
		$(function () {
		$('[data-toggle="tooltip"]').tooltip()
		})
</script>
	<script>
  // Show the button when the user scrolls down a certain distance
  window.onscroll = function() { scrollFunction() };
  		function scrollFunction() {
	    var scrollButton = document.getElementById("scrollButton");
	    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
	    	if(scrollButton!=null){
	    		scrollButton.style.display = "block";
	    	}
	    } else {
	    	if(scrollButton!=null){
	      scrollButton.style.display = "none";
	    	}
	    }
	  	}
  	// Scroll to the top when the button is clicked
  	function scrollToTop(){
    document.body.scrollTop = 0; // For Safari
    document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE, and Opera
 	}
  function AddTestSetUp(Id){
	  var value= $('#'+Id).val();
	
	  if(value==="0"){
		  $('#TestTypes').val("");
		  $('#TestTools').val("");
		  $('#TestSetupName').val("");
		 $('#TestSetUp').modal('show');
	  }
	  
	  var Text=$('#'+Id+' option:selected').text();
	  if(value.includes("0"))
		  {
		   $("#TestSetUp").modal('show');
		  }
  }
  function submitTestType(){
	  var TestTypes=$('#TestTypes').val();
	  var TestTools=$('#TestTools').val();
	  var TestSetupName=$('#TestSetupName').val();
	  var selectValue=document.getElementById('select1');
	  var options = selectValue.options;
	  var html="";
	  for(let i=0;i<options.length-1;i++){
		var value=options[i].value;
		var text=options[i].text;
		html=html+'<option value="'+value+'">'+text+'</option>'
	  }
	  if(TestTypes.length==0){
		  alert("Please fill all the data")}
		  else{
			  if(confirm("Are you sure to submit?")){
			  $.ajax({
					  type:'GET',
					  url:'InsertTestType.htm',
					  datatype:'json',
					  data:{
						  TestTypes:TestTypes,
						  TestTools:TestTools,
						  TestSetupName:TestSetupName,
					  },
					  success : function(result){
						  var ajaxresult=JSON.parse(result);
						  if(ajaxresult!="-1"){
							  var y=TestTypes;
							  html=html+"<option value='"+ajaxresult+"' selected>"+y+"</option>"
						  /* html=html+'<option class="bg-success text-light" value="1">ADD NEW</option>' */
						  //document.getElementById('select1').innerHTML=html; 
							  $('#select1 option[value="0"]').prop('selected', false);
							  $('#select1').append(html);
							  $('#TestSetUp').modal('hide');
						  }else{
							  alert("Please check the Test Type list carefully its already there!")
							 /*  html=html+'<option class="bg-success text-light" value="0">ADD NEW</option>'
							  document.getElementById('select1').innerHTML=html;  
							  $('#TestSetUp').modal('hide'); */
						  }
					  }
				  })
			  }else{
				  event.preventDefault();
			  }
		  }
  }
  </script>
  
  <script>
  $(document).ready(function(){
	  <%if(TestDetailsList!=null && TestDetailsList.size()>0) {%>
		$('#AddTestDetails').hide();
		$('#viewcard').show();
		$("#EditTestDetails").hide();
	<%} else{%>
		$('#AddTestDetails').show();
		$('#viewcard').hide();
		$("#EditTestDetails").hide();
	<%} %>
  });
  </script>
<script>

$(document).ready(function() {


$('#EditorPreConditions').summernote({
    
     tabsize: 5,
     height: 200
   });
   

$('#EditorPostConditions').summernote({
    
     tabsize: 5,
     height: 200
   });


$('#EditorSafetyReq').summernote({
    
     tabsize: 5,
     height: 200
   });


$('#EditorPersonnelResources').summernote({
    
     tabsize: 5,
     height: 200
   });

/* 	 $('#descriptioneditor').summernote({
		  width: 600,   //don't use px
		
		  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana'],
		 
	      lineHeights: ['0.5']
	
	 }); */

$('#descriptioneditor').summernote({
   
	 toolbar: [
         // Adding default toolbar buttons plus custom superscript and subscript
         ['style', ['bold', 'italic', 'underline', 'clear']],
         ['font', ['strikethrough', 'superscript', 'subscript']],
         ['insert', ['picture', 'table']],
         ['para', ['ul', 'ol', 'paragraph']],
         ['height', ['height']]
     ],
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
     height: 200

  });
/* 	 $('#descriptioneditoredit').summernote({
		  width: 600,   //don't use px
		
		  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana'],
		 
	      lineHeights: ['0.5']
	
	 }); */

$('#descriptioneditoredit').summernote({
   
    tabsize: 5,
    height: 200
  });
/* 	 $('#EditorPreConditionsForEdit').summernote({
		  width: 600,   //don't use px
		
		  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana'],
		 
	      lineHeights: ['0.5']
	
	 });
 */
$('#EditorPreConditionsForEdit').summernote({
   
    tabsize: 5,
    height: 200
  });
/* 	 $('#EditorPostConditionsForEdit').summernote({
		  width: 600,   //don't use px
		
		  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana'],
		 
	      lineHeights: ['0.5']
	
	 }); */

$('#EditorPostConditionsForEdit').summernote({
   
    tabsize: 5,
    height: 200
  });
/* 	 $('#EditorSafetyReqforEdit').summernote({
		  width: 600,   //don't use px
		
		  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana'],
		 
	      lineHeights: ['0.5']
	
	 });
 */
$('#EditorSafetyReqforEdit').summernote({
   
    tabsize: 5,
    height: 200
  });
/* 	 $('#EditorPersonnelResourcesForEdit').summernote({
		  width: 600,   //don't use px
		
		  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana'],
		 
	      lineHeights: ['0.5']
	
	 }); */

$('#EditorPersonnelResourcesForEdit').summernote({
   
    tabsize: 5,
    height: 200
  });
});
$('#myform1').submit(function() {
var data =$('#EditorPreConditions').summernote('code');

$('#PreConditionsAdd').val(data);
});

/* 	CKEDITOR.replace('EditorPostConditions', editor_config); */
$('#myform1').submit(function() {
	  var data =$('#EditorPostConditions').summernote('code');;
	
	 $('#PostConditionsAdd').val(data);
	 });
/*  CKEDITOR.replace('EditorSafetyReq', editor_config); */
$('#myform1').submit(function() {
	 var data =$('#EditorSafetyReq').summernote('code');;

	 $('#SafetyReqAdd').val(data);
	 });
/*  CKEDITOR.replace('EditorPersonnelResources', editor_config); */
$('#myform1').submit(function() {
	 var data =$('#EditorPersonnelResources').summernote('code');

	 $('#PersonnelResourcesAdd').val(data);
	 });
$('#myform1').submit(function() {
	 var data =$('#descriptioneditor').summernote('code');
	
	 $('#DescriptionAdd').val(data);
	 });
	/*  CKEDITOR.replace('EditorPreConditionsForEdit', editor_config); */
	 $('#myform2').submit(function() {
		/*  var data =CKEDITOR.instances['EditorPreConditionsForEdit'].getData(); */
		 var data =$('#EditorPreConditionsForEdit').summernote('code');;
		
		 $('#EditPreConditions').val(data);
		 });
	/*  CKEDITOR.replace('EditorPostConditionsForEdit', editor_config); */
	 $('#myform2').submit(function() {
	/* 	 var data =CKEDITOR.instances['EditorPostConditionsForEdit'].getData(); */
		 var data =$('#EditorPostConditionsForEdit').summernote('code');;

	
		 $('#EditPostConditions').val(data);
		 });
	/*  CKEDITOR.replace('EditorPersonnelResourcesForEdit', editor_config); */
	 $('#myform2').submit(function() {
/* 		 var data =CKEDITOR.instances['EditorPersonnelResourcesForEdit'].getData(); */
 var data =$('#EditorPersonnelResourcesForEdit').summernote('code');;

	
		 $('#EditPersonnelResources').val(data);
		 });
	
	 /* CKEDITOR.replace('EditorSafetyReqforEdit', editor_config); */
	 $('#myform2').submit(function() {
/* 		 var data =CKEDITOR.instances['EditorSafetyReqforEdit'].getData(); */
 		 var data =$('#EditorSafetyReqforEdit').summernote('code');;

		
		 $('#EditSafetyRequirements').val(data);
		 
		 var data =$('#descriptioneditoredit').summernote('code');;

		
		 $('#EditDescription').val(data);
		 });
	 
	 
	
	 function scrollToTop(){
		    document.body.scrollTop = 0; // For Safari
		    document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE, and Opera
		 	}
	 
	 function AddData(a,b){
		 const selectElement = document.getElementById("MethodologyAdd");
		    const selectedValues = Array.from(selectElement.selectedOptions).map(option => option.value);
		   
	
		    if(selectedValues.includes('0')){
		    	alert("Please give some alert")
		    }
	 }
	 
	 var temArray=[];
	 function onchangeSpec(){
		 var valueArray = $('#select').val();
		 var  result1 ='0';
		 if(temArray.length<valueArray.length){
			result1 = valueArray.filter(element => !temArray.includes(element));
			 temArray=valueArray
		 }
		if(result1!=='0'){
		
			 $.ajax({
				 type:'GET',
				 url:'getSpecificationData.htm',
				 data:{
					 SpecsId:result1+""
				 },
				 datatype:'json',
				 success : function(result){
					var ajaxresult = JSON.parse(result);
					
					
					 if(ajaxresult.Description!=null)
						 $('#modal-body1').html(ajaxresult.Description)
					 $('#exampleModalLongTitle1').html(ajaxresult.SpecificationName )
					 $('#exampleModalCenter1').modal('show');
					 
				 }
			 });
			
		}
		 
		 
	 }
		function deleteTestPlan(a){
			
			if(confirm('Are you sure to delete?')){
			
			$.ajax({
			type:'get',
			url:'deletetestPlan.htm',
			data:{
				TestId:a,
			},
			datatype:'json',
			success:function(result){
				
				alert("Test PlanId deleted successfully!")
				
				window.location.reload();
			}
			})
			}else{
				event.preventDefault();
				return false;
			}
		
		}
		
		
		function showMasterModal(){
			$('#dataModal').modal('show');
		}
		$('#ALLTestMasterIds').change(function(){
			if($(this).prop('checked')){
				$('.TestMasterIds').prop('checked',true);
			}else{
				$('.TestMasterIds').prop('checked',false);
			}
			
		});
		
		$('.TestMasterIds').change(function(){
			
			if($('.TestMasterIds:checked').length===$('.TestMasterIds').length){
				$('#ALLTestMasterIds').prop('checked',true);
			}else{
				$('#ALLTestMasterIds').prop('checked',false);
			}
		});
		
		
		function submitTestMaster(){
			var MasterIds=[];
		$('input:checkbox[class="TestMasterIds"]:checked').each(function(){
			
			MasterIds.push(this.value)
		})
		
		
		if(MasterIds.length==0){
				Swal.fire({
					  icon: "error",
					  title: "Oops...",
					  text: "Please select one of the test IDs.!",
					  
					});
			}else{
		
			if(confirm('Are you sure to submit?')){
				
					$.ajax({
					type:'GET',
					url:'AddTestDetailsFromMaster.htm',
					datatype:'json',
					data:{
						MasterIds:MasterIds+"",
						projectId:<%=projectId%>,
						initiationId:<%=initiationId%>,
						productTreeMainId:<%=productTreeMainId%>,
						testPlanInitiationId:<%=testPlanInitiationId%>,
						nextCount :	<%=nextCount %>,
					},
					success:function(result){
						var ajaxresult = JSON.parse(result);
						console.log("--"+typeof ajaxresult)
						if(ajaxresult!==0){
							
							  Swal.fire({
					    	       	title: "Success",
					                text: "Testplan Linked From TestPlan Master Successfully",
					                icon: "success",
					                allowOutsideClick :false
					         		});
			            	  $('.swal2-confirm').click(function (){
			      	                location.reload();
			      	        	})
						}
					}
					})
					
			}
			
		}
		}
		
		
		function initializeSelect2ForAll() {
		    // Clean up and reinitialize all select2
		    $('.StageApplicable').each(function () {
		        // Destroy existing Select2 if initialized
		        if ($(this).hasClass("select2-hidden-accessible")) {
		            $(this).select2('destroy');
		        }
		        // Reinitialize
		        $(this).select2({ width: '100%' });
		    });
		}
		
		$(document).ready(function () {
		    // Initialize all existing selects
		    initializeSelect2ForAll();
		});    
		// Delegate event for dynamically added buttons
	    var count = 1;
	    $('#specificationTable').on('click', '.btn', function () {
	    	
	    	let $button = $(this);
	        
	        // If button is plus
	        if ($button.find('i').hasClass('fa-plus')) {
	            let $row = $button.closest('tr').clone();
				++count;

			    // Clean up old select2 from clone
			    $row.find('.select2-container').remove();
			    $row.find('.StageApplicable')
			        .removeClass('select2-hidden-accessible')
			        .removeAttr('data-select2-id')
			        .removeAttr('aria-hidden')
			        .removeAttr('tabindex');
			    
	            // Change the button to minus
	            $row.find('i').removeClass('fa-plus').addClass('fa-minus');
	            $row.find('.btn').removeAttr('id'); // Remove ID from cloned row's button
	            $row.find('.StageApplicable').val('').attr("id", "StageApplicable_"+count);
	            
	            // Clear inputs
	            $row.find('input').val('');

	            $('#specificationTable').append($row);
	            
	            initializeSelect2ForAll();
	        }
	        // If button is minus
	        else if ($button.find('i').hasClass('fa-minus')) {
	            $button.closest('tr').remove();
	        }
	    });
	    
	   
		
		function initializeSelect2EditForAll() {
		    // Clean up and reinitialize all select2
		    $('.stageEditTable').each(function () {
		        // Destroy existing Select2 if initialized
		        if ($(this).hasClass("select2-hidden-accessible")) {
		            $(this).select2('destroy');
		        }
		        // Reinitialize
		        $(this).select2({ width: '100%' });
		    });
		}
		
		$(document).ready(function () {
		    // Initialize all existing selects
		    initializeSelect2EditForAll();
		});    
		// Delegate event for dynamically added buttons
	    var count = 1;
	    $('#stageEditTable').on('click', '.btn', function () {
	    	
	    	let $button = $(this);
	        
	        // If button is plus
	        if ($button.find('i').hasClass('fa-plus')) {
	            let $row = $button.closest('tr').clone();
				++count;

			    // Clean up old select2 from clone
			    $row.find('.select2-container').remove();
			    $row.find('.StageApplicableEdit')
			        .removeClass('select2-hidden-accessible')
			        .removeAttr('data-select2-id')
			        .removeAttr('aria-hidden')
			        .removeAttr('tabindex');
			    
	            // Change the button to minus
	            $row.find('i').removeClass('fa-plus').addClass('fa-minus');
	            $row.find('.btn').removeAttr('id'); // Remove ID from cloned row's button
	            $row.find('.StageApplicableEdit').val('').attr("id", "StageApplicable_"+count);
	            
	            // Clear inputs
	            $row.find('input').val('');

	            $('#stageEditTable').append($row);
	            
	            initializeSelect2EditForAll();
	        }
	        // If button is minus
	        else if ($button.find('i').hasClass('fa-minus')) {
	            $button.closest('tr').remove();
	        }
	    });
	    
	    
	    
	    function createTestStagePDF(ele){
	    	
	    	Swal.fire({
	    	    title: 'Generating PDF...',
	    	    text: 'Please wait while we prepare the document.',
	    	    allowOutsideClick: false,
	    	    didOpen: () => {
	    	        Swal.showLoading();
	    	    }
	    	});
	    
			var stage = ele.value
			var testPlan = [];
	
			$.ajax({
				
				type:'get',
				url:'getTestPlanMasterList.htm',
				datatype:'json',
				data:{
					testPlanInitiationId:<%=testPlanInitiationId %>,
				},
				success:function(result){
					
					var ajaxresult = JSON.parse(result);
					
					var stagePresent = [];
					console.log(ajaxresult)
					
					 for(var i =0;i<ajaxresult.length;i++){
						
						var data = ajaxresult[i][22].split(",");
						
						const exists = data.map(item => item.trim()).includes(stage);
						
						if(exists){
							stagePresent.push(ajaxresult[i])
						}
					} 
					console.log(stage+"----")
					console.log(stagePresent)
					
						var chapterCount = 0;
					    var mainContentCount = 0;
						var leftSideNote = '<%if(DocTempAtrr!=null && DocTempAtrr[12]!=null) {%><%=DocTempAtrr[12].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%} else{%>-<%}%>';
						
						var docDefinition = {
					            content: [
					                // Cover Page with Project Name and Logo
					                {
					                    text: htmlToPdfmake('<h4 class="heading-color ">Document For '+stage+' </h4>'),
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
					                    text: htmlToPdfmake('<h5><% if (LabList != null && LabList[1] != null) { %> <%= LabList[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + "(" + LabList[0].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + ")" %> <% } else { %> '-' <% } %></h5>'),
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
					                {
					                    text: '',
					                    pageBreak: 'before'
					                },
				
					      
					                ],
								
								/* last */
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
					            info: {
					                title: 'Test SetUp Document', // Set document title here
					                author: 'LRDE', // Optional metadata
					                subject: 'Subject of the PDF',       // Optional metadata
					                keywords: 'keyword1, keyword2',     // Optional metadata
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
					                                    { text: currentPage.toString() + ' of ' + pageCount, alignment: 'right', margin: [0, 0, 30, 0], fontSize: 8 }
					                                ]
					                            },
					                            { text: 'Restricted', alignment: 'center', fontSize: 8, margin: [0, 5, 0, 0], bold: true }
					                        ]
					                    };
					                }
					                return '';
					            },
					            header: function (currentPage) {
					                return {
					                    stack: [
					                        
					                        {
					                            columns: [
					                                {
					                                    // Left: Lab logo
					                                    image: '<%= lablogo != null ? "data:image/png;base64," + lablogo : "" %>',
					                                    width: 30,
					                                    height: 30,
					                                    alignment: 'left',
					                                    margin: [35, 10, 0, 10]
					                                },
					                                {
					                                    // Center: Text
					                                    text: 'Restricted',
					                                    alignment: 'center',
					                                    fontSize: 10,
					                                    bold: true,
					                                    margin: [0, 10, 0, 0]
					                                },
					                                {
					                                    // Right: DRDO logo
					                                    image: '<%= drdologo != null ? "data:image/png;base64," + drdologo : "" %>',
					                                    width: 30,
					                                    height: 30,
					                                    alignment: 'right',
					                                    margin: [0, 10, 20, 10]
					                                }
					                            ]
					                        },
					                        
					                    ]
					                };
					            },
								pageMargins: [50, 50, 30, 40],
					            
					        
					            watermark: { text: 'DRAFT', opacity: 0.1, bold: true, italics: false, fontSize: 80,  },
					           
					            defaultStyle: { fontSize: 12, color: 'black', }
					        };
							
						 pdfMake.createPdf(docDefinition).getBlob((blob) => {
					         // Create a URL for the blob
					         const url = URL.createObjectURL(blob);

					         // Open the PDF in a new tab
					         window.open(url, '_blank');
					         Swal.close(); 
					        
					     });
					
					
				}
				
				
			})
			
			
		}
	   
 </script>
	
</body>
</html>