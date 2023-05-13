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
.fa-list{
color: #6495ed;
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
    font-size: 18px !important;
}

.addreq {
	margin-left: -10%;
	margin-top: 5%;
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
	box-shadow: 2px 2px 2px cadetblue;
	border-radius: 5px;
	margin-left: 0%;
}
#rightside h5,#part2lefside h5,#part2rightside h5{
    padding: 5px;
    border: 1px solid white;
    border-radius: 5px;
    background: aliceblue;
    font-size: 20px;

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
	  /* background-image: linear-gradient(45deg, #4776E6, #8E54E9); */
	/*    background-image: linear-gradient(45deg, #FC354C, #0ABFBC);  */
	  	background-image: linear-gradient(45deg, white, #C4DDFF);
	   color :#292e49;  

}
.table-striped>tbody>tr:nth-child(odd) {
	  /* background-image: linear-gradient(45deg, #4776E6, #8E54E9);   */
	 /*   background-image: linear-gradient(45deg, #FC354C, #0ABFBC);     */
	 background-image: linear-gradient(45deg,#C4DDFF, white);
		 color :#292e49; 
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
	/* background-image: linear-gradient(45deg,#C4DDFF, #ffffff);  */
	display: none; /* height:520px; */
	background-image: repeating-linear-gradient(45deg,#ffffff 58%, #C4DDFF);
}

#leftside,#rightside,#part2lefside,#part2rightside{

border:1px solid #ffffff;
border-radius: 5px;
box-shadow: 3px 3px 3px gray;
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
	List<Object[]> ProjectInitiationLabList = (List<Object[]>) request.getAttribute("ProjectInitiationLabList");
	List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
	String projectTypeId=(String)request.getAttribute("projectTypeId");
    List<Object[]>projectFiles=(List<Object[]>)request.getAttribute("projectFiles");
    List<Object> DocumentId=new ArrayList<>();
   	if(!projectFiles.isEmpty()){
  	 DocumentId=projectFiles.stream().map(e->e[8]).collect(Collectors.toList());
  	 }
   	Object[]MacroDetails=(Object[])request.getAttribute("MacroDetails");
	%>
	
	<div align="center" style="display:None">
	<div class="alert alert-danger" id="danger"  role="alert">
	Data Edited Successfully.
	</div>
	</div>	
		<div align="center"  id="successdiv" style="display:None"> 
	<div class="alert alert-success" id="divalert"  role="alert">Data Edited Successfully.</div>
	</div>
	
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

						<div class="col-md-1" id="download" >
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
					<div class="col-md-6" id="div1">
						<label class="control-label"
							style="font-size: 15px; color: #07689f;"><b>Project:</b></label>
			</div>
				<div class="col-md-6" style="" id="projectname" >
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
											<td><h5>Not Applicable</h5></td>
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
													onclick="editPGNAJ(<%=obj[0]%>)" class="btn btn-warning ">EDIT</button></td>

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
												<td colspan="2" ><h5 style="margin-left: 50px;">Not Applicable</h5></td>
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
														class="btn btn-warning btn-sm">EDIT</button></td>

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
												<td align="center"><h5>Not Applicable</h5></td><td></td>
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
													<td align="center"><h5>Not Applicable</h5></td>
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
					</div>

					<%
					}
					%>
					<div class="card-body" id="cardbody1" >
					<div class="row">
					<div class="col-md-6" id="leftside">
					<div class="row mt-2">
					<div class="col-md-12 ml-1 leftsiderow" >
					<h5 class="ml-1">1.&nbsp;&nbsp;a.&nbsp;&nbsp;Title of the Project &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;<p><%=ProjectDetailes[7] %></p>   </h5>
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-12 ml-1 leftsiderow" >
					<h5 class="ml-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b.&nbsp;&nbsp;Short Name or Acronym &nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;<p><%=ProjectDetailes[6] %></p>   </h5>
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
												style="box-shadow: 2px 2px 2px grey;">EDIT</button>



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
					<h5 class="mt-1">9.Specify the proposed LSI / DcPP/ PA or selection methodology
					<span class="ml-5"></span><span class="ml-4"></span>
					<span class="ml-5" id="spanbtn9" style="float: right">
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
										<div align="center" id="addmethodology"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="submitMethodology()">EDIT</button></div>
										<%} %>
									</div>
									<%} %>
				    <div class="col-md-12 mt-2" id="divadditonal">
					<h5 class="mt-1">10.Additional requirement of mechanical transport vehicles specific to the project, for equipment/developed systems and stores (with justifications):
					<span class="ml-5"></span><span class="ml-4"></span>
					<span class="ml-5" id="spanbtn10" style="float: right" >
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
									   	<div align="center" id="reqsubmit"><button type="button" class="btn btn-sm btn-warning mt-1" onclick="submitRequirement()">EDIT</button></div>
									   <%} %>
									   
									    </div>
										<%}%>
										
										
					<div class="col-md-12 mt-2" id="divotherinformation">
					<h5 class="mt-1">11.Any other information
					<span class="ml-5"></span><span class="ml-5"></span><span class="ml-4"></span>
					<span class="ml-5" id="spanbtn11" style="float: right">
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
											<button type="button" class="btn btn-sm btn-warning mt-1"onclick="submitOtherInformation()">EDIT</button>
											</div>
										<%} %>
									</div>
									<%} %>
									
					<div class="col-md-12 mt-2" id="divenclosures">
					<h5 class="mt-1">12.Enclosures
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
												onclick="submitEnclosures()">EDIT</button>
										</div>
										<%} %>
									</div>
									<%} %>

					<div class="col-md-12 mt-2" id="projectdeliverables">
					<h5 class="mt-1">13.Proposed project deliverables<br>
					<span>
					<%if(MacroDetails.length==0){ %>	
					<label class=" font-weight-bold">(a) No of prototypes for testing :</label>
					<input class="form-control" id="PrototypesNo"name="PrototypesNo" type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" style="display:inline-block;width:10% ;margin-left:2%" >
					<br><label class=" font-weight-bold mt-1">(b) No of (type approved/qualified) deliverables:</label>
					<input class="form-control mt-1" id="deliverables" name="deliverables" type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" style="display:inline-block;width:10%;margin-left:2%" >
					 <br><span class="text-center" id="protospan"><button class="btn btn-sm btn-success mt-1" type="button" onclick="valueSubmit()" style="margin-left: 50%;">SUBMIT</button></span>
					 <%}else{ %>
					 <label class=" font-weight-bold">(a) No of prototypes for testing :</label>
					<input class="form-control" id="PrototypesNo"name="PrototypesNo" type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" style="display:inline-block;width:10% ;margin-left:2%" value="<%if(MacroDetails[6]!=null){%><%=MacroDetails[6] %><%}else{%><%}%>">
					<br><label class=" font-weight-bold mt-1">(b) No of (type approved/qualified) deliverables:</label>
					<input class="form-control mt-1" id="deliverables" name="deliverables" type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" style="display:inline-block;width:10%;margin-left:2%" value="<%if(MacroDetails[7]!=null){%><%=MacroDetails[7] %><%}else{%><%}%> ">
					 <br><span class="text-center" id="protospan">
					 <%if(MacroDetails[6]==null&&MacroDetails[7]==null) {%>
					 <button class="btn btn-sm btn-success mt-1" type="button" onclick="valueSubmit()" style="margin-left: 50%;">SUBMIT</button>
					 <%}else {%>
					  <button class="btn btn-sm btn-warning mt-1" type="button" onclick="valueSubmit()" style="margin-left: 50%;">EDIT</button>
					 <% }%>
					 </span>
					 <%} %>
					 </span>
					</h5>
					</div></div>
					</div>
					</div>
					</div>


					<div class="card-body" id="cardbody2" style="display: none;">
					<div class="row">
					<div class="col-md-6"  id="part2lefside">
					<div class="row mt-1">
					<div class="col-md-12">
					<h5>1. Brief technical appreciation
					<span class="ml-5" id="BriefPoint" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showAllSubPoints()" >
					<i class="btn  fa fa-lg fa-caret-down" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					
					
					</div>
					<div class="row subpointalldiv" id="briefSubPoints"  style="display:none ;height:450px; overflow-y: scroll;">
					<div class="col-md-11 subpoint"  id="subpointdiv1">
					<h5>Justification (need) for undertaking the project/programme along with the  recommendation of the cluster council/DMC.
					<span  id="subpoint1" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,1)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					 </h5>
					</div>
					<div class="col-md-11 subpoint" id="subpointdiv2">
					<h5>
					What will be achieved by taking this project. 
					<span  id="subpoint2" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,2)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					<div class="col-md-11 subpoint" id="subpointdiv3">
					<h5>Competence level/preliminary work done to acquire the same. 
					<span  id="subpoint3" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,3)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					<div class="col-md-11 subpoint" id="subpointdiv4">
					<h5> Brief of TRL analysis.
					<span  id="subpoint4" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,4)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					<div class="col-md-11 subpoint" id="subpointdiv5">
					<h5>
					Peer Review Committee recommendations
					<span  id="subpoint5" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,5)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					<div class="col-md-11 subpoint" id="subpointdiv6">
					<h5>
					Action Plan for prototype development. 
					<span  id="subpoint6" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,6)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					<div class="col-md-11 subpoint" id="subpointdiv7">
					<h5>Realisation Plan
					<span  id="subpoint7" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,7)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					<div class="col-md-11 subpoint" id="subpointdiv8">
					<h5>Testing Plan
					<span  id="subpoint8" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,8)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>					
					</h5>
					</div>
					<div class="col-md-11 subpoint" id="subpointdiv9">
					<h5>Critical factors/technology involved. 
					<span  id="subpoint9" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,9)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>							
					</h5>
					</div>
					<div class="col-md-11 subpoint" id="subpointdiv10">
					<h5 >High development risk areas and remedial actions proposed. 
					<span  id="subpoint10" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,10)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>						
					</h5>
					</div>	
					<div class="col-md-11 subpoint" id="subpointdiv11">
					<h5 >Responsibility Matrix 
					<span  id="subpoint11" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,11)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>						
					</h5>
					</div>	
					<div class="col-md-11 subpoint" id="subpointdiv12">
					<h5 >Development Partners/DcPP/LSI
					<span  id="subpoint12" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,12)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>						
					</h5>
					</div>
					<div class="col-md-11 subpoint" id="subpointdiv13">
					<h5 >Production agencies proposed. 
					<span  id="subpoint13" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,13)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>						
					</h5>
					</div>
					<div class="col-md-11 subpoint" id="subpointdiv14">
					<h5>Costs benefit analysis/spin-off benefits. 
					<span  id="subpoint14" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,14)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>							
					</h5>
					</div>	
					<div class="col-md-11 subpoint" id="subpointdiv15">
					<h5>Project management and monitoring structure proposed.
					<span  id="subpoint15" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,15)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>					
					</h5>
					</div>	
					<div class="col-md-11 subpoint" id="subpointdiv16">
					<h5>PERT/Gantt Charts
					<span  id="subpoint16" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,16)" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>							
					</h5>
					</div>														
					</div>
					<div class="row mt-1"  id="point2">
					<div class="col-md-12">
					<h5>2. List of major additional facilities (capital) required for the project 
					<span class="ml-5" id="BriefPoint" style="float: right">
					<button class="btn btn-sm bg-transparent " type="button" onclick="" >
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>
					</span>
					</h5>
					</div>
					</div>
					<div class="row mt-2" id="point3" >
					<div class="col-md-12">
					<h5>3. Major training requirements
					
					<span class="ml-5" style="float: right ;margin-top: -3px;">
					<button type="button" class="btn btn-sm bg-transparent"data-toggle="tooltip" data-placement="top"
					title="List of training requirements" onclick="ListModal1()"><i class="fa  fa-list" aria-hidden="true"></i></button>
					<button type="button" class="btn btn-sm bg-transparent"  data-toggle="tooltip" data-placement="top"
					title="Add training requirements" onclick="showAddModal(1)">
					<i class="btn  fa  fa-plus" style="color: green; padding: 0px  0px  0px  0px;">
					</i>
					</button>					
					</span>
					</h5></div>
					</div>
					
					<div class="row mt-2" id="point4">
					<div class="col-md-12">
					<h5>4. Details of Work Packages 
					<span class="ml-5" style="float: right ;margin-top: -3px;">
					<button type="button" class="btn btn-sm bg-transparent"data-toggle="tooltip" data-placement="top"
					title="List of Work Packages" onclick="ListModal2()"><i class="fa  fa-list" aria-hidden="true"></i></button>
					<button type="button" class="btn btn-sm bg-transparent"  data-toggle="tooltip" data-placement="top"
					title="Add Work Packages" onclick="showAddModal(2)">
					<i class="btn  fa  fa-plus" style="color: green; padding: 0px  0px  0px  0px;">
					</i>
					</button>					
					</span>					
					
					</h5>
					</div>
					</div>
					<div class="row mt-2" id="point5">
					<div class="col-md-12">
					<h5>5. Details of CARS
					<span class="ml-5" style="float: right ;margin-top: -3px;">
					<button type="button" class="btn btn-sm bg-transparent"data-toggle="tooltip" data-placement="top"
					title="List of CARS" onclick="ListModal3()"><i class="fa  fa-list" aria-hidden="true"></i></button>
					<button type="button" class="btn btn-sm bg-transparent"  data-toggle="tooltip" data-placement="top"
					title="Add CARS" onclick="showAddModal(3)">
					<i class="btn  fa  fa-plus" style="color: green; padding: 0px  0px  0px  0px;">
					</i>
					</button>					
					</span>		
					</h5>
					</div>
					</div>
					<div class="row mt-2" id="point6">
					<div class="col-md-12">
					<h5>6. Details of CAPSI 
					<span class="ml-5" style="float: right ;margin-top: -3px;">
					<button type="button" class="btn btn-sm bg-transparent"  data-toggle="tooltip" data-placement="top"
					title="">
					<i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;">
					</i>
					</button>
					</span>	
					</h5>
					</div>
					</div>
					</div>
					<!-- Right Side Part  -->
					<div class="col-md-6" id="part2rightside">
					<div class="row mt-1 rightsidediv" id="point7">
					<div class="col-md-12">
					<h5>5. Details of Consultancy requirements 
					<span class="ml-5" style="float: right ;margin-top: -3px;">
					<button type="button" class="btn btn-sm bg-transparent"data-toggle="tooltip" data-placement="top"
					title="List of Consultancy requirements"><i class="fa  fa-list" aria-hidden="true"></i></button>
					<button type="button" class="btn btn-sm bg-transparent"  data-toggle="tooltip" data-placement="top"
					title="Add Consultancy requirements">
					<i class="btn  fa  fa-plus" style="color: green; padding: 0px  0px  0px  0px;">
					</i>
					</button>					
					</span>		
					</h5>
					</div>
					</div>
					
					<div class="row mt-2 rightsidediv" id="point8">
					<div class="col-md-12">
					<h5>Details of additional manpower requirements 
					<span class="ml-5" style="float:right;margin-top:-3px;">
					<button type="button" class="btn btn-sm bg-transparent"data-toggle="tooltip" data-placement="top"
					title="List of manpower requirements "><i class="fa  fa-list" aria-hidden="true"></i></button>
					<button type="button" class="btn btn-sm bg-transparent"  data-toggle="tooltip" data-placement="top"
					title="Add manpower requirements ">
					<i class="btn  fa  fa-plus" style="color: green; padding: 0px  0px  0px  0px;">
					</i>
					</button>	
					</span>
					</h5>
					</div>
					</div>
					
					<div class="row mt-2 rightsidediv">
					<div class="col-md-12">
					<h5>Details of additional building space requirement 
					<span class="ml-5" style="float:right;margin-top:-3px;">
					<button type="button" class="btn btn-sm bg-transparent"data-toggle="tooltip" data-placement="top"
					title="List of additional building space requirement  "><i class="fa  fa-list" aria-hidden="true"></i></button>
					<button type="button" class="btn btn-sm bg-transparent"  data-toggle="tooltip" data-placement="top"
					title="Add additional building space requirement ">
					<i class="btn  fa  fa-plus" style="color: green; padding: 0px  0px  0px  0px;">
					</i>
					</button>	
					</span>					
					</h5>
					</div>
					</div>
					
					<div class="row mt-2 rightsidediv">
					<div class="col-md-12">
					<h5>Additional information
					<span class="ml-5" style="float:right;margin-top:-3px;">
					<button type="button" class="btn btn-sm bg-transparent"  data-toggle="tooltip" data-placement="top"
					title="">
					<i class="btn  fa  fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>	
					</span>						
					</h5>
					</div>
					</div>
					
					<div class="row mt-2 rightsidediv">
					<div class="col-md-12">
					<h5>Comments of Project Director
					<span class="ml-5" style="float:right;margin-top:-3px;">
					<button type="button" class="btn btn-sm bg-transparent"  data-toggle="tooltip" data-placement="top"
					title="">
					<i class="btn  fa  fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>	
					</span>									
					</h5>
					</div>
					</div>
					
					<div class="row mt-2 rightsidediv">
					<div class="col-md-12">
					<h5>Recommendations of Lab Director
					<span class="ml-5" style="float:right;margin-top:-3px;">
					<button type="button" class="btn btn-sm bg-transparent"  data-toggle="tooltip" data-placement="top"
					title="">
					<i class="btn  fa  fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i>
					</button>	
					</span>	
					</h5>
					</div>
					</div>
					</div>
					</div>

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
			<div class="modal fade bd-example-modal-lg" id="showAddModal1"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Training Requirements</h5>
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
					</div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="areafortraining" maxlength="255 characters" style="width:80%">
					</div>
					</div>
					<div class="row mt-4">
					<div class="col-md-4">
					<label class="sidelabel">Agency contacted</label><span class="mandatory" style="color: red;">*</span>
					</div>
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
					</div>
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
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Training Requirements</h5>
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
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Training Requirements</h5>
						<button type="button" class="close" data-dismiss="modal" id="cross3"
							aria-label="Close" style="color: white">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
					<div class="col-md-12">
					<div class="row mt-4">
					<div class="col-md-4">
					<label class="sidelabel">Discipline/area for training </label><span class="mandatory" style="color: red;">*</span>
					</div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="areafortrainingEdit" maxlength="255 characters" style="width:80%">
					</div>
					</div>
					<div class="row mt-4">
					<div class="col-md-4">
					<label class="sidelabel">Agency contacted</label><span class="mandatory" style="color: red;">*</span>
					</div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="agencyContactedEdit" maxlength="255 characters" style="width:80%">
					</div>
					</div>
					<div class="row mt-4">
					<div class="col-md-5" style="max-width: 34%">
					<label class="sidelabel">No of Personnel proposed to be trained </label><span class="mandatory" style="color: red;">*</span>
					</div>
					<div class="col-md-2" style="max-width: 12%">
					<input type="text" class="form-control" id="PersonneltrainedEdit" maxlength="255 characters" style="width:100%" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-1" style="padding: 0px;">
					<label class="sidelabel">Duration  </label><span class="mandatory" style="color: red;">*</span>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="DurationEdit" maxlength="255 characters" style="width:60%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-1">
					<label class="sidelabel">Cost  </label><span class="mandatory" style="color: red;">*</span>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="CostaddEdit" maxlength="255 characters" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					</div>
				    <div class="row mt-4">
					<div class="col-md-4">
					<label class="sidelabel">Remarks </label><span class="mandatory" style="color: red;">*</span>
					</div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="RemarksEdit" maxlength="255 characters" style="width:80%">
					<input type="hidden" id="trainingid">
					</div>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="editForm1()">SUBMIT</button>
					</div>
					</div>
					</div>
					</div>
					</div>	
					</div>

	<!-- End -->
	
			<!--Add work packages  -->
			<div class="modal fade bd-example-modal-lg" id="showAddModal2"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Work Packages</h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross4">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
					<div class="col-md-12">
					<div class="row">
					<div class="col-md-4">
					<label class="sidelabel">Name of Govt agencies<span class="mandatory" maxlength="255 charactes" style="color: red;">*</span></label>
					</div>
					<div class="col-md-6">
					<input class="form-control" type="text" id="GovtAgencies" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Work Package<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="workPackage" maxlength="255 charactes" placeholder="max 250 characters">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Objectives<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-8">
					<input type="text" id="Objectives"class="form-control" maxlength="400 characters" style="line-height: 3rem">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Scope<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-8">
					<input type="text" id="Scope"class="form-control" maxlength="400 characters" style="line-height: 3rem">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-2">
					<label class="sidelabel">Cost<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="Cost3" maxlength="255 characters" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-4" align="right">
					<label class="sidelabel"> PDC (in months) <span class="mandatory" style="color: red;">*</span></label>
					</div>
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
	
			<!--End  -->
			<!--List of Work Packages  -->
						<div class="modal fade bd-example-modal-lg" id="WorkPackacgesList"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 170%;margin-left: -35%">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Details of Work Packacges</h5>
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
					<th style="width:7%">Cost<br>( in cr)</th>
					</tr>
					</thead>
					<tbody id="tbody2">
					
					</tbody>
					</table>
					<span class="radiovalueModal2"><input type="hidden" value="0" id="radio2"></span>
					</div>
					<div class="mt-1" align="center">
					<button type="button" class="btn btn-sm btn-warning" onclick="showEditModal2()">EDIT</button>
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
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">Work Packages</h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross6">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
					<div class="col-md-12">
					<div class="row">
					<div class="col-md-4">
					<label class="sidelabel">Name of Govt agencies<span class="mandatory" maxlength="255 charactes" style="color: red;">*</span></label>
					</div>
					<div class="col-md-6">
					<input class="form-control" type="text" id="GovtAgenciesEdit" maxlength="255 charactes" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Work Package<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="workPackageEdit" maxlength="255 charactes" placeholder="max 250 characters">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Objectives<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-8">
					<input type="text" id="ObjectivesEdit"class="form-control" maxlength="400 characters" style="line-height: 3rem">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Scope<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-8">
					<input type="text" id="ScopeEdit"class="form-control" maxlength="400 characters" style="line-height: 3rem">
					<input type="hidden" id="workid">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-2">
					<label class="sidelabel">Cost<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="Cost3Edit" maxlength="255 characters" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-4" align="right">
					<label class="sidelabel"> PDC (in months) <span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="PDCEdit" maxlength="255 characters" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="editForm2()">SUBMIT</button>
					</div></div></div></div></div></div>
			<!--End  -->
			<!-- Add Cars Details -->
			<div class="modal fade bd-example-modal-lg" id="showAddModal3"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">CARS</h5>
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
					</div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="Institute" maxlength="300 characters" placeholder="maximum 300 characters">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Name of the identified professor<span class="mandatory" style="color: red;">*</span></label>					
					</div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="professor" maxlength="300 characters" placeholder="maximum 300 characters" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Area where R&D is required<span class="mandatory" style="color: red;">*</span></label>					
					</div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="Area" maxlength="300 characters" placeholder="maximum 300 characters" >
					</div>
					</div>	
					<div class="row mt-2">
					<div class="col-md-2">
					<label class="sidelabel">Cost<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="Cost4" maxlength="20" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-2" align="right">
					<label class="sidelabel">PDC<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="PDC1" maxlength="9" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>					
					</div>		
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Confidence level of the agency (1-10)
					<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-2">
					<input type="range" min="1" max="10" id="confidence" step="1" style="color:blue">
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
					<button type="button" class="btn btn-sm btn-warning" onclick="showEditModal3()">EDIT</button>
					</div></div></div></div></div>
			<!-- End -->
					<div class="modal fade bd-example-modal-lg" id="EditCars"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader" style="background: #145374; height: 50px;">
						<h5 class="modal-title" style="color:white;font-size: 20px;">CARS</h5>
						<button type="button" class="close" data-dismiss="modal" 
							aria-label="Close" style="color: white" id="cross9">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
					<div class="col-md-12">
					<div class="row">
					<div class="col-md-4">
					<label class="sidelabel">Name of Institute/ Agency<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="InstituteEdit" maxlength="300 characters" placeholder="maximum 300 characters">
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Name of the identified professor<span class="mandatory" style="color: red;">*</span></label>					
					</div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="professorEdit" maxlength="300 characters" placeholder="maximum 300 characters" >
					</div>
					</div>
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Area where R&D is required<span class="mandatory" style="color: red;">*</span></label>					
					</div>
					<div class="col-md-6">
					<input type="text" class="form-control" id="AreaEdit" maxlength="300 characters" placeholder="maximum 300 characters" >
					</div>
					</div>	
					<div class="row mt-2">
					<div class="col-md-2">
					<label class="sidelabel">Cost<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="Cost4Edit" maxlength="20" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>
					<div class="col-md-2" align="right">
					<label class="sidelabel">PDC<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-2">
					<input type="text" class="form-control" id="PDC1Edit" maxlength="9" style="width:100%"oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
					</div>					
					</div>		
					<div class="row mt-2">
					<div class="col-md-4">
					<label class="sidelabel">Confidence level of the agency (1-10)
					<span class="mandatory" style="color: red;">*</span></label>
					</div>
					<div class="col-md-2">
					<input type="range" min="1" max="10" id="confidenceEdit" step="1" style="color:blue">
					<input type="hidden" id="carsid">
					</div>
					</div>
					<div class="mt-2" align="center">
					<button type="button" class="btn btn-primary btn-sm submit" onclick="editForm3()">SUBMIT</button>
					</div></div></div></div></div></div>	
			
			
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
				$('.tdn').html('<input id="TDNedit" class="form-control" style="width:70%" type="text" maxlength="250" value="'+TDN+'"><button type="button" onclick="editTDN('+a+')" style="float: right; margin-top: -13%" class="btn btn-warning btn-sm">EDIT</button>');
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
				$(".pgnaj").html('<input type="text" id="PGNAJedit" style="width:70%;" class="form-control" value="'+PGNAJ+'"> <button type="b"style="float: right; margin-top: -13%"onclick="editPGNAJ(10)" class="btn btn-warning btn-sm">EDIT</button>')
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
		$('#text').html('MACRO DETAILS OF PROJECT/PROGRAMME (PART-I)');
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
		$('#text').html('MACRO DETAILS OF PROJECT/PROGRAMME (PART-II)');
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
					type:'GET',
					url:'ProjectAdditonalRequirementUpdate.htm',
					datatype:'json',
					data:{
						AdditionalRequirement:AdditionalRequirement,
						initiationid :<%=initiationid%>,
					},
					success:function(result){
						var ajaxresult=JSON.parse(result);
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">'+ajaxresult+'</div>');
						$('#successdiv').delay(3000).hide(0); 
						$('#reqsubmit').html('<button class="btn btn-warning btn-sm"  onclick="submitRequirement()" style="box-shadow: 2px 2px 2px grey;">EDIT</button>');
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
						type:'GET',
						url:'ProjectMethodologyUpdate.htm',
						datatype:'json',
						data:{
							initiationid :<%=initiationid%>,
							methodology:methodology,
						},
						success:function(result){
							var ajaxresult=JSON.parse(result);
							$('#successdiv').css("display","block");
							$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">'+ajaxresult+'</div>');
							$('#successdiv').delay(3000).hide(0); 
							$('#addmethodology').html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="submitMethodology()">EDIT</button>');
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
						type:'GET',
						url:'ProjectEnclosuresUpdate.htm',
						datatype:'json',
						data:{
							initiationid :<%=initiationid%>,
							Enclosures:Enclosures,
						},
					success:function(result){
						var ajaxresult=JSON.parse(result);
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">'+ajaxresult+'</div>');
						$('#successdiv').delay(3000).hide(0); 
						$('#addenclosures').html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="submitEnclosures()">EDIT</button>');

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
					type:'GET',
					url:'ProjectOtherInformationUpdate.htm',
					datatype:'json',
					data:{
						initiationid :<%=initiationid%>,
						OtherInformation:OtherInformation,
					},
					success:function(result){
						var ajaxresult=JSON.parse(result);
						$('#successdiv').css("display","block");
						$('#successdiv').html('<div class="alert alert-success" id="divalert"  role="alert">'+ajaxresult+'</div>');
						$('#successdiv').delay(3000).hide(0); 
						$('#informationSubmit').html('<button type="button" class="btn btn-sm btn-warning mt-1" onclick="submitOtherInformation()">EDIT</button>');
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
		var deliverables=$('#deliverables').val();
		console.log(PrototypesNo+"  "+deliverables);
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
						$('#protospan').html('<button class="btn btn-sm btn-warning mt-1" type="button" onclick="valueSubmit()" style="margin-left: 50%;">EDIT</button>');
					
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
			console.log(a+" "+b+"  "+c);
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
					$('#td'+(a+1)).html(ajaxresult);
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
						{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
					]
				} ;
		CKEDITOR.replace( 'methodologydiv',editor_config);
		CKEDITOR.replace( 'Additionaldiv',editor_config); 
		CKEDITOR.replace('otherinformationDiv',editor_config);
		CKEDITOR.replace('EnclosuresDiv',editor_config);
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
	function showsubPoint1(ele,a){
	  $('.subpoint').css("display","none")
	  $('#subpointdiv'+a).css("display","block");
	  $('#subpoint'+a).html('<button class="btn btn-sm bg-transparent " type="button" onclick="hidesubPoint1(this,'+a+')" ><i class="btn  fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>')
	}
	function hidesubPoint1(ele,a){
		$('.subpoint').css("display","block")	
		$('#subpoint'+a).html('<button class="btn btn-sm bg-transparent " type="button" onclick="showsubPoint1(this,'+a+')" ><i class="btn  fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>')
		}
	function showAddModal(a){
		$('#showAddModal'+a).modal('show');
	}
	function submitForm1(){

		var Discipline=$('#areafortraining').val().trim();
		var Agency=$('#agencyContacted').val().trim();
		var Personneltrained=$('#Personneltrained').val();
		var Duration=$('#Duration').val();
		var Cost=$('#Costadd').val();
		var Remarks=$('#Remarks').val();
		
		
		if(Discipline.length<=0||Agency.length<=0||Personneltrained.length<=0||Duration.length<=0||Cost.length<=0||Remarks.length<=0){
			alert("Please fill all the Field")
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
												setTimeout(ListModal1, 3000);
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
					$('#tbody1').html('<tr style="text-align:center;"> <td colspan="8">No Data Added </td></tr>')
				}else{
					var html="";

				for(var i=0;i<ajaxresult.length;i++){
					html=html+'<tr><td align="center"><input type="radio" name="modal1raio" onchange=radiovalueModal1('+ajaxresult[i][0]+','+1+')></td>'+'<td align="center">'+(i+1)+'</td>'+'<td>'+ajaxresult[i][2]+'</td>'+'<td>'+ajaxresult[i][3]+'</td>'+'<td align="center">'+ajaxresult[i][4]+'</td>'+'<td align="center">'+ajaxresult[i][5]+'</td>'+'<td align="right">'+ajaxresult[i][7]+'</td>'+'<td>'+ajaxresult[i][6]+'</td></tr>'
				}
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
		if(Discipline.length<=0||Agency.length<=0||Personneltrained.length<=0||Duration.length<=0||Cost.length<=0||Remarks.length<=0){
			alert("Please fill all the Field")
		}else{
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
		
		if(GovtAgencies<=0||workPackage<=0||Objectives<=0||Scope<=0||Cost3<=0||PDC<=0){
			alert("please fill all the fields")
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
		$('#tbody2').html('');
		$.ajax({
			type:'GET',
			url:'WorkPackageList.htm',
			datatype:'json',
			data:{
				initiationid :<%=initiationid%>,
			},
			success:function (result){
				var ajaxresult=JSON.parse(result);
				console.log(ajaxresult)
				if(ajaxresult.length==0){
				$('#tbody2').html('<tr style="text-align:center;"><td colspan="8">NO DATA ADDED</td></tr>')
				}else
					var html="";

				for(var i=0;i<ajaxresult.length;i++){
					html=html+'<tr><td align="center"><input type="radio" name="modal1raio" onchange=radiovalueModal1('+ajaxresult[i][0]+','+2+')></td>'+'<td align="center">'+(i+1)+'</td>'+'<td>'+ajaxresult[i][2]+'</td>'+'<td>'+ajaxresult[i][3]+'</td>'+'<td >'+ajaxresult[i][4]+'</td>'+'<td >'+ajaxresult[i][5]+'</td>'+'<td align="center">'+ajaxresult[i][6]+'</td>'+'<td align="right">'+ajaxresult[i][7]+'</td></tr>'
				}
				$('#tbody2').html(html)
			}
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
					document.getElementById("Cost3Edit").value=ajaxresult[6];
					document.getElementById("PDCEdit").value=ajaxresult[7];
					document.getElementById("workid").value=ajaxresult[0];
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
		
		if(GovtAgencies<=0||workPackage<=0||Objectives<=0||Scope<=0||Cost3<=0||PDC<=0){
			alert("please fill all the fields")
		}else{
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
		var Institute=$('#Institute').val().trim();
		var professor=$('#professor').val().trim();
		var Area=$('#Area').val().trim();
		var Cost4=$('#Cost4').val();
		var PDC1=$('#PDC1').val();
		var confidence=$('#confidence').val();
		
		if(Institute.length<=0||confidence.length<=0||professor.length<=0||Area.length<=0||Cost4.length<=0||PDC1.length<=0){
			alert("Please fill all the fields")
		}else{
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
		$('#CARSlist').modal('show');
		
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
				$('#tbody3').html('<tr style="text-align:center;"><td colspan="8">NO DATA ADDED</td></tr>')
				}
				else{
					var html="";

					for(var i=0;i<ajaxresult.length;i++){
						html=html+'<tr><td align="center"><input type="radio" name="modal1raio" onchange=radiovalueModal1('+ajaxresult[i][0]+','+3+')></td>'+'<td align="center">'+(i+1)+'</td>'+'<td>'+ajaxresult[i][2]+'</td>'+'<td>'+ajaxresult[i][3]+'</td>'+'<td >'+ajaxresult[i][4]+'</td>'+'<td align="right">'+ajaxresult[i][5]+'</td>'+'<td align="center">'+ajaxresult[i][6]+'</td>'+'<td align="center">'+ajaxresult[i][7]+'</td></tr>'
					}
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
				document.getElementById("carsid").value=ajaxresult[0];
				$('#cross8').click();
				$('#EditCars').modal('show');
			}
			})
		}
	}
	function editForm3(){
		var Institute=$('#InstituteEdit').val().trim();
		var professor=$('#professorEdit').val().trim();
		var Area=$('#AreaEdit').val().trim();
		var Cost4=$('#Cost4Edit').val();
		var PDC1=$('#PDC1Edit').val();
		var confidence=$('#confidenceEdit').val();
		var carsid=$('#carsid').val();
		if(Institute.length<=0||confidence.length<=0||professor.length<=0||Area.length<=0||Cost4.length<=0||PDC1.length<=0){
			alert("Please fill all the fields")
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
	</script>
</body>
	</html>