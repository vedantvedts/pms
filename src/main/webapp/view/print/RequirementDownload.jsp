<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.Format"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<script src="./webjars/jquery/3.4.0/jquery.min.js"></script>
<script src="./webjars/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="./webjars/bootstrap/4.0.0/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="./webjars/font-awesome/4.7.0/css/font-awesome.min.css" />
<script>
	/*     function exportHTML(){
	 var header = "<html xmlns:o='urn:schemas-microsoft-com:office:office' "+
            "xmlns:w='urn:schemas-microsoft-com:office:word' "+
            "xmlns='http://www.w3.org/TR/REC-html40'>"+
	 "<head><meta charset='utf-8'><title>Export HTML to Word Document with JavaScript</title></head><body>";
	 var footer = "</body></html>";
	 var sourceHTML = header+document.getElementById("source-html").innerHTML+footer;
	
	 var source = 'data:application/vnd.ms-word;charset=utf-8,' + encodeURIComponent(sourceHTML);
	 var fileDownload = document.createElement("a");
	 document.body.appendChild(fileDownload);
	 fileDownload.href = source;
	 fileDownload.download = 'System Requirement.doc';
	 fileDownload.click();
	 document.body.removeChild(fileDownload);
	 } */
	jQuery(document).ready(function($) {
		$("#btn-export").click(function(event) {
			$("#source-html").wordExport("System-Requirement");
		});
	});
</script>
<spring:url value="/resources/js/FileSaver.min.js" var="FileSaver" />
<script src="${FileSaver}"></script>

<spring:url value="/resources/js/jquery.wordexport.js" var="wordexport" />
<script src="${wordexport}"></script>

<meta charset="ISO-8859-1">
<title>Requirement Document</title>
<%
List<Object[]>OtherRequirements=(List<Object[]>)request.getAttribute("OtherRequirements");
String lablogo=(String)request.getAttribute("lablogo");
Object[]PfmsInitiationList=(Object[])request.getAttribute("PfmsInitiationList");
Object[]LabList=(Object[])request.getAttribute("LabList");
Object[]reqStatus=(Object[])request.getAttribute("reqStatus");
List<Object[]>RequirementList=(List<Object[]>)request.getAttribute("RequirementList");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf3=fc.getRegularDateFormat();
SimpleDateFormat sdf=fc.getRegularDateFormatshort();
SimpleDateFormat sdf1=fc.getSqlDateFormat();
List<Object[]>RequirementFiles=(List<Object[]>)request.getAttribute("RequirementFiles");
Object[]ReqIntro=(Object[])request.getAttribute("ReqIntro");
String uploadpath=(String)request.getAttribute("uploadpath");
String projectName=PfmsInitiationList[7].toString();
String classification=PfmsInitiationList[5].toString();
String projectshortName=PfmsInitiationList[6].toString();
List<Object[]>Verifications=(List<Object[]>)request.getAttribute("Verifications");
List<Object[]>ParaDetails=(List<Object[]>)request.getAttribute("ParaDetails");
int maincount=0;
int port=new URL( request.getRequestURL().toString()).getPort();
String path=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()+"/";
String conPath=(String)request.getContextPath();
LocalDate d = LocalDate.now();
int contentCount=0;
Month month= d.getMonth();
int year=d.getYear();
%>
<style>
td {
	padding: -13px 5px;
}

#pageborder {
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	border: 2px solid black;
}

@page {
	size: 790px 1050px;
	margin-top: 49px;
	margin-left: 49px;
	margin-right: 49px;
	margin-buttom: 49px;
	border: 2px solid black; @ bottom-right { content : "Page " counter(
	page) " of " counter( pages);
	margin-bottom: 30px;
	margin-right: 10px;
}

@
top-right {
	content: "Project : <%=PfmsInitiationList[6].toString() %>";
	margin-top: 30px;
	margin-right: 10px;
}

@
top-left {
	margin-top: 30px;
	margin-left: 10px;
	content:
		"<%if(reqStatus!=null && reqStatus[3]!=null){%><%=reqStatus[3].toString()%><%}else{%><%}%>";
}

@
top-left {
	margin-top: 30px;
	margin-left: 10px; <%--
	content: "<%=Labcode%>";
	--%>
}

@
top-center {
	font-size: 13px;
	margin-top: 30px;
	content: "<%=PfmsInitiationList[5].toString()%>";
}

@
bottom-center {
	font-size: 13px;
	margin-bottom: 30px;
	content: "<%=PfmsInitiationList[5].toString()%>";
}

.border-black {
	border: 1px solid black !important;
	border-collapse: collapse !important;
}

.border-black td th {
	padding: 0px !important;
	margin: 0px !important;
}

p {
	text-align: justify !important;
	padding: 5px;
}

span {
	background: white !important;
	color: black;
}

.border-black {
	border: 1px solid black;
	border-collapse: collapse;
}
</style>
</head>
<body>
	<div class="content-footer" align="center">
		<button id="btn-export" class="btn btn-lg bg-transparent"
			style="padding: 10px;">
			<i class="fa fa-lg fa-download" aria-hidden="true"
				style="color: green;"></i>
		</button>
	</div>
	<div class="source-html-outer">
		<div id="source-html">
			<div align="center"></div>
			<div style="text-align: center; margin-top: 75px;">
				<h1 style="font-size: 30px !important;" class="heading-color">SYSTEM
					REQUIREMENTS</h1>
				<h2 style="font-size: 20px;">For</h2>
				<h2 style="">
					Project:
					<%=PfmsInitiationList[7].toString()%><br> <br>
					<%="( " + PfmsInitiationList[6].toString() + " )"%>
				</h2>
				<h3 style="font-size: 18px; text-decoration: underline">Requirement
					No.</h3>
				<h3>
					<%if (reqStatus!=null && reqStatus[3] != null) {%><%=reqStatus[3].toString()%>
					<%} else {%>-<%}%>
				</h3>
					<div align="center" >
						<img class="logo" style="width: 20px; height: 20px; margin-bottom: 5px"
							<%if (lablogo != null) {%> src="data:image/png;base64,<%=lablogo%>" alt="Configuration"
							<%} else {%> alt="File Not Found" <%}%>>
				</div>
				<br> <br>
				<div align="center">
					<h3 style="font-size: 20px;">
				<%
				if(LabList[1] != null) {
				%>
				<%=LabList[1].toString()+"("+LabList[0].toString()+")"%>
				<%
				}else {
				%>-<%
				}
				%>
					</h3>
					<h4>
						Government of India, Ministry of Defence<br>Defence Research
						& Development Organization
					</h4>

				</div>

				<h4>
					<%if(LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %>
					<%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %>
					<%}else{ %>
					-
					<%} %>
				</h4>

			</div>
			<br> <br>
			<br>
			<br>
			<div align="center">
				<h4>CONTENTS</h4>
			</div>
			<%if(ReqIntro!=null) {%>
			<h5 style="margin-left: 10px"><%=++contentCount %>. &nbsp;SCOPE</h5>
			<h6 style="margin-left: 20px"><%=contentCount %>.1 Introduction</h6>
			<h6 style="margin-left: 20px"><%=contentCount %>.2 System Block Diagram</h6>
			<h6 style="margin-left: 20px"><%=contentCount %>.3 System Overview</h6>
			<h6 style="margin-left: 20px"><%=contentCount %>.4 Document Overview</h6>
			<h6 style="margin-left: 20px"><%=contentCount %>.5 Applicable Standards</h6>
			<%} %>
			<%if(!RequirementList.isEmpty()) {%>
				<h5 style="margin-left: 10px"><%=++contentCount %>. &nbsp;System Requirements</h5>
			<%for(Object[]obj:RequirementList) {%>
			<%-- <h6 style="margin-left: 20px"><%=obj[1].toString() %></h6> --%>
			<%}} %>
			<%if(!OtherRequirements.isEmpty()) {%>
			<h5 style="margin-left: 10px"><%=++contentCount %>. &nbsp;Additional Requirements</h5>
			<%
			for(Object[]obj:OtherRequirements){%>
				<h6 style="margin-left: 20px"><%if(obj[2].toString().equalsIgnoreCase("0")) {%> <%=obj[3].toString() %><%} %></h6>
			<%}}%>
			<div style="text-align: center;">
				<h1 style="font-size: 20px !important;" class="heading-color">DOCUMENT SUMMARY
				</h1>
				<hr style="width: 80%;">
			</div>
	<!-- 	<table class="border-black"
					style="width: 650px; margin-top: 10px; margin-bottom: 5px;">
			<tr>
			<td>1.Title: System Requirement Document Template</td>
			</tr>
			</table> -->
					<table style="width: 650px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;border-collapse: collapse;">
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;">1.&nbsp; Title: <span class="text-dark">System Requirements Document Template</span></td>
					</tr>
					<tr >
					<td class="text-dark" style="border:1px solid black;">2.&nbsp; Type of Document:<span class="text-dark">System Requirements Document</span></td>
					<td class="text-dark" style="border:1px solid black;">3.&nbsp; Classification: <span class="text-dark"><%=classification %></span></td>
					</tr>
				    <tr >
					<td class="text-dark" style="border:1px solid black;">4.&nbsp; Document Number:</td>
					<td class="text-dark" style="border:1px solid black;">5.&nbsp; Month Year:&nbsp;<span style="font-weight: 600"><%=month.toString().substring(0,3) %></span> <%= year %></td>
					</tr>
					<tr>
					<td class="text-dark" style="border:1px solid black;">6.&nbsp; Number of Pages:</td>
					<td class="text-dark" style="border:1px solid black;">7.&nbsp; Related Document:</td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;">8.&nbsp; Additional Information:
								
					</td>
					</tr>
				     <tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;">9.&nbsp; Project Number and Project Name: <span class="text-dark"><%=projectName %> ( &nbsp;<%= projectshortName %> &nbsp;) </span></td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;">10.&nbsp; Abstract:
						
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;">11.&nbsp; Keywords:</td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;">12.&nbsp; Organization and address:
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
					<td  class="text-dark" colspan="2" style="border:1px solid black;">13.&nbsp; Distribution:</td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;">14.&nbsp; Revision:</td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;">15.&nbsp; Prepared by: <span class="text-dark">-</span> </td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;">16.&nbsp; Reviewed by: <span class="text-dark">-</span> </td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;">17.&nbsp; Approved by: <span class="text-dark">-</span> </td>
					</tr>
					</table>
			
			
			
			
			<%if(ReqIntro!=null) {%>
			<div style="page-break-before: always"></div>
			<div style="text-align: center;">
				<h1 style="font-size: 20px !important;" class="heading-color"><%=++maincount %>.&nbsp;Introduction
				</h1>
				<hr style="width: 80%;">
			</div>
			<%if(ReqIntro!=null){ %>
			<div>
				<h4 style="margin-left: 10px;"><%=maincount+"." %>1
					&nbsp;Introduction
				</h4>
				<div>
					<%if(ReqIntro[1]!=null) {%><%=ReqIntro[1]%>
					<%}else {%><div style="text-align: center;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<div>
				<h4 style="margin-left: 10px;"><%=maincount+"." %>2
					&nbsp;System Block Diagram
				</h4>
				<div>
					<%if(ReqIntro[2]!=null) {%><%=ReqIntro[2]%>
					<%}else {%><div style="text-align: center;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<div>
				<h4 style="margin-left: 10px;"><%=maincount+"." %>3
					&nbsp;System Overview
				</h4>
				<div>
					<%if(ReqIntro[3]!=null) {%><%=ReqIntro[3]%>
					<%}else {%><div style="text-align: center;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<div>
				<h4 style="margin-left: 10px;"><%=maincount+"." %>4
					&nbsp;Document Overview
				</h4>
				<div>
					<%if(ReqIntro[4]!=null) {%><%=ReqIntro[4]%>
					<%}else {%><div style="text-align: center;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<div>
				<h4 style="margin-left: 10px;"><%=maincount+"." %>5
					&nbsp;Applicable Standards
				</h4>
				<div>
					<%if(ReqIntro[5]!=null) {%><%=ReqIntro[5]%>
					<%}else {%><div style="text-align: center;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<%}else{ %>
			<div align="center" style="margin-top: 350px">
				<h2>No Data Available !</h2>
			</div>
			<%}} %>

			<%if(!RequirementList.isEmpty()){ %>
			<div style="page-break-before: always;"></div>
			<div>
				<div align="center">
					<h1 style="font-size: 20px !important; color:;"
						class="heading-color">
						<br><%=++maincount %>.&nbsp;&nbsp;System Requirements
					</h1>
					<hr style="width: 80%;">
				</div>
				<%
	if(!RequirementList.isEmpty()){
		int reqcount=0;
	for(Object[]obj:RequirementList){ %>
				<div style="margin-left: 20px; margin-top: 15px; font-weight: 600">
					<span><%=maincount+"."+(++reqcount)%>&nbsp;&nbsp;Req ID
						&nbsp;::&nbsp;<%=obj[1].toString() %></span>
				</div>
				<table class="border-black"
					style="width: 650px; margin-top: 10px; margin-bottom: 5px;">
					<thead>
						<tr>
							<th class="border-black"
								style="width: 20px; padding: 5px; border: 1px solid black; border-collapse: collapse;">SN</th>
							<th class="border-black"
								style="width: 130px; padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">Attribute</th>
							<th class="border-black"
								style="padding: 5px; border: 1px solid black; border-collapse: collapse;">Content</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">1</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse; font-weight: 600;">ID</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;"><%=obj[1].toString() %></td>
						</tr>
						<tr>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse; vertical-align: top;">2</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; font-weight: 600; border: 1px solid black; border-collapse: collapse; vertical-align: top;">Name</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse; vertical-align: top;"><%=obj[3].toString() %></td>
						</tr>
						<tr>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">3</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; font-weight: 600; border: 1px solid black; border-collapse: collapse;">Type</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;">
								<%if(obj[6]!=null) {%> <%if(obj[6].toString().equalsIgnoreCase("D")) {%>Desirable<%} %>
								<%if(obj[6].toString().equalsIgnoreCase("E")) {%>Essential<%} %> <%}else {%>-<%} %>
							</td>
						</tr>
						<tr>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">4</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; font-weight: 600; border: 1px solid black; border-collapse: collapse;">Category</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;">
								<%if(obj[8]!=null) {%> <%if(obj[8].toString().equalsIgnoreCase("P")) {%>Performance<%} %>
								<%if(obj[8].toString().equalsIgnoreCase("E")) {%>Environmental<%} %>
								<%if(obj[8].toString().equalsIgnoreCase("M")) {%>Maintenance<%} %> <%}else {%>-<%} %>
							</td>
						</tr>
						<tr>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">5</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;">Linked
								Requirements</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;">
								<%if(obj[10]!=null && !obj[10].toString().equalsIgnoreCase("")) {
	int j=0;	
	String linkedReq=obj[10].toString();
	String []linkedreq=linkedReq.split(","); // spliting the data making it an array
	List al=Arrays.asList(linkedreq);  // making the array into a list
	if(!RequirementList.isEmpty()){
	for(Object[]obj1:RequirementList){  // looping over to get the matching data 
	if(al.contains(obj1[0].toString())){  // condition
	%><%=(++j)+". "+obj1[1].toString() +"&nbsp;" %><br> <%}}}}else{ %> <b>No
									requirement linked</b> <%}%>
							</td>
						</tr>
						<tr>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">6</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;">Priority</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;">
								<%if(obj[8]!=null) {%> <%if(obj[5].toString().equalsIgnoreCase("L")){%>Low<%} %>
								<%if(obj[5].toString().equalsIgnoreCase("H")){%>High<%} %> <%if(obj[5].toString().equalsIgnoreCase("M")){%>Medium<%} %>
								<%}else{%>-<%} %>
							</td>
						</tr>
						<tr>
							<td class="border-black"
								style="border: 1px solid black; border-collapse: collapse; padding: 5px; text-align: center; vertical-align: top;">7</td>
							<td class="border-black"
								style="border: 1px solid black; border-collapse: collapse; padding: 5px; text-align: left; vertical-align: top;">Description</td>
							<td class="border-black"
								style="padding: 5px; text-align: justify; border: 1px solid black; border-collapse: collapse; vertical-align: top;">
								<%if(obj[4]!=null){ %> <%=obj[4].toString() %> <%}else{ %>-<%} %>
							</td>
						</tr>
						<tr>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse; vertical-align: top;">8</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse; vertical-align: top;">Constraints</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse; vertical-align: top;">
								<%if(obj[9]!=null){ %> <%=obj[9].toString() %> <%}else{ %>-<%} %>
							</td>
						</tr>
						<tr>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">9</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;">Method
								of Testing</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;">&nbsp;&nbsp;-&nbsp;&nbsp;</td>
						</tr>
						<tr>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">10</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;">Remarks</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;">
								<%if(obj[7]!=null){ %> <%=obj[7].toString() %> <%}else{ %>-<%} %>
							</td>
						</tr>
						<tr>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">11</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;">Linked
								Documents</td>
							<td class="border-black"
								style="padding: 5px; text-align: left; border: 1px solid black; border-collapse: collapse;">
								<%if(obj[11]!=null && !obj[11].toString().equalsIgnoreCase("")){
	 int number=0;
	 String linkedDoc=obj[11].toString();
	 String linkeddoc[]=linkedDoc.split(",");
	 List al=Arrays.asList(linkeddoc);
	 if(!RequirementFiles.isEmpty()){
	 for(Object[]obj1:RequirementFiles){
	 if(al.contains(obj1[0].toString())){
				String []versiondoc=obj1[6].toString().split("\\.");
				String id=versiondoc[0];
				String subId=versiondoc[1];
	 %> <%=++number+". "%> <a style="font-size: 13px;" target="_blank"
								href="<%=path %>ProjectRequirementAttachmentDownload.htm?DocumentId=<%=obj1[8].toString()%>&initiationid=<%=obj1[1].toString() %>&stepid=<%=1%>&id=<%=id %>&subId=<%=subId%> ">View
									Document</a>&nbsp;&nbsp; <span> <%=obj1[4].toString() %>(Ver
									- <%=obj1[6].toString() %> )
							</span><br> <%}}}}else{ %> <b>No documents Linked</b> <%}%>
							</td>
						</tr>
					</tbody>
				</table>
				<%}}else {%>
				<div align="center" style="margin-top: 350px">
					<h2>No Data Available !</h2>
				</div>
				<%} }%>
				<%if(!OtherRequirements.isEmpty()){ %>
				<div style="page-break-before: always"></div>
				<div align="center">
					<h1 style="font-size: 20px !important; color:;"
						class="heading-color">
						<br><%=++maincount %>.&nbsp;Other System Requirements
					</h1>
					<hr style="width: 80%;">
				</div>
				<%int i=0;
	if(!OtherRequirements.isEmpty()){
	for(Object[]obj:OtherRequirements){%>
				<div>
					<%if(obj[2].toString().equalsIgnoreCase("0")) {%><h4
						style="margin-left: 10px;"><%=maincount+"."+(++i)+". "+obj[3].toString()%></h4>
					<div>
						<%if(obj[4]!=null){ %><%=obj[4].toString()%>
						<%}else{ %><p style="text-align: center;">-&nbsp;&nbsp;No
							details filled&nbsp;&nbsp;-</p>
						<%} 
	int j=0;%>
					</div>
					<%for(Object[]obj1:OtherRequirements){ 
	if(obj[0].toString().equalsIgnoreCase(obj1[2].toString())){%>
					<h5 style="margin-left: 20px;"><%="3."+i+"."+ ++j +". "+obj1[3].toString() %></h5>
					<%if(obj1[4]!=null){ %><div id="tablediv"><%=obj1[4].toString()%></div>
					<%}else{ %>
					<p style="text-align: center;">-&nbsp;&nbsp;No details
						filled&nbsp;&nbsp;-</p>
					<%} %>
					<%} %>
					<%}}%>
				</div>
				<%}}else{ %>
				<div style="margin-top: 300px" align="center">
					<h2>No Data Available !</h2>
				</div>
				<%}} %>
				<%if(RequirementList!=null && ParaDetails!=null && !ParaDetails.isEmpty()&&!RequirementList.isEmpty()) {%>
				<div style="page-break-before: always"></div>
				<div align="center">
					<h1 style="font-size: 16px !important; margin-left: 50px;"
						class="heading-color">
						<br><%=++maincount %>. Traceability
					</h1>
				</div>
				<div align="left">
					<h1
						style="font-size: 15px !important; font-weight: 400; margin-left: 50px;"
						class="heading-color">
						<br>4.1 Forward Traceability Matrix
					</h1>
				</div>
				<table class="border-black"
					style="width: 550px; margin-left: 50px; margin-top: 10px; margin-bottom: 5px;">
					<thead>
						<tr>
							<th class="border-black"
								style="width: 20px; padding: 5px; border: 1px solid black; border-collapse: collapse;">SN</th>
							<th class="border-black"
								style="width: 130px; padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">ReqID</th>
							<th class="border-black"
								style="width: 180px; padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">QR
								Para No</th>
							<th class="border-black"
								style="width: 150px; border: 1px solid black; border-collapse: collapse;">Remarks</th>
							<!-- <th class="border-black"style="padding:5px;">Remarks</th> -->
						</tr>
					</thead>
					<tbody>
						<%int count=0;
		for(Object[]obj:RequirementList){%>
						<tr>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++count %></td>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;"><%=obj[1].toString() %></td>
							<td class=""
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">
								<%if(obj[12]!=null && !ParaDetails.isEmpty()&&obj[12].toString().length()>0) {
		int coutPara=0;
		String linkedPara[]=obj[12].toString().split(",");
		List<String>paralist=Arrays.asList(linkedPara);
		for(Object[]para:ParaDetails){
		if(paralist.contains(para[0].toString())){
		%>
								<div align="left">
									<span><%=++coutPara +". "%></span><span style="padding: 3px;"><%=para[3].toString() %></span>
								</div> <%}}} else{%>
								<div align="center">-</div> <%} %>
							</td>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;"><div
									align="center">-</div></td>
						</tr>
						<%} %>
					</tbody>
				</table>
				<div align="left">
					<h1
						style="font-size: 15px !important; font-weight: 400; margin-left: 50px;"
						class="heading-color">
						<br>4.2 Reverse Traceability Matrix
					</h1>
				</div>
				<table class="border-black"
					style="width: 550px; margin-left: 50px; margin-top: 10px; margin-bottom: 5px;">
					<thead>
						<tr>
							<th class="border-black"
								style="width: 20px; padding: 5px; border: 1px solid black; border-collapse: collapse;">SN</th>
							<th class="border-black"
								style="width: 130px; padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">QR
								Para No</th>
							<th class="border-black"
								style="width: 180px; padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">ReqID</th>
							<th class="border-black"
								style="width: 150px; border: 1px solid black; border-collapse: collapse;">Remarks</th>
						</tr>
					</thead>
					<tbody>
						<%int count1=0;
	if(!ParaDetails.isEmpty()) 
	for(Object[]obj:ParaDetails){
		int reqCount=0;%>
						<tr>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++count1 %></td>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;"><%=obj[3].toString() %></td>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">
								<%
		for(Object[]obj1:RequirementList) {
		if(obj1[12]!=null){
		String linkedPara[]=obj1[12].toString().split(",");
		List<String>paralist=Arrays.asList(linkedPara);
		if(paralist.contains(obj[0].toString())){
		%>
								<div><%=(++reqCount)+". "+obj1[1].toString() %></div> <%}}}%> <%if(reqCount==0) {%>-<%} %>
							</td>
							<td class="border-black"
								style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">-</td>
						</tr>
						<%}%>
					</tbody>
				</table>
				<%}%>
				<div align="center">
					<h1 style="font-size: 16px !important; margin-left: 50px;"
						class="heading-color">
						<br><%=++maincount %>. Verification Provisions
					</h1>
				</div>
				<%if(!Verifications.isEmpty()) {
				int verificationCount=0;
				for(Object[]obj:Verifications){
				%>
			<div style="margin-left: 20px; margin-top: 15px; font-weight: 600">
		   <span><%=maincount+"."+(++verificationCount)%>&nbsp;&nbsp;.
			<%=obj[1].toString() %></span>
			</div>
				<div>
				<%if(obj[3]!=null){ %><%=obj[3].toString()%>
				<%}else{ %><p style="text-align: center;">-&nbsp;&nbsp;No
					details filled&nbsp;&nbsp;-</p>
						<%}%>
					</div>
			
				<%}} %>
				
				<table class="border-black"
					style="width: 650px; margin-top: 10px; margin-bottom: 5px;">
					<thead>
						<tr>
							<th class="border-black"
								style="width: 20px; padding: 5px; border: 1px solid black; border-collapse: collapse;">SN</th>
							<th class="border-black"
								style="width: 130px; padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">Verification
								Method</th>
							<th class="border-black"
								style="padding: 5px; border: 1px solid black; border-collapse: collapse;">Type
								of Test</th>
							<th class="border-black"
								style="padding: 5px; border: 1px solid black; border-collapse: collapse;">Purpose</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">1.</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">Demonstration</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">
								<div>D1.Sorties with DGPS Instrumented Aircraft</div>
								<div>D2.Sorties</div>
								<div>&nbsp;&nbsp;a) Aircraft</div>
								<div>&nbsp;&nbsp;b) Helicopter</div>
								<div>D3.Opportune targets</div>
								<div>D4.Ballon Sortie</div>
								<div>D5.Sorties with ECCM Exercise</div>
								<div>D6.Data communication within system and between
									system</div>
								<div>D7.Maintainability</div>
								<div>D8.Roadability</div>
							</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">
								Detection Range, System Accuracy , System Resolution , Angular
								Coverage capability, Detected Target RCS, Manoeuvring Target
								Tracking ECCM capability and other performance and functional
								capabilities , measuring of mean time to replace LRUs(MTTR)
								except for mechanical assemblies, mother boards , TWT, Drivers
								and so on, Mobility of the vehicle along with the system during
								transportaion</td>
						</tr>
						<tr>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">2.</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">TEST</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">
								<div>T1.RF BITE</div>
								<div>T2.Field BITE</div>
								<div>T3.Radar Environment Simulator(RES)</div>
								<div>T4.HMI Tests</div>
								<div>T5.ECCM Test with noise Jammer</div>
								<div>T6.Built IN Self Test(BIST)</div>
							</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">
								System MDS level,Revisit Time, Target Sampling Rate , Multi-Beam
								Test, System sensitivity, Range Velocity coverage, side lobe
								blanking , Probability of Detection etc should be proven</td>
						</tr>
						<tr>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">3.</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">Design
								/ Analysis</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">
								<div>A1. Design Analysis</div>
								<div>A2. Data recording & Analysis for S/W & F/W</div>
								<div>A3. Design Calculations and Analysis</div>
								<div>A4. Reliability Availability Maintainability (RAM)
									analysis</div>
							</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">
								Track capacity, System Reliability, System Maintainability,
								System Availability</td>
						</tr>
						<tr>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">4.</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">Inspection</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">
								<div>I1.Visual Examination</div>
								<div>I2.Mechanical Inspection</div>
							</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">
								Visual check for correctness of item and workmanship defects
								/physical damages , Mechanical checks for paint quality
								dimensions, weight</td>
						</tr>
						<tr>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">5.</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">Special
								Verification Methods</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">
								<div>S1.HASS Test</div>
								<div>S2.ESS Test</div>
								<div>S3.EMI-EMC Test</div>
								<div>S4.ATP</div>
								<div>S5.QTP Test</div>
								<div>S6.Calibration</div>
							</td>
							<td
								style="border: 1px solid black; vertical-align: top; padding: 3px">
								HASS/ESS to remove infant mortal failures , EMI /EMC com</td>
						</tr>
					</tbody>
				</table>

			</div>
		</div>
</body>
</html>