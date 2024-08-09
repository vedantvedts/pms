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
	width: 100%;
	margin-top: 4%;
	background: #055C9D;
	font-size: 1rem;
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
	subReqList=RequirementList.stream().filter(e->e[15]!=null && e[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
}

List<Object[]>VerificationMethodList = (List<Object[]>)request.getAttribute("VerificationMethodList");

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

//RequirementInitiation reqInitiation = (RequirementInitiation)request.getAttribute("reqInitiation");
//String status = reqInitiation!=null?reqInitiation.getReqStatusCode():"RIN";
//List<String> reqforwardstatus = Arrays.asList("RIN","RRR","RRA");

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
	<div id="reqmain" class="card-slider">

		<div class="container-fluid" style="" id="main">
			<div class="row">
				<div class="col-md-12">
					<div class="card shadow-nohover" style="margin-top: -0px;">
						<div class="row card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
							<div class="col-md-9" id="projecthead">
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
							<div class="col-md-3" id="addReqButton">
								<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
								<button class="btn btn-success btn-sm submit" style=""
										type="button" onclick='showdata()' data-toggle="tooltip"
										data-placement="top" data-original-data=""
										title="Link REQUIREMENTS">ADD HEADINGS</button>
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
				<div>	<button  type="button" class="btn btn-secondary viewbtn mt-2" style="width:88%" id="<%=obj[0] %>" value="<%=obj[14].toString()%>"  onclick="showDetails(<%=obj[0].toString()%>,'M')">
						 <%=(++count)+". "+ obj[3] %>
					</button>
					<button style="width:10%;background: white;" class="btn btn-sm" onclick="openSubReqModal(<%=obj[14].toString()%>,<%=obj[0].toString()%>)" data-toggle="tooltip" data-placement="bottom" data-original-data="" title="ADD REQ">
						<i class="fa fa-plus-square" aria-hidden="true"></i>
					</button> </div>
					<div class="col-md-10 subDiv" id="subDiv<%=obj[0].toString()%>" style="display:none;" >
					
						<% List<Object[]>subList=RequirementList.stream().filter(e->e[15].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());
							if(subList!=null && subList.size()>0){
								subList = subList.stream().sorted(Comparator.comparingInt(e -> Integer.parseInt(e[14].toString()))).collect(Collectors.toList());
								int subcount=0;
									for(Object[] obj1:subList){
						%>	
			
				
							<button type="button" class="btn btn-secondary viewbtn mt-2" id="<%=obj1[0] %>" value="<%=obj1[0]%>"  onclick="showDetailss(<%=obj1[0].toString()%>,<%=obj[0].toString()%>)" >
								<i class="fa fa-caret-right" aria-hidden="true" style="color:white;"></i> &nbsp;  
								<%=count+"."+(++subcount)+". "+  obj1[1] %>
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
								<!-- 	<div class="col-md-2" id="reqName"></div> -->
									

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
								<!-- 	<div class="col-md-3" style="">
										<h5 style="font-size: 22px; color: #005086;">Linked
											Requirements:</h5>
										<span id="linked" style="font-size: 18px;"></span>

									</div> -->

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

		 					<div class="col-md-12">
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
												<select class="form-control selectdee" name="LinkedPara" id="LinkedPara" data-width="80%" data-live-search="true" multiple onchange="">
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
											<textarea  name="description" class="form-control" id="descriptionadd" maxlength="4000" rows="5" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
										</div>
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
											Test:
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
							<button type="submit" class="btn btn-primary btn-sm submit btn-req" id="add" name="action" value="SUBMIT" onclick="return confirm('Are you sure to submit?');">SUBMIT</button>
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
												<select class="form-control selectdee" name="LinkedPara" id="LinkedParaEdit" data-width="80%" data-live-search="true" multiple onchange="">
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
											<textarea  name="description" class="form-control" id="descriptionedit" maxlength="4000" rows="5" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
										</div>
									</div>
								</div>
							</div>
									
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Demonstration:<span class="mandatory" style="color: red;"></span>
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
											Test:<span class="mandatory" style="color: red;">*</span>
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
								<div class="row">
									<div class="col-md-3">
										<label style="margin-top: 15px; font-size: 17px; color: #07689f">
											Analysis:<span class="mandatory" style="color: red;">*</span>
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
										Inspection:<span class="mandatory" style="color: red;">*</span>
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
										Special Methods:<span class="mandatory" style="color: red;">*</span>
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
							<button type="submit" class="btn btn-primary btn-sm edit btn-req" id="add" name="action" value="SUBMIT" onclick="return confirm('Are you sure to submit?');">UPDATE</button>
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
<!--        				<div align="center" class="mb-2"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#staticBackdrop">ADD NEW</button></div>
 -->      				<hr class="mb-2">
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
<!-- 				
								<!-- 	<div class=col-md-12>
										<div class="row">
											<div class="col-md-4">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f; margin-left: 0.1rem">Remarks
													<span class="mandatory" style="color: red;">*</span>
												</label>
											</div>
											<div class="col-md-8" style="margin-top: 10px">
												<div class="form-group">
													<input type="text" name="remarks" class="form-control"
														id="remarks" maxlength="255" required="required"
														placeholder="Maximum 250 Chararcters">
												</div>
											</div>
										</div>
									</div> -->
		

							
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
        <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Understood</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
function showdata(){
	$('#exampleModalLong').modal('show');
}

function reqSubmit(){
		var checkboxes = document.querySelectorAll('input[name="ReqValue"]');
		console.log("Selected values: ", checkboxes);
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
	    		console.log(typeof ajaxresult)
	    		
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
	$('#'+InitiationReqId).css("background","green");
	
	$('#row1').show();
	$('#row2').hide();
	$('#row3').hide();
	if(tempVal!=InitiationReqId){
		isOpen=false;
		tempVal=InitiationReqId;
		console.log("isOpen1 "+isOpen);
		console.log("tempVal2 "+tempVal);
	}else{
		isOpen=true;
		tempVal=0;
		console.log("isOpen3 "+isOpen);
		console.log("tempVal4 "+tempVal);
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
	console.log("ReqMainId" +ReqMainId)
	
	
	$.ajax({
			url:'RequirementJsonValue.htm',
			datatype:'json',
			data:{
				inititationReqId:InitiationReqId
			},
			success:function(result){
				 var ajaxresult=JSON.parse(result);
				$('#brief').html(ajaxresult[2]);
				
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

var map = new Map();
function showDetailss(subId,Id){
	$('.viewbtn').css("background","#055C9D");
	$('#'+subId).css("background","green");
	$('#'+Id).css("background","green");
	$('#subDivs').show();
	$('#row1').show();
	$('#row2').hide();
	$('#row3').hide();
	$.ajax({
		url:'RequirementJsonValue.htm',
		datatype:'json',
		data:{
			inititationReqId:subId
		},
		success:function(result){
			 var ajaxresult=JSON.parse(result);
			 console.log(ajaxresult)
			$('#brief').html(ajaxresult[2]+" (" +ajaxresult[4]+" )");
			
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
	console.log("InitiationReqId"+InitiationReqId)
	$.ajax({
			url:'RequirementJsonValue.htm',
			datatype:'json',
			data:{
				inititationReqId:InitiationReqId
			},
			success:function(result){
				 var ajaxresult=JSON.parse(result);
				console.log(ajaxresult);
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
	console.log("InitiationReqId"+InitiationReqId)
	$.ajax({
			url:'RequirementJsonValue.htm',
			datatype:'json',
			data:{
				inititationReqId:InitiationReqId
			},
			success:function(result){
				 var ajaxresult=JSON.parse(result);
				console.log(ajaxresult);
				 $('#descriptionedit').val(ajaxresult[3])
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
		
			 var reqtypeName =ajaxresult[4].split("_")[0];  
		      
		        var matchingKey = null;

		        map.forEach((value, key) => {
		            if (value === reqtypeName) {
		                matchingKey = key;
		            }
		        });
				$('#reqTypeedit').val(matchingKey)
		        console.log("Matching Key:", matchingKey);
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
			console.log(ajaxresult)
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
	
	
	console.log($('#'+value).val())
	
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
$( document ).ready(function() {
<%-- 	showDetails(<%=InitiationReqId%>,'M') --%>
	showDetailss(<%=InitiationReqId%>,<%=subId%>)
});
<%}%>


<%if(RequirementList==null || RequirementList.isEmpty()){%>
$( document ).ready(function() {
	showdata()
});
<%}%>



</script>

</body>
</html>