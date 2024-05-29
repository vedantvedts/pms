<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.util.stream.Collectors"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PMS</title>
<jsp:include page="../static/header.jsp"></jsp:include>
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
	
%>
<body style="background-color: white;">

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
								<div class="col-md-9" id="projecthead">
									<h5 style="margin-left: 1%;">
										<%="Test Details" %>
									</h5>
								</div>
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
				<div class="row">
					<div class="col-md-1" >
						<%if((TestDetailsList!=null) &&(!TestDetailsList.isEmpty())){ %>
							<div class="cardbody" id="" style="display:block;<%if(TestDetailsList.size()>9){%>height:1000px;<%}%>">
								<%int count=1;
									for(Object []obj:TestDetailsList) {%>
										<button type="button" class="btn btn-primary viewbtn mt-2" id="Test<%=obj[0] %>" value="<%=obj[0]%>" onclick="TestDetailsShow('<%=obj[0]%>')">
											<span style="font-weight: bold;"><%=obj[1] %></span>
										</button>
									<%count++;} %>
							</div>
						<%} else{%>
							<script type="text/javascript">
				                $(document).ready(function() {
				                    $("#noDataModal").modal('show');
				                });
	            			</script>
	            			<button type="button" class="btn btn-secondary viewbtn mt-2">
								<span style="font-weight: bold;;">No Data</span>
							</button>
	           				
						<%} %>
					</div>
					<div class="col-md-11">
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
										<div class="col-md-3" style="margin-top: 1%">
											<h5 style="font-size: 20px; color: #005086; width: fit-content">Test Name</h5>
										</div>
										<div class="col-md-2" style="margin-top: 1%">
											<p id="name" style="font-size: 17px;"></p>
										</div>
										<div class="col-md-2" style="padding-left: 0px; padding-right: 0px;">
											<h5 style="font-size: 20px; color: #005086;margin-top: 6%;margin-left:49%;" id="priority">Objective:</h5>
										</div>
										<div class="col-md-4" style="margin-top: 1%">
											<p id="Objective" style="font-size: 17px;"></p>
										</div>
										
										<hr>
										
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
															Sepc ID <span class="mandatory" style="color: red;"></span>
														</label>
													</div>
									
													<div class="col-md-2">
														<%if ((specificationList != null) && specificationList.size()>0 ) {%>
															<select required="required" class="form-control selectdee" name="SpecId" id="select" data-width="80%" data-live-search="true" multiple onchange="">
																<option value="" disabled="disabled">---Choose----</option>
																<%for (Object[] obj : specificationList) {%>
																	<option value="<%=obj[0]%>"><%=obj[1]%></option>
																<%}%>
															</select>
														<%} else {%>
															<input class="form-control" name="" id="linkedRequirements"  readonly placeholder="No requirements specified for Project">
														<%} %>
													</div>
													
													<div class="col-md-3">
													</div>	
														
													<div class="col-md-1">
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
																	<input type="text" name="Description" class="form-control" id="DescriptionAdd" maxlength="255" required="required" placeholder="Maximum 250 Chararcters" style="line-height: 3rem !important">
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
																<select class="form-control selectdee" name="Methodology" id="MethodologyAdd" data-width="100%" data-placeholder="Select Methodology" data-live-search="true" multiple  required >
																	<option value="" disabled="disabled">---Choose----</option>
																	<!-- <option value="0">NA ( Not Applicable )</option> -->
																	<%if((DemonstrationList!=null) &&(!DemonstrationList.isEmpty())){
																 	int count=0; 
																	%>
																		<%for(Object[] obj:DemonstrationList){ %>
												 							<option value="<%="D"+(++count) %>" title=<%=obj[3] %>><%=obj[3]%></option> 
																		<%}%>
																	<%}%>
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
																	data-live-search="true" style=""  data-placeholder="Choose" multiple="multiple" required="required">
																	<!-- <option disabled="disabled" value="" selected="selected">Choose..</option> -->
																	<option class="bg-success text-light" value="0"  >ADD NEW</option>
																	<%if(!TestTypeList.isEmpty()){
																		for(Object[] obj:TestTypeList){ %>
																			<option value="<%=obj[0]%>"><%=obj[1]%></option>
																	<%}}%>
																	
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
															<div class="col-md-2">
																<label style="font-size: 17px;color: #07689f;">
																	Est Time <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-10" style="">
																<input type="text" name="EstimatedTimeIteration" class="form-control" id="EstimatedTimeIterationAdd" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
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
																	Schedule <span class="mandatory" style="color: red;">*</span>
																</label>
															</div>
															<div class="col-md-10" style="">
																<input type="text" name="Schedule" class="form-control" id="ScheduleAdd" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
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
										
													<div class="col-md-6">
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
													</div>
												</div>
												
												<div class="form-group row">
													<div class="col-md-6">
														<label style="font-size: 17px; color: #07689f">
															Pre Conditions <span class="mandatory" style="color: red;">*</span>
														</label>
														
														<div id="EditorPreConditions" class="center">
															<textarea name="PreConditions"  id="PreConditionsAdd" ></textarea>
														</div>
														
													</div>
													
													<div class="col-md-6" id="textarea" style="">
														<label style="font-size: 17px; color: #07689f">
															Post Conditions <span class="mandatory" style="color: red;">*</span>
														</label>
														<div id="EditorPostConditions" class="center">
															<textarea name="PostConditions"  id="PostConditionsAdd" ></textarea>
														</div>
													</div>
												</div>
												
												<div class="form-group row">
													<div class="col-md-6">
														<label style="font-size: 17px;color: #07689f;">
															Safety Requirements <span class="mandatory" style="color: red;">*</span>
														</label>

														<div id="EditorSafetyReq" class="center">
															<textarea name="SafetyReq"  id="SafetyReqAdd" ></textarea>
														</div>
													</div>	
													
													<div class="col-md-6">
														<label style="font-size: 17px;color: #07689f;">
															Personnel Resources <span class="mandatory" style="color: red;">*</span>
														</label>
															
														<div id="EditorPersonnelResources" class="center">
															<textarea name="PersonnelResources"  id="PersonnelResourcesAdd" ></textarea>
														</div>
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
											    				<div class="col-md-2">
											    					<input type="text" name="name" class="form-control" id="editSpecId" maxlength="255" required="required" placeholder="Maximum 250 Characters"  readonly>
											    				</div>
											    				<div class="col-md-3">
													    		</div>
											    				<div class="col-md-1">
											        				<label style="font-size: 17px; margin-top: 7%;  color: #07689f">Test Name <span class="mandatory" style="color: red;">*</span></label>
											    				</div>
													   			 <div class="col-md-5">
													        		<input type="text" name="TestName" class="form-control" id="EName" maxlength="255" required="required" placeholder="Maximum 250 Characters" >
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
																		<input type="text" name="Description" class="form-control"id="EditDescription" maxlength="255" required="required"	placeholder="Maximum 250 Chararcters"style="line-height: 3rem !important">
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
																		<select required="required" class="form-control selectdee" name="Methodology" id="EditMethodology"data-width="100%" data-live-search="true" multiple>
																			<option value="" disabled="disabled">---Choose----</option>
																			<!-- <option value="0">NA ( Not Applicable )</option> -->
																			<%if((DemonstrationList!=null) &&(!DemonstrationList.isEmpty())){
																			int count=0;
																			%>
																				<%for(Object[] obj:DemonstrationList){ %>
																					<option value="<%="D"+(++count) %>" title=<%=obj[3] %>><%=obj[3]%></option>
																				<%}%>
																			<%}%>
																		</select>
																	</div>
																</div>
															</div>
														</div>
														
														<div class="col-md-6">
															<div class="row">
																<div class="col-md-2">
																	<label style="font-size: 17px;color: #07689f;">
																		Tool-Setup <span class="mandatory" style="color: red;">*</span>
																	</label>
																</div>
																								
																<div class="col-md-10" style="">
																	<select required="required" id="EditToolsSetup" name="ToolsSetup"
																		onchange="AddTestSetUp('EditToolsSetup')" class="form-control selectdee" data-width="80%"
																		data-live-search="true" style="margin-top: 5%"  multiple>
																		 <option class="bg-success text-light" value="0">ADD NEW </option> 
																		<%if(!TestTypeList.isEmpty()){
																		for(Object[] obj:TestTypeList){ %>
																		<option value="<%=obj[0]%>"><%=obj[1]%></option>
																		<%}}%>
																		
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
																<div class="col-md-10" style="">
																	<input type="text" name="EstimatedTimeIteration" class="form-control"id="EditEstimatedTimeIteration" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
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
														
														<div class="col-md-6">
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
														</div>
													</div>
														
													<div class="form-group row">
														<div class="col-md-6">
															<label style="margin: 0px; font-size: 17px; color: #07689f">
																Pre Conditions <span class="mandatory" style="color: red;">*</span>
															</label>
															<div id="EditorPreConditionsForEdit" class="center">
																<textarea name="PreConditions"  id="EditPreConditions" ></textarea>
															</div>
														</div>
														
														<div class="col-md-6">
															<label style="margin: 0px; font-size: 17px; color: #07689f">
																Post Conditions <span class="mandatory" style="color: red;">*</span>
															</label>
															<div id="EditorPostConditionsForEdit" class="center">
																<textarea name="PostConditions"  id="EditPostConditions" ></textarea>
															</div>
														</div>
													</div>
														
													<div class="form-group row">
														<div class="col-md-6">
															<label style="font-size: 17px;color: #07689f;">
																Safety Requirements <span class="mandatory" style="color: red;">*</span>
															</label>
															<div id="EditorSafetyReqforEdit" class="center">
																<textarea name="SafetyReq"  id="EditSafetyRequirements" ></textarea>
															</div>
														</div>
														
														<div class="col-md-6">
															<label 	style="font-size: 17px;color: #07689f;">
																Personnel Resources <span class="mandatory" style="color: red;">*</span>
															</label>
															<div id="EditorPersonnelResourcesForEdit" class="center">
																<textarea name="PersonnelResources"  id="EditPersonnelResources" ></textarea>
															</div>
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
														<button type="submit" class="btn btn-sm btn-warning edit mt-2" id="add" name="action" value="Add" onclick="return editCheck('myform2');">Update</button>
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
	 function TestDetailsShow(TestReqId)
	 {
		 $('.viewbtn').css("background","#055C9D");
			/* $('#Test'+TestReqId).css("background","green"); */
			var value=TestReqId;
			$.ajax({
				url:'TestDetailsJson.htm',
				datatype:'json',
				data:{
					testId:value
				},
			success:function(result){
				 var ajaxresult=JSON.parse(result); 
				 console.log(ajaxresult);
				 var jsObjectList = JSON.parse('<%= jsonArray %>');
				 
				 var jsObjectTestToolList =JSON.parse('<%= jsonArrayTestTool %>');
				 
				 var s="";
				 console.log("AJax call");
				$('#specidview').html(ajaxresult[19]);
				$('#name').html(ajaxresult[2]); 
				$('#Objective').html(ajaxresult[3]);
				$('#Description').html(ajaxresult[4]);
		 		$('#PreConditionsView').html(ajaxresult[5]);
				$('#PostConditionsView').html(ajaxresult[6]);
				$('#Constraints').html(ajaxresult[7]);
				$('#SafetyRequirements').html(ajaxresult[8]);
				$('#Methodology').html(ajaxresult[9]);
				$('#ToolsSetup').html(ajaxresult[10]);
				$('#PersonnelResourcesView').html(ajaxresult[11]);
				$('#EstimatedTimeIteration').html(ajaxresult[12]);
				$('#reqName').html(ajaxresult[1]);	 	 
				$('#Iterations').html(ajaxresult[13]);
				$('#Schedule').html(ajaxresult[14]);
				$('#PassFailCriteria').html(ajaxresult[15]);
				$('#Remarks').html(ajaxresult[16]);
				//$('#ToolsSetupname').html(ajaxresult[23]);
				var tempArray=ajaxresult[21].split(",");
				var tempsubArray="";
					for(var i=0;i<jsObjectList.length;i++){
						if(tempArray.includes(jsObjectList[i][0]+"")){
							tempsubArray=tempsubArray+jsObjectList[i][3]+",&nbsp;&nbsp;";
						}
					}
					tempsubArray=tempsubArray.substring(0,tempsubArray.length-1);
					console.log(tempsubArray);
				$('#StageApplicableView').html(tempsubArray.toString());
				var tempArrayToolsSetup=ajaxresult[10].split(",");
				
				var tempsubArrayToolsSetup="";
					for(var i=0;i<jsObjectTestToolList.length;i++){
						if(tempArrayToolsSetup.includes(jsObjectTestToolList[i][0]+"")){
							tempsubArrayToolsSetup=tempsubArrayToolsSetup+jsObjectTestToolList[i][1]+",&nbsp;&nbsp;";
						}
					}
					tempsubArrayToolsSetup=tempsubArrayToolsSetup.substring(0,tempsubArray.length-1);
					console.log(tempsubArrayToolsSetup);
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
		 console.log(result);
		 if(ajaxresult!=null){
		$('#edittestId').val(ajaxresult[0]);
		$('#editSpecId').val(ajaxresult[19]);
		$('#reqName1').val(ajaxresult[1]);
		$('#EName').val(ajaxresult[2]);
		$('#EditObjective').val(ajaxresult[3]);
		$('#EditDescription').val(ajaxresult[4]);
		$('#EditConstraints').val(ajaxresult[7]);
		CKEDITOR.instances['EditorSafetyReqforEdit'].setData(ajaxresult[8]);
		CKEDITOR.instances['EditorPersonnelResourcesForEdit'].setData(ajaxresult[11]);
		CKEDITOR.instances['EditorPostConditionsForEdit'].setData(ajaxresult[6]);
		CKEDITOR.instances['EditorPreConditionsForEdit'].setData(ajaxresult[5]);
		/* $('#EditSafetyRequirements').val(ajaxresult[8]); */
		//$('#EditToolsSetup').val(ajaxresult[10]);
		$('#EditEstimatedTimeIteration').val(ajaxresult[12]);
		$('#EditIterations').val(ajaxresult[13]);
		$('#EditSchedule').val(ajaxresult[14]);
		$('#EditPassFailCriteria').val(ajaxresult[15]);
		$('#EditRemarks').val(ajaxresult[16]);
		const StageApplicable=ajaxresult[21].split(",");
		$('#StageApplicableedit').val(StageApplicable).trigger('change');
		const EditMethodology=ajaxresult[9].split(",");
		$('#EditMethodology').val(EditMethodology).trigger('change');
		const EditToolsSetup=ajaxresult[10].split(",");
		$('#EditToolsSetup').val(EditToolsSetup).trigger('change');
		console.log(EditToolsSetup);
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
var editor_config = {
		toolbar : [
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
					name : 'align',
					items : [ 'JustifyLeft', 'JustifyCenter',
							'JustifyRight', 'JustifyBlock' ]
				} ],
		removeButtons : 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',
		customConfig : '',
		disallowedContent : 'img{width,height,float}',
		extraAllowedContent : 'img[width,height,align]',
		height : 80,
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
		}, ]
	};
CKEDITOR.replace('EditorPreConditions', editor_config);
$('#myform1').submit(function() {
	 var data =CKEDITOR.instances['EditorPreConditions'].getData();
	 console.log(data);
	 $('#PreConditionsAdd').val(data);
	 });

	CKEDITOR.replace('EditorPostConditions', editor_config);
	 $('#myform1').submit(function() {
		 var data =CKEDITOR.instances['EditorPostConditions'].getData();
		 console.log(data);
		 $('#PostConditionsAdd').val(data);
		 });
	 CKEDITOR.replace('EditorSafetyReq', editor_config);
	 $('#myform1').submit(function() {
		 var data =CKEDITOR.instances['EditorSafetyReq'].getData();
		 console.log(data);
		 $('#SafetyReqAdd').val(data);
		 });
	 CKEDITOR.replace('EditorPersonnelResources', editor_config);
	 $('#myform1').submit(function() {
		 var data =CKEDITOR.instances['EditorPersonnelResources'].getData();
		 console.log(data);
		 $('#PersonnelResourcesAdd').val(data);
		 });
	 CKEDITOR.replace('EditorPreConditionsForEdit', editor_config);
	 $('#myform2').submit(function() {
		 var data =CKEDITOR.instances['EditorPreConditionsForEdit'].getData();
		 console.log(data);
		 $('#EditPreConditions').val(data);
		 });
	 CKEDITOR.replace('EditorPostConditionsForEdit', editor_config);
	 $('#myform2').submit(function() {
		 var data =CKEDITOR.instances['EditorPostConditionsForEdit'].getData();
		 console.log(data);
		 $('#EditPostConditions').val(data);
		 });
	 CKEDITOR.replace('EditorPersonnelResourcesForEdit', editor_config);
	 $('#myform2').submit(function() {
		 var data =CKEDITOR.instances['EditorPersonnelResourcesForEdit'].getData();
		 console.log(data);
		 $('#EditPersonnelResources').val(data);
		 });
	
	 CKEDITOR.replace('EditorSafetyReqforEdit', editor_config);
	 $('#myform2').submit(function() {
		 var data =CKEDITOR.instances['EditorSafetyReqforEdit'].getData();
		 console.log(data);
		 $('#EditSafetyRequirements').val(data);
		 });
	
	 function scrollToTop(){
		    document.body.scrollTop = 0; // For Safari
		    document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE, and Opera
		 	}
 </script>
	
</body>
</html>