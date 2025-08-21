<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 14px;
}f

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
<body>
<%
String projectId = (String)request.getAttribute("projectId");
List<Object[]>RequirementTypeList= (List<Object[]>)request.getAttribute("reqTypeList");
List<Object[]>RequirementList = (List<Object[]>)request.getAttribute("RequirementList");
List<Object[]>ParaDetails=(List<Object[]>)request.getAttribute("ParaDetails");

String InitiationReqId=(String)request.getAttribute("InitiationReqId");
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
	<div id="reqmain" class="card-slider">

		<div class="container-fluid" style="" id="main">
			<div class="row">
				<div class="col-md-12">
					<div class="card shadow-nohover" style="margin-top: -0px;">
						<div class="row card-header"
							style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
							<div class="col-md-9" id="projecthead">
								<h5 style="margin-left: 1%;">
								System Requirements
								</h5>
								</div>
								<div class="col-md-3" id="addReqButton">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> 
								<form action="#">
								
									<button class="btn btn-success btn-sm submit" style="margin-top: -3%;"
										type="button" onclick='showdata()' data-toggle="tooltip"
										data-placement="top" data-original-data=""
										title="ADD REQUIREMENTS">ADD REQUIREMENETS</button>
									<input type="hidden" name="projectId" value=<%=projectId %>>
									<button class="btn btn-info btn-sm  back ml-2"
										formaction="Requirements.htm" formmethod="get"
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
				id="<%=obj[0] %>" value="<%=obj[0]%>"  onclick="showDetails(<%=obj[0].toString()%>)"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></button>
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
				 				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
								
								
								
				<!--*********************** modal for add **************************-->
		<form class="form-horizontal" role="form"
			action="ProjectRequirementSubmit.htm" method="POST" id="myform1">
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
												data-live-search="true" style="margin-top: 5%" onchange="AddReqType()">
												<option disabled="disabled" value="" selected="selected">Choose..</option>
												<%if(!RequirementTypeList.isEmpty()){
												for(Object[] obj:RequirementTypeList){ %>
												<option value="<%=obj[0]+" "+obj[1]+" "+obj[3]%>"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "+"-"+obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%></option>
												<%}}%>
												<option class="bg-success text-light" value="1">ADD NEW</option>
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
														<option value="<%=obj[0]%>" title=<%=obj[3] %>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
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
														<option value="<%=obj[0]%>"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%></option>
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
<!-- 																		<div class=col-md-12>
										<div class="row">
											<div class="col-md-4">
												<label
													style="font-size: 17px; margin-top: 5%; color: #07689f; margin-left: 0.1rem">Method
													of testing<span class="mandatory" style="color: red;">*</span>
												</label>
											</div>
											<div class="col-md-8" style="margin-top: 10px">
												<div class="form-group">
													<input type="text" name="testing" class="form-control"
														id="testing" maxlength="255" required="required"
														placeholder="Maximum 250 Chararcters">
												</div>
											</div>
										</div>
									</div> -->
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
													<input class="form-control" readonly
														name="linkedAttachements" id="linkedAttachements"
														placeholder="No files found">
											
												</div>


											</div>
										</div>
									</div>
									<div class="form-group" align="center" style="margin-top: 3%;">
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" />
										<button type="submit" class="btn btn-primary btn-sm submit"
											id="add" name="action" value="SUBMIT"
											onclick="return reqCheck('myform1');">SUBMIT</button>
								<input type="hidden" name="projectId" value=<%=projectId %>>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</form>
		
						
</body>
	<script>
		function showdata(){
		    $('#exampleModalLong').modal('show');
		}
		
		$(function () {
			$('[data-toggle="tooltip"]').tooltip()
			})
			
			
			
    function reqCheck(frmid){
	var description=$('#descriptionadd').val();
	var reqbrief=$('#reqbrief').val();
	var remarks=$('#remarks').val();
	var priorityAdd=$('#priorityAdd').val();
	var needtypeadd=$('#needtypeadd').val();
	var categoryAdd=$('#categoryAdd').val();
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
		
	function showDetails(InitiationReqId){
		$('.viewbtn').css("background","#055C9D");
		$('#'+InitiationReqId).css("background","green");
		
		$.ajax({
			url:'RequirementJsonValue.htm',
			datatype:'json',
			data:{
				inititationReqId:InitiationReqId
			},
			success:function(result){
				 var ajaxresult=JSON.parse(result);
				console.log(ajaxresult+"---");
				 
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
		$('#remarksshow').html(ajaxresult[9]);
		$('#constrainshow').html(ajaxresult[12]);	
		if(ajaxresult[11]==="E"){
			$('#categoryShow').html("Environmental");
		}else if(ajaxresult[11]==="P"){
			$('#categoryShow').html("Performance");
		}else{
			$('#categoryShow').html("Maintenance")
		}	
		$('#editreq').html('<button type="button"  class="btn btn-sm  btn-warning edit " onclick="edit()"  data-toggle="tooltip" data-placement="right" data-original-data="Tooltip on right" title="EDIT" name="action" value="'+ajaxresult[7] +'"id="reqbtns" >EDIT</button>');
		
		
			}
		})
	}	
		
	<%if(InitiationReqId!=null){%>
	$( document ).ready(function() {
		showDetails(<%=InitiationReqId%>)
	});
	
	<%}%>
		</script>
</html>