<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat ,  java.util.stream.Collectors"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../static/header.jsp"></jsp:include>

<meta charset="ISO-8859-1">
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<title>PMS</title>
 <script src="${ckeditor}"></script>
 <link href="${contentCss}" rel="stylesheet" />
<style>
#projectname {
	display: flex;
	align-items: center;
	justify-content: center;
	margin-top: -1%
}
#Notification1,#Notification2,#Notification3,#Notification4,#Notification5,#Notification6{ 
  animation: blinker 2s linear infinite;
  top:-3px!important;
  background-color:#008080 !important;
}

@keyframes blinker {
  50% {
    opacity: 0.35;
  }
}
input[type=radio] {
 accent-color: green;
}
.fa-list{
color: coral;
font-size: 17px;
}
#div1 {
	display: flex;
	align-items: center;
	justify-content: center;
}
#briefSubPoints h5{
    padding: 5px !important;
    border: 1px solid white !important;
    border-radius: 5px !important;
    background: aliceblue !important;
    font-size: 18xp !important;
}

.addreq {
	margin-left: -10%;
	margin-top: 5%;
	border-radius: 9px;
}

.costreq {
	margin-left: -25%;
	margin-top: 5%;
}

h5 {
	font-size: 18px;
	font-family: 'FontAwesome';
}

.details>h5 {
	text-align: left;
	background: white;
	padding: 5px;
	color: balck;
	font-family: 'FontAwesome';
	box-shadow: 2px 2px 2px cadetblue;
	border-radius: 5px;
	margin-left: 0%;
}

p {
	display:inline;
	font-size: 18px;
	text-align: left;
	background: white;
	padding: 7px;
	color: #DC143C ;
	font-family: 'FontAwesome';
	/* box-shadow: 2px 2px 2px cadetblue; */
	border-radius: 5px;
	margin-left: 0%;
}
#rightside h5,#part2lefside h5,#part2rightside h5{
    padding: 13px;
    border: 1px solid cadetblue;
    border-radius: 5px;
    background: aliceblue;
    font-size: 20px;

}

#part2lefside:hover,#part2rightside:hover{
	 transition-duration: 1s !important; 
	 box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
}
p:hover{
	 padding:13px; 
	 box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
}
#part2lefside h5:hover,#part2rightside h5:hover,#rightside .point:hover{
	transition-duration: 0.3s;
	padding:10px !important; 
	color:white;
	background:#22c8e5  !important;
	 box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
}
.plus:hover{
transition-duration: 0.3s !important;
background:#DCDCDC !important;
box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
}

.list:hover{
 #Notification1,#Notification2,#Notification3,
 #Notification4,#Notification5,#Notification6{ 
  animation: blinker 0s linear infinite;
}
transition-duration: 0.3s !important;
background:#DCDCDC !important;
box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
}
.font-weight-bold{
font-size:16px;
font-weight: 500;
font-family: 'FontAwesome';
}
#modalbody>p{
display:block !important;
color: black;
}
 .table-striped>tbody>tr:nth-child(even) {
	  	background-image: linear-gradient(45deg, white, #C4DDFF);
	   color :#292e49;  

}
.table-striped>tbody>tr:nth-child(odd) {
	 background-image: linear-gradient(45deg,#C4DDFF, white);
	 color :#292e49; 
} 

#page1:hover,#page2:hover,#page3:hover{
transition-duration: 0.3s !important;
background-color:#22c8e5 !important;
color:white !important;
box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19)!important;
}
#page1, #page2, #page3 {
	padding-left: 15px;
	padding-right: 15px;
	margin-left: 3px;
	font-family: 'Montserrat', sans-serif;
}
.leftsiderow>h5{
color:black;
}
strong {
	font-weight: 100;
}
#btn1:hover, #btn2:hover{
color:green !important;
}
#cardbody1,#cardbody2{
	display: none; /* height:520px; */
/* 	/* background-image: repeating-linear-gradient(45deg,#ffffff 58%, #C4DDFF); */ */
/* 	background-image: url("https://alphagypsumboard.com/wp-content/uploads/2019/07/Background-website-01-1024x687.jpg") !important;
 background-repeat: no-repeat !important;
 background-size: cover !important; */
}
#download:hover,#deliverables:hover{
box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19)!important;
}
#leftside,#rightside,#part2lefside,#part2rightside{
border:1px solid #ffffff;
border-radius: 5px;
box-shadow: 3px 3px 3px gray;
background-image: repeating-linear-gradient(45deg,#ffffff 40%, #C4DDFF) !important; 
/* background: #6a6ea7; */
background-image: url("view/images/background.jpg");
background-repeat: no-repeat;
background-size: cover;
}
#part2lefside,#part2rightside{
padding:20px;
}
.leftsiderow{
	padding:3px;
	color:#1565C0;
	
	box-shadow: 2px 2x 2px gray;
}
#briefSubPoints::-webkit-scrollbar {
    width:7px;
}
#briefSubPoints::-webkit-scrollbar-track {
    -webkit-box-shadow:inset 0 0 6px rgba(0,0,0,0.3); 
    border-radius:5px;
}
#briefSubPoints::-webkit-scrollbar-thumb {
    border-radius:5px;
  /*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}
#briefSubPoints::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
 	transition: 0.5s;
}
#scrollclass::-webkit-scrollbar {
    width:7px;
}
#scrollclass::-webkit-scrollbar-track {
    -webkit-box-shadow:inset 0 0 6px rgba(0,0,0,0.3); 
    border-radius:5px;
}
#scrollclass::-webkit-scrollbar-thumb {
    border-radius:5px;
  /*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}
#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
 	transition: 0.5s;
}
.sidelabel{
font-weight:600;
font-size: 15px;
color:#145374;
}

</style>
</head>
<body>
	
	<%
	
	List<Object[]> ProjectIntiationList = (List<Object[]>) request.getAttribute("ProjectIntiationList");
	Object[] ProjectDetailes = (Object[]) request.getAttribute("ProjectDetailes");
	String projectshortName = (String) request.getAttribute("projectshortName");
	String initiationid = (String) request.getAttribute("initiationid");
	String projectTitle = (String) request.getAttribute("projectTitle");
	NFormatConvertion nfc = new NFormatConvertion();
	List<Object[]> sanctionlistdetails = (List<Object[]>) request.getAttribute("sanctionlistdetails");
	List<Object[]> DetailsList = (List<Object[]>) request.getAttribute("DetailsList");
	List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
	List<Object[]> ProjectInitiationLabList = (List<Object[]>) request.getAttribute("ProjectInitiationLabList");
	
	String projectTypeId=(String)request.getAttribute("projectTypeId");
    List<Object[]>projectFiles=(List<Object[]>)request.getAttribute("projectFiles");
    List<Object> DocumentId=new ArrayList<>();
   	if(projectFiles!=null&&!projectFiles.isEmpty()){
  	 DocumentId=projectFiles.stream().map(e->e[8]).collect(Collectors.toList());
  	 }
   	Object[]MacroDetails=(Object[])request.getAttribute("MacroDetails");
	List<Object[]> ConsultancyList = (List<Object[]>) request.getAttribute("ConsultancyList");
	List<Object[]> CarsList = (List<Object[]>) request.getAttribute("CarsList");
	List<Object[]> WorkPackageList = (List<Object[]>) request.getAttribute("WorkPackageList");
	List<Object[]> TrainingRequirementList=(List<Object[]>)request.getAttribute("TrainingRequirementList");
	List<Object[]> ManpowerList=(List<Object[]>)request.getAttribute("ManpowerList");
	List<Object[]> CapsiList=(List<Object[]>)request.getAttribute("CapsiList");
	Object[] macrodetailsTwo = (Object[]) request.getAttribute("macrodetailsTwo");
	List<Object[]> CostDetailsListSummary=(List<Object[]>)request.getAttribute("CostDetailsListSummary");
	Object[]BriefList=(Object[])request.getAttribute("BriefList");
	String consultancyCost=(String)request.getAttribute("ConsultancyCost");
	String workCost=(String)request.getAttribute("WorksCost");
	String trainingCost=(String)request.getAttribute("trainingCost");
	String capsicost=(String)request.getAttribute("capsicost");
	String carscost=(String)request.getAttribute("carscost");
	%>
	<div align="center" style="display:None">
	<div class="alert alert-danger" id="danger"  role="alert">
	Data Edited Successfully.
	</div>
	</div>	
	<div align="center"  id="successdiv" style="display:None"> 
	<div class="alert alert-success" id="divalert"  role="alert">Data Edited Successfully.</div>
	</div>
	
		<%if(ProjectIntiationList.size()==0) {%>
		<div style="margin-top:20%;display: flex; justify-content: center; align-items: center;font-weight: 800;"><h3><b>No Data Available!</b></h3></div>
	<%}else{%>
	<div class="container-fluid" style="display: block;">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="row card-header"
						style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
						<div class="col-md-6" id="projecthead" align="left">
							<h5 id="text" style="margin-left: 1%; font-weight: 600">STATEMENT
								OF CASE FOR SANCTION OF PROJECT/PROGRAMME</h5>
						</div>
						<div class="col-md-3" 
							style="margin-right: 0%; margin-top: -4px;">
							<button class="btn btn-sm" id="page1"
								style="box-shadow: 2px 2px 2px darkslategray">Main</button>
							<button class="btn btn-sm" id="page2"
								style="box-shadow: 2px 2px 2px darkslategray">Part 1</button>
							<button class="btn btn-sm" id="page3"
								style="box-shadow: 2px 2px 2px darkslategray">Part 2</button>
						</div>

						<div class="col-md-1" id="download1" >
							<form action="#">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden"
									name="projectshortName" value="<%=projectshortName%>" /> <input
									type="hidden" name="IntiationId" value="<%=initiationid%>" />
									<span id="downloadform">
								<button type="submit" class="btn btn-sm" formmethod="GET"
									style="margin-top: -3%" formtarget="_blank"
									formaction="ProjectSanctionDetailsDownload.htm"
									data-toggle="tooltip" data-placement="top"
									title="Download file">
									<i class="fa fa-download fa-sm" aria-hidden="true"></i>
								</button></span>
							</form>
						</div>
						<div class="col-md-2">
						<form class="form-inline" method="POST" action="ProjectSanction.htm">
					<div class="row W-100" style="width: 100%; margin-top: -1.5%;">
					<div class="col-md-4" id="div1">
						<label class="control-label"
							style="font-size: 15px; color: #07689f;"><b>Project:</b></label>
			</div>
				<div class="col-md-8" style="" id="projectname" >
					<select class="form-control selectdee" id="project"
					required="required" name="project" >
					<%
					if (!ProjectIntiationList.isEmpty()) {
						for (Object[] obj : ProjectIntiationList) {
					%>
					<option value="<%=obj[0] + "/" + obj[4] + "/" + obj[5]%>"
						<%if (obj[4].toString().equalsIgnoreCase(projectshortName)) {%>
						selected <%}%>><%=obj[4]%></option>
					<%
					}
					}
					%>
				</select>
			</div>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input id="submit" type="submit"
				name="submit" value="Submit" hidden="hidden">
		</div>
	</form>
						
						</div>
					</div>
					<div class="card-body" id="cardbody"
						style="background: white; padding-top: 0%; color: black; height: 520px;">
						<div class="row">
							<%
							if (ProjectDetailes != null) {
							%>
							<div class="col-md-6">
								<table class="table table-striped" id="table1"
									style="width: 100%; margin-top: 2%;">
									<tbody>
										<tr>
											<td style="width: 60%"><h5>1. Name of laboratory:</h5></td>
											<td>
												<h5>MTRDC</h5>
											</td>
										</tr>
										<tr>
											<td><h5>2. Title of the Project/Programme:</h5></td>
											<td><h5><%=ProjectDetailes[7] + "(" + ProjectDetailes[6] + ")"%></h5></td>
										</tr>
										<tr>
											<td><h5>3. Category of Project:</h5></td>
											<td><h5>
													<%=ProjectDetailes[4]%></h5></td>
										</tr>
										<tr>
											<td><h5>4. Security classification of
													Project/Programme:</h5></td>
											<td><h5><%=ProjectDetailes[5]%></h5></td>
										</tr>
										<tr>
											<td><h5>5. Name of the Project Director/Programme
													Director (for approval of Competent Authority) :</h5></td>
											<td><h5><%=ProjectDetailes[1]%></h5></td>
										</tr>
										<tr>
											<td><h5>6. Cost( &#8377; in Cr):</h5></td>
											<td >
												<h5 id="costcheck">
													<%
													if (ProjectDetailes[8] != null && Double.parseDouble(ProjectDetailes[8].toString()) > 0) {
													%><%=nfc.convert(Double.parseDouble(ProjectDetailes[8].toString()) / 10000000)%>
													&nbsp;&nbsp;<%
													} else if (ProjectDetailes[20] != null && Double.parseDouble(ProjectDetailes[20].toString()) > 0) {
													%><%=nfc.convert(Double.parseDouble(ProjectDetailes[20].toString()) / 10000000)%>&nbsp;&nbsp;<%
													} else {
													%>-<%
													}
													%>
												</h5>
											</td>
										</tr>
										<tr>
											<td><h5>7. Schedule (Months):</h5></td>
											<td>
												<h5>
													<%
													if (ProjectDetailes[9] != null && Integer.parseInt(ProjectDetailes[9].toString()) > 0) {
													%><%=ProjectDetailes[9]%>
													<%
													} else if (ProjectDetailes[18] != null) {
													%><%=ProjectDetailes[18]%>
													<%
													} else {
													%>-<%
													}
													%>
												</h5>
											</td>
										</tr>
										<tr>
											<td><h5>8. Project Deliverables/Output:</h5></td>
											<td><h5>
													<%
													if (ProjectDetailes[12] != null && !ProjectDetailes[12].toString().equalsIgnoreCase("")) {
													%>
													<%=ProjectDetailes[12]%>
													<%
													} else {
													%>-<%
													}
													%>
												</h5></td>
										</tr>
										<tr>
											<td>
												<h5>9. PSQR/GSQR/NSQR/ASQR/JSQR No(for MM/ TD(S)
													Projects):</h5>
											</td>

											<%
											if (!ProjectDetailes[21].toString().equalsIgnoreCase("1") || ProjectDetailes[21].toString().equalsIgnoreCase("8")) {
											%>
											<td><h5><span class="badge badge-pill badge-danger" style="float:right;padding:10px;margin-top:-6px">Not Applicable</span></h5></td>
											<%
											} else {
											int i = 1;
											for (Object[] obj : sanctionlistdetails) {
												if (i == 10) {
													if (obj[4] != null) {
											%>
											<td colspan="2"><input class="form-control"
												id="PGNAJedit" style="width: 70%" type="text" required
												maxlength="250" placeholder="" value="<%=obj[4]%>"
												oninput="this.value = this.value.replace(/[^A-Za-z0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
												<button type="button" style="float: right; margin-top: -13%"
													onclick="editPGNAJ(<%=obj[0]%>)" class="btn btn-warning ">UPDATE</button></td>

											<%
											} else {
											%>
											<td colspan="2" class="pgnaj"><input
												class="form-control" id="PGNAJ" style="width: 70%"
												type="text" required maxlength="250"
												placeholder="PSQR/GSQR/NSQR/ASQR/JSQR No"
												oninput="this.value = this.value.replace(/[^A-Za-z0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
												<button type="button" style="float: right; margin-top: -11%"
												onclick="addPGNAJ(<%=obj[0]%>)"
												class="btn btn-success btn-sm">SUBMIT</button></td>
											<%
											}
											}
											i++;
											}
											%>
											<%
											}
											%>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="col-md-6">
								<div class="row"
									style="color: black; font-family: 'FontAwesome' !important;">
									<div class="col-md-12">
										<table class="table table-striped"
											style="width: 100%; margin-top: 2%;">
											<tr>
												<td style="width: 63%">
													<h5>10. Trial Directive No:(for UT Projects)</h5>
												</td>
												<%
												if (!ProjectDetailes[21].toString().equalsIgnoreCase("6")) {
												%>
												<td colspan="2" ><h5 style="margin-left: 50px;"><span class="badge badge-pill badge-danger" style="float:right;padding:10px;margin-top:-1px">Not Applicable</span></h5></td>
												<%
												} else {
												int i = 1;
												for (Object[] obj : sanctionlistdetails) {
													if (i == 9) {
														if (obj[3] != null) {
												%>
												<td colspan="2"><input class="form-control"
													id="TDNedit" style="width:55%;margin-left: 10%;" type="text" required
													maxlength="250" placeholder="Trial Directive No"
													value="<%=obj[3]%>"
													oninput="this.value = this.value.replace(/[^A-Za-z0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
													<button type="button"
														style="float: right; margin-top: -14%"
														onclick="editTDN('<%=obj[0]%>')"
														class="btn btn-warning btn-sm">UPDATE</button></td>

												<%
												} else {
												%>
												<td colspan="2" class="tdn"><input class="form-control"
													id="TDN" style="width:55%;margin-left: 10%" type="text" required
													maxlength="250" placeholder="Trial Directive No"
													oninput="this.value = this.value.replace(/[^A-Za-z0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
													<input type="hidden" value="<%=obj[0]%>">
													<button type="button"
														style="float: right; margin-top: -13%"
														onclick="addTDN('<%=obj[0]%>')"
														class="btn btn-success btn-sm">SUBMIT</button></td>
												<%
												}
												}
												i++;
												}
												%>
												<%
												}
												%>
											</tr>
											<%
											if(projectFiles.isEmpty()){
											int i = 1;
											for (Object[] obj : sanctionlistdetails) {
											%>
											<tr>
												<td><h5><%=Integer.parseInt(obj[0].toString()) + 10 + "." + " " + obj[1]%></h5></td>
												<%
												if (i == 5 && !projectTypeId.equalsIgnoreCase("1")) {
												%>
												<td align="center"><h5><span class="badge badge-pill badge-danger" style="float:right;padding:10px;margin-top:-6px">Not Applicable</span></h5><td></td>
												<%
												}else{%>
												<td align="center"><button class="btn btn-sm btn-danger" style="box-shadow: 2px 2px 2px gray;" type="button">NO</button></td>
											<td><a href="PreProjectFileUpload.htm?stepdidno=3&initiationid=<%=initiationid%>&projectshortName=<%=projectshortName%>&projectTitle=<%=projectTitle%>&projectTypeId<%=projectTypeId%>" target="_blank">UploadFile</a></td>
												
											<%}
											i++;
											if (i == 9)
												break;
											%>
											<%
											}}else{
												int i = 1;
												for (Object[] obj : sanctionlistdetails) {
												%>
												<tr>
													<td><h5><%=Integer.parseInt(obj[0].toString()) + 10 + "." + " " + obj[1]%></h5></td>
													<%
													if (i == 5 && !projectTypeId.equalsIgnoreCase("1")) {
													%>
													<td align="center"><h5><span class="badge badge-pill badge-danger" style="padding:10px;">Not Applicable</span></h5></td>
													<td></td>
													<%
													}else{
														if(DocumentId.contains(obj[0])){
													%>
											<td><button type="button" style="margin-left: 40%;box-shadow: 2px 2px 2px gray;" class="btn btn-sm btn-success">YES</button></td>
											<%for(Object[]obj1:projectFiles) {
											if(obj1[8].toString().equalsIgnoreCase(obj[0].toString())){
											%>
											<td><form action="#">
											<button type="submit" class="btn" style="background: transparent;" id="download"  name="DocId"  formaction="ProjectRequirementAttachmentDownload.htm" formtarget="_blank" formmethod="GET" value="<%=obj1[8].toString()%>,<%=obj1[6].toString() %>,<%=obj1[1].toString() %>,<%=obj1[2].toString() %>"data-toggle="tooltip" data-placement="top"
									title="<%=obj1[3].toString() %>" >
											<i class="fa fa-download" style="color:#1f4037;"></i>
											</button>
											</form>
											</td>
											<%}}}else{ %>
											
											<td><button type="button" style="margin-left: 40%;box-shadow: 2px 2px 2px gray;" class="btn btn-sm btn-danger">NO</button></td>
											<td><a href="PreProjectFileUpload.htm?stepdidno=3&initiationid=<%=initiationid%>&projectshortName=<%=projectshortName%>&projectTitle=<%=projectTitle%>&projectTypeId<%=projectTypeId%>" target="_blank">UploadFile</a></td>
											<% }}
													i++;
													if (i == 9)
														break;	
												
												}}%>
										
											

										</table>
									</div>
								</div>
							</div>
						</div>
					<div class="mt-2"align="left"><h5 style="color:red; display: initial;">Note:-</h5><h5 style="display: inline">Not Available ( please specify the cost in project initiation)</h5> <h5 style="display: inline">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not Applicable ( This field is not applicable for this project type)</h5></div>
					</div>
					<%
					}
					%>
					<div class="card-body" id="cardbody1" >
					<div class="row">
					<div class="col-md-6" id="leftside">
					<div class="row mt-2">
					<div class="col-md-12 ml-1 leftsiderow" >
					<h5 class="ml-1">1.&nbsp;&nbsp;a.&nbsp;&nbsp;Title of the Project &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;<p><%=ProjectDetailes[7].toString()%></p>   </h5>
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-12 ml-1 leftsiderow" >
					<h5 class="ml-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b.&nbsp;&nbsp;Short Name or Acronym &nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;<p><%=ProjectDetailes[6]%></p>   </h5>
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-12 ml-1 leftsiderow" >
					<h5 class="ml-1">2.&nbsp;&nbsp;&nbsp;&nbsp;Title of the Programme &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;<p><%=ProjectDetailes[16]%></p>   </h5>
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-12 ml-1 leftsiderow">
					<h5 class="ml-1">3.&nbsp;&nbsp;&nbsp;Objective&nbsp;&nbsp;&nbsp;&nbsp;- &nbsp;
												<%if(!DetailsList.isEmpty()){
												for (Object[] obj : DetailsList) {
													if (obj[1] != null) {
														if (obj[1].toString().length() > 60) {
												%>
												<%=obj[1].toString().substring(0,60)%>
												<button class="btn"  style="background: transparent;"
													type="button" onclick="showModal('Objective')">
													<span
														style="color: #1176ab; text-decoration: underline; font-size: 18px; font-weight: 900" id="btn1">View
														more</span>
												</button>
												<%
												} else if(obj[1].toString().trim().length()==0){%>
													<p>Not Mentioned</p>
													<%}else {
												%>
												<%=obj[1]%>
												<%
												}
												}else{%>
												<p>Not Mentioned</p>
												<%}}}else{
												%>
											<p>Not Mentioned</p>				
								<%} %>
					
					</h5>
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-12 ml-1 leftsiderow">
					<h5 class="ml-1">4.&nbsp;&nbsp;&nbsp;Scope&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;
						<%						if(!DetailsList.isEmpty()){
												for (Object[] obj : DetailsList) {
													if (obj[2] != null) {
														if (obj[2].toString().length() > 60) {
												%>
												<%=obj[2].toString().substring(0, 60)%>

												<button class="btn"  style="background: transparent;"
													type="button" onclick="showModal('Scope')">
													<span id="btn2"
														style="color: #1176ab; text-decoration: underline; font-size: 18px; font-weight: 900">View
														more</span>
												</button>
												<%
												} else if(obj[2].toString().trim().length()==0){%>
													<p>Not Mentioned</p>
													<%}else {
												%>
												<%=obj[2]%>
												<%
												}
												}else{%>
												<p>Not Mentioned</p>
												<%}}}else{
													%>					
												<p>Not Mentioned</p>
											<%} %>
					</h5>
					</div>
					</div>

					<div class="row mt-2">
					<div class="col-md-12 ml-1 leftsiderow">
					<h5 class="ml-1">5.&nbsp;&nbsp;&nbsp; Proposed Six monthly milestones along-with financial outlay (in Cr)&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-sm  btn-primary" style="box-shadow:2px 2px 2px gray;" onclick="showSchedule()" >View</button>
					</h5>
					</div>
					</div>
					
					<div class="row mt-2">
					<div class="col-md-12 ml-1 leftsiderow">
					<h5 class="ml-1">
					6.&nbsp;&nbsp;&nbsp;Specify the User 
						<%if(ProjectDetailes[22]==null){ %>
					
						<select class="form-control selectdee" id="user"
										name="user" data-container="body" data-live-search="true" style="font-size: 5px; width: 27%">
						<option value="IA">Army</option>			
						<option value="IAF">Air Force</option>
						<option value="IN">Navy</option>
						<option value="IS">Inter-services</option>
						<option value="DO">DRDO</option>
						<option value="OH">Others</option>				
					</select>
					
					
					<span id="adduser"><button type="button" class="btn btn-sm btn-success" onclick="submitUser()" style="box-shadow: 2px 2px 2px gray;">SUBMIT</button>
					</span>
					<%}else{ %>
											<select class="form-control selectdee" id="user" name="user"
												data-container="body" data-live-search="true"
												style="font-size: 5px; width: 27%">
												<option
													<%if (ProjectDetailes[22].toString().equalsIgnoreCase("IA")) {%>
													selected <%}%> value="IA">Army</option>
												<option
													<%if (ProjectDetailes[22].toString().equalsIgnoreCase("IAF")) {%>
													selected <%}%> value="IAF">Air Force</option>
												<option
													<%if (ProjectDetailes[22].toString().equalsIgnoreCase("IN")) {%>
													selected <%}%> value="IN">Navy</option>
												<option
													<%if (ProjectDetailes[22].toString().equalsIgnoreCase("IS")) {%>
													selected <%}%> value="IS">Inter-services</option>
												<option
													<%if (ProjectDetailes[22].toString().equalsIgnoreCase("DO")) {%>
													selected <%}%> value="DO">DRDO</option>
												<option
													<%if (ProjectDetailes[22].toString().equalsIgnoreCase("OH")) {%>
													selected <%} %> value="OH">Others</option>
											</select>


											<button class="btn btn-sm btn-warning" onclick="submitUser()"
												style="box-shadow: 2px 2px 2px grey;">UPDATE</button>



											<%} %>					
					</h5>
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-12 ml-1 leftsiderow">
					<h5 class="ml-1">7.&nbsp;&nbsp;&nbsp;Procurement Plan&nbsp;&nbsp;&nbsp;
					<a type="btn" class="btn btn-sm btn-primary" target="_blank" style="box-shadow: 2px 2px 2px gray" href="ProjectProcurement.htm?&initiationid=<%=initiationid%>&projectshortName=<%=projectshortName%>">View</a>
					</h5>
					</div>
					</div>
										<div class="row mt-2">
					<div class="col-md-12 ml-1 leftsiderow">
					<h5 class="ml-1">
					8.&nbsp;&nbsp;&nbsp;Is it a Multi-lab Project? &nbsp;&nbsp;<%
					if (ProjectDetailes[11] != null && ProjectDetailes[11].toString().equalsIgnoreCase("Y")) {
					%><p>&nbsp;&nbsp;Yes&nbsp;&nbsp;</p>
											<%
											} else {
											%><p>&nbsp;&nbsp;No&nbsp;&nbsp;</p>
											<%
											}
											%>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<%
											int count = 1;
											if (!ProjectInitiationLabList.isEmpty()) {
											%>

											<button type="button" class="btn btn-sm btn-primary"
												style="box-shadow: 2px 2px 2px gray; font-family: FontAwesome"
												data-toggle="tooltip" data-placement="top"
												data-width="100%"
												title="<%for (Object[] obj : ProjectInitiationLabList) {%><%=count + ". " + obj[2] + '\n'%><%count++;}%>">
												View Labs</button>
											<%
											}else{%>											
											<span class="badge badge-primary p-2" style="box-shadow: 2px 2px 2px gray">Not specified</span>
											<% }%>


										</h5>
					</div>
					</div>
					</div>					
					<div class="col-md-6 " id="rightside">
					<div class="row">
					<div class="col-md-12 mt-2" id="divmethodology">
					<h5 class="mt-1 point">9.Specify the proposed LSI / DcPP/ PA or selection methodology
					<span class="" id="spanbtn9" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showbtn9editor()" >
					<i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
									<%if(MacroDetails.length==0){ %>
									<div class="col-md-12" align="left"
										style="margin-left: 0px; width: 100%;display: none;" id="divmethodologyeditor"> 
										<div id="methodologydiv" class="center"></div>
										<div class="row"></div>

										<textarea name="methodology" style="display: none;"></textarea>
										<div align="center" id="addmethodology"><button type="button" class="btn btn-sm btn-success mt-1" onclick="submitMethodology()">SUBMIT</button></div>
									</div>
									<%}else{ %>
												<div class="col-md-12" align="left"
										style="margin-left: 0px; width: 100%;display: none;" id="divmethodologyeditor"> 
										<div id="methodologydiv" class="center"><%if(MacroDetails[3]!=null){ %><%=MacroDetails[3].toString()%><%} %></div>
										<div class="row"></div>

										<textarea name="methodology" style="display: none;"></textarea>
										<%if(MacroDetails[3]==null){ %>
										<div align="center" id="addmethodology"><button type="button" class="btn btn-sm btn-success mt-1" onclick="submitMethodology()">SUBMIT</button></div>
										<%}else{ %>
										<div align="center" id="addmethodology"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="submitMethodology()">UPDATE</button></div>
										<%} %>
									</div>
									<%} %>
				    <div class="col-md-12 mt-2" id="divadditonal">
					<h5 class="mt-1 point" style="">10.Additional requirement of mechanical transport vehicles specific to the project, for equipment/developed systems and stores<br> (with justifications):
					<span class="" id="spanbtn10" style="float: right" >
					<button class="btn btn-sm bg-transparent " type="button"  onclick="showbtn10editor()">
					<i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
									<%if(MacroDetails.length==0){ %>				
									<div class="col-md-12" align="left"
										style="margin-left: 0px; width: 100%;display: none;" id="divadditonaleditor"> 
										<div id="Additionaldiv" class="center"> </div>
										<div class="row"></div>

										<textarea name="AdditionalRequirement" style="display: none;"></textarea>
										<div align="center" id="reqsubmit"><button type="button" class="btn btn-sm btn-success mt-1" onclick="submitRequirement()">SUBMIT</button></div>
									    </div>
										<%}else{ %>
										<div class="col-md-12" align="left"
										style="margin-left: 0px; width: 100%;display: none;" id="divadditonaleditor"> 
										<div id="Additionaldiv" class="center"><%if(MacroDetails[2]!=null){ %><%=MacroDetails[2].toString()%><%} %> </div>
										<div class="row"></div>

										<textarea name="AdditionalRequirement" style="display: none;"></textarea>
											<%if(MacroDetails[2]==null){ %>
										<div align="center" id="reqsubmit"><button type="button" class="btn btn-sm btn-success mt-1" onclick="submitRequirement()">SUBMIT</button></div>
									   <%}else{ %>
									   	<div align="center" id="reqsubmit"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="submitRequirement()">UPDATE</button></div>
									   <%} %>
									   
									    </div>
										<%}%>
										
										
					<div class="col-md-12 mt-2" id="divotherinformation">
					<h5 class="mt-1 point">11.Any other information
					<span class="" id="spanbtn11" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showbtn11editor()" >
					<i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
										<%if(MacroDetails.length==0){ %>	
									<div class="col-md-12" align="left"
										style="margin-left: 0px; width: 100%; display: none;"
										id="divotherinformationeditor">
										<div id="otherinformationDiv" class="center"></div>
										<div class="row"></div>

										<textarea name="OtherInformation" style="display: none;"></textarea>
										<div align="center" id="informationSubmit">
											<button type="button" class="btn btn-sm btn-success mt-1"
												onclick="submitOtherInformation()">SUBMIT</button>
										</div>
									</div>
									<%}else{ %>
													<div class="col-md-12" align="left"
										style="margin-left: 0px; width: 100%; display: none;"
										id="divotherinformationeditor">
										<div id="otherinformationDiv" class="center"><%if(MacroDetails[4]!=null){ %><%=MacroDetails[4].toString()%><%} %></div>
										<div class="row"></div>

										<textarea name="OtherInformation" style="display: none;"></textarea>
										<%if(MacroDetails[4]==null){ %>
										<div align="center" id="informationSubmit">
											<button type="button" class="btn btn-sm btn-success mt-1"
												onclick="submitOtherInformation()">SUBMIT</button>
										</div>
										<%}else{ %>
											<div align="center" id="informationSubmit">
											<button type="button" class="btn btn-sm btn-warning mt-1"onclick="submitOtherInformation()">UPDATE</button>
											</div>
										<%} %>
									</div>
									<%} %>
									
					<div class="col-md-12 mt-2" id="divenclosures">
					<h5 class="mt-1 point">12.Enclosures
					<span class="ml-5"></span><span class="ml-5"></span><span class="ml-4"></span>
					<span class="ml-5" id="spanbtn12" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showbtn12editor()" >
					<i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
									<%if(MacroDetails.length==0){ %>	
									<div class="col-md-12" align="left"
										style="margin-left: 0px; width: 100%; display: none;"
										id="divEnclosureseditor">
										<div id="EnclosuresDiv" class="center"></div>
										<div class="row"></div>

										<textarea name="Enclosures" style="display: none;"></textarea>
										<div align="center" id="addenclosures">
											<button type="button" class="btn btn-sm btn-success mt-1"
												onclick="submitEnclosures()">SUBMIT</button>
										</div>
									</div>
									<%}else{ %>
									<div class="col-md-12" align="left"
										style="margin-left: 0px; width: 100%; display: none;"
										id="divEnclosureseditor">
										<div id="EnclosuresDiv" class="center">
										<%if(MacroDetails[5]!=null){ %><%=MacroDetails[5].toString()%><%} %>
										</div>
										<div class="row"></div>

										<textarea name="Enclosures" style="display: none;"></textarea>
										<%if(MacroDetails[5]==null){ %>
										<div align="center" id="addenclosures">
											<button type="button" class="btn btn-sm btn-success mt-1"
												onclick="submitEnclosures()">SUBMIT</button>
										</div>
										<%}else{ %>
												<div align="center" id="addenclosures">
											<button type="button" class="btn btn-sm btn-warning mt-1"
												onclick="submitEnclosures()">UPDATE</button>
										</div>
										<%} %>
									</div>
									<%} %>

					<div class="col-md-12 mt-2" id="projectdeliverables">
					<h5 class="mt-1" id="deliverables">13.Proposed project deliverables<br>
					<span>
					<%if(MacroDetails.length==0){ %>	
					<label class=" font-weight-bold">(a) No of prototypes for testing :</label>
					<input class="form-control" id="PrototypesNo"name="PrototypesNo" type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" style="display:inline-block;width:10% ;margin-left:2%" >
					<br><label class=" font-weight-bold mt-1">(b) No of (type approved/qualified) deliverables:</label>
					<input class="form-control mt-1" id="deliverables1" name="deliverables1" type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" style="display:inline-block;width:10%;margin-left:2%" >
					 <br><span class="text-center" id="protospan"><button class="btn btn-sm btn-success mt-1" type="button" onclick="valueSubmit()" style="margin-left: 50%;">SUBMIT</button></span>
					 <%}else{ %>
					 <label class=" font-weight-bold">(a) No of prototypes for testing :</label>
					<input class="form-control" id="PrototypesNo"name="PrototypesNo" type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" style="display:inline-block;width:10% ;margin-left:2%" value="<%if(!MacroDetails[6].toString().equalsIgnoreCase("0")){%><%=MacroDetails[6] %><%}else{%>0<%}%>">
					<br><label class=" font-weight-bold mt-1">(b) No of (type approved/qualified) deliverables:</label>
					<input class="form-control mt-1" id="deliverables1" name="deliverables" type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" style="display:inline-block;width:10%;margin-left:2%" value="<%if(!MacroDetails[7].toString().equalsIgnoreCase("0")){%><%=MacroDetails[7] %><%}else{%>0<%}%>">
					 <br><span class="text-center" id="protospan">
					 <%if(MacroDetails[6].toString().equalsIgnoreCase("0")&&MacroDetails[7].toString().equalsIgnoreCase("0")) {%>
					 <button class="btn btn-sm btn-success mt-1" type="button" onclick="valueSubmit()" style="margin-left: 50%;">SUBMIT</button>
					 <%}else {%>
					  <button class="btn btn-sm btn-warning mt-1" type="button" onclick="valueSubmit()" style="margin-left: 50%;">UPDATE</button>
					 <% }%>
					 </span>
					 <%} %>
					 </span>
					</h5>
					</div></div>
					</div>
					</div>
					<div class="mt-2"align="left"><h5 style="color:red; display: initial;">Note:-</h5><h5 style="display: inline">Not Available ( please specify the cost in project initiation)</h5> <h5 style="display: inline">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not Applicable ( This field is not applicable for this project type)</h5></div>
					</div>

					<div class="card-body" id="cardbody2" style="display: none;">
					<div class="row">
					<div class="col-md-6"  id="part2lefside">
					<div class="row mt-1" id="point1">
					<div class="col-md-12">
					<h5>1. Brief technical appreciation
					<span class="" id="BriefPoint" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showAllSubPoints()" >
					<i class="btn  fa fa-lg fa-caret-down" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					
					
					</div>
					<div class="row subpointalldiv" id="briefSubPoints"  style="display:none ;height:450px; overflow-y: scroll;">
					<div class="col-md-12 subpoint"  id="subpointdiv1">
					<h5 style="border: 1px solid cadetblue !important;">1.1. Justification (need) for undertaking the project/programme along with the  recommendation of the cluster council/DMC.
					<span  id="subpoint1" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,1)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					 </h5>
					</div>
				<div class="col-md-12 mt-3 subpointdiv1" align="left"
				style="margin-left: 0px; width: 100%;display: none;" id="">
				<p>Declared in PDF / If not specified you are suggested to add in Project Initiation Details</p> 
				</div>
					<div class="col-md-12 subpoint" id="subpointdiv2">
					<h5 style="border: 1px solid cadetblue !important;">
					1.2. What will be achieved by taking this project. 
					<span  id="subpoint2" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,2)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
				<div class="col-md-12 subpointdiv2" align="left"
				style="margin-left: 0px; width: 100%;display: none;" id=""> 
				<div id="subpointdiv2Editor" class="center">
				<%if(BriefList.length!=0 &&BriefList[12]!=null){ %>
				<%=BriefList[12].toString() %>
				<%}else{%><%}%>
				</div>
				<div class="row"></div>
				<textarea name="" style="display: none;"></textarea>
				<%if(BriefList.length!=0 &&BriefList[12]!=null){ %>
				<div align="center" id="a2"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefNeedSubmit(2)">UPDATE</button></div>
				<%}else{ %>
				<div align="center" id="a2"><button type="button" class="btn btn-sm btn-success mt-1" onclick="briefNeedSubmit(2)">SUBMIT</button></div>
				<%} %>
				</div>	 				
					
					<div class="col-md-12 subpoint" id="subpointdiv3">
					<h5 style="border: 1px solid cadetblue !important;">1.3. Competence level/preliminary work done to acquire the same. 
					<span  id="subpoint3" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,3)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					<div class="col-md-12 mt-3 subpointdiv3" align="left"
					style="margin-left: 0px; width: 100%;display: none;" id="">
					<p>Declared in PDF / If not specified you are suggested to add in Project Initiation Details</p> 
					</div>
					<div class="col-md-12 subpoint" id="subpointdiv4">
					<h5 style="border: 1px solid cadetblue !important;"> 1.4. Brief of TRL analysis.
					<span  id="subpoint4" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,4)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
				<!--Editor  -->
				<div class="col-md-12 subpointdiv4" align="left"
				style="margin-left: 0px; width: 100%;display: none;" id=""> 
				<div id="subpointdiv4Editor" class="center">
				<%if(BriefList.length!=0 &&BriefList[2]!=null){ %>
				<%=BriefList[2].toString() %>
				<%}else{%><%}%>
				</div>
				<div class="row"></div>
				<textarea name="" style="display: none;"></textarea>
				<%if(BriefList.length!=0 &&BriefList[2]!=null){ %>
				<div align="center" id="a4"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefTRLSubmit(4)">UPDATE</button></div>
				<%}else{ %>
				<div align="center" id="a4"><button type="button" class="btn btn-sm btn-success mt-1" onclick="briefTRLSubmit(4)">SUBMIT</button></div>
				<%} %>
				</div>
									
				<div class="col-md-12 subpoint" id="subpointdiv5">
					<h5 style="border: 1px solid cadetblue !important;">1.5.
					Peer Review Committee recommendations
					<span  id="subpoint5" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,5)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
				<div class="col-md-12 subpointdiv5" align="left"
				style="margin-left: 0px; width: 100%;display: none;" id=""> 
				<div id="subpointdiv5Editor" class="center">
				<%if(BriefList.length!=0 &&BriefList[3]!=null){ %>
				<%=BriefList[3].toString() %>
				<%}else{%><%}%>
				</div>
				<div class="row"></div>
				<textarea name="" style="display: none;">5</textarea>
				<%if(BriefList.length!=0 &&BriefList[3]!=null){ %>
				<div align="center" id="a5"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefPeerSubmit(5)">UPDATE</button></div>
				<%}else{ %>
				<div align="center" id="a5"><button type="button" class="btn btn-sm btn-success mt-1" onclick="briefPeerSubmit(5)">SUBMIT</button></div>
				<%} %>
				</div>
					
				<div class="col-md-12 subpoint" id="subpointdiv6">
					<h5 style="border: 1px solid cadetblue !important;">1.6.
					Action Plan for prototype development. 
					<span  id="subpoint6" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,6)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					
				<div class="col-md-12 subpointdiv6" align="left"
				style="margin-left: 0px; width: 100%;display: none;" id=""> 
				<div id="subpointdiv6Editor" class="center">
				<%if(BriefList.length!=0 &&BriefList[4]!=null){ %>
				<%=BriefList[4].toString() %>
				<%}else{%><%}%>
				</div>
				<div class="row"></div>
				<textarea name="" style="display: none;"></textarea>
				<%if(BriefList.length!=0 &&BriefList[4]!=null){ %>
				<div align="center" id="a6"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefActionSubmit(6)">UPDATE</button></div>
				<%}else{ %>
				<div align="center" id="a6"><button type="button" class="btn btn-sm btn-success mt-1" onclick="briefActionSubmit(6)">SUBMIT</button></div>
				<%} %>
				</div>
									
					<div class="col-md-12 subpoint" id="subpointdiv7">
					<h5 style="border: 1px solid cadetblue !important;">1.7. Realisation Plan
					<span  id="subpoint7" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,7)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					
					<div class="col-md-12 mt-3 subpointdiv7" align="left"
					style="margin-left: 0px; width: 100%;display: none;" id="">
					<p>Declared in PDF / If not specified you are suggested to add in Project Initiation Details</p> 
					</div>					
					<div class="col-md-12 subpoint" id="subpointdiv8">
					<h5 style="border: 1px solid cadetblue !important;">1.8. Testing Plan
					<span  id="subpoint8" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,8)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>					
					</h5>
					</div>
				<div class="col-md-12 subpointdiv8" align="left"
				style="margin-left: 0px; width: 100%;display: none;" id=""> 
				<div id="subpointdiv8Editor" class="center">
				<%if(BriefList.length!=0 &&BriefList[5]!=null){ %>
				<%=BriefList[5].toString() %>
				<%}else{%><%}%>
				
				
				</div>
				<div class="row"></div>
				<textarea name="" style="display: none;">8</textarea>
				<%if(BriefList.length!=0 &&BriefList[5]!=null){ %>
				<div align="center" id="a8"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefTestSubmit(8)">UPDATE</button></div>
				<%}else{ %>
				<div align="center" id="a8"><button type="button" class="btn btn-sm btn-success mt-1" onclick="briefTestSubmit(8)">SUBMIT</button></div>
				<%} %>
				</div>
					<div class="col-md-12 subpoint" id="subpointdiv9">
					<h5 style="border: 1px solid cadetblue !important;">1.9. Critical factors/technology involved. 
					<span  id="subpoint9" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,9)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>							
					</h5>
					</div>
					<div class="col-md-12 mt-3 subpointdiv9" align="left"
					style="margin-left: 0px; width: 100%;display: none;" id="">
					<p>Declared in PDF / If not specified you are suggested to add in Project Initiation Details</p> 
					</div>					
					<div class="col-md-12 subpoint" id="subpointdiv10">
					<h5 style="border: 1px solid cadetblue !important;">1.10. High development risk areas and remedial actions proposed. 
					<span  id="subpoint10" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,10)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>						
					</h5>
					</div>
					<div class="col-md-12 mt-3 subpointdiv10" align="left"
					style="margin-left: 0px; width: 100%;display: none;" id="">
					<p>Declared in PDF / If not specified you are suggested to add in Project Initiation Details</p> 
					</div>					
					<div class="col-md-12 subpoint" id="subpointdiv11">
					<h5 style="border: 1px solid cadetblue !important;">1.11. Responsibility Matrix 
					<span  id="subpoint11" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,11)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>						
					</h5>
					</div>	
				<div class="col-md-12 subpointdiv11" align="left"
				style="margin-left: 0px; width: 100%;display: none;" id=""> 
				<div id="subpointdiv11Editor" class="center">
				<%if(BriefList.length!=0 &&BriefList[6]!=null){ %>
				<%=BriefList[6].toString() %>
				<%}else{%><%}%>
				
				</div>
				<div class="row"></div>
				<textarea name="" style="display: none;"></textarea>
				<%if(BriefList.length!=0 &&BriefList[6]!=null){ %>
				<div align="center" id="a11"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefResSubmit(11)">UPDATE</button></div>
				<%}else{ %>
				<div align="center" id="a11"><button type="button" class="btn btn-sm btn-success mt-1" onclick="briefResrSubmit(11)">SUBMIT</button></div>
				<%} %>
				</div>						
					<div class="col-md-12 subpoint" id="subpointdiv12">
					<h5 style="border: 1px solid cadetblue !important;">1.12. Development Partners/DcPP/LSI
					<span  id="subpoint12" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,12)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>						
					</h5>
					</div>
				<div class="col-md-12 subpointdiv12" align="left"
				style="margin-left: 0px; width: 100%;display: none;" id=""> 
				<div id="subpointdiv12Editor" class="center">
				<%if(BriefList.length!=0 &&BriefList[7]!=null){ %>
				<%=BriefList[7].toString() %>
				<%}else{%><%}%>			
				</div>
				<div class="row"></div>
				<textarea name="" style="display: none;"></textarea>
				<%if(BriefList.length!=0 &&BriefList[7]!=null){ %>
				<div align="center" id="a12"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefDevelopmentSubmit(12)">UPDATE</button></div>
				<%}else{ %>
				<div align="center" id="a12"><button type="button" class="btn btn-sm btn-success mt-1" onclick="briefDevelopmentSubmit(12)">SUBMIT</button></div>
				<%} %>
				</div>						
					<div class="col-md-12 subpoint" id="subpointdiv13">
					<h5 style="border: 1px solid cadetblue !important;">1.13. Production agencies proposed. 
					<span  id="subpoint13" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,13)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>						
					</h5>
					</div>
				<div class="col-md-12 subpointdiv13" align="left"
				style="margin-left: 0px; width: 100%;display: none;" id=""> 
				<div id="subpointdiv13Editor" class="center">
					<%if(BriefList.length!=0 &&BriefList[8]!=null){ %>
				<%=BriefList[8].toString() %>
				<%}else{%><%}%>
				
				</div>
				<div class="row"></div>
				<textarea name="" style="display: none;"></textarea>
				<%if(BriefList.length!=0 &&BriefList[8]!=null){ %>
				<div align="center" id="a13"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefProductionSubmit(13)">UPDATE</button></div>
				<%}else{ %>
				<div align="center" id="a13"><button type="button" class="btn btn-sm btn-success mt-1" onclick="briefProductionSubmit(13)">SUBMIT</button></div>
				<%} %>				</div>					
					<div class="col-md-12 subpoint" id="subpointdiv14">
					<h5 style="border: 1px solid cadetblue !important;">1.14. Costs benefit analysis/spin-off benefits. 
					<span  id="subpoint14" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,14)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button></span></h5></div>	
				<div class="col-md-12 subpointdiv14" align="left"
				style="margin-left: 0px; width: 100%;display: none;" id=""> 
				<div id="subpointdiv14Editor" class="center">
				<%if(BriefList.length!=0 &&BriefList[9]!=null){ %>
				<%=BriefList[9].toString() %>
				<%}else{%><%}%>
				</div>
				<div class="row"></div>
				<textarea name="" style="display: none;"></textarea>
				<%if(BriefList.length!=0 &&BriefList[9]!=null){ %>
				<div align="center" id="a14"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefcostSubmit(14)">UPDATE</button></div>
				<%}else{ %>
				<div align="center" id="a14"><button type="button" class="btn btn-sm btn-success mt-1" onclick="briefcostSubmit(14)">SUBMIT</button></div>
				<%} %>	
				</div>
					<div class="col-md-12 subpoint" id="subpointdiv15">
					<h5 style="border: 1px solid cadetblue !important;">1.15. Project management and monitoring structure proposed.
					<span  id="subpoint15" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,15)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button></span></h5></div>
				 	<div class="col-md-12 subpointdiv15" align="left"
					style="margin-left: 0px; width: 100%;display: none;" id=""> 
					<div id="subpointdiv15Editor" class="center">
					<%if(BriefList.length!=0 &&BriefList[10]!=null){ %>
					<%=BriefList[10].toString() %>
					<%}else{%><%}%>			
				
					</div>
					<div class="row"></div>
					<textarea name="" style="display: none;"></textarea>
					<%if(BriefList.length!=0 &&BriefList[10]!=null){ %>
					<div align="center" id="a15"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefStructureSubmit(15)">UPDATE</button></div>
					<%}else{ %>
					<div align="center" id="a15"><button type="button" class="btn btn-sm btn-success mt-1" onclick="briefStructureSubmit(15)">SUBMIT</button></div>
					<%} %></div>	 
					<div class="col-md-12 subpoint" id="subpointdiv16">
					<h5 style="border: 1px solid cadetblue !important;">1.16. PERT/Gantt Charts
					<span  id="subpoint16" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,16)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button></span></h5></div>	
				<div class="col-md-12 subpointdiv16" align="left"
				style="margin-left: 0px; width: 100%;display: none;" id=""> 
				<div id="subpointdiv16Editor" class="center">
				<%if(BriefList.length!=0 &&BriefList[11]!=null){ %>
				<%=BriefList[11].toString() %>
				<%}else{%><%}%>			
				
				</div>
				<div class="row"></div>
				<textarea name="" style="display: none;"></textarea>
				<%if(BriefList.length!=0 &&BriefList[11]!=null){ %>
				<div align="center" id="a16"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefPertSubmit(16)">UPDATE</button></div>
				<%}else{ %>
				<div align="center" id="a16"><button type="button" class="btn btn-sm btn-success mt-1" onclick="briefPertSubmit(16)">SUBMIT</button></div>
				<%} %>	
				</div> 
				<div class="col-md-12 subpoint" id="subpointdiv17">
					<h5 style="border: 1px solid cadetblue !important;">1.17.Critical technologies from industry
					<span  id="subpoint17" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,17)" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button></span></h5></div>	
				<div class="col-md-12 subpointdiv17" align="left"
				style="margin-left: 0px; width: 100%;display: none;" id=""> 
				<div id="subpointdiv17Editor" class="center">
				<%if(BriefList.length!=0 &&BriefList[13]!=null){ %>
				<%=BriefList[13].toString() %>
				<%}else{%><%}%>			
				
				</div>
				<div class="row"></div>
				<textarea name="" style="display: none;"></textarea>
				<%if(BriefList.length!=0 &&BriefList[13]!=null){ %>
				<div align="center" id="a17"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefCriticalSubmit(17)">UPDATE</button></div>
				<%}else{ %>
				<div align="center" id="a17"><button type="button" class="btn btn-sm btn-success mt-1" onclick="briefCriticalSubmit(17)">SUBMIT</button></div>
				<%} %>	
				</div>										
					</div>
					<div class="row mt-1"  id="point2">
					<div class="col-md-12">
					<h5>2. List of major additional facilities (capital) required for the project 
					<span class="" id="ADF" style="float: right">
					<button class="btn btn-sm bg-transparent plus" type="button" onclick="showAdditionalFacilities()" >
					<i class="btn  fa fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					</div>
				<div class="col-md-12 " align="left"
				style="margin-left: 0px; width: 100%;display: none;" id="majorcapitalEditor"> 
				<div id="majorcapital" class="center">
				<%if(macrodetailsTwo.length!=0&&macrodetailsTwo[5]!=null) {%>
				<%=macrodetailsTwo[5].toString() %>
				<%} %>
				</div>
				<div class="row"></div>
				<textarea name="" style="display: none;"></textarea>			
					<%if(macrodetailsTwo.length!=0&&macrodetailsTwo[5]!=null) {%>
				<div class="submit4" align="center" id=""><button type="button" class="btn btn-sm btn-warning mt-1" onclick="InformationSubmit(4)">UPDATE</button></div>
				<%}else{ %>
				<div class="submit4" align="center" id=""><button type="button" class="btn btn-sm btn-success mt-1" onclick="InformationSubmit(4)">SUBMIT</button></div>
				<%} %>
				</div>
					
					<div class="row mt-2" id="point3" >
					<div class="col-md-12">
					<h5 >3. Major training requirements
					<%if(projectTypeId.equalsIgnoreCase("3")||projectTypeId.equalsIgnoreCase("5")) {
					if(!trainingCost.equalsIgnoreCase("0.00")){
					%>
					<span class="" style="float: right ;margin-top: -3px;">
					<button type="button" class="btn btn-sm bg-transparent list"data-toggle="tooltip" data-placement="top"
					title="Details of training requirements"  onclick="ListModal1()"><i class="fa  fa-list" aria-hidden="true"></i>
					<span class="badge badge-counter badge-success" id="Notification1" style="float: right; margin-left: -7px;font-size: 100%!important;"><%=TrainingRequirementList.size() %></span>
					</button>					
					</span>
					<%}else{%>
					<span class="badge badge-pill badge-primary" style="float:right;padding:10px;margin-top:-6px">Not Available</span>
					<%}}else{ %>
					<span class="badge badge-pill badge-danger" style="float:right;padding:10px;margin-top:-6px">Not Applicable</span>
					<%} %>
					</h5></div>
					</div>
					
					<div class="row mt-2" id="point4">
					<div class="col-md-12">
					<h5>4. Details of Work Packages 
					<%if(!workCost.equalsIgnoreCase("0.00")){ %>
					<span class="" style="float: right ;margin-top: -3px;">
					<button type="button" class="btn btn-sm bg-transparent list"data-toggle="tooltip" data-placement="top"
					title="Details of Work Packages" onclick="ListModal2()"><i class="fa  fa-list" aria-hidden="true"></i>
					<span class="badge badge-counter badge-success" id="Notification2" style="float: right; margin-left: -7px; font-size: 100%!important;"><%=WorkPackageList.size() %></span>
					</button>
<!-- 					<button type="button" class="btn btn-sm bg-transparent plus"  data-toggle="tooltip" data-placement="top"
					title="Add Work Packages" onclick="showAddModal(2)">
					<i class="btn  fa  fa-plus " style="color: green; padding: 0px  0px  0px  0px;">
					</i>
					</button>	 --> 			
					</span>					
					<%} else{%>
						<span class="badge badge-pill badge-primary" style="float:right;padding:10px;margin-top:-6px;">Not Available</span>
					<%} %>
					</h5>
					</div>
					</div>
					<div class="row mt-2" id="point5">
					<div class="col-md-12">
					<h5>5. Details of CARS
					<%if(!carscost.equalsIgnoreCase("0.00")){ %>
					<span class="" style="float: right ;margin-top: -3px;">
					<button type="button" class="btn btn-sm bg-transparent list"data-toggle="tooltip" data-placement="top"
					title="Details of CARS" onclick="ListModal3()"><i class="fa  fa-list" aria-hidden="true"></i>
					<span class="badge badge-counter badge-success" id="Notification3" style="float: right; margin-left: -7px; font-size: 100%!important;"><%=CarsList.size() %></span>
					</button>					
					</span>	
					<%}else{ %>
					<span class="badge badge-pill badge-primary" style="float:right;padding:10px;margin-top:-6px;">Not Available</span>
					<%} %>	
					</h5>
					</div>
					</div>
					<div class="row mt-2" id="point6">
					<div class="col-md-12">
					<h5>6. Details of CAPSI 
					<%if(!capsicost.equalsIgnoreCase("0.00")) {%>
					<span class="ml-5" style="float: right ;margin-top: -3px;">
					<button type="button" class="btn btn-sm bg-transparent list"data-toggle="tooltip" data-placement="top"
					title="Details of CAPSI"  onclick="ListModal6()"><i class="fa  fa-list" aria-hidden="true"></i>
					<span class="badge badge-counter badge-success" id="Notification6" style="float: right; margin-left: -7px; font-size: 100%!important;"><%=CapsiList.size()%></span>
					</button>
					</span>	
					<%}else{%>
					<span class="badge badge-pill badge-primary" style="float:right;padding:10px;margin-top:-6px;">Not Available</span>
					<%} %>
					</h5>
					</div>
					</div>
					</div>
					<!-- Right Side Part  -->
					<div class="col-md-6" id="part2rightside"  style="">
					<div class="row mt-1 rightsidediv" id="point7">
					<div class="col-md-12">
					<h5>7. Details of Consultancy requirements 
					<%int x=0;
					if(!CostDetailsListSummary.isEmpty()) {
					for(Object[]obj:CostDetailsListSummary){
						if(obj[0].toString().contains("Consultancy")){	
					%>
					<span class="ml-5" style="float: right ;margin-top: -3px;">
					<button type="button" class="btn btn-sm bg-transparent list"data-toggle="tooltip" data-placement="top"
					title="Details of Consultancy requirements" onclick="ListModal4()"><i class="fa  fa-list" aria-hidden="true"></i>
					<span class="badge badge-counter badge-success" id="Notification4" style="float: right; margin-left: -7px; font-size: 100%!important;"><%=ConsultancyList.size() %></span>
					</button>			
					</span>	
					<%}else if(++x==CostDetailsListSummary.size()){%>
							<span class="badge badge-pill badge-primary" style="float:right;padding:10px;margin-top:-6px;">Not Available</span>
					<%}}}else{ %>
						<span class="badge badge-pill badge-primary" style="float:right;padding:10px;margin-top:-6px;">Not Available</span>
					<%} %>
					</h5>
					</div>
					</div>
					
					<div class="row mt-2 rightsidediv" id="point8">
					<div class="col-md-12">
					<h5>8. Details of additional manpower requirements 
					<span class="ml-5" style="float:right;margin-top:-3px;">
					<button type="button" class="btn btn-sm bg-transparent list"data-toggle="tooltip" data-placement="top"
					title="Details of manpower requirements " onclick="ListModal5()"><i class="fa  fa-list" aria-hidden="true"></i>
					<span class="badge badge-counter badge-success" id="Notification5" style="float: right; margin-left: -7px; font-size: 100%!important;"><%=ManpowerList.size() %></span>
					</button>
					</span>
					</h5>
					</div>
					</div>
					
					<div class="row mt-2 rightsidediv" id="point9">
					<div class="col-md-12">
					<h5>9. Details of additional building space requirement 
					
					<%int k=0;
					if(!CostDetailsListSummary.isEmpty()){
					for(Object[]obj:CostDetailsListSummary){
					if(obj[0].toString().contains("Works")){%>
						<span class="ml-5" id="buildingwork" style="float:right;margin-top:-3px;">
						<button type="button" class="btn btn-sm bg-transparent plus"  data-toggle="tooltip" data-placement="top"  onclick="showWork()">
					<i class="btn  fa  fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i></button>
					</span>	
					<%}else if(++k==CostDetailsListSummary.size()){%>
						<span class="badge badge-pill badge-primary" style="float:right;padding:10px;margin-top:-6px;">Not Available</span>
					<%}}}else{%>
						<span class="badge badge-pill badge-primary" style="float:right;padding:10px;margin-top:-6px;">Not Available</span>
					<%} %>
					</h5>
					</div>
					</div>
					<div class="row mt-2 rightsidediv" id="buildingworkDiv" style="display:none;">
					<div class="col-md-12">
					<div id="" style="">
					<table class="table table-striped table-bordered" id="mytable" style="width: 100%;font-family: 'FontAwesome';">
					<thead style="background: #055C9D;color: white;position: sticky;top:-2px;">
					<tr style="text-align: center;">
					<th style="width:3%">SN</th>
					<th style="width:30%">Head Code</th>
					<th style="width:40%">Item</th>
					<th style="width:15%">Cost <br>( &#8377; In Cr.)</th>
					</tr>
					</thead>
					<tbody id="">
					<%int c=0;
					if(!CostDetailsListSummary.isEmpty()){ 
					for(Object[]obj:CostDetailsListSummary){
						if(obj[0].toString().contains("Works")){
					%>
					<tr>
					<td><%=++c %></td>
					<td><%=obj[0].toString()+"( "%><%=obj[1].toString() +" )"%></td>
					<td></td>
					<td align="right"><%=nfc.convert(Double.parseDouble(obj[2].toString())/100000)%></td>
					</tr>
					<%}}} %>
					</tbody>
					</table>
					</div>
					</div>	
					</div>
					<div class="row mt-2 rightsidediv">
					<div class="col-md-12">
					<h5>10. Additional information
					<span class="ml-5 span1" style="float:right;margin-top:-3px;">
					<button type="button" class="btn btn-sm bg-transparent plus" onclick="showpart2information(1)">
					<i class="btn  fa  fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>	
					</span>						
					</h5>
					</div>
					</div>
					<%if(macrodetailsTwo.length!=0&&macrodetailsTwo[2].toString().length()>0) {%>
					<div class="row mt-1 information1" style="display: none;">
					<div class="col-md-12">
					<textarea id="information1"  class="form-control" maxlength="255 characters"><%=macrodetailsTwo[2].toString() %></textarea>
					</div>
					<div class="col-md-12 mt-1 submit1" align="center"><button type="submit" class="btn btn-sm btn-warning" onclick="InformationSubmit(1)">UPDATE</button></div>
					</div>
					<%} else{%>
					<div class="row mt-1 information1" style="display: none;">
					<div class="col-md-12">
					<textarea id="information1" class="form-control" maxlength="255 characters"></textarea>
					</div>
					<div class="col-md-12 mt-1 submit1" align="center"><button type="submit" class="btn btn-sm btn-success" onclick="InformationSubmit(1)">SUBMIT</button></div>
					</div>
					<%} %>
					<div class="row mt-2 rightsidediv">
					<div class="col-md-12">
					<h5>11. Comments of Project Director
					<span class="ml-5 span2" style="float:right;margin-top:-3px;">
					<button type="button" class="btn btn-sm bg-transparent plus" onclick="showpart2information(2)">
					<i class="btn  fa  fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button></span></h5></div></div>
					<%if(macrodetailsTwo.length!=0&&macrodetailsTwo[3].toString().length()>0) {%>
					<div class="row mt-1 information2" style="display: none;">
					<div class="col-md-12">
					<textarea id="information2"  class="form-control" maxlength="255 characters"><%=macrodetailsTwo[3].toString() %></textarea>
					</div>
					<div class="col-md-12 mt-1 submit2" align="center"><button type="button" class="btn btn-sm btn-warning" onclick="InformationSubmit(2)">UPDATE</button></div>
					</div>
					<%}else{ %>
					<div class="row mt-1 information2" style="display: none;">
					<div class="col-md-12">
					<textarea id="information2" class="form-control" maxlength="255 characters"></textarea>
					</div>
					<div class="col-md-12 mt-1 submit2" align="center"><button type="button" class="btn btn-sm btn-success" onclick="InformationSubmit(2)">SUBMIT</button></div>
					</div>
					<%} %>
					<div class="row mt-2 rightsidediv">
					<div class="col-md-12">
					<h5>12. Recommendations of Lab Director
					<span class="ml-5 span3" style="float:right;margin-top:-3px;">
					<button type="button" class="btn btn-sm bg-transparent plus" onclick="showpart2information(3)">
					<i class="btn  fa  fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button></span></h5></div></div>
					<%if(macrodetailsTwo.length!=0&&macrodetailsTwo[4].toString().length()>0) {%>
					<div class="row mt-1 information3" style="display: none;">
					<div class="col-md-12">
					<textarea id="information3"  class="form-control" maxlength="255 characters"><%=macrodetailsTwo[4].toString() %></textarea>
					</div>
					<div class="col-md-12 mt-1 submit3" align="center"><button type="button" class="btn btn-sm btn-warning" onclick="InformationSubmit(3)">UPDATE</button></div>
					</div>
					<%}else{ %>
				    <div class="row mt-1 information3" style="display: none;">
					<div class="col-md-12">
					<textarea id="information3"  class="form-control" maxlength="255 characters"></textarea>
					</div>
					<div class="col-md-12 mt-1 submit3" align="center"><button type="button" class="btn btn-sm btn-success" onclick="InformationSubmit(3)">SUBMIT</button></div>
					</div>
					<%} %>
					</div>
					</div>
				<div class="mt-2"align="left"><h5 style="color:red; display: initial;">Note:-</h5><h5 style="display: inline">Not Available ( please specify the cost in project initiation)</h5> <h5 style="display: inline">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not Applicable ( This field is not applicable for this project type)</h5></div>
				</div>
			</div>
		</div>
	</div>
	<!--View More Modal  -->
	<div class="modal fade bd-example-modal-lg" id="exampleModalLong"
		tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content addreq" style="width: 120%;">
				<div class="modal-header" style="background: #145374; height: 50px;">
					<h5 id="modalreqheader" style="font-size: 20px; color: white;"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" style="color: white">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="modalbody"></div>
			</div>
		</div>
	</div>
	
	<!--schedule and finacial outlay modal  -->
		<div class="modal fade bd-example-modal-lg" id="exampleschduleModal"
		tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content costreq" style="width: 150%;">
				<div class="modal-header" style="background: #145374; height: 50px;">
					<h5 id="modalreqheader" style="font-size: 20px; color: white;padding-left:20px ">Six monthly milestones along-with financial outlay</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" style="color: white">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="modalSchedulebody">
					<div class="col-md-12">
						<table class="table table-striped table-bordered" id="mytable"
							style="width: 100%;font-family: 'FontAwesome';">
							<thead style="background: #055C9D;color: white;">
								<tr>
								<th style="width:8%;text-align: center;">SN</th>
								<th style="width:12%;text-align: center;">Time(Months)</th>
								<th style="width:50%;text-align: center;">Six Monthly Technical Milestone</th>
								<th style="width:20%;text-align: center;">Financial Outlay &nbsp;(&#8377; in Cr.)</th>
								</tr>
							</thead>
							<tbody>
							<%/* int i=0; */
							if(ScheduleList.isEmpty()){%>
							<tr><td colspan="3" align="center"><h5>Please add Schedule for the project in Project Initiation</h5><td></tr>
							<%}else{
							int monthDivision=Integer.parseInt(ProjectDetailes[9].toString())%6==0?Integer.parseInt(ProjectDetailes[9].toString())/6:Integer.parseInt(ProjectDetailes[9].toString())/6+1;
							
							for(int i=0;i<monthDivision;i++){
							%>
							<tr >
							<td style="text-align: center;"><%=i+1%></td>
							<td style="text-align: center;"><%=((i*6)+1)+"-"+((i+1)*6)%></td>
						
							<td>
							<%for(Object[]obj:ScheduleList) {
								boolean case1=Integer.parseInt(obj[5].toString())<=i;
								boolean case2=Integer.parseInt(obj[6].toString())>=((i*6)+1);
								boolean case3=Integer.parseInt(obj[6].toString())>((i+1)*6);
								boolean case4=case2&&Integer.parseInt(obj[6].toString())<((i+1)*6);
								boolean case5=Integer.parseInt(obj[5].toString())>=monthDivision;
								if(case1&&(case2||case3)){
								%>
								<%="MIL -"+obj[0].toString() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<%}else if(case5 &&case4){%>
								<%="MIL -"+obj[0].toString() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<%}}%>
								</td>
								<td id="td<%=i+1%>" align="right"><button class="finance" type="button" style="display:none;" onclick="finance(<%=i%>,<%=((i*6)+1)%>,<%=((i+1)*6)%>)"></button></td>
								</tr>
								<%}} %>
						
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--Cost Modal  -->
	<div class="modal fade bd-example-modal-lg" id="exampleCostModal"
		tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content costreq" style="width: 150%;">
				<div class="modal-header" style="background: #145374; height: 50px;">
					<h5 id="modalreqheader" style="font-size: 20px; color: white;">Breakup
						of Cost</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" style="color: white">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="modalCostbody">
					<div class="col-md-12">
						<table class="table table-striped table-bordered"
							style="width: 100%">
							<thead>
								<tr>
									<th style="width: 30%"><h5>Item</h5></th>
									<th style="width: 30%"><h5>Details</h5></th>
									<th style="width: 40%"><h5>Cost(in Cr.)</h5></th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--Add Major Trainig Requirements  Start-->
				<input type="hidden" id="mainTrainingBudget" value="<%=trainingCost%>">  
			<input type="hidden" id="TrainingBudget" value="">  
			<div class="modal fade bd-example-modal-lg" id="showAddModal1"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Training Requirements</h5>
						<h5 id="TrainingCostLeft" class="mt-2 ml-5"style="color:palegreen;font-size: 16px; margin-left:50% !important;">Budget Left - <%=nfc.convert(Double.parseDouble(trainingCost)/100000)+" Lakhs"%></h5>
						<button type="button" class="close" data-dismiss="modal" id="cross1"
							aria-label="Close" style="color: white">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
					<div class="col-md-12">
					<div class="row mt-4">
					<div class="col-md-4">
					<label class="sidelabel">Discipline/area for training </label><span class="mandatory" style="color: red;">*</span>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="areafortraining" maxlength="255 characters" style="width:80%">
					</div>
					</div>
					<div class="row mt-4">
					<div class="col-md-4">
					<label class="sidelabel">Agency contacted</label><span class="mandatory" style="color: red;">*</span>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="agencyContacted" maxlength="255 characters" style="width:80%">
					</div>
					</div>
					<div class="row mt-4">
					<div class="col-md-5" style="max-width: 34%">
					<label class="sidelabel">No of Personnel proposed to be trained </label><span class="mandatory" style="color: red;">*</span>
					</div>
					<div class="col-md-2" style="max-width: 12%">
					<input type="text" class="form-control" id="Personneltrained" maxlength="255 characters" style="width:100%" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-1" style="padding: 0px;">
					<label class="sidelabel">Duration  </label><span class="mandatory" style="color: red;">*</span>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="Duration" maxlength="255 characters" style="width:60%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-1">
					<label class="sidelabel">Cost  </label><span class="mandatory" style="color: red;">*</span>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="Costadd" maxlength="255 characters" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					</div>
				    <div class="row mt-4">
					<div class="col-md-4">
					<label class="sidelabel">Remarks </label><span class="mandatory" style="color: red;">*</span>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="Remarks" maxlength="255 characters" style="width:80%">
					</div>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="submitForm1()">SUBMIT</button>
					</div>
					</div>
					</div>
					</div>
					</div>	
					</div>
	<!--End-->
		<!--List of Major Training Requirements  -->
			<div class="modal fade bd-example-modal-lg" id="TrainingRequirementsList"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 170%;margin-left: -35%">
					<div class="modal-header" id="modalreqheader" style="background: #145374; ">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Training Requirements</h5>
						<h5 id="TableTrainingCost" class="mt-2 ml-5"style="color:orange;font-size: 16px; font-weight:800;margin-left:10% !important;"></h5>
						<h5 id="TableTrainingCostPlanned" class="mt-2 ml-3"style="color:white;font-size: 16px; font-weight:800;"></h5>
						<h5 id="TableTrainingCostLeft" class="mt-2 ml-3"style="color:palegreen; font-weight:800;font-size: 16px; ">Budget Left - <%=nfc.convert(Double.parseDouble(workCost)/100000)+" Lakhs"%></h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross2">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
					<div id="scrollclass" style="height:400px;overflow-y:scroll">
					<table class="table table-striped table-bordered" id="mytable" style="width: 100%;font-family: 'FontAwesome';">
					<thead style="background: #055C9D;color: white;position: sticky;top:-2px;">
					<tr style="text-align: center;">
					<th style="width:3%">Selcet</th>
					<th style="width:3%">SN</th>
					<th style="width:30%">Discipline/area for training</th>
					<th style="width:20%">Agency contacted</th>
					<th style="width:12%">No of Personnel </th>
					<th style="width:7%">Duration<br>(Months)</th>
					<th style="width:7%">Cost<br>( in cr)</th>
					<th style="width:13%">Remarks</th>
					</tr>
					</thead>
					<tbody id="tbody1">
					
					</tbody>
					</table>
					<span class="radiovalueModal1"><input type="hidden" value="0" id="radio1"></span>
					</div>
					<div class="mt-1" align="center">
					<button type="button" id="trainBtn"class="btn btn-primary btn-sm submit"  data-toggle="tooltip" data-placement="top"
					title="Add training requirements" onclick="showAddModal(1)">ADD
				
					</button>
					<button type="button" class="btn btn-sm btn-warning" onclick="showEditModal1()">EDIT</button>
					</div>
					</div>
					</div>
					</div>
					</div>
		<!--End  -->
		<!--Edit training requirements  -->
		<div class="modal fade bd-example-modal-lg" id="EditTrainingRequirements"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; ">
					<input type="hidden" id="previousTrainingCost">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Training Requirements</h5>
						<h5 id="EditTrainCostPlanned" class="mt-2 ml-3"style="color:orange;font-size: 16px; font-weight:800;margin-left:30%!important;"></h5>
						<h5 id="EditTrainCostLeft" class="mt-2 ml-3"style="color:palegreen; font-weight:800;font-size: 16px; ">Budget Left - <%=nfc.convert(Double.parseDouble(workCost)/100000)+" Lakhs"%></h5>
						<button type="button" class="close" data-dismiss="modal" id="cross3"
							aria-label="Close" style="color: white">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<input type="hidden" id="traingingPlannedCost">
					<div class="modal-body">
					<div class="col-md-12">
					<div class="row mt-4">
					<div class="col-md-4">
					<label class="sidelabel">Discipline/area for training </label><span class="mandatory" style="color: red;">*</span>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="areafortrainingEdit" maxlength="255 characters" style="width:80%">
					</div>
					</div>
					<div class="row mt-4">
					<div class="col-md-4">
					<label class="sidelabel">Agency contacted</label><span class="mandatory" style="color: red;">*</span>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="agencyContactedEdit" maxlength="255 characters" style="width:80%">
					</div>
					</div>
					<div class="row mt-4">
					<div class="col-md-5" style="max-width: 34%">
					<label class="sidelabel">No of Personnel to be trained </label><span class="mandatory" style="color: red;">*</span><label class="sidelabel">&nbsp;&nbsp; &nbsp;&nbsp;: </label>
					</div>
					<div class="col-md-2" style="max-width: 12%">
					<input type="text" class="form-control" id="PersonneltrainedEdit" maxlength="255 characters" style="width:100%" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-1" style="padding: 0px;">
					<label class="sidelabel">Duration</label><span class="mandatory" style="color: red;">*</span><label class="sidelabel"> &nbsp;: </label>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="DurationEdit" maxlength="255 characters" style="width:60%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-1">
					<label class="sidelabel">Cost</label><span class="mandatory" style="color: red;">*</span><label class="sidelabel"> &nbsp;&nbsp;: </label>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="CostaddEdit" maxlength="255 characters" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					</div>
				    <div class="row mt-4">
					<div class="col-md-4">
					<label class="sidelabel">Remarks </label><span class="mandatory" style="color: red;">*</span>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="RemarksEdit" maxlength="255 characters" style="width:80%">
					<input type="hidden" id="trainingid">
					</div>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="editForm1()">SUBMIT</button>
					<button type="button" class="btn  btn-sm  back" onclick="BackModal(1)">BACK</button>
					</div>
					</div>
					</div>
					</div>
					</div>	
					</div>

	<!-- End -->
	
			<!--Add work packages  -->
			<input type="hidden" id="mainWorkBudget" value="<%=workCost%>">  
			<input type="hidden" id="WorkBudget" value="">  
			<div class="modal fade bd-example-modal-lg" id="showAddModal2"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374;;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Work Packages</h5>
						<h5 id="workCostLeft" class="mt-2 ml-5"style="color:palegreen;font-size: 16px; margin-left:50% !important;">Budget Left - <%=nfc.convert(Double.parseDouble(workCost)/100000)+" Lakhs"%></h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross4">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
					<div class="col-md-12">
					<div class="row">
					<div class="col-md-3">
					<label class="sidelabel">Name of Govt agencies<span class="mandatory" maxlength="255 charactes" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input class="form-control" type="text" id="GovtAgencies" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3">
					<label class="sidelabel">Work Package<span class="mandatory" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="workPackage" maxlength="255 charactes" placeholder="max 250 characters">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3">
					<label class="sidelabel">Objectives<span class="mandatory" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-8">
					<input type="text" id="Objectives"class="form-control" maxlength="400 characters" style="line-height: 3rem">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3">
					<label class="sidelabel">Scope<span class="mandatory" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-8">
					<input type="text" id="Scope"class="form-control" maxlength="400 characters" style="line-height: 3rem">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3">
					<label class="sidelabel">Cost<span class="mandatory" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="Cost3" maxlength="255 characters" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-3" align="right">
					<label class="sidelabel"> PDC (in months) <span class="mandatory" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="PDC" maxlength="255 characters" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="submitForm2()">SUBMIT</button>
					</div>
					</div>
					</div>
					</div>
					</div>
					</div>
					</div>
	<%} %>
			<!--End  -->
			<!--List of Work Packages  -->
						<div class="modal fade bd-example-modal-lg" id="WorkPackacgesList"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 170%;margin-left: -35%">
					<div class="modal-header" id="modalreqheader" style="background: #145374;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Details of Work Packacges</h5>
						<h5 id="TableWorkCost" class="mt-2 ml-5"style="color:orange;font-size: 16px; font-weight:800;margin-left:10% !important;"></h5>
						<h5 id="TableWorkCostPlanned" class="mt-2 ml-3"style="color:white;font-size: 16px; font-weight:800;"></h5>
						<h5 id="TableWorkCostLeft" class="mt-2 ml-3"style="color:palegreen; font-weight:800;font-size: 16px; ">Budget Left - <%=nfc.convert(Double.parseDouble(workCost)/100000)+" Lakhs"%></h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross5">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
					<div id="scrollclass" style="height:400px;overflow-y:scroll">
					<table class="table table-striped table-bordered" id="mytable" style="width: 100%;font-family: 'FontAwesome';">
					<thead style="background: #055C9D;color: white;position: sticky;top:-2px;">
					<tr style="text-align: center;">
					<th style="width:3%">Selcet</th>
					<th style="width:3%">SN</th>
					<th style="width:15%">Name of Govt agencies</th>
					<th style="width:15%">Work Package </th>
					<th style="width:20%">Objectives</th>
					<th style="width:20%">Scope</th>
					<th style="width:7%">PDC<br>(Months)</th>
					<th style="width:7%">Cost<br>( in Lakhs)</th>
					</tr>
					</thead>
					<tbody id="tbody2">
					
					</tbody>
					</table>
					<span class="radiovalueModal2"><input type="hidden" value="0" id="radio2"></span>
					</div>
					<div class="mt-1" align="center">
					<button id="workAdd" type="button" class="btn btn-primary btn-sm submit"  data-toggle="tooltip" data-placement="top"
					title="Add Work Packages" onclick="showAddModal(2)">ADD
					</button>
					<button id="workedit" type="button" class="btn btn-sm btn-warning" onclick="showEditModal2()">EDIT</button>
					</div>
					</div>
					</div>
					</div>
					</div>
			
			<!--End  -->
			
			<!--Edit work packages  -->
						<div class="modal fade bd-example-modal-lg" id="EditWork"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; ">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Work Packages</h5>
						<h5 id="EditWorkCostPlanned" class="mt-2 ml-3"style="color:orange;font-size: 16px; font-weight:800;margin-left:30%!important;"></h5>
						<h5 id="EditWorkCostLeft" class="mt-2 ml-3"style="color:palegreen; font-weight:800;font-size: 16px; ">Budget Left - <%=nfc.convert(Double.parseDouble(workCost)/100000)+" Lakhs"%></h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross6">
							<span aria-hidden="true">&times;</span>
						</button>
						<input type="hidden" id="previousWorkCost">
					</div>
					<input type="hidden" id="WorkPlanned">
					<div class="modal-body">
					<div class="col-md-12">
					<div class="row">
					<div class="col-md-3">
					<label class="sidelabel">Name of Govt agencies<span class="mandatory" maxlength="255 charactes" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input class="form-control" type="text" id="GovtAgenciesEdit" maxlength="255 charactes" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3">
					<label class="sidelabel">Work Package<span class="mandatory" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="workPackageEdit" maxlength="255 charactes" placeholder="max 250 characters">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3">
					<label class="sidelabel">Objectives<span class="mandatory" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-8">
					<input type="text" id="ObjectivesEdit"class="form-control" maxlength="400 characters" style="line-height: 3rem">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3">
					<label class="sidelabel">Scope<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-8">
					<input type="text" id="ScopeEdit"class="form-control" maxlength="400 characters" style="line-height: 3rem">
					<input type="hidden" id="workid">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3">
					<label class="sidelabel">Cost<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="Cost3Edit" maxlength="255 characters" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-3" align="right">
					<label class="sidelabel"> PDC (in months) <span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="PDCEdit" maxlength="255 characters" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="editForm2()">SUBMIT</button>
					<button type="button" class="btn  btn-sm  back" onclick="BackModal(2)">BACK</button>
					</div></div></div></div></div></div>
			<!--End  -->
			<!-- Add Cars Details -->
			<input type="hidden" id="mainCarBudget" value="<%=carscost%>">
			<input type="hidden" id="CarBudget">
			<div class="modal fade bd-example-modal-lg" id="showAddModal3"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">CARS</h5>
						<h5 id="CarBudgetLeft" class="mt-2 ml-5"style="color:palegreen;font-size: 16px; margin-left:50% !important;">Budget Left - <%=nfc.convert(Double.parseDouble(carscost)/100000)+" Lakhs"%></h5>	
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross7">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
					<div class="col-md-12">
					<div class="row">
					<div class="col-md-4">
					<label class="sidelabel">Name of Institute/ Agency<span class="mandatory" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="Institute" maxlength="300 characters" placeholder="maximum 300 characters">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Name of the identified professor<span class="mandatory" style="color: red;">*</span></label>					
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="professor" maxlength="300 characters" placeholder="maximum 300 characters" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Area where R&D is required<span class="mandatory" style="color: red;">*</span></label>					
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="Area" maxlength="300 characters" placeholder="maximum 300 characters" >
					</div>
					</div>	
					<div class="row mt-2">
					<div class="col-md-2">
					<label class="sidelabel">Cost<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="Cost4" maxlength="20" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-2" align="right">
					<label class="sidelabel">PDC<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="PDC1" maxlength="9" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>					
					</div>		
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Confidence level of the agency (1-10)
					<span class="mandatory" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					  <input type="range" class="form-control-range" step="1" min="1" max="10" id="confidence" onInput="$('#rangeval1').html($(this).val())">
     				 <span id="rangeval1">5<!-- Default value --></span>
					</div>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="submitForm3()">SUBMIT</button>
					</div></div></div></div></div></div>
			<!--End  -->
			<!--List of Cars  -->
			<div class="modal fade bd-example-modal-lg" id="CARSlist"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 170%;margin-left: -35%">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Details of Cars</h5>
						<h5 id="TablecarCost" class="mt-2 ml-5"style="color:orange;font-size: 16px; font-weight:800;margin-left:10% !important;"></h5>
						<h5 id="TablecarCostPlanned" class="mt-2 ml-3"style="color:white;font-size: 16px; font-weight:800;"></h5>
						<h5 id="TablecarCostCostLeft" class="mt-2 ml-3"style="color:palegreen; font-weight:800;font-size: 16px; ">Budget Left - <%=nfc.convert(Double.parseDouble(carscost)/100000)+" Lakhs"%></h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross8">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
					<div id="scrollclass" style="height:400px;overflow-y:scroll">
					<table class="table table-striped table-bordered" id="mytable" style="width: 100%;font-family: 'FontAwesome';">
					<thead style="background: #055C9D;color: white;position: sticky;top:-2px;">
					<tr style="text-align: center;">
					<th style="width:3%">Selcet</th>
					<th style="width:3%">SN</th>
					<th style="width:18%">Name of Institute/ Agency </th>
					<th style="width:18%">Name of the identified professo</th>
					<th style="width:18%">Area where R&D is required </th>
					<th style="width:5%">Cost<br>( in cr)</th>
					<th style="width:5%">PDC<br>(Months)</th>
					<th style="width:10%">Confidence level of the agency</th>
					</tr>
					</thead>
					<tbody id="tbody3">
					
					</tbody>
					</table>
					</div>
					<span class="radiovalueModal3"><input type="hidden" value="0" id="radio3"></span>
					<div class="mt-1" align="center">
					<button type="button" id="carsAdd"class="btn btn-primary btn-sm submit"  data-toggle="tooltip" data-placement="top"
					title="Add CARS" onclick="showAddModal(3)">ADD
					</button>
					<button type="button" id="carsEdit"class="btn btn-sm btn-warning" onclick="showEditModal3()">EDIT</button>
					</div></div></div></div></div>
			<!-- End -->
					<div class="modal fade bd-example-modal-lg" id="EditCars"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<input type="hidden" id="previousCarCost">
						<h5 class="modal-title" style="color:white;font-size: 20px;">CARS</h5>
							<h5 id="EditcarCostPlanned" class="mt-2 ml-5"style="color:Orange;font-size: 16px; font-weight:800;margin-left: 20%!important;"></h5>
						<h5 id="EditcarCostCostLeft" class="mt-2 ml-3"style="color:palegreen; font-weight:800;font-size: 16px; "></h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross9">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<input type="hidden" id="carscostPlanned">
					<div class="modal-body">
					<div class="col-md-12">
					<div class="row">
					<div class="col-md-4">
					<label class="sidelabel">Name of Institute/ Agency<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="InstituteEdit" maxlength="300 characters" placeholder="maximum 300 characters">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Name of the identified professor<span class="mandatory" style="color: red;">*</span></label>					
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="professorEdit" maxlength="300 characters" placeholder="maximum 300 characters" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Area where R&D is required<span class="mandatory" style="color: red;">*</span></label>					
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="AreaEdit" maxlength="300 characters" placeholder="maximum 300 characters" >
					</div>
					</div>	
					<div class="row mt-2">
					<div class="col-md-2">
					<label class="sidelabel">Cost<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="Cost4Edit" maxlength="20" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-2" align="right">
					<label class="sidelabel">PDC<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="PDC1Edit" maxlength="9" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>					
					</div>		
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Confidence level of the agency (1-10)
					<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
<!-- 					<input type="range" min="1" max="10" id="confidenceEdit" step="1" style="color:blue"> -->
					 <input type="range" class="form-control-range" step="1" min="1" max="10" id="confidenceEdit" onInput="$('#rangeval2').html($(this).val())">
     				 <span id="rangeval2"><!-- Default value --></span>
					<input type="hidden" id="carsid">
					</div>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="editForm3()">SUBMIT</button>
					<button type="button" class="btn  btn-sm  back" onclick="BackModal(3)">BACK</button>
					</div></div></div></div></div></div>	
			<!-- Consultancy Add -->
			<input type="hidden" id="mainConsultancyBudget" value="<%=consultancyCost%>">  
			<input type="hidden" id="ConsultancyBudget" value="">  
			<div class="modal fade bd-example-modal-lg" id="showAddModal4"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; ">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Consultancy requirements</h5>
						<h5 id="consultancyCostLeft" class="mt-2 ml-5"style="color:palegreen;font-size: 16px; margin-left:50% !important;">Budget Left - <%=nfc.convert(Double.parseDouble(consultancyCost)/100000)+" Lakhs"%></h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross10">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
					<div class="col-md-12">
					<div class="row mt-2">
					<div class="col-md-3"><label class="sidelabel">Discipline/Area <span class="mandatory" style="color: red;">*</span></label> </div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input id="ConsultancyArea" type="text" maxlength="300 characters" class="form-control" placeholder="maximum 250 characters" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3"><label class="sidelabel">Agency <span class="mandatory" style="color: red;">*</span></label> </div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input id="ConsultancyAgency" type="text" maxlength="300 characters" class="form-control" placeholder="maximum 250 characters" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3"><label class="sidelabel">Name of person/ expert  <span class="mandatory" style="color: red;">*</span></label> </div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input id="Consultancyperson" type="text" maxlength="300 characters" class="form-control" placeholder="maximum 250 characters" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3" style="padding-right: 0px;"><label class="sidelabel">Process that will be followed  <span class="mandatory" style="color: red;">*</span></label> </div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input id="ConsultancyProcess" type="text" maxlength="300 characters" class="form-control" placeholder="maximum 250 characters" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3" style="padding-right: 0px;"><label class="sidelabel">Cost  <span class="mandatory" style="color: red;">*</span></label> </div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-3">
					<input id="ConsultancyCost" type="text" maxlength="300 characters" class="form-control" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" placeholder="" >
					</div>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="submitForm4()">SUBMIT</button>
					</div>
					
					</div>
					</div></div></div></div>
			<!-- Consultancy List -->
			<div class="modal fade bd-example-modal-lg" id="ConsultancyList"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 170%;margin-left: -35%">
					<div class="modal-header" id="modalreqheader" style="background: #145374;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Details of Consultancy requirements</h5>
						<h5 id="TableconsultancyCost" class="mt-2 ml-5"style="color:orange;font-size: 16px; font-weight:800;margin-left:10% !important;"></h5>
						<h5 id="TableconsultancyCostPlanned" class="mt-2 ml-3"style="color:white;font-size: 16px; font-weight:800;"></h5>
						<h5 id="TableconsultancyCostLeft" class="mt-2 ml-3"style="color:palegreen; font-weight:800;font-size: 16px; ">Budget Left - <%=nfc.convert(Double.parseDouble(consultancyCost)/100000)+" Lakhs"%></h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross11">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body" >
					<div id="scrollclass" style="height:400px;overflow-y:scroll">
					<table class="table table-striped table-bordered" id="mytable" style="width: 100%;font-family: 'FontAwesome';">
					<thead style="background: #055C9D;color: white;position: sticky;top:-2px;">
					<tr style="text-align: center;">
					<th style="width:3%">Selcet</th>
					<th style="width:3%">SN</th>
					<th style="width:18%">Discipline/Area</th>
					<th style="width:18%">Agency</th>
					<th style="width:20%">Name of person/ expert </th>
					<th style="width:8%">Cost<br>( in Lakhs)</th>
					<th style="width:20%">Process that will be followed</th>
					</tr>
					</thead>
					<tbody id="tbody4">
					</tbody>
					</table>
					<span class="radiovalueModal4"><input type="hidden" value="0" id="radio4"></span>
					</div>
					<div class="mt-2" align="center">
					<button id="consultancyAdd" type="button" class="btn btn-primary btn-sm submit"  data-toggle="tooltip" data-placement="top"
					title="Add Consultancy requirements" onclick="showAddModal(4)">
					<!-- <i class="btn  fa  fa-plus " style="color: green; padding: 0px  0px  0px  0px;"> -->
					ADD
					</i>
					</button>	
					<button type="button" class="btn btn-sm btn-warning" onclick="showEditModal4()">EDIT</button>
					</div></div>
					</div>
					</div>
					</div>
			<!-- End --><!--Edit Consultancy  -->
				<div class="modal fade bd-example-modal-lg" id="EditConsultancyModal"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; ">
					<input type="hidden" id="ConsultancyPlanned">
					<input type="hidden" id="CBT"><!--consultancy Budget for this id  -->
						<h5 class="modal-title" style="color:white;font-size: 20px;">Consultancy requirements</h5>
						<h5 id="EditconsultancyCostPlanned" class="mt-2 ml-3"style="color:orange;font-size: 16px; font-weight:800; margin-left:30% !important;"></h5>
						<h5 id="EditconsultancyCostLeft" class="mt-2 ml-3"style="color:palegreen; font-weight:800;font-size: 16px; "></h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross12">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
					<div class="col-md-12">
					<div class="row mt-2">
					<div class="col-md-3"><label class="sidelabel">Discipline/Area <span class="mandatory" style="color: red;">*</span></label> </div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input id="ConsultancyAreaEdit" type="text" maxlength="300 characters" class="form-control" placeholder="maximum 250 characters" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3"><label class="sidelabel">Agency <span class="mandatory" style="color: red;">*</span></label> </div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input id="ConsultancyAgencyEdit" type="text" maxlength="300 characters" class="form-control" placeholder="maximum 250 characters" >
					<input type="hidden" id="consultancyid">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3"><label class="sidelabel">Name of person/ expert  <span class="mandatory" style="color: red;">*</span></label> </div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input id="ConsultancypersonEdit" type="text" maxlength="300 characters" class="form-control" placeholder="maximum 250 characters" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3" style="padding-right: 0px;"><label class="sidelabel">Process that will be followed  <span class="mandatory" style="color: red;">*</span></label> </div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6">
					<input id="ConsultancyProcessEdit" type="text" maxlength="300 characters" class="form-control" placeholder="maximum 250 characters" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3" style="padding-right: 0px;"><label class="sidelabel">Cost  <span class="mandatory" style="color: red;">*</span></label> </div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-3">
					<input id="ConsultancyCostEdit" type="text" maxlength="300 characters" class="form-control" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" placeholder="" >
					</div>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="editForm4()">SUBMIT</button>
					<button type="button" class="btn  btn-sm  back" onclick="BackModal(4)">BACK</button>
					</div>
					
					</div>
					</div></div></div></div>		
			<!--Additional Manpower Requirements-->
			<div class="modal fade bd-example-modal-lg" id="showAddModal5"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 110%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Additional manpower requirements 
						</h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross13">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" >
					<div class="col-md-12">
					<div class="row mt-1">
					<div class="col-md-3"><label class="sidelabel">Designation/Rank<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-8"><input type="text" id="designation" class="form-control" maxlength="255 characters" placeholder="Enter Designaton"></div>
					</div>
					<div class="row mt-3">
					<div class="col-md-3"><label class="sidelabel">Discipline<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-8"><input type="text" id="DisciplineAdd" class="form-control" maxlength="255 characters" placeholder="Enter Discipline"></div>
					</div>
					<div class="row mt-3">
					<div class="col-md-3"><label class="sidelabel">Number(s)<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2"><input type="text" id="Numbers" class="form-control" maxlength="10 characters" placeholder="" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"></div>
					<div class="col-md-2" align="right"><label class="sidelabel">Period<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2"><input type="text" id="Period" class="form-control" maxlength="10 characters" placeholder="Months" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"></div>					
					</div>
					<div class="row mt-3">
					<div class="col-md-3"><label class="sidelabel">Remarks<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-8"><input type="text" id="RemarksAdd" class="form-control" maxlength="255 characters" placeholder="Enter Remarks"></div>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="submitForm5()">SUBMIT</button>
					</div>
					</div>
					</div></div></div></div>
			
			<!--List of Manpower -->		
						<div class="modal fade bd-example-modal-lg" id="ManpowerList"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 170%;margin-left: -35%">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Details of manpower requirements</h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross14">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
					<div id="scrollclass" style="height:400px;overflow-y:scroll">
					<table class="table table-striped table-bordered" id="mytable" style="width: 100%;font-family: 'FontAwesome';">
					<thead style="background: #055C9D;color: white;position: sticky;top:-2px;">
					<tr style="text-align: center;">
					<th style="width:3%">Selcet</th>
					<th style="width:3%">SN</th>
					<th style="width:15%">Designation/Rank </th>
					<th style="width:25%">Discipline</th>
					<th style="width:5%">Number(s) </th>
					<th style="width:5%">Period </th>
					<th style="width:25%">Remarks</th>
					</tr>
					</thead>
					<tbody id="tbody5">
					</tbody>
					</table>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit"  data-toggle="tooltip" data-placement="top"
					title="Add manpower requirements "  onclick="showAddModal(5)">ADD</button>
					<button type="button" id="manpowEdit" class="btn btn-sm btn-warning" onclick="showEditModal5()">EDIT</button></div>
					<span class="radiovalueModal5"><input type="hidden" value="0" id="radio5"></span>
					</div></div></div></div>
			<!--  -->
			<!--Edit Modal  -->
						<div class="modal fade bd-example-modal-lg" id="EditManpower"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 110%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Additional manpower requirements 
						</h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross15">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" >
					<div class="col-md-12">
					<div class="row mt-1">
					<div class="col-md-3"><label class="sidelabel">Designation/Rank<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-8"><input type="text" id="designationEdit" class="form-control" maxlength="255 characters" placeholder="Enter Designaton"></div>
					</div>
					<div class="row mt-3">
					<div class="col-md-3"><label class="sidelabel">Discipline<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-8"><input type="text" id="DisciplineAddEdit" class="form-control" maxlength="255 characters" placeholder="Enter Discipline"></div>
					</div>
					<div class="row mt-3">
					<div class="col-md-3"><label class="sidelabel">Number(s)<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2"><input type="text" id="NumbersEdit" class="form-control" maxlength="10 characters" placeholder="" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"></div>
					<div class="col-md-2" align="right"><label class="sidelabel">Period<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2"><input type="text" id="PeriodEdit" class="form-control" maxlength="10 characters" placeholder="Months" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"></div>					
					</div>
					<div class="row mt-3">
					<div class="col-md-3"><label class="sidelabel">Remarks<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-8"><input type="text" id="RemarksAddEdit" class="form-control" maxlength="255 characters" placeholder="Enter Remarks"></div>
					<input type="hidden" id="requirementid">
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="editForm5()">SUBMIT</button>
					<button type="button" class="btn  btn-sm  back" onclick="BackModal(5)">BACK</button>
					</div>
					</div>
					</div></div></div></div>
			<input type="hidden" id="mainCapsiBudget" value="<%=capsicost%>">
			<input type="hidden" id="CapsiBudget">	
			<div class="modal fade bd-example-modal-lg" id="showAddModal6"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">CAPSI</h5>
						<h5 id="CapsiBudgetLeft" class="mt-2 ml-5"style="color:palegreen;font-size: 16px; margin-left:50% !important;">Budget Left - <%=nfc.convert(Double.parseDouble(carscost)/100000)+" Lakhs"%></h5>	
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross16">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
					<div class="row mt-1">
					<div class="col-md-3"><label class="sidelabel">IDST Location<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6"><input type="text" id="Station" class="form-control" maxlength="255 characters" placeholder="Enter Station"></div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3"><label class="sidelabel">Area where R&D is required<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6"><input type="text" id="Capsiarea" class="form-control" maxlength="255 characters" placeholder="Enter R&D"></div>
					</div>
										<div class="row mt-2">
					<div class="col-md-2">
					<label class="sidelabel">Cost<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="Capsicost" maxlength="20" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-2" align="right">
					<label class="sidelabel">PDC<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="capsipdc" maxlength="9" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>					
					</div>							
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Confidence level of the agency (1-10)
					<span class="mandatory" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<!-- <input type="range" min="1" max="10" id="capsiconfidence" step="1" style="color:blue"> -->
					<input type="range" class="form-control-range" step="1" min="1" max="10" id="capsiconfidence" onInput="$('#rangeval3').html($(this).val())">
     				 <span id="rangeval3">5<!-- Default value --></span>
					</div>
					</div>	
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="submitForm6()">SUBMIT</button>
					</div>								
					</div></div></div></div>
			<!--  -->
			<div class="modal fade bd-example-modal-lg" id="CAPSILIST"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 170%;margin-left: -35%">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Details of CAPSI</h5>
						<h5 id="TablecapsiCost" class="mt-2 ml-5"style="color:orange;font-size: 16px; font-weight:800;margin-left:10% !important;"></h5>
						<h5 id="TablecapsiCostPlanned" class="mt-2 ml-3"style="color:white;font-size: 16px; font-weight:800;"></h5>
						<h5 id="TablecapsiCostCostLeft" class="mt-2 ml-3"style="color:palegreen; font-weight:800;font-size: 16px; ">Budget Left - <%=nfc.convert(Double.parseDouble(capsicost)/100000)+" Lakhs"%></h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross17">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
					<div id="scrollclass" style="height:400px;overflow-y:scroll">
					<table class="table table-striped table-bordered" id="mytable" style="width: 100%;font-family: 'FontAwesome';">
					<thead style="background: #055C9D;color: white;position: sticky;top:-2px;">
					<tr style="text-align: center;">
					<th style="width:3%">Selcet</th>
					<th style="width:3%">SN</th>
					<th style="width:25%">IDST Location </th>
					<th style="width:20%">Area where R&D is required </th>
					<th style="width:10%">Cost<br>( in cr)</th>
					<th style="width:10%">PDC<br>(Months)</th>
					<th style="width:10%">Confidence level of the agency</th>
					</tr>
					</thead>
					<tbody id="tbody6">
					</tbody>
					</table>
					</div>
					<div class="mt-2" align="center">
					<button type="button" id="capsiAdd"class="btn btn-primary btn-sm submit"  data-toggle="tooltip" data-placement="top"
					title="" onclick="showAddModal(6)">ADD</button>
					<button type="button" id="capsiEdit" class="btn btn-sm btn-warning" onclick="showEditModal6()">EDIT</button></div>
					<span class="radiovalueModal6"><input type="hidden" value="0" id="radio6"></span>
					</div></div></div></div>
				<!--  -->
			<div class="modal fade bd-example-modal-lg" id="CapsiEditModal"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
					<input type="hidden" id="previousCapsiCost">
						<h5 class="modal-title" style="color:white;font-size: 20px;">CAPSI</h5>
								<h5 id="EditcapsiCostPlanned" class="mt-2 ml-5"style="color:Orange;font-size: 16px; font-weight:800;margin-left: 20%!important;"></h5>
						<h5 id="EditcapsiCostCostLeft" class="mt-2 ml-3"style="color:palegreen; font-weight:800;font-size: 16px; "></h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross18">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<input type="hidden" id="CapsiPlanned">
					<div class="modal-body">
					<div class="row mt-1">
					<div class="col-md-3"><label class="sidelabel">IDST Location<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6"><input type="text" id="StationEdit" class="form-control" maxlength="255 characters" placeholder="Enter Station"></div>
					</div>
					<div class="row mt-2">
					<div class="col-md-3"><label class="sidelabel">Area where R&D is required<span class="mandatory" style="color: red;">*</span></label></div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-6"><input type="text" id="CapsiareaEdit" class="form-control" maxlength="255 characters" placeholder="Enter R&D"></div>
					</div>
					<input type="hidden" id="capsid" value="0">
										<div class="row mt-2">
					<div class="col-md-2">
					<label class="sidelabel">Cost<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="CapsicostEdit" maxlength="20" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-2" align="right">
					<label class="sidelabel">PDC<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="capsipdcEdit" maxlength="9" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>					
					</div>							
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Confidence level of the agency (1-10)
					<span class="mandatory" style="color: red;">*</span></label>
					</div><div class="col-md-1"><label class="sidelabel">:</label></div>
					<div class="col-md-2">
					<input type="range" min="1" max="10" id="capsiconfidenceEdit" step="1" style="color:blue">
					</div>
					</div>	
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="editForm7()">SUBMIT</button>
					<button type="button" class="btn  btn-sm  back" onclick="BackModal(6)">BACK</button>
					</div>								
					</div></div></div></div>	
					
	<script>
	function showCostModal(){
		$('#exampleCostModal').modal('show');
	}
	function showSchedule(){
		$('#exampleschduleModal').modal('show');
	}
	$(document).ready(function() {
		$('#project').on('change', function() {
			var temp = $(this).children("option:selected").val();
			$('#submit').click();
		});
	});
		function addTDN(a) {
			var TDN = $('#TDN').val().trim();
			
			
			if(TDN===""){
				alert("The field can not be empty.")
			}else{
				$('#successdiv').css("display","none");
			if (confirm("Are you sure, you want to add Trial Directive No-"+TDN+"?")) {
				console.log(TDN)
				$.ajax({
					type : "GET",
					url : "SanctionDataUpdate.htm",
					data : {
						initiationid :
					<%=initiationid%>,
					StatementId:a,
					TDN:TDN,
				},
			datatype:"json",
			success : function (result){
				console.log(result);
				if(Number(result)>0){
					$('#successdiv').css("display","block");
					$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data Added Successfully.</div>');
					$('#successdiv').delay(3000).hide(0); 
				}
				$('.tdn').html('<input id="TDNedit" class="form-control" style="width:70%" type="text" maxlength="250" value="'+TDN+'"><button type="button" onclick="editTDN('+a+')" style="float: right; margin-top: -13%" class="btn btn-warning btn-sm">UPDATE</button>');
			}
			}) 
			
		}else{
			event.preventDefault();
			return false;
		}
			}
	}
	$(function () {
		  $('[data-toggle="tooltip"]').tooltip()
		})
	
	function editTDN(a){
		
		const tdn=$('#TDNedit').val().trim();
		if(tdn===""){
			alert("The field can not be empty.")
		}else{
			$('#successdiv').css("display","none");
			if (confirm("Are you sure, you want to update Trial Directive No-"+tdn+"?")){
				$.ajax({
					type:'GET',
					url:'ProjectTdnUpdate.htm',
					data:{
						initiationid :<%=initiationid%>,
					    StatementId:a,
						TDN:tdn,
						
					},
				datatype:'json',
				success:function(result){
					if(Number(result)>0){
						
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data Edited Successfully.</div>');
						$('#successdiv').delay(3000).hide(0); 
					
					}
				}
				})
				
				}
			else{
				event.preventDefault();
				return false;
			}
			}
			
	}

	function addPGNAJ(a) {
		var PGNAJ = $('#PGNAJ').val().trim();
	
		if(PGNAJ===""){
			alert("The field can not be empty.")
		}else{
			$('#successdiv').css("display","none");
		if (confirm("Are you sure, you want to add PSQR/GSQR/NSQR/ASQR/JSQR No-"+PGNAJ+"?")) {
			
			$.ajax({
				type : "GET",
				url : "SanctionUpdatePGNAJ.htm",
				data : {
					initiationid :
				<%=initiationid%>,
				StatementId:a,
				PGNAJ:PGNAJ,
			},
			datatype:"json",
			success:function(result){
				console.log(result);
				if(Number(result)>0){
					$('#successdiv').css("display","block");
					$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data Added Successfully.</div>');
					$('#successdiv').delay(3000).hide(0); 
				}
				$(".pgnaj").html('<input type="text" id="PGNAJedit" style="width:70%;" class="form-control" value="'+PGNAJ+'"> <button type="b"style="float: right; margin-top: -13%"onclick="editPGNAJ(10)" class="btn btn-warning btn-sm">UPDATE</button>')
			}
	
		}) 
	}else{
		event.preventDefault();
		return false;
	}
		}
}
	function editPGNAJ(a){
	
		const PGNAJedit=$('#PGNAJedit').val().trim();
		console.log(PGNAJedit)
		if(PGNAJedit===""){
			alert("This field can not be empty!")
		}else{
			$('#successdiv').css("display","none");
			
			if (confirm("Are you sure, you want to update PSQR/GSQR/NSQR/ASQR/JSQR No-"+PGNAJedit+"?")){
				 	$.ajax({
					type:'GET',
					url:'ProjectPGNAJUpdate.htm',
					data:{
						initiationid :<%=initiationid%>,
					    StatementId:a,
					    PGNAJ:PGNAJedit,
						
					},
				datatype:'json',
				success:function(result){
					if(Number(result)>0){
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data Edited Successfully.</div>');
						$('#successdiv').delay(3000).hide(0); 
					}
				}
				})
				}
			else{
				event.preventDefault();
				return false;
			}
			}
		}

	/* Second page clcik function */
		$('#page2').click(function(){
		$('#text').html('MICRO DETAILS OF PROJECT/PROGRAMME (PART-I)');
		$('#cardbody').css("display","none");
		$('#cardbody2').css("display","none");
		$('#cardbody1').css("display","block");
		$('#page2').css("background","#28a745");
		$('#page2').css("color","white");
		$('#page1').css("background","rgb(210 213 215)");
		$('#page1').css("color","black");
		$('#page3').css("background","rgb(210 213 215)");
		$('#page3').css("color","black");
		$('#page2').css("font-weight","800");
		$('#page3').css("font-weight","600");
		$('#page1').css("font-weight","600");
		$('#downloadform').html('<button type="submit" class="btn btn-sm" formmethod="GET"style="margin-top: -3%" formtarget="_blank"formaction="ProjectSanctionMacroDetailsDownload.htm"data-toggle="tooltip" data-placement="top"title="Download file"><i class="fa fa-download fa-sm" aria-hidden="true"></i></button>');
		})
		/*Third page click function */
		$('#page3').click(function(){
		$('#text').html('MICRO DETAILS OF PROJECT/PROGRAMME (PART-II)');
		$('#cardbody').css("display","none");
		$('#cardbody1').css("display","none");
		$('#cardbody2').css("display","block");
		$('#page3').css("background","#28a745");
		$('#page3').css("color","white");
		$('#page2').css("background","rgb(210 213 215)");
		$('#page2').css("color","black");
		$('#page1').css("background","rgb(210 213 215)");
		$('#page1').css("color","black");
		$('#page2').css("font-weight","600");
		$('#page3').css("font-weight","800");
		$('#page1').css("font-weight","600");
		$('#downloadform').html('');
		$('#downloadform').html('<button type="submit" class="btn btn-sm" formmethod="GET"style="margin-top: -3%" formtarget="_blank"formaction="ProjectSanctionMacroDetailsPart2Download.htm"data-toggle="tooltip" data-placement="top"title="Download file"><i class="fa fa-download fa-sm" aria-hidden="true"></i></button>');
		})
		/* First page click function  */
		$('#page1').click(function(){
		$('#text').html('STATEMENT OF CASE FOR SANCTION OF PROJECT/PROGRAMME');
		$('#cardbody1').css("display","none");
		$('#cardbody2').css("display","none");
		$('#cardbody').css("display","block");
		$('#page1').css("background","#28a745");
		$('#page1').css("color","white");
		$('#page2').css("background","rgb(210 213 215)");
		$('#page2').css("color","black");
		$('#page3').css("background","rgb(210 213 215)");
		$('#page3').css("color","black");
		$('#page2').css("font-weight","600");
		$('#page3').css("font-weight","600");
		$('#page1').css("font-weight","800");
		$('#downloadform').html('<button type="submit" class="btn btn-sm" formmethod="GET"style="margin-top: -3%" formtarget="_blank"formaction="ProjectSanctionDetailsDownload.htm"data-toggle="tooltip" data-placement="top"title="Download file"><i class="fa fa-download fa-sm" aria-hidden="true"></i></button>');
		})
		/*First page clicked function when page loaded  */
		$(document).ready(function(){
		$('#page1').click();	
		})
		
		/*for view more modal  */
		function showModal(a){
		
			$.ajax({
				type:'GET',
				url:'ProjectInitiationDetailsJsonValue.htm',
				data:{
					initiationid :<%=initiationid%>,
				},
				datatype:'json',
				success:function(result){
					 var ajaxresult=JSON.parse(result);
					if(a==="Objective"){
					$('#modalreqheader').html(a);
					$('#modalbody').html(ajaxresult[0][1]);
					}
					if(a==="Scope"){
						$('#modalreqheader').html(a);
						$('#modalbody').html(ajaxresult[0][2]);}
					
				}
			})
			
		
			$('#exampleModalLong').modal('show');
		}
		
	/* part1 page javascript  */
	function submitRequirement(){
		var AdditionalRequirement =CKEDITOR.instances['Additionaldiv'].getData();
		console.log(AdditionalRequirement);
		if(AdditionalRequirement===""){
			alert("This field can not be empty!")
		}else{
			if(confirm("Are you sure you want to update data?")){
				$('#successdiv').css("display","none");
			$.ajax({
					type:'POST',
					url:'ProjectAdditonalRequirementUpdate.htm',
					datatype:'json',
					data:{
						AdditionalRequirement:AdditionalRequirement,
						initiationid :<%=initiationid%>,
						${_csrf.parameterName}:	"${_csrf.token}",
					},
					success:function(result){
						var ajaxresult=JSON.parse(result);
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">'+ajaxresult+'</div>');
						$('#successdiv').delay(3000).hide(0); 
						$('#reqsubmit').html('<button class="btn btn-warning btn-sm"  onclick="submitRequirement()" style="box-shadow: 2px 2px 2px grey;">UPDATE</button>');
					}
				})
				
			}else{
				event.preventDefault();
				return false;
			}
		}
	}
		
		function submitMethodology(){

			var methodology =CKEDITOR.instances['methodologydiv'].getData();
			console.log(methodology)
			if(methodology===""){
				alert("This field can not be empty!")
			}else{
				if(confirm("Are you sure you want to update data?")){
					$('#successdiv').css("display","none");
				$.ajax({
						type:'POST',
						url:'ProjectMethodologyUpdate.htm',
						datatype:'json',
						data:{
							initiationid :<%=initiationid%>,
							methodology:methodology,
							${_csrf.parameterName}:	"${_csrf.token}",
						},
						success:function(result){
							var ajaxresult=JSON.parse(result);
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">'+ajaxresult+'</div>');
							$('#successdiv').delay(3000).hide(0); 
							$('#addmethodology').html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="submitMethodology()">UPDATE</button>');
						}
				}) 
			}
				else{
					event.preventDefault();
					return false;
				}
				
			}}
		
		function submitEnclosures(){
			var Enclosures =CKEDITOR.instances['EnclosuresDiv'].getData();
			console.log(Enclosures)
			if(Enclosures===""){
				alert("This field can not be empty!")
			}else{
				if(confirm("Are you sure you want to update data?")){
					$('#successdiv').css("display","none");
					$.ajax({
						type:'POST',
						url:'ProjectEnclosuresUpdate.htm',
						datatype:'json',
						data:{
							initiationid :<%=initiationid%>,
							Enclosures:Enclosures,
							${_csrf.parameterName}:	"${_csrf.token}",
						},
					success:function(result){
						var ajaxresult=JSON.parse(result);
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">'+ajaxresult+'</div>');
						$('#successdiv').delay(3000).hide(0); 
						$('#addenclosures').html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="submitEnclosures()">UPDATE</button>');

					}
					})
					
				}else{
					event.preventDefault();
					return false;
				}
				}
			
		}
		
		
	function submitOtherInformation(){
		var OtherInformation =CKEDITOR.instances['otherinformationDiv'].getData();
		console.log(OtherInformation)
		if(OtherInformation===""){
			alert("This field can not be empty!")
		}else{
			if(confirm("Are you sure you want to update data?")){
			$('#successdiv').css("display","none"); 
				$.ajax({
					type:'POST',
					url:'ProjectOtherInformationUpdate.htm',
					datatype:'json',
					data:{
						initiationid :<%=initiationid%>,
						OtherInformation:OtherInformation,
						${_csrf.parameterName}:	"${_csrf.token}",
					},
					success:function(result){
						var ajaxresult=JSON.parse(result);
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">'+ajaxresult+'</div>');
						$('#successdiv').delay(3000).hide(0); 
						$('#informationSubmit').html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="submitOtherInformation()">UPDATE</button>');
					}
				})
			}
			else{
				event.preventDefault();
				return false;
			}
		}
	}
	
	function valueSubmit(){
		var PrototypesNo=$('#PrototypesNo').val();
		var deliverables=$('#deliverables1').val();
		console.log(PrototypesNo+"hashas");
		if(PrototypesNo===""||deliverables===""){
			alert("please fill both the field");
		}else{
			if(confirm("Are you sure you want to update data?")){
				$('#successdiv').css("display","none"); 
		  		$.ajax({
					type:'GET',
					url:'PrototypeDeliverables.htm',
					datatype:'json',
					data:{
						initiationid :<%=initiationid%>,
						PrototypesNo:PrototypesNo,
						deliverables:deliverables,
						},
					success:function(result){
						var ajaxresult=JSON.parse(result);
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">'+ajaxresult+'</div>');
						$('#successdiv').delay(3000).hide(0); 
						$('#protospan').html('<button class="btn btn-sm btn-warning mt-1" type="button" onclick="valueSubmit()" style="margin-left: 50%;">UPDATE</button>');
					
					} 
				}) 
				
			}else{
				event.preventDefault();
				return false;
			}	
			}	
	}	
	function submitUser(){
			var user=$('#user').val().trim();
			if(confirm("Are you want to change the data?")){
				$('#successdiv').css("display","none");
				$.ajax({
					type:'GET',
					url:'ProjectUserUpdate.htm',
					datatype:'json',
					data:{
						user:user,
						initiationid :<%=initiationid%>,
					},
					success:function(result){
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data updated Successfully.</div>');
						$('#adduser').html('<button class="btn btn-warning btn-sm"  onclick="submitUser()" style="box-shadow: 2px 2px 2px grey;">EDIT</button>');
						$('#successdiv').delay(3000).hide(0); 
					
					}
				})
			}else{
				event.preventDefault();
				return false;
			}
		}
			function finance(a,b,c){
			$.ajax({
				type:'GET',
				url:'ProjectScheduleFinancialOutlay.htm',
				datatype:'json',
				data:{
					initiationid :<%=initiationid%>,
					Start:b,
					End:c,
				},
				success:function(result){
					var ajaxresult=JSON.parse(result);
					let str = ajaxresult;  
					let num = parseFloat(ajaxresult)/10000000;  


					let formattedNum = num.toLocaleString('en-IN', {
					  style: 'currency',
					  currency: 'INR',
					  minimumFractionDigits: 2,
					  maximumFractionDigits: 2,
					});
					$('#td'+(a+1)).html(formattedNum);
				}
			})
				}
			$(document).ready(function() {
				$('.finance').click();
			});
		var editor_config = {
				
				toolbar: [{
				          name: 'clipboard',
				          items: ['PasteFromWord', '-', 'Undo', 'Redo']
				        },
				        {
				          name: 'basicstyles',
				          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
				        },
				        {
				          name: 'links',
				          items: ['Link', 'Unlink']
				        },
				        {
				          name: 'paragraph',
				          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
				        },
				        {
				          name: 'insert',
				          items: ['Image', 'Table']
				        },
				        {
				          name: 'editing',
				          items: ['Scayt']
				        },
				        '/',

				        {
				          name: 'styles',
				          items: ['Format', 'Font', 'FontSize']
				        },
				        {
				          name: 'colors',
				          items: ['TextColor', 'BGColor', 'CopyFormatting']
				        },
				        {
				          name: 'align',
				          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
				        },
				        {
				          name: 'document',
				          items: ['Print', 'PageBreak', 'Source']
				        }
				      ],
				     
				    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

					customConfig: '',

					disallowedContent: 'img{width,height,float}',
					extraAllowedContent: 'img[width,height,align]',

					height: 250,

					
					contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

					
					bodyClass: 'document-editor',

					
					format_tags: 'p;h1;h2;h3;pre',

					
					removeDialogTabs: 'image:advanced;link:advanced',

					stylesSet: [
					
						{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
						{ name: 'Cited Work', element: 'cite' },
						{ name: 'Inline Quotation', element: 'q' },

						
						{
							name: 'Special Container',
							element: 'div',
							styles: {
								padding: '5px 10px',
								background: '#eee',
								border: '1px solid #ccc'
							}
						},
						{
							name: 'Compact table',
							element: 'table',
							attributes: {
								cellpadding: '5',
								cellspacing: '0',
								border: '1',
								bordercolor: '#ccc'
							},
							styles: {
								'border-collapse': 'collapse'
							}
						},
						{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
						{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } },

					]
				} ;
		CKEDITOR.replace( 'methodologydiv',editor_config);
		CKEDITOR.replace( 'Additionaldiv',editor_config); 
		CKEDITOR.replace('otherinformationDiv',editor_config);
		CKEDITOR.replace('EnclosuresDiv',editor_config);
		CKEDITOR.replace('subpointdiv2Editor',editor_config);
		CKEDITOR.replace('subpointdiv4Editor',editor_config);
		CKEDITOR.replace('subpointdiv5Editor',editor_config);
		CKEDITOR.replace('subpointdiv6Editor',editor_config);
		CKEDITOR.replace('subpointdiv8Editor',editor_config);
		CKEDITOR.replace('subpointdiv11Editor',editor_config);
		CKEDITOR.replace('subpointdiv12Editor',editor_config);
		CKEDITOR.replace('subpointdiv13Editor',editor_config);
		CKEDITOR.replace('subpointdiv14Editor',editor_config);
		CKEDITOR.replace('subpointdiv15Editor',editor_config);
		CKEDITOR.replace('subpointdiv16Editor',editor_config);
		CKEDITOR.replace('subpointdiv17Editor',editor_config);
		CKEDITOR.replace('majorcapital',editor_config);
	function showbtn9editor(){
		$('#divadditonal').css("display","none");
		$('#spanbtn9').html('<button class="btn btn-sm bg-transparent " type="button" onclick="hidebtn9editor()" ><i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>');
		$('#divmethodologyeditor').css("display","block");
		$('#divotherinformation').css("display","none");
		$('#divenclosures').css("display","none");
		$('#projectdeliverables').css("display","none");
		}
	function hidebtn9editor(){
		$('#divadditonal').css("display","block");
		$('#spanbtn9').html('<button class="btn btn-sm bg-transparent " type="button" onclick="showbtn9editor()" ><i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>');
		$('#divmethodologyeditor').css("display","none");
		$('#divotherinformation').css("display","block");
		$('#divenclosures').css("display","block");
		$('#projectdeliverables').css("display","block");
		}	
	function showbtn10editor(){
		$('#divmethodology').css("display","none");
		$('#spanbtn10').html('<button class="btn btn-sm bg-transparent " type="button" onclick="hidebtn10editor()" ><i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>');
		$('#divadditonaleditor').css("display","block");
		$('#divotherinformation').css("display","none");
		$('#divenclosures').css("display","none");
		$('#projectdeliverables').css("display","none");
		}
	function hidebtn10editor(){
		$('#divmethodology').css("display","block");
		$('#divotherinformation').css("display","block");
		$('#divadditonaleditor').css("display","none");
		$('#spanbtn10').html('<button class="btn btn-sm bg-transparent " type="button" onclick="showbtn10editor()" ><i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>');
		$('#divenclosures').css("display","block");
		$('#projectdeliverables').css("display","block");
	}
	function showbtn11editor(){
		$('#divmethodology').css("display","none");
		$('#divadditonal').css("display","none");
		$('#spanbtn11').html('<button class="btn btn-sm bg-transparent " type="button" onclick="hidebtn11editor()" ><i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>');
		$('#divotherinformationeditor').css("display","block");
		$('#divenclosures').css("display","none");
		$('#projectdeliverables').css("display","none");
	}
	function hidebtn11editor(){
		$('#divmethodology').css("display","block");
		$('#divadditonal').css("display","block");
		$('#spanbtn11').html('<button class="btn btn-sm bg-transparent " type="button" onclick="showbtn11editor()" ><i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>');
		$('#divotherinformationeditor').css("display","none");
		$('#divenclosures').css("display","block");
		$('#projectdeliverables').css("display","block");
	}
	function showbtn12editor(){
		$('#divmethodology').css("display","none");
		$('#divadditonal').css("display","none");
		$('#divotherinformation').css("display","none");
		$('#divEnclosureseditor').css("display","block");
		$('#spanbtn12').html('<button class="btn btn-sm bg-transparent " type="button" onclick="hidebtn12editor()" ><i class="btn btn-sm fa fa-minus" style="color:red; padding: 0px  0px  0px  0px;"></i></button>');
		$('#projectdeliverables').css("display","none");
	}
	function hidebtn12editor(){
		$('#divmethodology').css("display","block");
		$('#divEnclosureseditor').css("display","none");
		$('#divadditonal').css("display","block");
		$('#spanbtn12').html('<button class="btn btn-sm bg-transparent " type="button" onclick="showbtn12editor()" ><i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>');
		$('#divotherinformation').css("display","block");
		$('#projectdeliverables').css("display","block");
	}
	/* part1 page javascript  end*/
	/*part 2page javascript start  */
	function showAllSubPoints(){
		$('#briefSubPoints').css("display","block");
		$('#BriefPoint').html('<button class="btn btn-sm bg-transparent " type="button" onclick="hideAllSubPoints()" ><i class="btn  fa fa-lg fa-caret-up" style="color: red; padding: 0px  0px  0px  0px;"></i></button>')
		$('#point2').css("display","none");
		$('#point3').css("display","none");
		$('#point4').css("display","none");
		$('#point5').css("display","none");
		$('#point6').css("display","none");
		}
	function hideAllSubPoints(){
		$('#briefSubPoints').css("display","none");
		$('#BriefPoint').html('<button class="btn btn-sm bg-transparent " type="button" onclick="showAllSubPoints()" ><i class="btn  fa fa-lg fa-caret-down" style="color: green; padding: 0px  0px  0px  0px;"></i></button>')
		$('#point2').css("display","block");
		$('#point3').css("display","block");
		$('#point4').css("display","block");
		$('#point5').css("display","block");
		$('#point6').css("display","block");	
		}
	function showAdditionalFacilities(){
		$('#ADF').html('<button class="btn btn-sm bg-transparent " type="button" onclick="hideAdditionalFacilities()" ><i class="btn  fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>')
		$('#majorcapitalEditor').css("display","block");
		$('#point3').css("display","none");
		$('#point4').css("display","none");
		$('#point5').css("display","none");
		$('#point6').css("display","none");
		$('#point1').css("display","none");
	}
	function hideAdditionalFacilities(){
		$('#ADF').html('<button class="btn btn-sm bg-transparent " type="button" onclick="showAdditionalFacilities()" ><i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>')
		$('#majorcapitalEditor').css("display","none");		
		$('#point3').css("display","block");
		$('#point4').css("display","block");
		$('#point5').css("display","block");
		$('#point6').css("display","block");
		$('#point1').css("display","block");
	}
	
	function showsubPoint1(ele,a){
		/* console.log(x.class) */
	  $('.subpoint').css("display","none")
	  $('#subpointdiv'+a).css("display","block");
	  $('.subpointdiv'+a).css("display","block");
	  $('#subpoint'+a).html('<button class="btn btn-sm bg-transparent " type="button" onclick="hidesubPoint1(this,'+a+')" ><i class="btn  fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>')
	}
	function hidesubPoint1(ele,a,x){
		 $('.subpointdiv'+a).css("display","none");
		$('.subpoint').css("display","block")	
		$('#subpoint'+a).html('<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,'+a+')" ><i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>')
		}
	function showAddModal(a){
		$('#showAddModal'+a).modal('show');
		if(a===4){
			$('#cross11').click();
			var consultancy=$('#ConsultancyBudget').val();
			if(consultancy===""){
				consultancy=$('#mainConsultancyBudget').val();
				document.getElementById("ConsultancyBudget").value=consultancy
			}
			let str =consultancy;  
			let num = parseFloat(str)/100000;  
			let formattedNum = num.toLocaleString('en-IN', {
			  style: 'currency',
			  currency: 'INR',
			  minimumFractionDigits: 2,
			  maximumFractionDigits: 2,
			});
			document.getElementById('consultancyCostLeft').innerHTML="Budget Left- "+formattedNum+" Lakhs"
		}
		if(a===2){
			$('#cross5').click();
			var WorkBudget=$('#WorkBudget').val();
			if(WorkBudget===""){
				WorkBudget=$('#mainWorkBudget').val();
				document.getElementById("WorkBudget").value=WorkBudget
			}
			let str =WorkBudget;  
			let num = parseFloat(str)/100000;  
			let formattedNum = num.toLocaleString('en-IN', {
			  style: 'currency',
			  currency: 'INR',
			  minimumFractionDigits: 2,
			  maximumFractionDigits: 2,
			});
			document.getElementById('workCostLeft').innerHTML="Budget Left- "+formattedNum+" Lakhs"
		}
		if(a===1){
			$('#cross2').click();
			var TrainingBudget=$('#TrainingBudget').val();
			if(TrainingBudget===""){
				TrainingBudget=$('#mainTrainingBudget').val();
				document.getElementById("TrainingBudget").value=TrainingBudget;
			}
			let str =TrainingBudget;  
			let num = parseFloat(str)/100000;  
			let formattedNum = num.toLocaleString('en-IN', {
			  style: 'currency',
			  currency: 'INR',
			  minimumFractionDigits: 2,
			  maximumFractionDigits: 2,
			});
			document.getElementById('TrainingCostLeft').innerHTML="Budget Left- "+formattedNum+" Lakhs"
		}
		if(a===5){
			$('#cross14').click();
		}
		if(a===3){
			$('#cross8').click();
			var CarBudget=$('#CarBudget').val();
			if(CarBudget===""){
				CarBudget=$('#mainCarBudget').val();
				document.getElementById("CarBudget").value=CarBudget;
			}
			let str =CarBudget;  
			let num = parseFloat(str)/100000;  
			let formattedNum = num.toLocaleString('en-IN', {
			  style: 'currency',
			  currency: 'INR',
			  minimumFractionDigits: 2,
			  maximumFractionDigits: 2,
			});
			document.getElementById('CarBudgetLeft').innerHTML="Budget Left- "+formattedNum+" Lakhs"
		}
		if(a===6){
		$('#cross17').click();
		var CapsiBudget=$('#CapsiBudget').val();
		if(CapsiBudget===""){
			CapsiBudget=$('#mainCapsiBudget').val();
			document.getElementById("CapsiBudget").value=CapsiBudget;
		}
		let str =CapsiBudget;  
		let num = parseFloat(str)/100000;  
		let formattedNum = num.toLocaleString('en-IN', {
		  style: 'currency',
		  currency: 'INR',
		  minimumFractionDigits: 2,
		  maximumFractionDigits: 2,
		});
		document.getElementById('CapsiBudgetLeft').innerHTML="Budget Left- "+formattedNum+" Lakhs"
		}
		
	}
	function submitForm1(){

		var Discipline=$('#areafortraining').val().trim();
		var Agency=$('#agencyContacted').val().trim();
		var Personneltrained=$('#Personneltrained').val();
		var Duration=$('#Duration').val();
		var Cost=$('#Costadd').val();
		var Remarks=$('#Remarks').val();
		var TrainingBudget=$('#TrainingBudget').val();
		
		if(Discipline.length<=0||Agency.length<=0||Personneltrained.length<=0||Duration.length<=0||Cost.length<=0||Remarks.length<=0){
			alert("Please fill all the Field")
		}else if(Number(TrainingBudget)<Number(Cost)){
			alert("The cost is exceeding the budget")
		}
		else{
			if(window.confirm('Are you sure, you want to submit?')){
				$('#successdiv').css("display","none");
				$.ajax({
					type:'GET',
					url:'ProjectMajorTrainingRequirementSubmit.htm',
					datatype:'json',
					data:{
						initiationid :<%=initiationid%>,
						Discipline:Discipline,
						Agency:Agency,
						Personneltrained:Personneltrained,
						Duration:Duration,
						Cost:Cost,
						Remarks:Remarks,
					},
					success:function(result){
						if(result>0){
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data Added Successfully.</div>');
						$('#successdiv').delay(3000).hide(0);
						$('#cross1').click();
						document.getElementById("areafortraining").value=""
							document.getElementById("agencyContacted").value=""
								document.getElementById("Personneltrained").value=""
									document.getElementById("Duration").value=""
										document.getElementById("Costadd").value=""
											document.getElementById("Remarks").value=""
												document.getElementById("TrainingBudget").value=Number(TrainingBudget)-Number(Cost);
												setTimeout(ListModal1, 3000);
						var Notification1=document.getElementById("Notification1").innerHTML;
						$('#Notification1').html(Number(Notification1)+1);
						}
						else{
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-danger" id="divalert"  role="alert">Data Added Unsuccessful.</div>');
							$('#successdiv').delay(3000).hide(0);
						}
					}
					
			
				})
				
			}else{
				event.preventDefault();
				return false;
			}
		}
		
	}
	function ListModal1(){
	var value=$('#mainTrainingBudget').val(); var x=0;
		$('#tbody1').html('');
		$.ajax({
			type:'GET',
			url:'ListOfTrainingRequirements.htm',
			datatype:'json',
			data:{
				initiationid :<%=initiationid%>,
			},
			success:function(result){
				var ajaxresult=JSON.parse(result);
				if(ajaxresult.length==0){
					 document.getElementById("TrainingBudget").value=value 
					$('#tbody1').html('<tr style="text-align:center;"> <td colspan="8">No Data Available </td></tr>')
				}else{
					var html="";

				for(var i=0;i<ajaxresult.length;i++){
					x=x+ajaxresult[i][7];
					let str = ajaxresult[i][7];  
					let num = parseFloat(ajaxresult[i][7])/10000000;  


					let formattedNum = num.toLocaleString('en-IN', {
					  style: 'currency',
					  currency: 'INR',
					  minimumFractionDigits: 2,
					  maximumFractionDigits: 2,
					});
					html=html+'<tr><td align="center"><input type="radio" name="modal1raio" onchange=radiovalueModal1('+ajaxresult[i][0]+','+1+')></td>'+'<td align="center">'+(i+1)+'</td>'+'<td>'+ajaxresult[i][2]+'</td>'+'<td>'+ajaxresult[i][3]+'</td>'+'<td align="center">'+ajaxresult[i][4]+'</td>'+'<td align="center">'+ajaxresult[i][5]+'</td>'+'<td align="right">'+formattedNum+'</td>'+'<td>'+ajaxresult[i][6]+'</td></tr>'
				}
				var traingbudgetleft=Number(value)-Number(x);
				if(traingbudgetleft==0){
					$('#trainBtn').hide();
				}else{
					$('#trainBtn').show();
				}
				document.getElementById("TrainingBudget").value=traingbudgetleft; 
				document.getElementById("traingingPlannedCost").value=x; 
				let str1 = value;  
				let num1 = parseFloat(str1)/100000;  


				let formattedNum1= num1.toLocaleString('en-IN', {
				  style: 'currency',
				  currency: 'INR',
				  minimumFractionDigits: 2,
				  maximumFractionDigits: 2,
				});
				
				let str2 = traingbudgetleft;  
				let num2 = parseFloat(str2)/100000;  
				let formattedNum2= num2.toLocaleString('en-IN', {
				  style: 'currency',
				  currency: 'INR',
				  minimumFractionDigits: 2,
				  maximumFractionDigits: 2,
				});
				
				let str3 = x;  
				let num3 = parseFloat(str3)/100000;  
				let formattedNum3= num3.toLocaleString('en-IN', {
				  style: 'currency',
				  currency: 'INR',
				  minimumFractionDigits: 2,
				  maximumFractionDigits: 2,
				});
				document.getElementById("TableTrainingCost").innerHTML="Total Budget- "+formattedNum1+" Lakhs";
				document.getElementById("TableTrainingCostPlanned").innerHTML="Budget planned- "+formattedNum3+" Lakhs";
				document.getElementById("TableTrainingCostLeft").innerHTML="Budget Left- "+formattedNum2+" Lakhs";
				document.getElementById("EditTrainCostPlanned").innerHTML="Budget planned- "+formattedNum3+" Lakhs";
				document.getElementById("EditTrainCostLeft").innerHTML="Budget Left- "+formattedNum2+" Lakhs";
				$('#tbody1').html(html)
				}
			}
		})
		$('#TrainingRequirementsList').modal('show');
	}
	function radiovalueModal1(a,b){
		$(".radiovalueModal"+b).html('<input type="hidden" value="'+a+'" id="radio'+b+'">')
	}
	function showEditModal1(){
		var radio=$('#radio1').val();
		if(radio==0){
			alert("Please select one!")
		}else{
			$.ajax({
				type:'GET',
				url:'TraingRequirements.htm',
				datatype:'json',
				data:{
					trainingid:radio,
				},
			success:function(result){
				var ajaxresult=JSON.parse(result);
				console.log(ajaxresult)
				document.getElementById("areafortrainingEdit").value=ajaxresult[2];
				document.getElementById("agencyContactedEdit").value=ajaxresult[3];
					document.getElementById("PersonneltrainedEdit").value=ajaxresult[4];
						document.getElementById("DurationEdit").value=ajaxresult[5];
							document.getElementById("CostaddEdit").value=ajaxresult[6];
								document.getElementById("RemarksEdit").value=ajaxresult[7];
								document.getElementById("trainingid").value=ajaxresult[0];
								document.getElementById("previousTrainingCost").value=ajaxresult[6];
								
			}
			})
		
		$('#cross2').click();	
		document.getElementById("radio1").value=0;
		$('#EditTrainingRequirements').modal('show');
		}
	}
	
	function editForm1(){
		var Discipline=$('#areafortrainingEdit').val().trim();
		var Agency=$('#agencyContactedEdit').val().trim();
		var Personneltrained=$('#PersonneltrainedEdit').val();
		var Duration=$('#DurationEdit').val();
		var Cost=$('#CostaddEdit').val();
		var Remarks=$('#RemarksEdit').val();
		var trainingid=$('#trainingid').val();
		var traingingPlannedCost=$('#traingingPlannedCost').val();
		var mainTrainingBudget=$('#mainTrainingBudget').val();
		var previousTrainingCost=$('#previousTrainingCost').val();
 		var x=Number(traingingPlannedCost)+Number(Cost)-Number(previousTrainingCost) 
		if(Discipline.length<=0||Agency.length<=0||Personneltrained.length<=0||Duration.length<=0||Cost.length<=0||Remarks.length<=0){
			alert("Please fill all the Field")
		}else if(x>Number(mainTrainingBudget)){
			alert("The cost is exceeding the total budget");
		}
		else{
			if(window.confirm('Are you sure, you want to submit?')){
				$('#successdiv').css("display","none");
				$.ajax({
					type:'GET',
					url:'ProjectMajorTrainingRequirementUpdate.htm',
					datatype:'json',
					data:{
						Discipline:Discipline,
						Agency:Agency,
						Personneltrained:Personneltrained,
						Duration:Duration,
						Cost:Cost,
						Remarks:Remarks,
						trainingid:trainingid,
					},
					success:function(result){
						console.log(result);
						
						if(result>0){
							$('#cross3').click();	
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Training Requirement Updated Successfully.</div>');
							$('#successdiv').delay(3000).hide(0);
						}
						setTimeout(ListModal1, 3000);
					}
				})
				
			}else{
				event.preventDefault();
				return false;
			}
		}
	}
	function submitForm2(){
		var GovtAgencies=$('#GovtAgencies').val().trim();
		var workPackage=$('#workPackage').val().trim();
		var Objectives=$('#Objectives').val().trim();
		var Scope=$('#Scope').val().trim();
		var Cost3=$('#Cost3').val().trim();
		var PDC=$('#PDC').val().trim();
		var WorkBudget=$('#WorkBudget').val();
		
		if(GovtAgencies<=0||workPackage<=0||Objectives<=0||Scope<=0||Cost3<=0||PDC<=0){
			alert("please fill all the fields")
		}else if(Number(Cost3)>Number(WorkBudget)){
			alert("The cost is exceeding the total budget")
		}
		else{
			if(confirm("Are you sure ,you want to submit the data?")){
				$('#successdiv').css("display","none");
				$.ajax({
					type:'GET',
					url:'WorkPackageSubmit.htm',
					datatype:'json',
					data:{
						initiationid :<%=initiationid%>,
						GovtAgencies:GovtAgencies,
						workPackage:workPackage,
						Objectives:Objectives,
						Scope:Scope,
						Cost:Cost3,
						PDC:PDC,
					},
				success:function (result){
					console.log(result);
					
					if(result>0){
						$('#cross4').click();	
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data added Successfully.</div>');
						$('#successdiv').delay(3000).hide(0);
						document.getElementById("GovtAgencies").value="";
						document.getElementById("workPackage").value="";
						document.getElementById("Objectives").value="";
						document.getElementById("Scope").value="";
						document.getElementById("Cost3").value="";
						document.getElementById("PDC").value="";
						var Notification2=document.getElementById("Notification2").innerHTML;
						$('#Notification2').html(Number(Notification2)+1);
						document.getElementById("WorkBudget").value=Number(WorkBudget)-Number(Cost3);
					}
					setTimeout(ListModal2, 3000);
				}
				})
			}else{
				event.preventDefault();
				return false;
			}
		}
	}
	function ListModal2(){
		var value=$('#mainWorkBudget').val();
		$('#tbody2').html('');
		var x=0;
		$.ajax({
			type:'GET',
			url:'WorkPackageList.htm',
			datatype:'json',
			data:{
				initiationid :<%=initiationid%>,
			},
			success:function (result){
				var ajaxresult=JSON.parse(result);
				if(ajaxresult.length==0){
				$('#workedit').hide();
				document.getElementById("WorkBudget").value=value
				$('#tbody2').html('<tr style="text-align:center;"><td colspan="8">No Data Available</td></tr>')
				}else{
				var html="";
				for(var i=0;i<ajaxresult.length;i++){
					x=x+Number(ajaxresult[i][7]);
					let str = ajaxresult[i][7];  
					let num = parseFloat(ajaxresult[i][7])/100000;  
					let formattedNum = num.toLocaleString('en-IN', {
					  style: 'currency',
					  currency: 'INR',
					  minimumFractionDigits: 2,
					  maximumFractionDigits: 2,
					});		
					html=html+'<tr><td align="center"><input type="radio" name="modal1raio" onchange=radiovalueModal1('+ajaxresult[i][0]+','+2+')></td>'+'<td align="center">'+(i+1)+'</td>'+'<td>'+ajaxresult[i][2]+'</td>'+'<td>'+ajaxresult[i][3]+'</td>'+'<td >'+ajaxresult[i][4]+'</td>'+'<td >'+ajaxresult[i][5]+'</td>'+'<td align="center">'+ajaxresult[i][6]+'</td>'+'<td align="right">'+formattedNum+'</td></tr>'
				}
				$('#workedit').show();
				var workBudgetLeft=Number(value)-Number(x);
				if(workBudgetLeft==0){
				$('#workAdd').hide();
				}else{
				$('#workAdd').show();
				}
				document.getElementById("WorkPlanned").value=x;
				document.getElementById("WorkBudget").value=workBudgetLeft;
				let str1=value;
				let num1 = parseFloat(str1)/100000;  
				let formattedNum1 = num1.toLocaleString('en-IN', {
				  style: 'currency',
				  currency: 'INR',
				  minimumFractionDigits: 2,
				  maximumFractionDigits: 2,
				});	
				let str2=workBudgetLeft;
				let num2 = parseFloat(str2)/100000;  
				let formattedNum2 = num2.toLocaleString('en-IN',{
				  style:'currency',
				  currency:'INR',
				  minimumFractionDigits: 2,
				  maximumFractionDigits: 2,
				});	
				let str3=x;
				let num3 = parseFloat(str3)/100000;  
				let formattedNum3 = num3.toLocaleString('en-IN', {
				  style: 'currency',
				  currency: 'INR',
				  minimumFractionDigits: 2,
				  maximumFractionDigits: 2,
				});	
				document.getElementById("TableWorkCost").innerHTML="Total Budget- "+formattedNum1+" Lakhs";
				document.getElementById("TableWorkCostLeft").innerHTML="Budget Left- "+formattedNum2+" Lakhs";
				 document.getElementById("TableWorkCostPlanned").innerHTML="Budget Planned- "+(formattedNum3)+" Lakhs"; 
					document.getElementById("EditWorkCostLeft").innerHTML="Budget Left- "+formattedNum2+" Lakhs";
					 document.getElementById("EditWorkCostPlanned").innerHTML="Budget Planned- "+(formattedNum3)+" Lakhs"; 
				$('#tbody2').html(html)
			}}
		})
		$('#WorkPackacgesList').modal('show');
	} 
	function showEditModal2(){
		var radio=$('#radio2').val();
		if(radio==0){
			alert("Please select one!")
		}else{
			$.ajax({
				type:'GET',
				url:'WorkPackageValue.htm',
				datatype:'json',
				data:{
					Workdid:radio,
				},
				success:function(result){
					var ajaxresult=JSON.parse(result);
					console.log(ajaxresult);
					document.getElementById("GovtAgenciesEdit").value=ajaxresult[2];
					document.getElementById("workPackageEdit").value=ajaxresult[3];
					document.getElementById("ObjectivesEdit").value=ajaxresult[4];
					document.getElementById("ScopeEdit").value=ajaxresult[5];
					document.getElementById("Cost3Edit").value=ajaxresult[7];
					document.getElementById("PDCEdit").value=ajaxresult[6];
					document.getElementById("workid").value=ajaxresult[0];
					document.getElementById("previousWorkCost").value=ajaxresult[7];
					$('#cross5').click();
					$('#EditWork').modal('show');
				}
			})
		}
	}
	
	function editForm2(){
		var GovtAgencies=$('#GovtAgenciesEdit').val().trim();
		var workPackage=$('#workPackageEdit').val().trim();
		var Objectives=$('#ObjectivesEdit').val().trim();
		var Scope=$('#ScopeEdit').val().trim();
		var Cost3=$('#Cost3Edit').val().trim();
		var PDC=$('#PDCEdit').val().trim();
		var workid=$('#workid').val();
		var WorkPlanned=$('#WorkPlanned').val();
		var previousWorkCost=$('#previousWorkCost').val();
		var mainWorkBudget=$('#mainWorkBudget').val();
		var x=Number(WorkPlanned)+Number(Cost3)-Number(previousWorkCost);
		console.log(x>Number(mainWorkBudget));
		if(GovtAgencies<=0||workPackage<=0||Objectives<=0||Scope<=0||Cost3<=0||PDC<=0){
			alert("please fill all the fields")
		}else if(x>Number(mainWorkBudget)){
			alert("The cost is exceeding the budget");
		}
		else{
			if(window.confirm('Are you sure, you want to submit?')){
				$('#successdiv').css("display","none");
				$.ajax({
					type:'GET',
					url:'WorkPackagesEdit.htm',
					datatype:'json',
					data:{
						GovtAgencies:GovtAgencies,
						workPackage:workPackage,
						Objectives:Objectives,
						Scope:Scope,
						Cost:Cost3,
						PDC:PDC,
						workid:workid,
					},
					success:function(result){
						console.log(result);
						
						if(result>0){
							$('#cross6').click();	
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Work Package Updated Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
							document.getElementById("radio2").value=0;
						}
						setTimeout(ListModal2, 3000);
					}
				})
				
			}else{
				event.preventDefault();
				return false;	
			}
		}
	}
	
	function submitForm3(){
		var value=$('#CarBudget').val();
		var Institute=$('#Institute').val().trim();
		var professor=$('#professor').val().trim();
		var Area=$('#Area').val().trim();
		var Cost4=$('#Cost4').val();
		var PDC1=$('#PDC1').val();
		var confidence=$('#confidence').val();
		
		if(Institute.length<=0||confidence.length<=0||professor.length<=0||Area.length<=0||Cost4.length<=0||PDC1.length<=0){
			alert("Please fill all the fields")
		}else if(Number(Cost4)>Number(value)){
			alert("The given cost is exceeding the total budget")
		}
		else{
			if(confirm("Are you sure,you want to submit?")){
				$('#successdiv').css("display","none");
				$.ajax({
				
					type:'GET',
					url:'CarsDetailsAdd.htm',
					datatype:'json',
					data:{
						Institute:Institute,
						professor:professor,
						Area:Area,
						Cost:Cost4,
						PDC:PDC1,
						confidence:confidence,
						initiationid :<%=initiationid%>,
					},
					success:function(result){
						if(result>0){
							$('#cross7').click();	
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data Added Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
							
							document.getElementById("Institute").value="";
							document.getElementById("professor").value="";
							document.getElementById("Area").value="";
							document.getElementById("Cost4").value="";
							document.getElementById("PDC1").value="";
							var x=(Number(value)-Number(Cost4));
							document.getElementById("CarBudget").value=x;
							setTimeout(ListModal3, 3000);
							var Notification3=document.getElementById("Notification3").innerHTML;
							$('#Notification3').html(Number(Notification3)+1);
							
							
						}else{
							$('#cross7').click();
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-danger" id="divalert"  role="alert">Data adding unsuccessful</div>');
							$('#successdiv').delay(3000).hide(0);
						}
					}
				})
			}else{
				event.preventDefault();
				return false;		
			}
		}
	}
	function ListModal3(){
		var value=$('#mainCarBudget').val();
		$('#CARSlist').modal('show');
		$('#tbody3').html('');
		var x=0;
		$.ajax({
			type:'GET',
			url:'CarsList.htm',
			datatye:'json',
			data:{
				initiationid :<%=initiationid%>,
			},
			success:function(result){
				var ajaxresult=JSON.parse(result);
				console.log(ajaxresult)
				if(ajaxresult.length==0){
				$('#carsEdit').hide();
				document.getElementById("CarBudget").value=value;
				$('#tbody3').html('<tr style="text-align:center;"><td colspan="8">No Data Available</td></tr>')
				}
				else{
					$('#carsEdit').show();
					var html="";
					for(var i=0;i<ajaxresult.length;i++){
						x=x+Number(ajaxresult[i][5]);
						let str = ajaxresult[i][5];  
						let num = parseFloat(ajaxresult[i][5])/10000000;  
						let formattedNum = num.toLocaleString('en-IN', {
						  style: 'currency',
						  currency: 'INR',
						  minimumFractionDigits: 2,
						  maximumFractionDigits: 2,
						});						
						html=html+'<tr><td align="center"><input type="radio" name="modal1raio" onchange=radiovalueModal1('+ajaxresult[i][0]+','+3+')></td>'+'<td align="center">'+(i+1)+'</td>'+'<td>'+ajaxresult[i][2]+'</td>'+'<td>'+ajaxresult[i][3]+'</td>'+'<td >'+ajaxresult[i][4]+'</td>'+'<td align="right">'+formattedNum+'</td>'+'<td align="center">'+ajaxresult[i][6]+'</td>'+'<td align="center">'+ajaxresult[i][7]+'</td></tr>'
					}
					var carBudgetLeft=Number(value)-Number(x);
					if(carBudgetLeft===0){
						$('#carsAdd').hide();
					}else{
						$('#carsAdd').show();
					}
					let str1= value;  
					let num1 = parseFloat(str1)/100000;  
					let formattedNum1 = num1.toLocaleString('en-IN', {
					  style: 'currency',
					  currency: 'INR',
					  minimumFractionDigits: 2,
					  maximumFractionDigits: 2,
					});		
					let str2= carBudgetLeft;  
					let num2 = parseFloat(str2)/100000;  
					let formattedNum2 = num2.toLocaleString('en-IN', {
					  style: 'currency',
					  currency: 'INR',
					  minimumFractionDigits: 2,
					  maximumFractionDigits: 2,
					});
					let str3= x;  
					let num3 = parseFloat(str3)/100000;  
					let formattedNum3 = num3.toLocaleString('en-IN', {
					  style: 'currency',
					  currency: 'INR',
					  minimumFractionDigits: 2,
					  maximumFractionDigits: 2,
					});
					document.getElementById('TablecarCost').innerHTML="Total Budget -"+formattedNum1+" Lakhs"
					document.getElementById('TablecarCostPlanned').innerHTML="Budget planned-"+formattedNum3+" Lakhs"
					document.getElementById('TablecarCostCostLeft').innerHTML="Budget Left -"+formattedNum2+" Lakhs"
					document.getElementById('EditcarCostPlanned').innerHTML="Budget planned-"+formattedNum3+" Lakhs"
					document.getElementById('EditcarCostCostLeft').innerHTML="Budget Left -"+formattedNum2+" Lakhs"
					document.getElementById("carscostPlanned").value=x;
					document.getElementById("CarBudget").value=carBudgetLeft;
					$('#tbody3').html(html);
				}
			}
		})
	}
	function showEditModal3(){
		var radio=$('#radio3').val();
		if(radio==0){
			alert("Please select one!")
		}else{
			$.ajax({
				type:'GET',
				url:'CarsValue.htm',
				datatype:'json',
				data:{
					carsid:radio,
				},
			success:function(result){
				var ajaxresult=JSON.parse(result);
				console.log(ajaxresult);
				document.getElementById("InstituteEdit").value=ajaxresult[2];
				document.getElementById("professorEdit").value=ajaxresult[3];
				document.getElementById("AreaEdit").value=ajaxresult[4];
				document.getElementById("Cost4Edit").value=ajaxresult[5];
				document.getElementById("PDC1Edit").value=ajaxresult[6];
				document.getElementById("confidenceEdit").value=ajaxresult[7];
				document.getElementById("rangeval2").innerHTML=ajaxresult[7];
				document.getElementById("carsid").value=ajaxresult[0];
				document.getElementById("previousCarCost").value=ajaxresult[5];
				$('#cross8').click();
				$('#EditCars').modal('show');
			}
			})
		}
	}
	function editForm3(){
		var mainCarBudget=$('#mainCarBudget').val();
		var Institute=$('#InstituteEdit').val().trim();
		var professor=$('#professorEdit').val().trim();
		var Area=$('#AreaEdit').val().trim();
		var Cost4=$('#Cost4Edit').val();
		var PDC1=$('#PDC1Edit').val();
		var confidence=$('#confidenceEdit').val();
		var carsid=$('#carsid').val();
		var previousCarCost=$('#previousCarCost').val();
		var carscostPlanned=$('#carscostPlanned').val();
		var x=Number(carscostPlanned)+Number(Cost4)-Number(previousCarCost);
		if(Institute.length<=0||confidence.length<=0||professor.length<=0||Area.length<=0||Cost4.length<=0||PDC1.length<=0){
			alert("Please fill all the fields")
		}else if(x>Number(mainCarBudget)){
			alert("The given cost is exceeding the budget")
		}else{
			if(confirm("Are you sure,you want to submit?")){
				
			$.ajax({
				type:'GET',
				url:'CarsEdit.htm',
				datatype:'json',
				data:{
					Institute:Institute,
					professor:professor,
					Area:Area,
					Cost:Cost4,
					PDC:PDC1,
					confidence:confidence,
					carsid:carsid,
				},
				success:function(result){
					if(result>0){
						$('#cross9').click();	
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Cars Data Updated Successfully</div>');
						$('#successdiv').delay(3000).hide(0);
						document.getElementById("radio3").value=0;
					}
					setTimeout(ListModal3, 3000);
				}
			}) 
			}else{
				event.preventDefault();
				return false;		
			}
		}
		
	}
	/*For showing and hiding textarea for last few points  */
	function showpart2information(a){
		$('.information'+a).css("display","block");	
		$('.span'+a).html('<button type="button" class="btn btn-sm bg-transparent plus" onclick="hidepart2information('+a+')"><i class="btn  fa  fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>')
	}
	function hidepart2information(a){
		$('.information'+a).css("display","none");	
		$('.span'+a).html('<button type="button" class="btn btn-sm bg-transparent plus" onclick="showpart2information('+a+')"><i class="btn  fa  fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>')
	}
	/*  */
	
	function submitForm4(){
		var ConsultancyArea=$('#ConsultancyArea').val().trim();
		var ConsultancyAgency=$('#ConsultancyAgency').val().trim();
		var Consultancyperson=$('#Consultancyperson').val().trim();
		var ConsultancyProcess=$('#ConsultancyProcess').val().trim();
		var ConsultancyCost=$('#ConsultancyCost').val().trim();
		var ConsultancyBudget=$('#ConsultancyBudget').val().trim();
		if(ConsultancyArea.length<=0||ConsultancyAgency.length<=0||Consultancyperson.length<=0||ConsultancyProcess.length<=0||ConsultancyCost.length<=0){
		alert("Please fill all the fields")
		}else if(Number(ConsultancyCost)>Number(ConsultancyBudget)){
			alert("The given cost is exceeding the Budget")
		}else {
			if(confirm("Are you sure ,you want to submit the data?")){
				$('#successdiv').css("display","none");
				$.ajax({
					type:'GET',
					url:'ConsultancySubmit.htm',
					datatype:'json',
					data:{
						ConsultancyArea:ConsultancyArea,
						ConsultancyAgency:ConsultancyAgency,
						Consultancyperson:Consultancyperson,
						ConsultancyProcess:ConsultancyProcess,
						ConsultancyCost:ConsultancyCost,
						initiationid:<%=initiationid%>,
					},
					success:function (result){
						if(result>0){
							$('#cross10').click();	
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert"> Data Added Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
							document.getElementById("ConsultancyArea").value="";
							document.getElementById("ConsultancyAgency").value="";
							document.getElementById("Consultancyperson").value="";
							document.getElementById("ConsultancyProcess").value="";
							document.getElementById("ConsultancyCost").value="";
							setTimeout(ListModal4, 3000);
							var Notification4=document.getElementById("Notification4").innerHTML;
							$('#Notification4').html(Number(Notification4)+1);
							document.getElementById("ConsultancyBudget").value=Number(ConsultancyBudget)-Number(ConsultancyCost)
						}						
					}
					
				})
				
				
			}else{event.preventDefault();return false;}}}
	
	function ListModal4(){
		var value=$('#mainConsultancyBudget').val();
		var x=0;
		$('#tbody4').html('');
		$.ajax({
			type:'GET',
			url:'ConsultancyList.htm',
			datatype:'json',
			data:{
				initiationid:<%=initiationid%>,
			},
		success:function(result){
			var ajaxresult=JSON.parse(result);
			if(ajaxresult.length==0){
				document.getElementById("ConsultancyBudget").value=value
				$('#tbody4').html('<tr style="text-align:center;"><td colspan="8">No Data Available</td></tr>')
				}else{
			var html="";
			for(var i=0;i<ajaxresult.length;i++){
				x=x+Number(ajaxresult[i][5])
				let str = ajaxresult[i][5];  
				let num = parseFloat(ajaxresult[i][5])/100000;  


				let formattedNum = num.toLocaleString('en-IN', {
				  style: 'currency',
				  currency: 'INR',
				  minimumFractionDigits: 2,
				  maximumFractionDigits: 2,
				});
				html=html+'<tr><td align="center"><input type="radio" name="modal1raio" onchange=radiovalueModal1('+ajaxresult[i][0]+','+4+')></td>'+'<td align="center">'+(i+1)+'</td>'+'<td>'+ajaxresult[i][2]+'</td>'+'<td>'+ajaxresult[i][3]+'</td>'+'<td >'+ajaxresult[i][4]+'</td>'+'<td align="right">'+formattedNum+'</td>'+'<td align="left">'+ajaxresult[i][6]+'</td></tr>'
			}
			var consultancyBudgetleft=Number(value)-Number(x);
			if(consultancyBudgetleft==0){
		 	$('#consultancyAdd').hide();
			}else{
				$('#consultancyAdd').show();
			}
			document.getElementById("ConsultancyBudget").value=consultancyBudgetleft;
			document.getElementById("ConsultancyPlanned").value=x;
			let str1 =value;  
			let num1 = parseFloat(str1)/100000;  
			let formattedNum1 = num1.toLocaleString('en-IN', {
			  style: 'currency',
			  currency: 'INR',
			  minimumFractionDigits: 2,
			  maximumFractionDigits: 2,
			});
			let str2 =consultancyBudgetleft;  
			let num2 = parseFloat(str2)/100000;  
			let formattedNum2 = num2.toLocaleString('en-IN', {
			  style: 'currency',
			  currency: 'INR',
			  minimumFractionDigits: 2,
			  maximumFractionDigits: 2,
			});
			
			let str3 =x;  
			let num3 = parseFloat(str3)/100000;  
			let formattedNum3 = num3.toLocaleString('en-IN', {
			  style: 'currency',
			  currency: 'INR',
			  minimumFractionDigits: 2,
			  maximumFractionDigits: 2,
			});
			
			document.getElementById("TableconsultancyCost").innerHTML="Total Budget- "+formattedNum1+" Lakhs";
			document.getElementById("TableconsultancyCostLeft").innerHTML="Budget Left- "+formattedNum2+" Lakhs";
			 document.getElementById("TableconsultancyCostPlanned").innerHTML="Budget Planned- "+(formattedNum3)+" Lakhs"; 
			 document.getElementById("EditconsultancyCostLeft").innerHTML="Budget Left- "+formattedNum2+" Lakhs";
			 document.getElementById("EditconsultancyCostPlanned").innerHTML="Budget Planned- "+(formattedNum3)+" Lakhs"; 
			
			$('#tbody4').html(html);
			
			}
		}
		})
		$('#ConsultancyList').modal('show');
	}
	
	function showEditModal4(){
		var radio=$('#radio4').val();
		if(radio==0){
			alert("Please select one!")
		}
		$.ajax({
			type:'GET',
			url:'ConsultancyValue.htm',
			datatype:'json',
			data:{
				consultancyid:radio,
			},
		success:function(result){
			var ajaxresult=JSON.parse(result);
			document.getElementById("ConsultancyAreaEdit").value=ajaxresult[2];
			document.getElementById("ConsultancyAgencyEdit").value=ajaxresult[3];
			document.getElementById("ConsultancypersonEdit").value=ajaxresult[4];
			document.getElementById("ConsultancyProcessEdit").value=ajaxresult[6];
			document.getElementById("ConsultancyCostEdit").value=ajaxresult[5];
			document.getElementById("consultancyid").value=ajaxresult[0];
			document.getElementById("CBT").value=ajaxresult[5];
			$('#cross11').click();
			$('#EditConsultancyModal').modal('show');
		}
		})
	}
	function editForm4(){
		var ConsultancyArea=$('#ConsultancyAreaEdit').val().trim();
		var ConsultancyAgency=$('#ConsultancyAgencyEdit').val().trim();
		var Consultancyperson=$('#ConsultancypersonEdit').val().trim();
		var ConsultancyProcess=$('#ConsultancyProcessEdit').val().trim();
		var ConsultancyCost=$('#ConsultancyCostEdit').val().trim();
		var consultancyid=$('#consultancyid').val();
		var ConsultancyPlanned=$('#ConsultancyPlanned').val();
		var CBT=$('#CBT').val();
		var mainConsultancyBudget=$('#mainConsultancyBudget').val();
		var x=Number(ConsultancyPlanned)+(Number(ConsultancyCost)-Number(CBT));
		
		if(ConsultancyArea.length<=0||ConsultancyAgency.length<=0||Consultancyperson.length<=0||ConsultancyProcess.length<=0||ConsultancyCost.length<=0){
			alert("Please fill all the fields")
		} else if(Number(x)>Number(mainConsultancyBudget)){
			alert("The cost is exceeding the budget")
		} 
		else{
			if(confirm("Are you sure, you want to submit?")){
				$('#successdiv').css("display","none");
				$.ajax({
					type:'GET',
					url:'ConsultancyEdit.htm',
					datatype:'json',
					data:{
						ConsultancyArea:ConsultancyArea,
						ConsultancyAgency:ConsultancyAgency,
						Consultancyperson:Consultancyperson,
						ConsultancyProcess:ConsultancyProcess,
						ConsultancyCost:ConsultancyCost,
						consultancyid:consultancyid,
					},
					success:function(result){
						if(result>0){
							$('#cross12').click();	
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Consultancy requirements  Updated Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
							document.getElementById("radio4").value=0;
						}
						setTimeout(ListModal4, 3000);
					}	
					
				})
				
			}else{
				event.preventDefault();
				return false;
			}
		}
	}
	function submitForm5(){
		var designation=$('#designation').val().trim();
		var Discipline=$('#DisciplineAdd').val().trim();
		var Numbers=$('#Numbers').val().trim();
		var Period=$('#Period').val().trim();
		var Remarks=$('#RemarksAdd').val().trim();
		console.log(designation)
		
		if(designation.length<=0||Discipline.length<=0||Numbers.length<=0||Period.length<=0||Remarks.length<=0){
			alert("Please fill all the fields")
		}else{
			if(confirm("Are you sure, you want to submit the data?")){
				$('#successdiv').css("display","none");
				$.ajax({
					type:'GET',
					url:'ManpowerSubmit.htm',
					datatype:'json',
					data:{
						designation:designation,
						Discipline:Discipline,
						Numbers:Numbers,
						Period:Period,
						Remarks:Remarks,
						initiationid:<%=initiationid%>,
					},
				success:function(result){
					if(result>0){
						$('#cross13').click();	
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert"> Data Added Successfully</div>');
						$('#successdiv').delay(3000).hide(0);
						document.getElementById("designation").value="";
						document.getElementById("DisciplineAdd").value="";
						document.getElementById("Numbers").value="";
						document.getElementById("Period").value="";
						document.getElementById("RemarksAdd").value="";
						var Notification5=document.getElementById("Notification5").innerHTML;
						$('#Notification5').html(Number(Notification5)+1);
						setTimeout(ListModal5, 3000);
					}else{
						$('#cross13').click();	
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-danger" id="divalert"  role="alert"> Data Add unsuccessfully</div>');
						$('#successdiv').delay(3000).hide(0);
						document.getElementById("designation").value="";
						document.getElementById("DisciplineAdd").value="";
						document.getElementById("Numbers").value="";
						document.getElementById("Period").value="";
						document.getElementById("RemarksAdd").value="";

					}
					
				}
				})
				
			}else{
				event.preventDefault();
				return false;
			}
			
		}
	}
	function ListModal5(){
		$('#tbody5').html("");
		
		$.ajax({
			type:'GET',
			url:'ManpowerList.htm',
			datatype:'json',
			data:{
				initiationid:<%=initiationid%>,
			},
			success:function(result){
				var ajaxresult=JSON.parse(result);
				var html="";
				if(ajaxresult.length==0){
					$('#manpowEdit').hide();
					$('#tbody5').html('<tr style="text-align:center;"><td colspan="7">No Data Available</td></tr>')
					}else{
				for(var i=0;i<ajaxresult.length;i++){
					html=html+'<tr><td align="center"><input type="radio" name="modal1raio" onchange=radiovalueModal1('+ajaxresult[i][0]+','+5+')></td>'+'<td align="center">'+(i+1)+'</td>'+'<td>'+ajaxresult[i][2]+'</td>'+'<td>'+ajaxresult[i][3]+'</td>'+'<td align="center">'+ajaxresult[i][4]+'</td>'+'<td align="center">'+ajaxresult[i][5]+'</td>'+'<td align="left">'+ajaxresult[i][6]+'</td></tr>'
				}
				$('#manpowEdit').show();
				$('#tbody5').html(html);
					}
			}
		})
		$('#ManpowerList').modal('show');
	}
	function BackModal(a){
		if(a===1){ListModal1();$('#cross'+(Number(a)*3)).click();document.getElementById("radio1").value=0;}
		if(a===2){ListModal2();$('#cross'+(Number(a)*3)).click(); document.getElementById("radio2").value=0;}
		if(a===3){ListModal3();$('#cross'+(Number(a)*3)).click(); document.getElementById("radio3").value=0;}
		if(a===4){ListModal4();$('#cross'+(Number(a)*3)).click(); document.getElementById("radio4").value=0;}
		if(a===5){ListModal5();$('#cross'+(Number(a)*3)).click(); document.getElementById("radio5").value=0;}
		if(a===6){ListModal6();$('#cross'+(Number(a)*3)).click(); document.getElementById("radio6").value=0;}
	}
	
	function showEditModal5(){
		var radio=$('#radio5').val();
		if(radio==0){
			alert("Please select one!")
		}else{
			$.ajax({
				type:'GET',
				url:'ManpowerValue.htm',
				datatype:'json',
				data:{
					requirementid:radio,
				},
				success:function(result){
					var ajaxresult=JSON.parse(result);
					document.getElementById("designationEdit").value=ajaxresult[2];
					document.getElementById("DisciplineAddEdit").value=ajaxresult[3];
					document.getElementById("NumbersEdit").value=ajaxresult[4];
					document.getElementById("PeriodEdit").value=ajaxresult[5];
					document.getElementById("RemarksAddEdit").value=ajaxresult[6];
					document.getElementById("requirementid").value=ajaxresult[0];
					$('#cross14').click()
					$('#EditManpower').modal('show');
				}
			})
		}
	}
	function editForm5(){
		var designation=$('#designationEdit').val().trim();
		var Discipline=$('#DisciplineAddEdit').val().trim();
		var Numbers=$('#NumbersEdit').val().trim();
		var Period=$('#PeriodEdit').val().trim();
		var Remarks=$('#RemarksAddEdit').val().trim();
		var requirementid=$('#requirementid').val();
		if(designation.length<=0||Discipline.length<=0||Numbers.length<=0||Period.length<=0||Remarks.length<=0){
			alert("Please fill all the fields")
		}else{
			if(confirm("Are you sure , you want to submit?")){
				$('#successdiv').css("display","none");
				$.ajax({
					type:'GET',
					url:'ManpowerEdit.htm',
					datatype:'json',
					data:{
						designation:designation,
						Discipline:Discipline,
						Numbers:Numbers,
						Period:Period,
						Remarks:Remarks,
						requirementid:requirementid,
					},
					success:function (result){
						if(result>0){
							$('#cross15').click();	
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Manpower requirements  Updated Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
							document.getElementById("radio5").value=0;
						}
						setTimeout(ListModal5, 3000);
					}
				})
				
			}else{event.preventDefault();return false;}}}
	
	/* submit information and major additional facilities  */
	function InformationSubmit(a){
		var information1=$('#information1').val().trim();
		var information2=$('#information2').val().trim();
		var information3=$('#information3').val().trim();
		var majorcapital =CKEDITOR.instances['majorcapital'].getData();

		
 		if(information1.length<=0&&information2.length<=0&&information3.length<=0&&majorcapital.length<=0){
			alert("Please fill the field")
		}else{
			if(confirm("Are you sure,you want to submit the data?")){
				$('#successdiv').css("display","none");
				$.ajax({
					type:'POST',
					url:'MacroDetailsPart2.htm',
					datatype:'json',
					data:{
						majorcapital:majorcapital,
						information1:information1,
						information2:information2,
						information3:information3,
						initiationid:<%=initiationid%>,
						${_csrf.parameterName}:	"${_csrf.token}"
					},
					success:function(result){
						if(result>0){
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
							$('.submit'+a).html('<button type="submit" class="btn btn-sm btn-warning mt-1" onclick="InformationSubmit()">UPDATE</button>')
						}
					}
					
				})
			}else{
				event.preventDefault();
				return false;
			}
		}
	}
	 function briefPertSubmit(a){
		 var subpointdiv16Editor =CKEDITOR.instances['subpointdiv16Editor'].getData();
		 if(subpointdiv16Editor.length==0){
			 alert("please fill this field")
		 }else{
				if(confirm("Are you sure ,you want to submit?")){
					$('#successdiv').css("display","none");
					$.ajax({
						type:'post',
						url:'BriefPertSubmit.htm',
						datatype:'json',
						data:{
							PERT:subpointdiv16Editor,
							initiationid:<%=initiationid%>,
							${_csrf.parameterName}:	"${_csrf.token}"
						},
						success:function(result){
							if(result>0){
								$('#successdiv').css("display","block");
								$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
								$('#successdiv').delay(3000).hide(0);
								
								$('#a'+a).html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefPertSubmit('+a+')">UPDATE</button>');
							}
						}
					})
				}else{
					event.preventDefault();
					return false;
				}
			}
	 }
	 
	 function briefStructureSubmit(a){
		 var subpointdiv15Editor =CKEDITOR.instances['subpointdiv15Editor'].getData();
			 if(subpointdiv15Editor.length==0){
				 alert("please fill this field")
			 }else{
					if(confirm("Are you sure ,you want to submit?")){
						$('#successdiv').css("display","none");
						$.ajax({
							type:'post',
							url:'BriefStructureSubmit.htm',
							datatype:'json',
							data:{
								ProjectManagement:subpointdiv15Editor,
								initiationid:<%=initiationid%>,
								${_csrf.parameterName}:	"${_csrf.token}"
							},
							success:function(result){
								if(result>0){
									$('#successdiv').css("display","block");
									$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
									$('#successdiv').delay(3000).hide(0);
									
									$('#a'+a).html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefStructureSubmit('+a+')">UPDATE</button>');
								}
							}
						})
					}else{
						event.preventDefault();
						return false;
					}
				} 
	 }
	 
	 function briefcostSubmit(a){
			var subpointdiv14Editor =CKEDITOR.instances['subpointdiv14Editor'].getData();
			 if(subpointdiv14Editor.length==0){
				 alert("please fill this field")
			 }else{
					if(confirm("Are you sure ,you want to submit?")){
						$('#successdiv').css("display","none");
						$.ajax({
							type:'post',
							url:'BriefCostDeSubmit.htm',
							datatype:'json',
							data:{
								CostsBenefit:subpointdiv14Editor,
								initiationid:<%=initiationid%>,
								${_csrf.parameterName}:	"${_csrf.token}"
							},
							success:function(result){
								if(result>0){
									$('#successdiv').css("display","block");
									$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
									$('#successdiv').delay(3000).hide(0);
									
									$('#a'+a).html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefcostSubmit('+a+')">UPDATE</button>');
								}
							}
						})
					}else{
						event.preventDefault();
						return false;
					}
				} 
	 }
	 function briefCriticalSubmit(a){
			var subpointdiv17Editor =CKEDITOR.instances['subpointdiv17Editor'].getData();
		 if(subpointdiv17Editor.length==0){
			 alert("please fill this field")
		 }else{
				if(confirm("Are you sure ,you want to submit?")){
					$('#successdiv').css("display","none");
					$.ajax({
						type:'POST',
						url:'BriefCriticalubmit.htm',
						datatype:'json',
						data:{
							CriticalTech:subpointdiv17Editor,
							initiationid:<%=initiationid%>,
							${_csrf.parameterName}:	"${_csrf.token}"
						},
						success:function(result){
							if(result>0){
								$('#successdiv').css("display","block");
								$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
								$('#successdiv').delay(3000).hide(0);
								
								$('#a'+a).html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefCriticalSubmit('+a+')">UPDATE</button>');
							}
						}
					})
					
				}else{
					event.preventDefault();
					return false;
				}
			} 
	 }
	 function briefProductionSubmit(a){
		 var subpointdiv13Editor =CKEDITOR.instances['subpointdiv13Editor'].getData();
			 if(subpointdiv13Editor.length==0){
				 alert("please fill this field")
			 }else{
					if(confirm("Are you sure ,you want to submit?")){
						$('#successdiv').css("display","none");
						$.ajax({
							type:'POST',
							url:'BriefProsubmit.htm',
							datatype:'json',
							data:{
								ProductionAgencies:subpointdiv13Editor,
								initiationid:<%=initiationid%>,
								${_csrf.parameterName}:	"${_csrf.token}"
							},
							success:function(result){
								if(result>0){
									$('#successdiv').css("display","block");
									$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
									$('#successdiv').delay(3000).hide(0);
									
									$('#a'+a).html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefProductionSubmit('+a+')">UPDATE</button>');
					  }
					 }
					})		
				}else{
				event.preventDefault();
				return false;
			}
		}
	 }
	 function briefDevelopmentSubmit(a){
			var subpointdiv12Editor =CKEDITOR.instances['subpointdiv12Editor'].getData();
		 if(subpointdiv12Editor.length==0){
			 alert("please fill this field")
		 }else{
				if(confirm("Are you sure ,you want to submit?")){
					$('#successdiv').css("display","none");
					$.ajax({
						type:'POST',
						url:'BriefDevsubmit.htm',
						datatype:'json',
						data:{
							DevelopmentPartner:subpointdiv12Editor,
							initiationid:<%=initiationid%>,
							${_csrf.parameterName}:	"${_csrf.token}"
						},
						success:function(result){
							if(result>0){
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
							$('#a'+a).html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefDevelopmentSubmit('+a+')">UPDATE</button>');
							}
						}
					})
					
				}else{
					event.preventDefault();
					return false;
				}
			}
	 }
	 function briefResrSubmit(a){
		 var subpointdiv11Editor =CKEDITOR.instances['subpointdiv11Editor'].getData();
		 if(subpointdiv11Editor.length==0){
			 alert("please fill this field")
		 }else{
				if(confirm("Are you sure ,you want to submit?")){
					$('#successdiv').css("display","none");
					$.ajax({
						type:'POST',
						url:'BriefMatrixsubmit.htm',
						datatype:'json',
						data:{
						ResponsibilityMatrix:subpointdiv11Editor,
						initiationid:<%=initiationid%>,
						${_csrf.parameterName}:	"${_csrf.token}"
						},
						success:function(result){
							if(result>0){
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
							$('#a'+a).html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefResrSubmit('+a+')">UPDATE</button>');
							}
						}
					})
				}else{
					event.preventDefault();
					return false;
				}
			}
	 }
	 function briefTestSubmit(a){
		 var subpointdiv8Editor =CKEDITOR.instances['subpointdiv8Editor'].getData();
		 if(subpointdiv8Editor.length==0){
			 alert("please fill this field")
		 }else{
				if(confirm("Are you sure ,you want to submit?")){
					$('#successdiv').css("display","none");
					$.ajax({
						type:'POST',
						url:'BriefTestsubmit.htm',
						datatype:'json',
						data:{
						TestingPlan:subpointdiv8Editor,
						initiationid:<%=initiationid%>,
						${_csrf.parameterName}:	"${_csrf.token}"
						},
						success:function(result){
							if(result>0){
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
							$('#a'+a).html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefTestSubmit('+a+')">UPDATE</button>');
							}
						}
					})
					
				}else{
				event.preventDefault();
				return false;
				}
			}
		 
	 }
	 function briefActionSubmit(a){
		 var subpointdiv6Editor =CKEDITOR.instances['subpointdiv6Editor'].getData();
		 if(subpointdiv6Editor.length==0){
			 alert("please fill this field")
		 }else{
				if(confirm("Are you sure ,you want to submit?")){
					$('#successdiv').css("display","none");
					$.ajax({
						type:'POST',
						url:'BriefActionsubmit.htm',
						datatype:'json',
						data:{
							ActionPlan:subpointdiv6Editor,
							initiationid:<%=initiationid%>,
							${_csrf.parameterName}:	"${_csrf.token}"
						},
						success:function(result){
							if(result>0){
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
								
							$('#a'+a).html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefActionSubmit('+a+')">UPDATE</button>');
							}
						}
					})
				}else{
				event.preventDefault();
				return false;
				}
			}
	 }
	 function briefPeerSubmit(a){
			var subpointdiv5Editor =CKEDITOR.instances['subpointdiv5Editor'].getData();
			if(subpointdiv5Editor.length==0){
				alert("please fill this field");
			}else{
				if(confirm("Are you sure ,you want to submit?")){
					$('#successdiv').css("display","none");
					$.ajax({
						type:'POST',
						url:'BriefPeersubmit.htm',
						datatype:'json',
						data:{
						PeerReview:subpointdiv5Editor,
						initiationid:<%=initiationid%>,
						${_csrf.parameterName}:	"${_csrf.token}"
						},
						success:function(result){
							if(result>0){
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
							$('#a'+a).html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefPeerSubmit('+a+')">UPDATE</button>');
							}
						}
					})
					
				}else{
					event.preventDefault();
					return false;
				}
			}
	 }
	 /* update achivement data */
	function briefNeedSubmit(a){
		var subpointdiv2Editor =CKEDITOR.instances['subpointdiv2Editor'].getData();
		if(subpointdiv2Editor.length==0){
			alert("please fill the field");
		}else{
			if(confirm("Are you sure ,you want to submit?")){
				$('#successdiv').css("display","none");
				$.ajax({
					type:'POST',
					url:'BriefPoint2submit.htm',
					datatype:'json',
					data:{
					Achievement:subpointdiv2Editor,
					initiationid:<%=initiationid%>,
					${_csrf.parameterName}:	"${_csrf.token}"
					},
					success:function(result){
						if(result>0){
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
						$('#successdiv').delay(3000).hide(0);
						$('#a'+a).html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefNeedSubmit('+a+')">UPDATE</button>');
						}
					}
				})
				
			}else{
				event.preventDefault();
				return false;
			}
		}
	}
	/*  update trl data*/
	function briefTRLSubmit(a){
		var subpointdiv4Editor =CKEDITOR.instances['subpointdiv4Editor'].getData();
		if(subpointdiv4Editor.length==0){
			alert("please fill this field")
		}else{
			if(confirm("Are you sure you want to submit?")){
				$.ajax({
					type:'POST',
					url:'BriefTRLsubmit.htm',
					datatype:'json',
					data:{
						TRLanalysis:subpointdiv4Editor,
						initiationid:<%=initiationid%>,
						${_csrf.parameterName}:	"${_csrf.token}"
					},
					success:function(result){
						if(result>0){
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">Data  Updated Successfully</div>');
							$('#successdiv').delay(3000).hide(0);
							$('#a'+a).html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="briefTRLSubmit('+a+')">UPDATE</button>');
						}
					}
				})
				
			}else{
				event.preventDefault();
				return false;
			}
		}
	} 
	/*submitting capsi data  */
	function submitForm6(){
		var CapsiBudget=$('#CapsiBudget').val();
		var Station=$('#Station').val().trim();
		/* var CapsiConsultant=$('#CapsiConsultant').val().trim(); */
		var Capsiarea=$('#Capsiarea').val().trim();
		var Capsicost=$('#Capsicost').val().trim();
		var capsipdc=$('#capsipdc').val().trim();
		var capsiconfidence=$('#capsiconfidence').val().trim();
		
		if(Station.length==0||Capsiarea.length==0||Capsicost.length==0||capsipdc.length==0||capsiconfidence.length==0){
			alert("Please fill all the fields")
		}else if(Number(Capsicost)>Number(CapsiBudget)){
			alert("The given cost is exceeding the budget")
		}
		else{
			if(confirm("Are you sure , you want to submit the data?")){
				$('#successdiv').css("display","none");
				$.ajax({
					type:'GET',
					url:'ProjectCapsiSubmit.htm',
					datatype:'json',
					data:{
						Station:Station,
						Capsiarea:Capsiarea,
						Capsicost:Capsicost,
						capsipdc:capsipdc,
						capsiconfidence:capsiconfidence,
 						initiationid:<%=initiationid%>,
					},
				success:function(result){
					if(result>0){
						$('#cross16').click();	
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert"> Data Added Successfully</div>');
						$('#successdiv').delay(3000).hide(0);
						document.getElementById("Station").value="";
					/* 	document.getElementById("CapsiConsultant").value=""; */
						document.getElementById("Capsiarea").value="";
						document.getElementById("Capsicost").value="";
						document.getElementById("capsipdc").value="";
						
					var Notification6=document.getElementById("Notification6").innerHTML;
						$('#Notification6').html(Number(Notification6)+1);
						setTimeout(ListModal6, 3000); 
					}else{
						$('#cross16').click();
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert"> Data adding Unsuccessful</div>');
						$('#successdiv').delay(3000).hide(0);
						document.getElementById("Station").value="";
				/* 		document.getElementById("CapsiConsultant").value=""; */
						document.getElementById("Capsiarea").value="";
						document.getElementById("capsipdc").value="";
					}
				}	
				})
			}else{
				event.preventDefault();
				return false;
			}
		}
	}
	/* Getting Capsi table data */
function ListModal6(){
	var value=$('#mainCapsiBudget').val()
	$('#tbody6').html('')
	var x=0;
	$.ajax({
		type:'GET',
		url:'CapsiList.htm',
		datatype:'json',
		data:{
			initiationid:<%=initiationid%>,
		},
		success:function(result){
			var ajaxresult=JSON.parse(result);
			if(ajaxresult.length==0){
				$('#capsiEdit').hide();
				document.getElementById("CapsiBudget").value=value
			$('#tbody6').html('<tr style="text-align:center;"><td colspan="8">No Data Available</td></tr>')
			}
			else{
				$('#capsiEdit').show();
				var html="";
				for(var i=0;i<ajaxresult.length;i++){
					x=x+Number(ajaxresult[i][5]);
					let str = ajaxresult[i][5];  
					let num = parseFloat(ajaxresult[i][5])/10000000;  
					let formattedNum = num.toLocaleString('en-IN', {
					 style: 'currency',
					 currency: 'INR',
					 minimumFractionDigits: 2,
					 maximumFractionDigits: 2,
					});						
				html=html+'<tr><td align="center"><input type="radio" name="modal1raio" onchange=radiovalueModal1('+ajaxresult[i][0]+','+6+')></td>'+'<td align="center">'+(i+1)+'</td>'+'<td>'+ajaxresult[i][2]+'</td>'+'<td >'+ajaxresult[i][4]+'</td>'+'<td align="right">'+formattedNum+'</td>'+'<td align="center">'+ajaxresult[i][6]+'</td>'+'<td align="center">'+ajaxresult[i][7]+'</td></tr>'
				}
				var capsiBudgetLeft=Number(value)-Number(x);
				if(capsiBudgetLeft==0){
					$('#capsiAdd').hide();
				}else{
					$('#capsiAdd').show();
				}
				let str1 = value;  
				let num1 = parseFloat(str1)/10000000;  
				let formattedNum1 = num1.toLocaleString('en-IN', {
				 style: 'currency',
				 currency: 'INR',
				 minimumFractionDigits: 2,
				 maximumFractionDigits: 2,
				});	
				let str2 = x;  
				let num2 = parseFloat(str2)/10000000;  
				let formattedNum2 = num2.toLocaleString('en-IN', {
				 style: 'currency',
				 currency: 'INR',
				 minimumFractionDigits: 2,
				 maximumFractionDigits: 2,
				});	
				let str3 = capsiBudgetLeft;  
				let num3 = parseFloat(str3)/10000000;  
				let formattedNum3 = num3.toLocaleString('en-IN', {
				 style: 'currency',
				 currency: 'INR',
				 minimumFractionDigits: 2,
				 maximumFractionDigits: 2,
				});	
				document.getElementById('TablecapsiCost').innerHTML="Total Budget -"+formattedNum1+" Lakhs"
				document.getElementById('TablecapsiCostPlanned').innerHTML="Budget planned-"+formattedNum2+" Lakhs"
				document.getElementById('TablecapsiCostCostLeft').innerHTML="Budget Left -"+formattedNum3+" Lakhs"
				document.getElementById('EditcapsiCostPlanned').innerHTML="Budget planned-"+formattedNum2+" Lakhs"
				document.getElementById('EditcapsiCostCostLeft').innerHTML="Budget Left -"+formattedNum3+" Lakhs"
				document.getElementById("CapsiPlanned").value=x;
				document.getElementById("CapsiBudget").value=capsiBudgetLeft;
				$('#tbody6').html(html);
			}	
		}
		
	})
	$('#CAPSILIST').modal('show');
}
/* open capsi edit modal */
function showEditModal6(){
	var radio=$('#radio6').val();
	if(radio==0){
		alert("Please select one!")
	}else{
		$.ajax({
			type:'GET',
			url:'CapsiValue.htm',
			datatype:'json',
			data:{
				capsid:radio,
			},
			success:function(result){
			var ajaxresult=JSON.parse(result);
			document.getElementById("StationEdit").value=ajaxresult[2];
		/* 	document.getElementById("CapsiConsultantEdit").value=ajaxresult[3]; */
			document.getElementById("CapsiareaEdit").value=ajaxresult[4];
			document.getElementById("CapsicostEdit").value=ajaxresult[5];
			document.getElementById("capsipdcEdit").value=ajaxresult[6];
			document.getElementById("capsiconfidenceEdit").value=ajaxresult[7];
			document.getElementById("capsid").value=ajaxresult[0];
			document.getElementById("previousCapsiCost").value=ajaxresult[5];
			$('#CapsiEditModal').modal('show');
			$('#cross17').click();
			}
		})
		
	}
}
/* Edit capsi details */
function editForm7(){
	var previousCapsiCost=$('#previousCapsiCost').val();
	var CapsiPlanned=$('#CapsiPlanned').val();
	var mainCapsiBudget=$('#mainCapsiBudget').val();
	var Station=$('#StationEdit').val().trim();
	/* var CapsiConsultant=$('#CapsiConsultantEdit').val().trim(); */
	var Capsiarea=$('#CapsiareaEdit').val().trim();
	var Capsicost=$('#CapsicostEdit').val().trim();
	var capsipdc=$('#capsipdcEdit').val().trim();
	var capsiconfidence=$('#capsiconfidenceEdit').val().trim();
	var capsid=$('#capsid').val();
	var x=Number(CapsiPlanned)+Number(Capsicost)-Number(previousCapsiCost);
	if(Station.length==0||Capsiarea.length==0||Capsicost.length==0||capsipdc.length==0||capsiconfidence.length==0){
		alert("Please fill all the fields")
	}else if(x>Number(mainCapsiBudget)){
		alert("The given cost is exceeding the total budget")
	}
	else{
		if(confirm("Are you sure,you want to submit?")){
			$('#successdiv').css("display","none");	
			$.ajax({
				type:'GET',
				url:'CapsiEdt.htm',
				datatype:'json',
				data:{
				Station:Station,
				Capsiarea:Capsiarea,
				Capsicost:Capsicost,
				capsipdc:capsipdc,
				capsiconfidence:capsiconfidence,
				capsid:capsid,
				},
			success:function(result){
				if(result>0){
				$('#cross18').click();	
				$('#successdiv').css("display","block");
				$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">CapsiData   updated successfully</div>');
				$('#successdiv').delay(3000).hide(0);
				document.getElementById("radio6").value=0;
				}
				setTimeout(ListModal6, 3000);
			}
			
			})
		}else{
		event.preventDefault();
		return false;
		}
	}
}
/*show the work packages  */
function showWork(){
	$('#buildingworkDiv').css("display","block");
	$('#buildingwork').html('<button type="button" class="btn btn-sm bg-transparent plus"  data-toggle="tooltip" data-placement="top" onclick="hideWork()"><i class="btn  fa  fa-minus " style="color: red; padding: 0px  0px  0px  0px;"></i></button>');
}
/*Hide the work Packages  */
function hideWork(){
	$('#buildingworkDiv').css("display","none");
	$('#buildingwork').html('<button type="button" class="btn btn-sm bg-transparent plus"  data-toggle="tooltip" data-placement="top" onclick="showWork()"><i class="btn  fa  fa-plus " style="color: green; padding: 0px  0px  0px  0px;"></i></button>');
}

</script>
</body>
	</html>