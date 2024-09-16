<%@page import="com.vts.pfms.requirements.model.RequirementInitiation"%>
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
<spring:url value="/resources/css/Overall.css" var="StyleCSS" />
<link href="${StyleCSS}" rel="stylesheet" />
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>
<link href="${contentCss}" rel="stylesheet" />
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />


<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />

<style>
.bs-example {
	margin: 20px;
}

.accordion .fa {
	margin-right: 0.5rem;
}

.spansub {
	width: 49px;
	height: 24px;
	font-size: 10px;
	font-weight: bold;
	text-align: justify;
	display: inline-block;
}

.fa-times {
	color: red;
}
</style>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
}

.note-editable {
	line-height: 1.0;
}

.panel-info {
	border-color: #bce8f1;
}

.panel {
	margin-bottom: 10px;
	background-color: #fff;
	border: 1px solid transparent;
	border-radius: 4px;
	-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
	box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}

.panel-heading {
	background-color: #FFF !important;
	border-color: #bce8f1 !important;
	border-bottom: 2px solid #466BA2 !important;
	color: #1d5987;
}

.panel-title {
	margin-top: 0;
	margin-bottom: 0;
	font-size: 13px;
	color: inherit;
	font-weight: bold;
	display: contents;
}

.buttonEd {
	float: right;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

div {
	display: block;
}

element.style {
	
}

.olre-body .panel-info .panel-heading {
	background-color: #FFF !important;
	border-color: #bce8f1 !important;
	border-bottom: 2px solid #466BA2 !important;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-heading {
	padding: 3px 10px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

.panel-heading {
	padding: 3px 10px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

.panel-heading {
	padding: 3px 10px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

.panel-heading {
	padding: 3px 10px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

.panel-heading {
	padding: 3px 10px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

.p-5 {
	padding: 5px;
}

.panel-heading {
	padding: 10px 15px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

#MyTable1>thead {
	background: #055C9D;
	color: white;
	font-weight: 800;
	font-size: 1rem;
}

user agent stylesheet
div {
	display: block;
}

.panel-info {
	border-color: #bce8f1;
}

.form-check {
	margin: 0px 2%;
}

.fa-thumbs-up {
	font-family: FontAwesome, 'Quicksand', Quicksand, sans-serif;
}

.form-inline {
	display: inline-block;
}

#adddoc {
	font-weight: 600;
	font-family: 'Montserrat', sans-serif;
	float: right;
}

.inputx {
	width: 50%;
	display: inline;
	padding: 0px;
	line-height: 20px;
}

.close>span:hover {
	border: 1px solid black;
	padding: 0px 2px 0px 2px;
}

#noSqr {
	border: 5px solid gray;
	padding: 20px;
	width: 50%;
	margin: 10rem 0rem 0rem 30%;
	box-shadow: 5px 5px 5px gray;
	color: red;
	animation: blinker 1s linear infinite;
	top: -3px !important;
}

@
keyframes blinker { 50% {
	opacity: 0.5;
}
}
</style>
</head>
<body>
	<%
	Object[] SQRFile = (Object[]) request.getAttribute("SQRFile");
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	String initiationId = (String) request.getAttribute("initiationId");
	String reqInitiationId = (String) request.getAttribute("reqInitiationId");
	String project = (String) request.getAttribute("project");
	String[] projectDetails = project.split("/");
	List<Object[]> ParaDetails = (List<Object[]>) request.getAttribute("ParaDetails");
	List<Object[]> TotalSqr = (List<Object[]>) request.getAttribute("TotalSqr");
	String paracounts = (String) request.getAttribute("paracounts");
	
	//RequirementInitiation reqInitiation = (RequirementInitiation)request.getAttribute("reqInitiation");
	//String status = reqInitiation!=null?reqInitiation.getReqStatusCode():"RIN";
	//List<String> reqforwardstatus = Arrays.asList("RIN","RRR","RRA");
	%>
	<nav class="navbar navbar-light bg-light justify-content-between"
		style="margin-top: -1%;display: flex;">
		<a class="navbar-brand"> <b
			style="color: #585858; font-size: 19px; font-weight: bold; text-align: left; float: left"><span
				style="color: #31708f">SQR para for Project <%=projectDetails[1]%>
			</span> <span style="color: #31708f; font-size: 19px"> <%-- <%=projectDetails[1].toString() %> --%></span></b>
		</a>
	<div class="col-md-6">
	<%
	if (SQRFile != null) {
	%>
		<label>Import SQR : -</label>
	<select id="sqrImport" class="form-control selectdee" style="width:30%"  onchange="importSqr()">
	<option  selected="selected" disabled="disabled">SELECT</option>
	<%for(Object[]obj:TotalSqr){ %>
	<option value="<%=obj[14].toString() %>"><%=obj[4].toString() %></option>
	<%} %>
	</select>
	<%} %>
	</div>
		<form action="#">
			<button class="btn bg-transparent"
				formaction="RequirementParaDownload.htm" formmethod="get"
				formnovalidate="formnovalidate" formtarget="_blank">
				<i class="fa fa-download text-success" aria-hidden="true"></i>
			</button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			<input type="hidden" name="project" value="<%=project%>"> 
			<input type="hidden" name="initiationId" value="<%=initiationId%>">
			<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
		<button class="btn bg-transparent"
				formaction="RequirementParaDownloads.htm" formmethod="get"
				formnovalidate="formnovalidate" formtarget="_blank">
				<i class="fa fa-download text-success" aria-hidden="true"></i>
			</button>
 
 			

			<button class="btn btn-info btn-sm  back ml-2 mt-1"
				formaction="ProjectOverAllRequirement.htm" formmethod="get"
				formnovalidate="formnovalidate" style="float: right;">BACK</button>
			<input type="hidden" name="InitiationId"> <input
				type="hidden" name="projectShortName">
			<button type="button" class="btn btn-sm prints bg-secondary mt-1"
				style="border: white;" onclick="showsqrModal()">SQR</button>

		</form>
	</nav>
	<%
	String ses = (String) request.getParameter("result");
	String ses1 = (String) request.getParameter("resultfail");
	if (ses1 != null) {
	%>
	<div class="mt-2" align="center">
		<div class="alert alert-danger" role="alert">
			<%=ses1%>
		</div>
	</div>
	<%
	}
	if (ses != null) {
	%>
	<div class="mt-2" align="center">
		<div class="alert alert-success" role="alert">
			<%=ses%>
		</div>
	</div>
	<%
	}
	%>

	<%
	if (SQRFile != null) {
	%>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-5">
				<div class="card" style="border-color: #00DADA; margin-top: 2%;">
					<div class="card-body" id="scrollclass" style="height: 30.5rem;overflow: auto">

						<%
						if (!ParaDetails.isEmpty()) {
							int count = 0;
							for (Object[] obj : ParaDetails) {
						%>
						<form action="#">
							<div class="panel panel-info" style="margin-top: 10px;">
								<div class="panel-heading ">
				
									<h4 class="panel-title">
										<input type="number" class="form-control inputx serial" style="width: 8%" value="<%=obj[5]!=null?obj[5].toString():"0"%>" min="0" max="<%=ParaDetails.size()%>">
										<input class="paraidclass" type="hidden" value="<%=obj[0].toString()%>">
											<input type="hidden" id="paracount<%=obj[0].toString()%>" name="paracount" value="<%=count%>"> 
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
											<input type="hidden" name="project" value="<%=project%>"> 
											<input type="hidden" name="initiationId" value="<%=initiationId%>">
											<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
											<input type="text" class="form-control inputx" id="input<%=obj[0].toString()%>" name="ParaNo" maxlength="250 characters" placeholder="Enter Text" value="<%=obj[3].toString()%>" readonly style="width: 40%">
											<input type="hidden" name="paraid" value=<%=obj[0].toString()%>>
											<input type="hidden" name="initiation" value="S">
											<button class="btn btn-sm ml-1 bg-transparent" type="button"
												id="btns<%=obj[0].toString()%>"
												style="width: 44px; height: 24px; font-size: 10px; font-weight: bold; text-align: justify; display: inline-block;"
												onclick="showSpan(<%=obj[0].toString()%>)"
												data-toggle="tooltip" data-placement="right"
												data-original-data="" title=""
												data-original-title="EDIT PARA">
												<i class="fa fa-lg fa-pencil" aria-hidden="true"
													style="color: blue;"></i>
											</button> <span id="spans<%=obj[0].toString()%>"
											style="display: none">
												<button class="btn btn-sm btn-info spansub btn-req" type="submit"
													formaction="RequirementParaEdit.htm" formmethod="POST"
													formnovalidate="formnovalidate"
													onclick="return confirm('Are you sure you want to update?')">Update</button>
												<button class="btn bg-transparent" type="button"
													onclick="hideUpdateSpan(<%=obj[0].toString()%>)">
													<i class="fa fa-times" aria-hidden="true"></i>
												</button>
										</span>


										</span>
									</h4>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
									<input type="hidden" name="sqrid" value="<%=SQRFile[7].toString()%>"> 
									<input type="hidden" name="project" value="<%=project%>"> 
									<input type="hidden" name="initiationId" value="<%=initiationId%>">
									<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
										<button class="btn btn-sm bg-transparent" type="button" onclick="deleteSqr(<%=obj[0].toString()%>)">
									<i class="fa fa-trash-o" aria-hidden="true" style="color:red;"></i>
									</button>
									
									<button class="btn bg-transparent buttonEd" type="button"
										style="display: block;" id="btnEditor<%=obj[0].toString()%>"
										onclick="showEditor(<%=obj[0].toString()%>,'<%=obj[3].toString()%>')"
										data-toggle="tooltip" data-placement="left"
										data-original-data="" title=""
										data-original-title="VIEW & EDIT PARA DETAILS">
										<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
									</button>

								</div>
							</div>
						</form>
						<%
						}
						}
						%>
						<div class="panel panel-info" style="margin-top: 10px;">
							<div class="panel-heading ">
								<form action="#">
									<h4 class="panel-title">
										<span class="ml-2" style="font-size: 14px"> <input
											type="text" class="form-control inputx" name="ParaNo"
											maxlength="250 characters" placeholder="Enter PARA"
											id="ParaNOid">
											<button class="btn btn-success btn-sm ml-3 btn-req" type="submit"
												formaction="RequirementParaSubmit.htm" formmethod="POST"
												formnovalidate="formnovalidate"
												style="width: 44px; height: 24px; font-size: 10px; font-weight: bold; text-align: justify; display: inline-block;"
												onclick="submitForm()">ADD</button>
										</span>
									</h4>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
									<input type="hidden" name="sqrid" value="<%=SQRFile[7].toString()%>"> 
									<input type="hidden" name="project" value="<%=project%>"> 
									<input type="hidden" name="initiationId" value="<%=initiationId%>">
									<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
									<input type="hidden" name="serialNumber" value="<%=ParaDetails!=null?ParaDetails.size()+1:"0" %>">
									<button class="btn bg-transparent buttonEd" type="button"
										style="display: none;" id="btnEditor1" onclick="">
										<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
									</button>
								</form>
							</div>
						</div>
						<div align="left"><button class="btn btn-sm edit" onclick="getValues()">UPDATE ORDER</button></div>

					</div>
				</div>
			</div>

			<!-- Editor -->
			<div class="col-md-7" style="display: block" id="col1">
				<form action="RequirementParaEdit.htm" method="POST" id="myfrm">
					<div class="card" style="border-color: #00DADA; margin-top: 2%;">
						<h5 class="heading ml-4 mt-3" id="editorHeading"
							style="font-weight: 500; color: #31708f;"></h5>
						<hr>
						<div class="card-body" style="margin-top: -8px">
							<div class="row">
								<div class="col-md-12 " align="left"
									style="margin-left: 0px; width: 100%;">
									<div id="Editor" class="center"></div>
									<textarea name="Details" style="display: none;"></textarea>
									<div class="mt-2" align="center" id="detailsSubmit">
										<span id="EditorDetails"></span> 
										<input type="hidden" id="paracountDetails" name="paracount" value=""> 
										<input type="hidden" name="ParaNo" id="ParaNos" value=""> 
										<input type="hidden" name="paraid" id="paraids" value=""> 
										<input type="hidden" name="project" value="<%=project%>"> 
										<input type="hidden" name="initiationId" value="<%=initiationId%>">
										<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
										<input type="hidden" name="initiation" value="S">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
										<span id="Editorspan"> 
											<span id="btn1" style="display: none;">
												<button type="submit" class="btn btn-sm btn-success submit mt-2 btn-req" onclick="return confirm('Are you sure you want to submit?')">SUBMIT</button>
											</span>
											<span id="btn2" style="display: none;">
												<button type="submit" class="btn btn-sm btn-warning edit mt-2 btn-req" onclick="return confirm('Are you sure you want to update?')">UPDATE</button>
											</span>
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%} else {%>
		<h2 align="center" id="noSqr">SQR is not specified for the Project!</h2>
	<%}%>
	<div class="modal fade bd-example-modal-lg" id="sqrModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content" style="margin-left: -10%; width: 120%;">
				<div class="modal-header" style="background: antiquewhite;">
					<h5 class="modal-title" id="exampleModalLabel" style="color: #07689f !important;">Staff Qualification Requirement</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="hidemodalbody()">
						<span aria-hidden="true" style="color: red;">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<table class="table table-bordered" id="MyTable1">
						<thead>
							<tr style="text-align: center;">
								<th>SN</th>
								<th>User</th>
								<th>Ref No.</th>
								<th>Date</th>
								<th>Version</th>
								<th>Issuing Authority</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<% if (SQRFile == null) {%>
							<tr>
								<td colspan="7" style="text-align: center;">No Data Available</td>
							</tr>
							<%} else {%>
							<tr>
								<td style="text-align: center">1.</td>
								<td>
									<%if(SQRFile[0].toString().equalsIgnoreCase("IA")) {%>
										Indian Army
									<%} else if(SQRFile[0].toString().equalsIgnoreCase("IN")) {%>
										Indian Navy
									<%}else if(SQRFile[0].toString().equalsIgnoreCase("OH")) {%>
										Others
									<%}else if(SQRFile[0].toString().equalsIgnoreCase("DO")) {%>
										DRDO
									<%}else if(SQRFile[0].toString().equalsIgnoreCase("IAF")) {%>
										Indian Air Force
									<%}%>
								</td>
								<td>
									<%if(SQRFile[1] != null) {%><%=SQRFile[1].toString()%><%}%>
								</td>
								<td>
									<%if(SQRFile[5] != null) {%><%=(sdf.format(SQRFile[5]))%><%}%>
								</td>
								<td style="text-align: right">
									<%if(SQRFile[4] != null) {%><%=SQRFile[4].toString()%><%}%>
								</td>
								<td>
									<%if(SQRFile[3] != null) {%><%=SQRFile[3].toString()%><%}%>
								</td>
								<td align="center">
									<form action="#">
										<button type="submit" class="btn btn-sm bg-transparent" formaction="SQRDownload.htm" formmethod="get" formtarget="blank">
											<i class="fa fa-download" aria-hidden="true" style="color: green;"></i>
										</button>
										<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
									</form>
								</td>
							</tr>
							<%}%>
						</tbody>
					</table>
					<%-- <%
					if (SQRFile == null) {
					%> --%>
					<form action="ProjectSqrSubmit.htm" method="post" enctype="multipart/form-data">
						
						<div class="row mt-2">
									<div class="col-md-4">
									&nbsp;&nbsp;
										<label style="font-size: 17px;color: #07689f; font-weight: bold">Title :</label> 
										<span class="mandatory" style="color: red;">*</span>
									</div>
									<div class="col-md-6">
									
										<input class="form-control modals" type="text" name="Qrtitle" maxlength="10" placeholder="Enter Maximum 10 characters" 
										value="<%if (SQRFile != null && SQRFile[13] != null) {%><%=SQRFile[13].toString()%><%}%>" required style="width: 440px;">
									</div>
									
								</div>
								<br>
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-4">
										<label style="font-size: 17px; color: #07689f; font-weight: bold">QR Type :</label>
										<span class="mandatory" style="color: red;">*</span>
									</div>
									<div class="col-md-6">
										<select class="form-control modals" required name="QrType">
											<option value="0">SELECT</option>
											<option value="Q" <%if (SQRFile != null && SQRFile[14]!=null && SQRFile[14].toString().equalsIgnoreCase("Q")) {%>selected <%}%>>QR</option>
											<option value="P" <%if (SQRFile != null&& SQRFile[14]!=null && SQRFile[14].toString().equalsIgnoreCase("P")) {%>selected <%}%>>PSQR</option>
											<option value="G" <%if (SQRFile != null&& SQRFile[14]!=null && SQRFile[14].toString().equalsIgnoreCase("G")) {%>selected <%}%>>GSQR</option>
											<option value="J" <%if (SQRFile != null && SQRFile[14]!=null&& SQRFile[14].toString().equalsIgnoreCase("J")) {%>selected <%}%>>JSQR</option>
										</select>
										<br>
									</div>
									</div>
							
								<div class="row">
									<div class="col-md-4">
										<label style="font-size: 17px; color: #07689f; font-weight: bold">User :</label>
										<span class="mandatory" style="color: red;">*</span>
									</div>
									<div class="col-md-6">
										<select class="form-control modals" required name="users">
											<option value="IA"<%if (SQRFile != null && SQRFile[0].toString().equalsIgnoreCase("IA")) {%>selected <%}%>>Indian Army</option>
											<option value="IN"<%if (SQRFile != null && SQRFile[0].toString().equalsIgnoreCase("IN")) {%>selected <%}%>>Indian Navy</option>
											<option value="IAF"<%if (SQRFile != null && SQRFile[0].toString().equalsIgnoreCase("IAF")) {%>selected <%}%>>Indian Air Force</option>
											<option value="DO"<%if (SQRFile != null && SQRFile[0].toString().equalsIgnoreCase("DO")) {%>selected <%}%>>DRDO</option>
											<option value="OH"<%if (SQRFile != null && SQRFile[0].toString().equalsIgnoreCase("OH")) {%>selected <%}%>>Other</option>
										</select>
									</div>
								</div>
								<div class="row mt-2">
									<div class="col-md-4">
										<label style="font-size: 17px;color: #07689f; font-weight: bold">Refernce No :</label> 
										<span class="mandatory" style="color: red;">*</span>
									</div>
									<div class="col-md-6">
										<input class="form-control modals" type="text" name="refNo" maxlength="255" placeholder="Enter Maximum 255 characters" 
										value="<%if (SQRFile != null && SQRFile[1] != null) {%><%=SQRFile[1].toString()%><%}%>" required>
									</div>
								</div>
								
								<div class="row mt-2">
						      			<div class="col-md-4">
								      		<label style="font-size: 17px;color: #07689f;font-weight:bold">Previous  SQR No. :</label>
								     		<span class="mandatory" style="color: red;">*</span>
								      	</div>
								      	 
						      			<div class="col-md-6" style="">
						      				<input class="form-control modals" id="previoussqrno" type="text" name="previousSQRNo" maxlength="255" placeholder="Enter Maximum 255 characters"
						      				value="<%if(SQRFile!=null && SQRFile[8]!=null) {%><%=SQRFile[8].toString()%><%} %>" required>
						     			</div>
						      		</div>  
      
      								<!-- meeting refernce -->
       								<div class="row mt-2">
      									<div class="col-md-4">
      										<label style="font-size: 17px;color: #07689f;font-weight:bold">Meeting Reference :</label>
     										<span class="mandatory" style="color: red;">*</span>
      									</div>
								      	<div class="col-md-6" style="" >
								      		<textarea rows="2" class="form-control modals"  maxlength="1000" placeholder="Enter Maximum 1000 characters"
								      		required name="MeetingReference"><%if(SQRFile!=null && SQRFile[9]!=null) {%><%=SQRFile[9].toString()%><%} %></textarea>
								     	</div>
      								</div> 

         							<div class="row mt-5">
      									<div class="col-md-4">
      										<label style="font-size: 17px;color: #07689f;font-weight:bold">Priority for Development :</label>
     										<span class="mandatory" style="color: red;">*</span>
      									</div>
      									<div class="col-md-6" style="">
     										<select class="form-control modals" required name="PriorityDevelopment">
									      		<option value="E" <%if(SQRFile!=null && SQRFile[10].toString().equalsIgnoreCase("E")) {%>selected<%} %>>Early</option>
									      		<option value="I" <%if(SQRFile!=null && SQRFile[10].toString().equalsIgnoreCase("I")) {%>selected<%} %>>Immediate</option>
									      		<option value="L" <%if(SQRFile!=null && SQRFile[10].toString().equalsIgnoreCase("L")) {%>selected<%} %>>Later</option>
											</select>
										</div>
									</div> 
								
								<div class="row mt-2">
									<div class="col-md-4">
										<label style="font-size: 17px;color: #07689f; font-weight: bold">Issuing Authority :</label> 
										<span class="mandatory" style="color: red;">*</span>
									</div>
									<div class="col-md-6" style="">
										<input type="text" class="form-control modals" name="IssuingAuthority" required maxlength="255" placeholder="Enter Maximum 255 characters"
										value="<%if (SQRFile != null && SQRFile[3] != null) {%><%=SQRFile[3].toString()%><%}%>">
									</div>
								</div>
								<div class="row mt-2">
									<div class="col-md-4">
										<label style="font-size: 17px;color: #07689f; font-weight: bold">Version No. :</label> 
										<span class="mandatory" style="color: red;">*</span>
									</div>
									<div class="col-md-6">
										<input class="form-control modals" id="versionUpdates" maxlength="5"
											type="number" style="" required
											oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
											name="version"
											value="<%if (SQRFile != null && SQRFile[4] != null) {%><%=SQRFile[4].toString()%><%}%>"
											<%if (SQRFile != null) {%> readonly <%}%>>
									</div>
								</div>
								<div class="row mt-2">
									<div class="col-md-4">
										<label style="font-size: 17px;color: #07689f; font-weight: bold">Choose file :</label> 
										<span class="mandatory" style="color: red;">*</span>
									</div>
									<div class="col-md-6">
										<input type="file" class="form-control modals" required accept=".pdf" name="Attachments">
									</div>
								</div>
								<div align="center" class="mt-3">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
									<input type="hidden" name="project" value="<%=project%>"> 
									<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
									<input type="hidden" name="reqInitiationId" value="<%=reqInitiationId%>"> 
									<input type="hidden" name="pageid" value="2"> 
									<span> 
										<%if(SQRFile != null) {%>
											<button class="btn btn-sm edit btn-req" type="submit" onclick="return confirm('Are you sure you want to update?')"style="box-shadow: 2px 2px 2px gray;">UPDATE</button> 
										<%} else {%>
											<button class="btn btn-sm submit btn-req" type="submit"onclick="return confirm('Are you sure you want to submit?')">SUBMIT</button>
										<%}%>
									</span>
								</div>
							</div>
						</div>
					</form>
					<%-- <%
					}
					%> --%>
				</div>
			</div>
		</div>
	</div>
<!--Modal for import Para  -->


<div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Import Para </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" >
      <div class="row m-2 mainProject" ><input id="mainProject" style="transform:scale(1.5)" type="checkbox"  >&nbsp; Select All</div>
       <div class="row" id="modalBody">
       
       
       
       </div>
       <div align="center" id="submit" class="mt-2"> 
       	<input type="hidden" id="reqInitiationId" value="<%=reqInitiationId%>">
		<input type="hidden" id="sqrid" value="<%=SQRFile!=null&& SQRFile[7]!=null ?  SQRFile[7].toString():""%>"> 
       <button class="btn btn-sm submit" onclick="submitImportSqr()">SUBMIT</button>
       </div>
      </div>
    
    </div>
  </div>
</div>
	<script>
	var inputValue; 
	function showSpan(a){
		$('#btns'+a).hide();
		$('#spans'+a).show();
		inputValue=document.getElementById("input"+a).value;
		document.getElementById("input"+a).readOnly=false;
	}
	function hideUpdateSpan(a){
		$('#btns'+a).show();
		$('#spans'+a).hide();
		document.getElementById("input"+a).value=inputValue;
		document.getElementById("input"+a).readOnly=true;
	}

	
	
	/* 	var editor_config = {
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
	
		CKEDITOR.replace('Editor', editor_config); */
		$(document).ready(function() {
			 $('#Editor').summernote({
				  width: 800,   //don't use px
				
				  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana'],
				 
			      lineHeights: ['0.5']
			
			 });

		$('#Editor').summernote({
		     
			  tabsize: 2,
		       height: 1000
		    });
		    
		});
		function showsqrModal(){
		$('#sqrModal').modal('show');
		}
		$( document ).ready(function() {
			<%if (SQRFile == null) {%>
				showsqrModal();
			<%}%>
			var paracounts=<%=paracounts%>;
			$('#btnEditor'+paracounts).click();
			var editorHeading=document.getElementById('editorHeading').innerHTML;
			if(editorHeading.length>0){
			console.log("---")
			}		
			});
		function showEditor(paraid,parano){
		document.getElementById('paraids').value=paraid;
		document.getElementById('ParaNos').value=parano;
		var paracount=$('#paracount'+paraid).val();
		document.getElementById('paracountDetails').value=paracount;
		document.getElementById('editorHeading').innerHTML=parano;
		$.ajax({
			type:'GET',
			url:'RequirementParaDetails.htm',
			datatype:'json',
			data:{
				reqInitiationId:<%=reqInitiationId%>,
			},
			success:function(result){
				var ajaxresult=JSON.parse(result);
				console.log(ajaxresult)
				var html="";
				for(var i=0;i<ajaxresult.length;i++){
					if(ajaxresult[i][0]===paraid && ajaxresult[i][4]!=null){
						html=ajaxresult[i][4];
					}
				}
				$('#Editor').summernote('code', html);
			
				if(html.length>1){ // if list [i][5] is empty show update button else submit button
				$('#btn1').hide();
				$('#btn2').show();
				}else{
					$('#btn2').hide();
					$('#btn1').show();
				}
			}
		})
		}
	   $('#myfrm').submit(function() {
		   $('textarea[name=Details]').val($('#Editor').summernote('code'));
		});
		$(function () {
		$('[data-toggle="tooltip"]').tooltip()
		})
			function submitForm(){
			var ParaNOid=$('#ParaNOid').val().trim();
			console.log(ParaNOid+"---")
			if(ParaNOid.length==0){
				alert("The field is empty!")
				event.preventDefault();
				return false;
			}else{
				if(confirm("Are you sure you want to submit?")){
					return true;
					}else{
					event.preventDefault();
					return false;	
					}
			}
			}
	
		function show(){
			
		}
		

		function importSqr(){

			var value= $('#sqrImport').val();
			console.log(value)
			
			$.ajax({
		            type: 'GET',
		            url: 'RequirementParaDetails.htm',
		            datatype: 'json',
		            data: {
		                reqInitiationId: value,
		            },
		            success: function(result) {
		                var ajaxresult = JSON.parse(result);
		                console.log(ajaxresult);
		                var html= "";
		                if(ajaxresult.length>0){
		                	for(var i=0;i<ajaxresult.length;i++){
		                	
		                		html = html+'<div class="col-md-2"><input class="sqrIds" type="checkbox"  name="sqrids" value="'+ajaxresult[i][0]+'"><span style="font-size:16px;"> '+ajaxresult[i][3]+'</span></div>'
		                		
		                	}
		                	$('#submit').show();
		                	$('.mainProject').show();
		                	$('#modalBody').html(html);
		                	
		                }else{
		                	$('#submit').hide();
		                	$('.mainProject').hide();
		                	
		                	$('#modalBody').html("No parars are there for this SQR");
		                }
		                
		                
			            $('#exampleModal1').modal('show');
		            }

			});
		}
		  $('#mainProject').change(function() {
			    
		      var isChecked = $(this).prop('checked');
		      
		    
		      $('input:checkbox.sqrIds').prop('checked', isChecked);
		    });
		    
		    var initialChecked = $('#mainProject').prop('checked');
		    $('input:checkbox.sqrIds').prop('checked', initialChecked);
		function submitImportSqr(){
			var checkedValues = [];
			$('input[name="sqrids"]:checked').each(function() {
			    checkedValues.push($(this).val());
			});
			var reqInitiationId = $('#reqInitiationId').val();
			var sqrid = $('#sqrid').val();
			console.log(checkedValues)
			if(checkedValues.length>0){
				
			if(confirm('Are you sure to submit?')){	
			$.ajax({
				type:'GET',
				url:'Importpara.htm',
				data:{
					checkedValues:checkedValues+"",
					reqInitiationId:reqInitiationId,
					sqrid:sqrid,
				},
				datatype:'json',
				success:function(result){
				var ajaxresult=JSON.parse(result);
				if(ajaxresult>0){
					alert("Paras imported Successfully");
			        location.reload();
				}
				}
			})
			}else{
				event.preventDefault();
				return false;
			}
			
			}

			
		}
		
	function deleteSqr(paraId){
			
			var paraId = paraId;
			console.log(paraId);
			
			if(confirm('Are you sure to submit?')){
			$.ajax({
				type:'GET',
				url:'deleteSqr.htm',
				datatype:'json',
				data:{
					paraId:paraId,
				},
				success:function(result){
					
					var ajaxresult = JSON.parse(result);
					console.log(ajaxresult)
					if(Number(ajaxresult)>0){
						alert("Para Deleted Successfully!")
					}
					window.location.reload();
				}
				
			})
			}else{
				event.preventDefault();
				return false;
			}
			
		}
	
	
	function getValues(){
		let serialValues = [];
		 var arr = document.getElementsByClassName("serial");
		 var arr2 = document.getElementsByClassName("paraidclass");
	
	
		 var arr1 = [];
		 var arr3 = [];
			for (var i=0;i<arr.length;i++){
				arr1.push(arr[i].value);
			}
			for (var i=0;i<arr2.length;i++){
				arr3.push(arr2[i].value);
	
			}
	
			 let result = false;
			    const s = new Set(arr1);
			    
			    console.log(s)
			    if(arr.length !== s.size){
			       result = true;
			    }
			    
			   if(result){
				   alert("Two para can not have same serial Number.")
			   } else{
				 
				   $.ajax({
					 type:'GET',
					 url:'UpdateSqrSerial.htm',
					 data:{
						 serialNo:arr1+"",
						 paraid:arr3+"",
					 },
					 dataype:'json',
					 success:function(result){
						 window.location.reload();
					 }
				   })
				   
				   
			   }
	    console.log(result);
	}
</script>

<%-- <script type="text/javascript">
	<%if(reqforwardstatus.contains(status)) {%>
		$('.btn-req').prop('disabled',false);
	<%} else{%>
	    $('.btn-req').prop('disabled',true);
	<%} %>
</script> --%>


</body>
</html>