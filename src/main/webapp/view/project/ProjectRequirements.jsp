<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PMS</title>
<%-- <spring:url value="/resources/css/Multiselect1.css" var="Multiselect1Css" />     
<link href="${Multiselect1Css}" rel="stylesheet" /> --%>
<jsp:include page="../static/header.jsp"></jsp:include>
<%--  <spring:url value="/resources/js/Multiselect1.js" var="Multiselect1js" />  
<script src="${Multiselect1js}"></script>  --%>
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
</style>

</head>
<%
	List<Object[]> ProjectIntiationList=(List<Object[]>)request.getAttribute("ProjectIntiationList"); 
 	String projectshortName=(String)request.getAttribute("projectshortName");
	String initiationid=(String)request.getAttribute("initiationid");
	String projectTitle=(String)request.getAttribute("projectTitle");
 	List<Object[]>RequirementList=(List<Object[]>)request.getAttribute("RequirementList"); 
 	List<Object[]>RequirementTypeList=(List<Object[]>)request.getAttribute("reqTypeList");
 	String filesize=(String) request.getAttribute("filesize"); 
 	String initiationReqId=(String)request.getAttribute("initiationReqId");
 	List<Object[]>RequirementFiles=(List<Object[]>)request.getAttribute("RequirementFiles");
 	Object[]RequirementStatus=(Object[])request.getAttribute("RequirementStatus");
 	List<Object[]>ParaDetails=(List<Object[]>)request.getAttribute("ParaDetails");
 	Boolean b=false;
 	if(RequirementStatus!=null){
 	if(RequirementStatus[1].toString().equalsIgnoreCase("RIN")||RequirementStatus[1].toString().equalsIgnoreCase("RID")||RequirementStatus[1].toString().equalsIgnoreCase("RIP")||RequirementStatus[1].toString().equalsIgnoreCase("RIA")||RequirementStatus[1 ].toString().equalsIgnoreCase("RIT")){
 	b=true;
 	}
 	}
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
	<%if(ProjectIntiationList==null ) {%>
	<div
		style="margin-top: 20%; display: flex; justify-content: center; align-items: center;">
		<h3>No Data Available!</h3>
	</div>
	<%}else{ %>
	<div id="reqmain" class="card-slider">
		<%-- 		<form class="form-inline" method="POST"
			action="ProjectRequirement.htm">
			<div class="row W-100" style="width: 80%; margin-top: -0.5%;">
				<div class="col-md-2" id="div1">
					<label class="control-label"
						style="font-size: 15px; color: #07689f;">Project Name :</label>
				</div>
				<div class="col-md-2" style="margin-top: 3px;" id="projectname">
					<select class="form-control selectdee" id="project"
						required="required" name="project">
						<%if(!ProjectIntiationList.isEmpty()) {
                                        for(Object[]obj:ProjectIntiationList){%>
						<option value="<%=obj[0]+"/"+obj[4]+"/"+obj[5]%>"
							<%if(obj[4].toString().equalsIgnoreCase(projectshortName)) {%>
							selected <%}else {%>disabled<%} %>><%=obj[4] %></option>
						<%}} %>
					</select>
				</div>

				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input id="submit" type="submit"
					name="submit" value="Submit" hidden="hidden">
			</div>
		</form> --%>
		<div class="container-fluid" style="display: none;" id="main">
			<div class="row">
				<div class="col-md-12">
					<div class="card shadow-nohover" style="margin-top: -0px;">
						<div class="row card-header"
							style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
							<div class="col-md-9" id="projecthead">
								<h5 style="margin-left: 1%;">
									<%=" "+projectshortName+" "+ "System Requirements List" %>
								</h5>
							</div>

							<div class="col-md-3" id="addReqButton">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden"
									name="projectshortName" value="<%=projectshortName %>" /> <input
									type="hidden" name="IntiationId" value="<%=initiationid %>" />
								<form action="#">
									<input type="hidden" name="project"
										value="<%=initiationid+"/"+projectshortName+"/"+projectTitle%>">
									<%if(b||RequirementStatus==null) {%>
									<button class="btn btn-success btn-sm submit" style="margin-top: -3%;"
										type="button" onclick='showdata()' data-toggle="tooltip"
										data-placement="top" data-original-data=""
										title="ADD REQUIREMENTS">ADD REQUIREMENETS</button>
									<%} %>
									<button class="btn btn-info btn-sm  back ml-2"
										formaction="ProjectOverAllRequirement.htm" formmethod="get"
										formnovalidate="formnovalidate" style="margin-top: -3%;">BACK</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%if((RequirementList!=null) &&(!RequirementList.isEmpty())){ %>
		<div class="requirementid"
			style="display:block;<%if(RequirementList.size()>9){%>height:500px;<%}%>">

			<%int count=1;
			for(Object []obj:RequirementList) {%>
			<button type="button" class="btn btn-secondary viewbtn mt-2"
				id="<%=obj[0] %>" value="<%=obj[0]%>"><%=obj[1] %></button>
			<%count++;} %>
		</div>
		<div class="container" id="container">
			<div class="row">
				<div class="col-md-12" id="reqdiv">
					<div class="card-body" id="cardbody">
						<div class="row">
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-2" id="reqName"></div>
									<div class="col-md-10" style="" id="editreq"></div>

								</div>
							</div>
							<div class="col-md-10" style="margin-top: 1%">
								<h5 style="font-size: 22px; color: #005086; width: fit-content">Brief
								</h5>

							</div>

							<div class="col-md-12" style="">
								<p id="brief" style="font-size: 18px;"></p>
								<hr>
							</div>
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-3" style="">
										<h5 style="font-size: 22px; color: #005086;">Linked
											Requirements:</h5>
										<span id="linked" style="font-size: 18px;"></span>

									</div>

									<div class="col-md-4" style="">
										<div class="row">
											<div class="col-md-4">
												<h5 style="font-size: 22px; color: #005086;" id="priority">Priority
													:</h5>
											</div>
											<p id="Prioritytext" style="font-size: 18px;"></p>
										</div>
									</div>
									<hr>
									<div class="col-md-4">
										<div class="row">
											<div class="col-md-4"
												style="padding-left: 0px; padding-right: 0px;">
												<h5 style="font-size: 22px; color: #005086;" id="priority">Need
													Type :</h5>
											</div>
											<p id="needtypetext" style="font-size: 18px;"></p>
										</div>
									</div>


								</div>
								<hr>
							</div>
							<!-- category -->
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-2" style="margin-top: 1%">
										<h5
											style="font-size: 20px; color: #005086; width: fit-content">Category:</h5>
									</div>
									<div class="col-md-10" style="margin-top: 1%;">
										<p id="categoryShow" style="font-size: 18px;">azxzczxc</p>
									</div>
								</div>
								<hr>
							</div>

							<div class="col-md-12" style="">
								<h5 style="font-size: 22px; color: #005086; width: fit-content">Description
								</h5>

							</div>
							<div class="col-md-12" style="">
								<p id="description" style="font-size: 18px;"></p>
								<hr>
							</div>
							<form action="###" class="form-horizontal" style="width: 100%">

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

										<div class="row">
											<input type="hidden" name="IntiationId"
												value="<%=initiationid %>" /> <input type="hidden"
												name="projectshortName" value="<%=projectshortName %>" /> <input
												type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" />
										</div>
									</div>
								</div>
								<hr>
								<div class="col-md-12">
									<div class="row">
										<div class="col-md-2" style="margin-top: 1%">
											<h5
												style="font-size: 20px; color: #005086; width: fit-content">Constraints:</h5>
										</div>
										<div class="col-md-10" style="margin-top: 1%;">
											<p id="constrainshow" style="font-size: 18px;"></p>
										</div>
									</div>
								</div>
							</form>
						</div>

					</div>
				</div>
			</div>

			<%} %>
		</div>
		<button onclick="scrollToTop()" id="scrollButton"
			data-toggle="tooltip" data-placement="top" data-original-data=""
			title="Go to Top">
			<i class="fa fa-arrow-up" aria-hidden="true"></i>
		</button>
		<!--modal for empty list  -->
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content"
					style="margin-top: 50%; background: azure;">
					<div class="modal-header" style="height: 10px;">
						<h5 class="modal-title" id="exampleModalLabel"></h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="margin-top: -6%;">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class=col-md-12>
							<div class="row">
								<div class="col-md-12" id="modaal-A">
									No Requirement is available for
									<%=projectshortName %>
								</div>
							</div>
							<br>
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-5"></div>
									<div class="col-md-2" id="addReqButton">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <input type="hidden"
											name="projectshortName" value="<%=projectshortName %>" /> <input
											type="hidden" name="IntiationId" value="<%=initiationid %>" />
										<button class="btn btn-primary btn-sm submit"
											style="margin-top: -5%;" type="button" onclick='showdata()'>ADD
											REQUIREMENETS</button>
									</div>
								</div>
							</div>

						</div>

					</div>
				</div>
			</div>


		</div>
		<div style="display: none;">
			<button type="button" class="btn btn-primary show"
				data-toggle="modal" data-target="#exampleModal"></button>
		</div>
		<!--*********************** modal for add **************************-->
		<form class="form-horizontal" role="form"
			action="ProjectRequirementAddSubmit.htm" method="POST" id="myform1">
			<div class="modal fade bd-example-modal-lg" id="exampleModalLong"
				tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg modal-dialog-jump">
					<div class="modal-content addreq" style="width: 150%;">
						<div class="modal-header" id="modalreqheader">
							<h5 class="modal-title" id="exampleModalLabel">Requirements</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close" style="color: white">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div style="height: 550px; overflow: auto;" id="scrollclass">
							<div class="modal-body">
								<div class="col-md-12">
									<div class="row">
										<div class="col-md-3">
											<label
												style="font-size: 17px; margin-top: 5%; margin-left: 5%; color: #07689f">
												Requirement Type<span class="mandatory" style="color: red;">*</span>
											</label>
										</div>
										<div class=col-md-3>
											<select required="required" id="select" name="reqtype"
												class="form-control selectpicker" data-width="80%"
												data-live-search="true" style="margin-top: 5%">
												<option disabled="disabled" value="" selected="selected">Choose..</option>
												<%if(!RequirementTypeList.isEmpty()){
												for(Object[] obj:RequirementTypeList){ %>
												<option value="<%=obj[0]+" "+obj[1]+" "+obj[3]%>"><%=obj[3]+"-"+obj[2]%></option>
												<%}}%>
											</select>
										</div>
										<div class=col-md-2>
											<label
												style="font-size: 17px; margin-top: 7%; margin-left: 0.1rem; color: #07689f">Priority<span
												class="mandatory" style="color: red;">*</span></label>
										</div>
										<div class=col-md-3>
											<select required="required" id="priorityAdd" name="priority"
												class="form-control selectpicker" data-width="80%"
												data-live-search="true" style="margin-top: 5%">
												<option disabled="disabled" value="" selected="selected">Choose..</option>
												<option value="L">Low</option>
												<option value="M">Medium</option>
												<option value="H">High</option>
											</select>
										</div>
									</div>

									<div class="col-md-12">
										<div class="row">
											<div class="col-md-3">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f">Need
													Type<span class="mandatory" style="color: red;">*</span>
												</label>
											</div>
											<div class="col-md-3">
												<select required="required" id="needtypeadd" name="needtype"
													class="form-control selectpicker" data-width="80%"
													data-live-search="true" style="margin-top: 5%">
													<option disabled="disabled" value="" selected="selected">Choose..</option>
													<option value="E">Essential</option>
													<option value="D">Desirable</option>
												</select>
											</div>
											<div class="col-md-2">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f">Category<span
													class="mandatory" style="color: red;">*</span>
												</label>
											</div>
											<div class="col-md-3">
												<select required="required" id="categoryAdd" name="Category"
													class="form-control selectpicker" data-width="80%"
													data-live-search="true" style="margin-top: 5%">
													<option disabled="disabled" value="" selected="selected">Choose..</option>
													<option value="E">Environmental</option>
													<option value="P">Performance</option>
													<option value="M">Maintenance</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-4">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f">Linked
													Requirements</label>
											</div>
											<div class="col-md-7" style="margin-top: 1%;">
												<div class="form-group">

													<%if((RequirementList!=null) &&(!RequirementList.isEmpty())){%>
													<select class="form-control selectdee"
														name="linkedRequirements" id="linkedRequirements"
														data-width="80%" data-live-search="true" multiple
														onchange="showSelectValue()">
														<option value="" disabled="disabled">---Choose----</option>
														<%for(Object[] obj:RequirementList){ %>
														<option value="<%=obj[0]%>" title=<%=obj[3] %>><%=obj[1]%></option>
														<%}%>
													</select>
													<%}else{%>
													<input class="form-control" name="linkedRequirements"
														id="linkedRequirements" value="" readonly
														placeholder="No requirements to Choose">
													<%} %>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-4">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f">Linked
													Para</label>
											</div>
											<div class="col-md-7" style="margin-top: 1%;">
												<div class="form-group">
													<%
													if ((ParaDetails != null) && (!ParaDetails.isEmpty())) {
													%>
													<select class="form-control selectdee" name="LinkedPara"
														id="LinkedPara" data-width="80%" data-live-search="true"
														multiple onchange="">
														<option value="" disabled="disabled">---Choose----</option>
														<%
														for (Object[] obj : ParaDetails) {
														%>
														<option value="<%=obj[0]%>"><%=obj[3]%></option>
														<%
														}
														%>
													</select>
													<%
													} else {
													%>
													<input class="form-control" name="LinkedPara"
														id="LinkedPara" value="" readonly
														placeholder="No para specified for Project">
													<%} %>
												</div>
											</div>
										</div>
									</div>
									<div class=col-md-12>
										<div class="row">
											<div class="col-md-4">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f; margin-left: 0.1rem">Requirement
													Brief<span class="mandatory" style="color: red;">*</span>
												</label>
											</div>
											<div class="col-md-8" style="margin-top: 10px">
												<div class="form-group">
													<input type="text" name="reqbrief" class="form-control"
														id="reqbrief" maxlength="255" required="required"
														placeholder="Maximum 250 Chararcters"
														style="line-height: 3rem !important">
												</div>
											</div>
										</div>
									</div>
									<div class=col-md-12>
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
													<textarea required="required" name="description"
														class="form-control" id="descriptionadd" maxlength="4000"
														rows="5" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
												</div>
											</div>
										</div>
									</div>
									<div class=col-md-12>
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
									</div>
									<!-- Constraints  -->
									<div class=col-md-12>
										<div class="row">
											<div class="col-md-4">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f; margin-left: 0.1rem">Constraints
													<span class="mandatory" style="color: red;">*</span>
												</label>
											</div>
											<div class="col-md-8" style="margin-top: 10px">
												<div class="form-group">
													<input type="text" name="Constraints" class="form-control"
														id="remarks" maxlength="255" required="required"
														placeholder="Maximum 250 Chararcters">
												</div>
											</div>
										</div>
									</div>

									<div class="col-md-12">
										<div class="row">
											<div class="col-md-4">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f">Linked
													Documents</label>
											</div>
											<div class="col-md-8" style="margin-top: 1%;">
												<div class="form-group">

													<%if(!RequirementFiles.isEmpty()){ %>
													<select class="form-control selectdee"
														name="linkedAttachements" id="linkedAttachements"
														data-width="80%" data-live-search="true"
														data-placeholder="Choose" multiple>

														<%for(Object[] obj:RequirementFiles){ %>
														<option value="<%=obj[0]%>"><%=obj[3]%></option>
														<%}%>
													</select>
													<%} else{%>
													<input class="form-control" readonly
														name="linkedAttachements" id="linkedAttachements"
														placeholder="No files found">
													<%} %>
												</div>


											</div>
										</div>
									</div>





									<input type="hidden" name="IntiationId"
										value="<%=initiationid %>" /> <input type="hidden"
										name="projectshortName" value="<%=projectshortName %>" />
									<div class="form-group" align="center" style="margin-top: 3%;">
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" />
										<button type="submit" class="btn btn-primary btn-sm submit"
											id="add" name="action" value="SUBMIT"
											onclick="return reqCheck('myform1');">SUBMIT</button>

									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</form>

		<!-- modal for attacments  -->

		<!-- attachment modal end  -->
		<!--*************************************************************** modal for edit************************************* -->
		<form class="form-horizontal" role="form"
			action="ProjectRequirementEditSubmit.htm" method="POST" id="myform2">
			<div class="modal fade bd-example-modal-lg" id="exampleModalLongedit"
				tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg">

					<div class="modal-content addreq modal-dialog-jump" style="width: 150%;">
						<div class="modal-header" id="modalreqheader">
							<h5 class="modal-title" id="exampleModalLabel">Requirement</h5>
							<div class=col-md-3 id="headerid">
								<div class="row">
									<h6 style="font-size: 12px;">ID-</h6>
									<h6 style="font-size: 12px;" id="reqID" class="reqID1"></h6>
								</div>
							</div>
							<div class=col-md-3 id="headeridedit">
								<div class="row " id="headerdata"></div>
							</div>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close" style="color: white">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div style="height: 550px; overflow: auto;" id="scrollclass">
							<div class="modal-body">
								<div class="col-md-12">
									<div class="row">
										<div class="col-md-3">
											<label
												style="font-size: 17px; margin-top: 5%; margin-left: 5%; color: #07689f">Requirement
												Type<span class="mandatory" style="color: red;">*</span>
											</label>
										</div>
										<div class=col-md-3>
											<select required="required" id="editreqtype"
												name="editreqtype" class="form-control selectpicker"
												data-width="80%" data-live-search="true"
												style="margin-top: 5%" onchange="editReqTypeChange()">
												<option disabled="disabled" value="" selected="selected">Choose..</option>
												<%if(!RequirementTypeList.isEmpty()){
													for(Object[] obj:RequirementTypeList){ %>
												<option value="<%=obj[0]%>"><%=obj[3]+"-"+obj[2]%></option>
												<%}} %>
											</select>
										</div>
										<div class=col-md-2>
											<label
												style="font-size: 17px; margin-top: 7%; margin-left: 0.1rem; color: #07689f">Priority<span
												class="mandatory" style="color: red;">*</span></label>
										</div>
										<div class=col-md-3>
											<select required="required" id="editselect"
												name="priorityedit" class="form-control selectpicker"
												data-width="80%" data-live-search="true"
												style="margin-top: 5%">
												<option value="L">Low</option>
												<option value="M">Medium</option>
												<option value="H">High</option>
											</select>
										</div>
									</div>
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-3">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f">Need
													Type<span class="mandatory" style="color: red;">*</span>
												</label>
											</div>
											<div class="col-md-3">
												<select required="required" id="editneedtype"
													name="needtype" class="form-control selectpicker"
													data-width="80%" data-live-search="true"
													style="margin-top: 5%">
													<option disabled="disabled" value="" selected="selected">Choose..</option>
													<option value="E">Essential</option>
													<option value="D">Desirable</option>
												</select>
											</div>

											<!--Category  -->
											<div class="col-md-2">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f">Category<span
													class="mandatory" style="color: red;">*</span>
												</label>
											</div>
											<div class="col-md-3">
												<select required="required" name="CategoryEdit"
													id="CategoryEdit" class="form-control selectpicker"
													data-width="80%" data-live-search="true"
													style="margin-top: 5%">
													<option disabled="disabled" value="" selected="selected">Choose..</option>
													<option value="E">Environmental</option>
													<option value="P">Performance</option>
													<option value="M">Maintenance</option>
												</select>
											</div>

										</div>
									</div>
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-3">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f">Linked
													Requirements</label>
											</div>
											<div class="col-md-9" style="margin-top: 1%;">
												<div class="form-group">
													<select class="form-control selectdee"
														name="linkedRequirementsedit" id="linkedRequirementsedit" onchange="showSelectEditValue()"
														data-width="80%" data-live-search="true"
														data-placeholder="Choose" multiple>

														<%if((RequirementList!=null) &&(!RequirementList.isEmpty())){%>
														<%for(Object[] obj:RequirementList){ %>
														<option value="<%=obj[0]%>"><%=obj[1]%></option>
														<%}}%>

													</select>
												</div>

											</div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-3">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f">Linked
													Para</label>
											</div>
											<div class="col-md-9" style="margin-top: 1%;">
												<div class="form-group">
													<%
													if ((ParaDetails != null) && (!ParaDetails.isEmpty())) {
													%>
													<select class="form-control selectdee"
														name="LinkedParaEdit" id="LinkedParaEdit" data-width="80%"
														data-live-search="true" multiple onchange="">
														<option value="" disabled="disabled">---Choose----</option>
														<%
														for (Object[] obj : ParaDetails) {
														%>
														<option value="<%=obj[0]%>"><%=obj[3]%></option>
														<%
														}
														%>
													</select>
													<%
													} else {
													%>
													<input class="form-control" name="LinkedParaEdit"
														id="LinkedParaEdit" value="" readonly
														placeholder="No para specified for Project">
													<%} %>
												</div>
											</div>
										</div>
									</div>


									<div class=col-md-12>
										<div class="row">
											<div class="col-md-3">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f; margin-left: 0.1rem">Requirement
													Brief<span class="mandatory" style="color: red;">*</span>
												</label>
											</div>
											<div class="col-md-8" style="margin-top: 10px">
												<div class="form-group" id="editrqbrief"></div>
											</div>
										</div>
									</div>
									<div class=col-md-12>
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
												<div class="form-group" id="editdescription"></div>
											</div>
											<div class=col-md-12>
												<div class="row">
													<div class="col-md-3">
														<label
															style="font-size: 17px; margin-top: 5%; color: #07689f; margin-left: 0.1rem">Remarks
															<span class="mandatory" style="color: red;">*</span>
														</label>
													</div>
													<div class="col-md-8" style="margin-top: 10px">
														<div class="form-group" id="remarksedit"></div>
													</div>
												</div>
											</div>
										</div>
									</div>

									<div class=col-md-12>
										<div class="row">
											<div class="col-md-3">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f; margin-left: 0.1rem">Constraints
													<span class="mandatory" style="color: red;">*</span>
												</label>
											</div>
											<div class="col-md-8" style="margin-top: 10px">
												<div class="form-group">
													<input type="text" name="Constraints" class="form-control"
														id="ConstraintsEdit" maxlength="255" required="required"
														placeholder="Maximum 250 Chararcters">
												</div>
											</div>
										</div>
									</div>

									<div class="col-md-12">
										<div class="row">
											<div class="col-md-3">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f">Linked
													Documents</label>
											</div>
											<div class="col-md-9" style="margin-top: 1%;">
												<div class="form-group">


													<select class="form-control selectdee"
														name="linkedAttachements" id="linkedAttachementsedit"
														data-width="80%" data-live-search="true"
														data-placeholder="Choose" multiple>

														<%for(Object[] obj:RequirementFiles){ %>
														<option value="<%=obj[0]%>"><%=obj[3]%></option>
														<%}%>
													</select>

												</div>


											</div>
										</div>
									</div>

									<input type="hidden" name="IntiationId"
										value="<%=initiationid %>" /> <input type="hidden"
										name="projectshortName" value="<%=projectshortName %>" />
									<div id="editvalues"></div>
									<div class="form-group" align="center">
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" />
										<button type="submit" class="btn btn-primary btn-sm submit"
											id="add" name="action" value="SUBMIT"
											onclick="return editCheck('myform2');">SUBMIT</button>

									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</form>

		<!--modal for view attachments-->

		<div class="modal fade bd-example-modal-lg"
			id="exampleModalLongAttachment" tabindex="-1" role="dialog"
			aria-labelledby="myLargeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-jump">
				<div class="modal-content addreq"
					style="width: 100%; margin-left: 0%; ">
					<div class="modal-header" id="modalreqheader">
						<h5 class="modal-title" id="exampleModalLabel">Attachments</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="color: white">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>

					<div class="modal-body" style="background: aliceblue;">
						<div class="row">
							<div class="col-md-12">
								<form action="#">
									<table class="table table-bordered " style="width: 100%;"
										id="MyTable1">
										<thead>
											<tr>
												<th style="width: 4.8889px; text-align: center;">SN</th>
												<th style="text-align: center;">Name</th>
												<th style="text-align: center;">UpdateOn</th>
												<th style="text-align: center;">Action</th>
											</tr>
										</thead>
										<tbody id="listtbody">

										</tbody>
									</table>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%} %>
		<!-- select dropdown on change modal  -->
		<div class="modal fade" id="dataModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-dialog-jump-pop" role="document">
				<div class="modal-content" style="border-radius: 30px;">

					<div class="modal-body">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" id="myButtonModal">
							<span aria-hidden="true" style="color: red;">&times;</span>
						</button>
						<div id="modalhead"
							style="padding: 10px 10px 10px 0px; font-weight: 700; color: coral"></div>
						<div id="modalbody"></div>
					</div>
				</div>
			</div>
		</div>



		<script>
$(document).ready(function() {
	   $('#project').on('change', function() {
		   var temp=$(this).children("option:selected").val();
		   $('#submit').click(); 
	   });
	});
	<%if(projectshortName!=null){%>
$(document).ajaxComplete(function(){
	$('#main').css("display", "inline-block");
	$('#main').css("margin-top", "0.5%");
	$('#message').css("display","block");

});


	$('.viewbtn').click(function(){
		$('.viewbtn').css("background","#055C9D");
		$(this).css("background","green");
		var initiationId=<%=initiationid%>;
		var value=$(this).val();
		$.ajax({
			type:'GET',
			url:'RequirementJsonValue.htm',
			datatype:'json',
	     	data:{
				inititationReqId:value
			},
		success:function(result){
			 var ajaxresult=JSON.parse(result);
			 var s="";
			$('#brief').html(ajaxresult[2]);
			 
			 if(ajaxresult[5]==="L"){
			$('#Prioritytext').html("Low");
			 }else if(ajaxresult[5]==="M"){
					$('#Prioritytext').html("Medium"); 
			 }else{
				 $('#Prioritytext').html("High"); 
			 }
			 
				$('#reqName').html(ajaxresult[4]);	 
			$('#description').html(ajaxresult[3]);
			
	
			  if(ajaxresult[10].length>0){
					if(!ajaxresult[10].includes(",")){
						var myArray1=ajaxresult[10].split(ajaxresult[10].length);
					}else{
					var myArray1=ajaxresult[10].split(",");
					}
					}		
			$('#editreq').html('<button type="button" title="EDIT" data-toggle="tooltip" data-placement="top" title="Tooltip on top" class="btn btn-sm  btn-warning edit " onclick="edit()" name="action" value="'+ajaxresult[7] +'"id="reqbtns" >EDIT</button><button class="btn btn-info back"  onclick="showAttachment('+'['+myArray1+']'+')" style="margin-left:1%; box-shadow:2px 2px 2px gray">View Attachments</button>');
			
			var myArray=[];
			  if(ajaxresult[6].length>0){
					if(!ajaxresult[6].includes(",")){
						 myArray=ajaxresult[6].split(ajaxresult[6].length);
					}else{
					myArray=ajaxresult[6].split(",");
					}
					}
			  if(ajaxresult[6].length==0){
				  $('#linked').html("-");  
			  }else{
				 $.ajax({
						type:'GET',
						url:'RequirementListJsonValue.htm',
						datatype:'json',
						data:{
							initiationId:initiationId
						},
						success:function(result1){
							const map = new Map(Object.entries(JSON.parse(result1)));
							map.forEach((values,keys)=>{
								for(var i=0;i<myArray.length;i++){
									if(myArray[i]==keys){
										s=s+values;
										if(i<myArray.length-1){
											s=s+",";
										}
									}
								}
							    })
								$('#linked').html(s);
						}
						}) 
			  }
		$('#remarksshow').html(ajaxresult[9]);
		$('#constrainshow').html(ajaxresult[12]);	
		if(ajaxresult[11]==="E"){
			$('#categoryShow').html("Environmental");
		}else if(ajaxresult[11]==="P"){
			$('#categoryShow').html("Performance");
		}else{
			$('#categoryShow').html("Maintenance")
		}
		}
		})
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
function showAttachment(documentid){

 $("#MyTable1").DataTable().destroy(); 
 var initiationId=<%=initiationid%>;
var jsArray = [<%int i=0; for (Object[] obj:RequirementFiles) { %>"<%= obj[0] %>"+"//"+"<%=obj[3]%>"+"//"+"<%=obj[9]%>"+"//"+"<%=obj[8]%>"+"//"+"<%=obj[6]%>"+"//"+"<%=obj[1]%>"+"//"+"<%=obj[2]%>" <%= i + 1 < RequirementFiles.size() ? ",":"" %><% } %>];
var html='';
var count=1;
for(var i=0;i<jsArray.length;i++){
	var val =  jsArray[i].split("//")[0] ;
	var value1 =  jsArray[i].split("//")[1] ;
	var value2=jsArray[i].split("//")[2] ;
	var value3=jsArray[i].split("//")[3] ;
	var value4=jsArray[i].split("//")[4] ;
	var value5=jsArray[i].split("//")[5] ;
	var value6=jsArray[i].split("//")[6] ;
	if(documentid.includes(parseInt(val))){
		const dateStr = value2;
		const formattedDate = moment(dateStr).format('DD-MM-YYYY');
	    html=html+'<tr><td style="text-align: center;">'+(count++)+'</td><td>'+value1+'</td><td style="text-align: center;">'+formattedDate+'</td><td align="center"><button class="btn" type="submit" name="DocId"  formaction="ProjectRequirementAttachmentDownload.htm" formtarget="_blank" formmethod="GET" value="'+value3+','+value4+','+value5+','+value6+'"><i class="fa fa-download" ></i></button></td></tr>';
	}
}
$('#listtbody').html(html);
 $("#MyTable1").DataTable({		 
		 "lengthMenu": [5,10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 5,
		 "language": {
		      "emptyTable": "No attachments Added"
		    }
	}); 

$('#exampleModalLongAttachment').modal('show');
}
</script>
		<script type="text/javascript">
function reqCheck(frmid){

	var description=$('#descriptionadd').val();
	var reqbrief=$('#reqbrief').val();
	var remarks=$('#remarks').val();
	var priorityAdd=$('#priorityAdd').val();
	var needtypeadd=$('#needtypeadd').val();
	var categoryAdd=$('#categoryAdd').val();
	console.log(needtypeadd)

	if(description===null||description===""||reqbrief===null||reqbrief===""||remarks===null||remarks===""||priorityAdd==null||needtypeadd==null||categoryAdd==null){
		window.alert('Please fill all the fields');
	}else if
		(description.length>4000){
			var extra=description.length-4000;
			window.alert('Description exceed 4000 characters, '+extra+'characters are extra')
			return false;
		} 
	else{

	if(window.confirm('Are you sure to save?')){
		document.getElementById(frmid).submit(); 
	}else{
		event.preventDefault();
		return false;
	}
	}
}
function editCheck(frmid){
	var description=$('#descriptionedit').val();
	var reqbrief=$('#reqbriefedit').val();
	var editselect=$('#editselect').val();
	var editreqtype=$('#editreqtype').val();
	var linkedRequirementsedit=$('#linkedRequirementsedit').val();

	if(description===null||description===""||reqbrief===null||reqbrief===""){
		window.alert('Please fill all the fields');
	}else if
		(description.length>4000){
			var extra=description.length-4000;
			window.alert('Description exceed 4000 characters, '+extra+'characters are extra')
			return false;
		} 
	else{

	if(window.confirm('Are you sure to save?')){
		document.getElementById(frmid).submit(); 
	}else{
		event.preventDefault();
		return false;
	}
	}
}

<%if((RequirementList!=null) &&(!RequirementList.isEmpty())){%>
$(document).ready(function(){
$('#'+<%=initiationReqId%>).click();
});

$('#'+<%=initiationReqId%>).click(function(){

	$('.viewbtn').css("background","#055C9D");
	$(this).css("background","green");
	var value=$(this).val();
	var initiationId=<%=initiationid%>;

	$.ajax({
		url:'RequirementJsonValue.htm',
		datatype:'json',
		data:{
			inititationReqId:value
		},
	success:function(result){
		 var ajaxresult=JSON.parse(result); 
		 var s="";
		$('#brief').html(ajaxresult[2]);
	
		if(ajaxresult[5]==="L"){
			$('#Prioritytext').html("Low");
			 }else if(ajaxresult[5]==="M"){
					$('#Prioritytext').html("Medium"); 
			 }else{
				 $('#Prioritytext').html("High"); 
			 } 
				 
			if(ajaxresult[8]==="E"){
				$('#needtypetext').html("Essential");
			}else{
				$('#needtypetext').html("Deliverable");
			}
	$('#reqName').html(ajaxresult[4]);	 	
	$('#description').html(ajaxresult[3]);
	  if(ajaxresult[10].length>0){
			if(!ajaxresult[10].includes(",")){
				var myArray1=ajaxresult[10].split(ajaxresult[10].length);
			}else{
			var myArray1=ajaxresult[10].split(",");
			}
			}
		
		$('#editreq').html('<button type="button"  class="btn btn-sm  btn-warning edit " onclick="edit()"  data-toggle="tooltip" data-placement="right" data-original-data="Tooltip on right" title="EDIT" name="action" value="'+ajaxresult[7] +'"id="reqbtns" >EDIT</button><button type="button" class="btn btn-info back" style="margin-left:1%; box-shadow:2px 2px 2px gray" onclick="showAttachment('+'['+myArray1+']'+')">View Attachments</button>');
	    if(ajaxresult[6].length>0){
		if(!ajaxresult[6].includes(",")){
			var myArray=ajaxresult[6].split(ajaxresult[6].length);
		}else{
		var myArray=ajaxresult[6].split(",");
		}
		} 

	    if(ajaxresult[6].length==0){
			  $('#linked').html("-");  
	    }else{
		 $.ajax({
				type:'GET',
				url:'RequirementListJsonValue.htm',
				datatype:'json',
				data:{
					initiationId:initiationId
				},
				success:function(result1){
					const map = new Map(Object.entries(JSON.parse(result1)));
					map.forEach((values,keys)=>{
						for(var i=0;i<myArray.length;i++){
							if(myArray[i]==keys){
								s=s+values;
								if(i<myArray.length-1){
									s=s+",";
								}
							}}
					    })
						$('#linked').html(s);
				}
				}) 
	    }
		$('#remarksshow').html(ajaxresult[9]);
		$('#constrainshow').html(ajaxresult[12]);	
		if(ajaxresult[11]==="E"){
			$('#categoryShow').html("Environmental");
		}else if(ajaxresult[11]==="P"){
			$('#categoryShow').html("Performance");
		}else{
			$('#categoryShow').html("Maintenance")
		}
	}
	});
});
<%}%>
function showdata(){
    $('#exampleModalLong').modal('show');
}
//call for the edit function
var beforeSelectedEditedArray="";// to get the default selected linked requirements 
var linkedReqDropdown = document.getElementById("linkedRequirementsedit").innerHTML;// to get the default dropdown
function edit(){
	
	$('#linkedRequirementsedit').html(linkedReqDropdown);
	var value=$('#reqbtns').val();
	var value2=$('#description').val;
	$.ajax({
		type:'GET',
		url:'RequirementJsonValue.htm',
		datatype:'json',
		data:{
			inititationReqId:value
		},
	success:function(result){
		 var ajaxresult=JSON.parse(result); 
		$('#reqID').html(ajaxresult[4]);
		$('#headerdata').html('<h6 style="font-size: 12px;margin-top:2%;" id="codeedit" >CODE - </h6><input type="text"   class="form-control numbersOnly" maxlength="5" onchange="oninputChange()"    value="'+ajaxresult[4].substring(5)+'" id="code">')
		$('#editdescription').html('<textarea required="required" name="descriptionedit" class="form-control"  id="descriptionedit" maxlength="4000"  rows="5" cols="53" placeholder="Maximum 4000 Chararcters">'+ajaxresult[3]+'</textarea>')
		$('#editrqbrief').html('<input type="text" name="reqbriefedit"class="form-control" id="reqbriefedit" maxlength="255" value="'+ajaxresult[2]+'" required="required" placeholder="Maximum 250 Chararcters" style="line-height: 3rem!important">')
		$('#editselect').val(ajaxresult[5]);
		$('#remarksedit').html('<input type="text" name="remarks" class="form-control" id="remarks" maxlength="255" required="required" value="'+ajaxresult[9]+'" placeholder="Maximum 250 Chararcters">')
	
			const linkedReqDropdown = document.getElementById("linkedRequirementsedit");
 		 	const options = linkedReqDropdown.querySelectorAll("option"); // to remove that requirement from that list
 		 	 options.forEach((option) => {
 		 	    if (value==(option.value)) {
 		 	    	option.remove();
 		 	    }
 		 	  });
		
		const LinkedReqs = ajaxresult[6].split(",");
		
		$('#linkedRequirementsedit').val(LinkedReqs).trigger('change');
		beforeSelectedEditedArray=$('#linkedRequirementsedit').val();
		
		const LinkedDocs=ajaxresult[10].split(",");
		$('#linkedAttachementsedit').val(LinkedDocs).trigger('change');
		
		if(ajaxresult[13]!=null && ajaxresult[13].length>0){
		const LinkedPara=ajaxresult[13].split(",");
		$('#LinkedParaEdit').val(LinkedPara).trigger('change');
		}else{
		$('#LinkedParaEdit').val(" ").trigger('change');
		}
		
		$('#editreqtype').val(ajaxresult[1]);
		$('#editneedtype').val(ajaxresult[8]);
		$('#CategoryEdit').val(ajaxresult[11]);
		$('#ConstraintsEdit').val(ajaxresult[12]);
		$('#editvalues').html('<input type="hidden" id="requirementIds" name="requirementid"class="form-control"  value="'+ajaxresult[4]+'" required="required">'+
		'<input type="hidden" name="InitiationReqId" class="form-control"  value="'+ajaxresult[7]+'">');
	}
	})  
   
 	$('#exampleModalLongedit').modal('show');
	
}


function editReqTypeChange(){
	 var value=document.getElementById('editreqtype').value;
	 var code=document.getElementById('code').value;
	 $.ajax({
		 type:'GET',
		 url:'RequirementTypeJson.htm',
		 dataType:'json',
		 data:{
		 ReqTypeId:value
		 },
		 success:function(result2){
			var result=result2[3]+result2[1]+code;
			console.log(result);
			document.getElementById('reqID').innerHTML=result;
			document.getElementById('requirementIds').value=result;
		 }
	 })
}
<%if((RequirementList.isEmpty())&&(projectshortName!=null)){%>
$(document).ready(function(){
	$('.show').click();
	});
<%}%>
</script>
<script type="text/javascript">
var count=0;
function editcheck(editfileid,alertn)
{
	const fi = $('#'+editfileid )[0].files[0].size;							 	
    const file = Math.round((fi / 1024/1024));
    
    
    const filesize1=<%=filesize%>;
    if (document.getElementById(editfileid).files.length!=0 && file >= <%=filesize%> ) 
    {
    	if(alertn==1){
	    	
    		alert("File too Big, please select a file less than <%=filesize%> mb");
    	}else
    	{
    		count++;
    	}
     	
    }
}
function attchmentadd(){
	var i=1
	$('#Attachments').append('<div class="col-md-4" id="attachmentadd"><input class="form-control" type="file" name="Attachment" id="'+(i+1)+'" accept=".xlsx,.xls,.pdf,.doc,.docx"  onchange="" ><button type="button" class="btn btn-sm removebtn " name="sub" style="margin-left:3%;"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></div>');
	i++;
}

function attchmentaddedit(){
	var i=1
	$('#Attachmentsedit').append('<div class="col-md-4" id="attachmentaddedit"><input class="form-control" type="file" name="Attachedit" id="'+(i+1)+'" accept=".xlsx,.xls,.pdf,.doc,.docx"  onchange="" ><button type="button" class="btn btn-sm removebtn " name="sub" style="margin-left:3%;"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></div>');
	i++;
}

$(document).on("click", ".removebtn", function() {
    $(this).parent("div").remove();
  });

function myFunction(){
	if(window.confirm("Are you sure to delete this attachment?")){
		return true;
	}else{
		  event.preventDefault()
		  return false;
	}
}
$(function () {
    $('#reqbtns[data-toggle="tooltip"]').tooltip({
        animated: 'fade',
        placement: 'top',
        html : true,
    });
});

	function oninputChange(){
		var value=document.getElementById('code').value;
		var intvalue=parseInt(value);
		var initiationId=<%=initiationid%>;
		if(value.length<5){
			alert("The code should be of five digit")
		}else if(/[a-zA-Z]/g.test(value)){
			alert("The code should only contain digits")
		}
		else{
			var flag=true;
			   $.ajax({
					type:'GET',
					url:'ReqCountJson.htm',
					dataType:'json',
					data:{
						initiationId:initiationId
					},
					success:function(result){
						for(var i=0;i<result.length;i++){
							if(result[i]===intvalue){
								flag=false;
								alert("The code already exist");
								console.log(flag);
							}
						}
						if(flag==true){	
							var value1=document.getElementById('reqID').innerHTML.substring(0,5);
							document.getElementById('reqID').innerHTML=value1+value
							document.getElementById('requirementIds').value=value1+value;
							}
					}
				})
		}
		}
		$(function () {
		$('[data-toggle="tooltip"]').tooltip()
		})
	//taking an empty array to track the length of array
	var beforeSelectedArray=[];
	function showSelectValue(){
	var afterSelectedArray=$('#linkedRequirements').val();
	if(afterSelectedArray.length>beforeSelectedArray.length){
	for(var i=0;i<afterSelectedArray.length;i++){
		if(!beforeSelectedArray.includes(afterSelectedArray[i])){
			$.ajax({
				url:'RequirementJsonValue.htm',
				datatype:'json',
				data:{
					inititationReqId:afterSelectedArray[i]
				},
			success:function(result){
				 var ajaxresult=JSON.parse(result);
				 $('#modalhead').html(ajaxresult[4]);
				 $('#modalbody').html(ajaxresult[3]);
			}
			});
		}
	}	
	$('#dataModal').modal('show');
	}
	beforeSelectedArray=afterSelectedArray;
	}
function showSelectEditValue(){
	/* if(beforeSelectedEditedArray.length==0)return; */
 	var afterSelectedEditedArray= $('#linkedRequirementsedit').val();
	if(afterSelectedEditedArray.length>beforeSelectedEditedArray.length){
		for(var i=0;i<afterSelectedEditedArray.length;i++){
			if(!beforeSelectedEditedArray.includes(afterSelectedEditedArray[i])){
				$.ajax({
					url:'RequirementJsonValue.htm',
					datatype:'json',
					data:{
						inititationReqId:afterSelectedEditedArray[i]
					},
				success:function(result){
					 var ajaxresult=JSON.parse(result);
					 $('#modalhead').html(ajaxresult[4]);
					 $('#modalbody').html(ajaxresult[3]);
				}
				});
			}
		}	
		$('#dataModal').modal('show');
		}
	beforeSelectedEditedArray=afterSelectedEditedArray; 
}	

</script>
	<script>
  // Show the button when the user scrolls down a certain distance
  window.onscroll = function() { scrollFunction() };
  		function scrollFunction() {
	    var scrollButton = document.getElementById("scrollButton");
	    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
	      scrollButton.style.display = "block";
	    } else {
	      scrollButton.style.display = "none";
	    }
	  	}
  	// Scroll to the top when the button is clicked
  	function scrollToTop(){
    document.body.scrollTop = 0; // For Safari
    document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE, and Opera
 	}
  
  </script>
</body>
</html>