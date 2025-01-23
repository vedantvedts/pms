<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.util.stream.Collectors"%>
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
<spring:url value="/resources/css/sweetalert2.min.css" var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
<!DOCTYPE html>
<html>
<head>
	<link href="${sweetalertCss}" rel="stylesheet" />
	<script src="${sweetalertJs}"></script>
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
 /* 	 $( document ).ready(function() {
		 download();
		}); */ 
	/* 	 function download(){
			$("#source-html").wordExport("System-Requirement");
			window.close();
	 } */
</script>
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
<meta charset="ISO-8859-1">
<title>Requirement Document</title>
 <style>
        /* Loading spinner styling */
        #loading {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 18px;
            color: #333;
        }
           @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    </style>
	</head>		
	<body >
	
<div id="loadingOverlay" style="display: flex; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999; justify-content: center; align-items: center; flex-direction: column; color: white; font-size: 20px; font-weight: bold;">
    <div class="spinner" style="border: 4px solid rgba(255, 255, 255, 0.3); border-top: 4px solid white; border-radius: 50%; width: 40px; height: 40px; animation: spin 1s linear infinite; margin-bottom: 10px;"></div>
    Please wait while we are generating the PDF...
</div>
		<button onclick="generatePDF()" id="generatePDF" style="background: none;border: none;"></button>
		<div style="display: none">
			<div id="verification">
				<table>
					<tbody>
						 <%
						 Object[]LabList=(Object[])request.getAttribute("LabList");
						 List<Object[]> VerificationDataList=(List<Object[]>)request.getAttribute("VerificationDataList");
						 Map<String, List<Object[]>> verificationDataListMap = VerificationDataList!=null && VerificationDataList.size()>0?VerificationDataList.stream()
								  											.collect(Collectors.groupingBy(array -> array[1] + "", LinkedHashMap::new, Collectors.toList())) : new HashMap<>();
						 String lablogo=(String)request.getAttribute("lablogo");
						 String drdologo=(String)request.getAttribute("drdologo");
						 Object[] DocTempAtrr=(Object[])request.getAttribute("DocTempAttributes");
						 String FontFamily="Times New Roman";
						 
						 if(DocTempAtrr!=null && DocTempAtrr[11]!=null){
			                	FontFamily= DocTempAtrr[11].toString();
			                }
						 if(VerificationDataList!=null) {
							 int countSN=0;
							 int SN=0;
							 String data="";
							 int subcount=0;
			                   	for(Object[]obj:VerificationDataList){
			                   	++SN;
	                   		%>
							<tr>
								<td class="border-black">
									<%if(!data.equalsIgnoreCase(obj[2].toString())){ %> <%=++countSN %><%} %>
								</td>
								<td class="border-black">
								   <%if(!data.equalsIgnoreCase(obj[2].toString())){ %> <%=obj[2] %><%} %>
								</td>
								<%if(!data.equalsIgnoreCase(obj[2].toString())){
									subcount=0;
								} %> 
								<td class="border-black"style="padding: 5px; text-align: justify;  border-collapse: collapse;">  <%=obj[2].toString().substring(0,1)+(++subcount)+". "+obj[3] %></td>
								<td class="border-black"style="padding: 5px; text-align: justify;  border-collapse: collapse;"><%=obj[4]%></td>
							</tr>
					 		<%data = obj[2].toString();
	                 		} }%>
					</tbody>
				</table>	
			</div>

			<%List<Object[]>MemberList=(List<Object[]>)request.getAttribute("MemberList"); %>
			<div id="MemberList" style="width: 100% !important;">
				<table style="width: 100% !important; border:1px solid black; border-collapse:collapse;margin: 1rem;"> 
					<thead>
						<tr >
							<th style="width: 15% !important;">SN</th>
							<th style="width: 35% !important;">Name</th>
							<th style="width: 25% !important;">Designation</th>
							<th style="width: 25% !important;">Division/Lab</th>
						</tr>
					</thead>
					<tbody>
           				<% 
						    if (MemberList != null) {
						        int i = 1;
						        for (Object[] mlist : MemberList) {
						%>
							<tr>
								<td style="width: 15% !important;"><%=i++ + "."%></td>
								<td style="width: 35% !important;"><%=mlist[1]%></td>
								<td style="width: 25% !important;"><%=mlist[2]%></td>
								<td style="width: 25% !important;"><%=mlist[3]%></td>
							</tr>
						<% } } %>
					</tbody>
				</table>
			</div>


			<%List<Object[]> DocumentSummary = (List<Object[]>)request.getAttribute("DocumentSummary"); 
			Object[] projectDetails = (Object[])request.getAttribute("projectDetails"); 
			String projectShortName = (String)request.getAttribute("projectShortName");
			String Classification = (String)request.getAttribute("Classification");
			String docnumber = "-";
			String version =(String)request.getAttribute("version");
			
			if(DocumentSummary!=null && DocumentSummary.size()>0) {
				docnumber = "SRD-"+(DocumentSummary.get(0)[11]!=null?DocumentSummary.get(0)[11].toString().replaceAll("-", ""):"-")+"-"+session.getAttribute("labcode")+"-"+((projectDetails!=null && projectDetails[1]!=null)?projectDetails[1]:"")+"-V"+version;
			}
			LocalDate now = LocalDate.now();
			Month month = now.getMonth();
			int year = now.getYear();
			%>
			<div id="docSummary">
				<table style="width: 635px; margin-left:10px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;border-collapse: collapse;">
					<tr>
						<td  class="text-darks" colspan="2" style="border:1px solid black;text-align:left;">1.&nbsp; Title: <span class="text-darks">System Requirements Document for </span></td>
					</tr>
					<tr >
						<td class="text-darks" style="border:1px solid black;">2.&nbsp; Type of Document:<span class="text-darks">System Requirement Document</span></td>
						<td class="text-darks" style="border:1px solid black;">3.&nbsp; Classification: <span class="text-darks"></span></td>
					</tr>
				    <tr >
						<td class="text-darks" style="border:1px solid black;">4.&nbsp; Document Number:</td>
						<td class="text-darks" style="border:1px solid black;">5.&nbsp; Month Year:&nbsp;<span style="font-weight: 600"></span> </td>
					</tr>
					<tr>
						<td class="text-darks" style="border:1px solid black;">6.&nbsp; Number of Pages:  ${totalPages}</td>
						<td class="text-darks" style="border:1px solid black;">7.&nbsp; Related Document:</td>
					</tr>
					<tr>
						<td  class="text-darks" colspan="2" style="border:1px solid black;">8.&nbsp; Additional Information:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[0] %><%} %></span></td>
					</tr>
					<tr>
						<td  class="text-darks" colspan="2" style="border:1px solid black;">9.&nbsp; Project Name: <span class="text-darks"> </span></td>
					</tr>
					<tr>
						<td  class="text-darks" colspan="2" style="border:1px solid black;">10.&nbsp; Abstract:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[1] %><%} %></span>
					</tr>
					<tr>
						<td  class="text-darks" colspan="2" style="border:1px solid black;">11.&nbsp; Keywords:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[2] %><%} %></span> </td>
					</tr>
					<tr>
						<td  class="text-darks" colspan="2" style="border:1px solid black;">12.&nbsp; Organization and address:
							<span class="text-darks" >		
								<%
								if (LabList!=null && LabList[1] != null) {%>
									<%=LabList[1].toString() + "(" + LabList[0].toString() + ")"%>
								<%} else {%>
									-
								<%}%>
								Government of India, Ministry of Defence,Defence
									Research & Development Organization
								<%
									if (LabList!=null && LabList[2] != null && LabList[3] != null && LabList[5] != null) {
								%>
									<%=LabList[2] + " , " + LabList[3].toString() + ", PIN-" + LabList[5].toString()+"."%>
								<%}else{ %>
									-
								<%} %>
							</span>
						</td>
					</tr>
					<tr>
						<td  class="text-darks" colspan="2" style="border:1px solid black; ">13.&nbsp; Distribution:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[3] %><%} %></span></td>
					</tr>
					<tr>
						<td  class="text-darks" colspan="2" style="border:1px solid black; ">14.&nbsp; Revision:</td>
					</tr>
					<tr>
						<td  class="text-darks" colspan="2" style="border:1px solid black;">15.&nbsp; Prepared by:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[10] %><%} %></span></td>
					</tr>
					<tr>
						<td  class="text-darks" colspan="2" style="border:1px solid black; ">16.&nbsp; Reviewed by: <span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[7] %><%} %></span> </td>
					</tr>
					<tr>
						<td  class="text-darks" colspan="2" style="border:1px solid black;">17.&nbsp; Approved by: <span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[6] %><%} %></span> </td>
					</tr>
				</table>
			</div>


			<%List<Object[]>AbbreviationDetails=(List<Object[]>)request.getAttribute("AbbreviationDetails");%>
			<div id="abbreviationDiv">
		
				<h4 style="font-size:16px;text-align: center;"> Abbreviations used in the Manual to be listed and arranged in alphabetical order</h4>
				<%  if (AbbreviationDetails != null && !AbbreviationDetails.isEmpty()) { %>	
    				<table style="margin-left:50px;">
        				<thead>
         					<tr>
						        <th><span >S.No</span></th>
						        <th><span >Abbreviations</span></th>
						        <th><span >Full Forms</span></th>
           					</tr>
        				</thead>
        				<tbody>
                			<% int i = 1;
        					for (Object[] alist : AbbreviationDetails) {
							%>
              					<tr>
					                <td ><%=  i+++"."%></td>
					                <td><%= alist[1] %></td>
					                <td ><%= alist[2] %></td>
            					</tr>
              				<% } %>
     					</tbody>
    				</table>
    			<%} %>
			</div>
		
		
			<!-- Scopediv -->
	
			<%Object[]ReqIntro=(Object[])request.getAttribute("ReqIntro"); %>
			<div id="scopeDiv">
			
				<h2 style="font-size: 16px;margin-top:20px;font-weight: bold">1.1
					&nbsp;System Identification
				</h2>
				<%if(ReqIntro!=null && ReqIntro[1]!=null) {%>
					<%=ReqIntro[1]%>
				<%}else {%>
					Guidance: 
					This paragraph should contain a full identification of the system to which this document applies.  
				<%} %>
				<h2 style="font-size: 16px;margin-top:20px;font-weight: bold">1.2
					&nbsp;System Overview
				</h2>
				<%if(ReqIntro!=null && ReqIntro[3]!=null) {%>
					<%=ReqIntro[3]%>
				<%}else {%>
					Guidance:  
					This paragraph should briefly describe the general nature of the system required. It summarizes the objectives of the system from various perspectives (Operational, Maintenance, Deployment, Technological, Environmental and so on...), should give a brief description of the operating scenario and desired configuration of the system. It should also state the identified project sponsor, acquirer, developer, and support agencies; along with current and planned operating sites.
				<%} %>
		
				<h2 style="font-size: 16px;margin-top:20px;font-weight: bold">1.3
					&nbsp;Document Overview
				</h2>
				<%if(ReqIntro!=null && ReqIntro[4]!=null) {%>
					<%=ReqIntro[4]%>
				<%}else {%>
					This document brings out the system requirements of the radar system. The document gives a brief overview of the system, states the modes of operation of the radar (operational, maintenance, training and so on..) along with types of operational modes. All requirements are classified under various categories and stated in a brief unambiguous manner after resolving all conflicts and identifying derived requirements. The various design and construction constraints imposed on the system either by the User or by the designer are clearly brought out. This document also brings out the precedence and criticality of the requirements. Verification methodologies such as Demonstration /Test / Analysis / Inspection / Special verification methods employed to validate the system requirements are clearly listed. This document also contains a tabularized verification matrix for every system requirement, Requirements Traceability matrix and states the key performance parameters/key system attributes. 
				<%} %>
			</div>
		
		
			<!--Req Div  -->
			<div id="reqDiv">
				<%	List<Object[]>RequirementList=(List<Object[]>)request.getAttribute("RequirementList");
					List<Object[]>ProjectParaDetails=(List<Object[]>)request.getAttribute("ProjectParaDetails");
				%>
				<%if(!RequirementList.isEmpty()) {
					List<Object[]> mainReqList = RequirementList.stream()
												.filter(e->e[15]!=null && e[15].toString().equalsIgnoreCase("0"))
												.sorted(Comparator.comparing(k -> Integer.parseInt(k[14].toString())))
												.collect(Collectors.toList());
					int mainReqCount=0;
					for(Object[]obj:mainReqList){
				%>
						<div style="padding:none;"><h2  class="heading-colors" style="font-size: 16px;"> <%="2."+(++mainReqCount) %> &nbsp;<%=obj[3].toString() %></h2></div>
						<%if(obj[4]!=null) {%>
							<div style="padding:0px;" class="heading-colors"><%=obj[4].toString()%></div>
						<%}else{ %>
							<span></span>
						<%} %>
				<% List<Object[]> subMainReqList =  RequirementList.stream()
													.filter(e->e[15]!=null&&e[15].toString().equalsIgnoreCase(obj[0].toString()))
													.sorted(Comparator.comparing(k -> Integer.parseInt(k[14].toString())))
													.collect(Collectors.toList());%>
				<%
				String ReqName="";
				int subReqCount=0;
				for(Object[]obj1:subMainReqList) {
					int snCount=0;
				%>
					<%if(!ReqName.equalsIgnoreCase(obj1[3].toString()) && !obj1[3].toString().equalsIgnoreCase(obj[3].toString())) {%>
						<h3 class="heading-colors" style="font-size: 15px;"><%="2."+(mainReqCount)+"."+(++subReqCount)%>&nbsp;<%=obj1[3].toString() %></h3>
					<%} %> 
	
					<table class="border-black" style="margin-left: 10px;margin-top:7px;width: 635px;margin-right:20px; margin-bottom: 5px;">
						<thead>
							<tr class="border-black">
								<th class="border-black"
									style="width: 20px;  border: 1px solid black;text-align:center; border-collapse: collapse;">SN</th>
								<th class="border-black"
									style="width: 130px;  text-align: center; border: 1px solid black; border-collapse: collapse;">Attribute</th>
								<th class="border-black"
									style=" border: 1px solid black; border-collapse: collapse;">Content</th>
							</tr>
							</thead>
							<tbody>
								<tr class="border-black">
									<td class="border-black"
										style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %></td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse; font-weight: 600;">ID</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;"><%=obj1[1].toString() %></td>
								</tr>
								<tr class="border-black">
									<td class="border-black"
										style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %>.</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse; font-weight: 600;"> QR Para </td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;">
									
										<%if(obj1[12]!=null) {
											String [] a=obj1[12].toString().split(", ");
											for(String s:a){
										%> 
									
											<%=ProjectParaDetails.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[3].toString()).collect(Collectors.joining("")) %> <br>
										<%}}else{ %>
											-
										<%} %>
									
									</td>
								</tr>
							
								<tr>
									<td class="border-black"
										style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %>.</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse; font-weight: 600;">Priority</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;">
										<%if(obj1[5]!=null) {%> <%=obj1[5].toString() %>
										<%}else{%>-<%} %>
									</td>
								</tr>
							
								<tr>
									<td class="border-black"
										style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %>.</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse; font-weight: 600;">Criticality</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;">
										<%if(obj1[21]!=null) {%> <%=obj1[21].toString() %>
										<%}else{%>-<%} %>
									</td>
								</tr>
								<tr>
									<td class="border-black"
										style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %>.</td>
									<td class="border-black"
										style=" text-align: left; font-weight: 600; border: 1px solid black; border-collapse: collapse;">Type</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;">
										<%if(obj1[6]!=null) {%> <%if(obj1[6].toString().equalsIgnoreCase("D")) {%>Desirable<%} %>
										<%if(obj1[6].toString().equalsIgnoreCase("E")) {%>Essential<%} %> <%}else {%>-<%} %>
									</td>
								</tr>
								<%-- <tr>
									<td class="border-black"
										style="border: 1px solid black; border-collapse: collapse;  text-align: center; vertical-align: top;" ><%=++snCount %>.</td>
									<td class="border-black"
										style="border: 1px solid black; border-collapse: collapse;  text-align: left; vertical-align: top;font-weight: 600;"colspan="2">Description</td>
									<td class="border-black"
										style="text-align: justify; border: 1px solid black; border-collapse: collapse; vertical-align: top;">
										<%if(obj1[4]!=null){ %> <%=obj1[4].toString() %> <%}else{ %>-<%} %>
									</td>
								</tr> --%>
								<tr>
									<td class="border-black" colspan="3" style="text-align: justify; border: 1px solid black; border-collapse: collapse; vertical-align: top;">
										<div id="description<%=mainReqCount+"."+subReqCount %>">
											<%=++snCount %> .Description: <%if(obj1[4]!=null){ %> <%=obj1[4].toString() %> <%}else{ %>-<%} %>
										</div>
									</td>
								</tr>
								<tr>
									<td class="border-black"
										style="border: 1px solid black; border-collapse: collapse;  text-align: center; vertical-align: top;"><%=++snCount %>.</td>
									<td class="border-black"
										style="border: 1px solid black; border-collapse: collapse;  text-align: left; vertical-align: top;font-weight: 600;">Remarks</td>
									<td class="border-black"
										style="text-align: justify; border: 1px solid black; border-collapse: collapse; vertical-align: top;">
										<%if(obj1[7]!=null){ %> <%=obj1[7].toString() %> <%}else{ %>-<%} %>
									</td>
								</tr>
								<tr>
									<td class="border-black"
										style="border: 1px solid black; border-collapse: collapse;  text-align: center; vertical-align: top;"><%=++snCount %>.</td>
									<td class="border-black"
										style="border: 1px solid black; border-collapse: collapse;  text-align: left; vertical-align: top;font-weight: 600;">Constraints</td>
									<td class="border-black"
										style="text-align: justify; border: 1px solid black; border-collapse: collapse; vertical-align: top;">
										<%if(obj1[9]!=null){ %> <%=obj1[9].toString() %> <%}else{ %>-<%} %>
									</td>
								</tr>
								<tr>
									<td class="border-black"
										style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %>.</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;font-weight: 600;">Demonstration</td>
										<td class="border-black" style=" text-align: left; border: 1px solid black; border-collapse: collapse;">
										
										<%if(obj1[16]!=null) {
										List<Object[]>DemonList=VerificationDataList.stream().filter(e->e[1].toString().equalsIgnoreCase("1")).collect(Collectors.toList());
										String [] a=obj1[16].toString().split(", ");
										for(int i=0;i<a.length;i++){
										%>
										
										<%=	a[i] +" . "+ DemonList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>
										<%} %>
										<%}else{%>-<%} %>
									   
									</td>
								</tr>
							
								<tr>
									<td class="border-black"
										style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %>.</td>
									<td class="border-black"
										style="text-align: left; border: 1px solid black; border-collapse: collapse;font-weight: 600;">Test</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;">
										<%if(obj1[17]!=null) {
											List<Object[]>TestList=VerificationDataList.stream().filter(e->e[1].toString().equalsIgnoreCase("2")).collect(Collectors.toList());
											String [] a=obj1[17].toString().split(", ");
											for(int i=0;i<a.length;i++){
												%>
												
												<%=	a[i] +" . "+ TestList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>
												<%} %>
												<%}else{%>-<%} %>
									</td>
								</tr>
							
								<tr>
									<td class="border-black"
										style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %>.</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;font-weight: 600;">Design/Analysis</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;">
										<%if(obj1[18]!=null) {
											List<Object[]>AnalysisList=VerificationDataList.stream().filter(e->e[1].toString().equalsIgnoreCase("3")).collect(Collectors.toList());
											String [] a=obj1[18].toString().split(", ");
											for(int i=0;i<a.length;i++){
												%>
												
												<%=	a[i] +" . "+ AnalysisList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>
												<%} %>
												<%}else{%>-<%} %>
									</td>
								</tr>
							
								<tr>
									<td class="border-black"
										style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %>.</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;font-weight: 600;">Inspection</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;">
										<%if(obj1[19]!=null) {
											List<Object[]>InspectionList=VerificationDataList.stream().filter(e->e[1].toString().equalsIgnoreCase("4")).collect(Collectors.toList());
											String [] a=obj1[19].toString().split(", ");
										for(int i=0;i<a.length;i++){
												%>
												
												<%=	a[i] +" . "+ InspectionList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>
												<%} %>
												<%}else{%>-<%} %>
									</td>
								</tr>
							
							
								<tr>
									<td class="border-black"
										style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %>.</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;font-weight: 600;">Special Methods</td>
									<td class="border-black"
										style=" text-align: left; border: 1px solid black; border-collapse: collapse;">
										<%if(obj1[20]!=null) {
											List<Object[]>specialList=VerificationDataList.stream().filter(e->e[1].toString().equalsIgnoreCase("5")).collect(Collectors.toList());
											String [] a=obj1[20].toString().split(", ");
											for(int i=0;i<a.length;i++){
												%>
												
												<%=	a[i] +" . "+ specialList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>
												<%} %>
												<%}else{%>-<%} %>
									</td>
								</tr>
							</tbody>
						
						</table>
	
				<%
				ReqName=obj1[3].toString();
				} %>
				<%}%>
	
				<%
				List<Object[]>nonMainReqList=RequirementList.stream().filter(e->e[15]!=null&&!e[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
				%>
				<%if(nonMainReqList!=null && !nonMainReqList.isEmpty()) { %>
					<div style="padding:none;"><h2 class="heading-colors" style="font-size: 16px;"><%="2."+(++mainReqCount) %>  &nbsp; Precedence and Criticality of Requirements</h2></div>
						<table class="border-black"style="margin-left: 20px;;width: 400px; margin-bottom: 5px;">
							<thead>
								<tr>
									<th class="border-black"style="width: 10px;  border: 1px solid black; border-collapse: collapse;">SN</th>
									<th class="border-black"style="width: 150px;  text-align: center; border: 1px solid black; border-collapse: collapse;">Requirement ID</th>
									<th class="border-black"style="width: 60px; border: 1px solid black; border-collapse: collapse;">Priority</th>
									<th class="border-black"style="width: 60px; border: 1px solid black; border-collapse: collapse;">Criticality</th>
								
								</tr>
							</thead>
							<tbody>
								<%int rcount=0;
								for(Object[]obj:nonMainReqList) {
								if(obj[21]!=null){
								%>
									<tr>
										<td style="text-align:center;border: 1px solid black; border-collapse: collapse;"><%=++rcount %></td>
										<td class="border-black" style="text-align:justify;border: 1px solid black; border-collapse: collapse;"><%=obj[1] %></td>
										<td class="border-black" style="text-align:center;border: 1px solid black; border-collapse: collapse;"><%if(obj[5]!=null) {%><%=obj[5].toString()%><%}else{ %>-<%} %></td>
										<td class="border-black" style="text-align:center;border: 1px solid black; border-collapse: collapse;"><%if(obj[21]!=null) {%> <%=obj[21].toString() %>
											<%}else{%>-<%} %>
										</td>
									</tr>
								<%}} %>
							</tbody>
						</table>
					<% } %>
	
				<%} %>
			</div>
		
		
			<%List<Object[]>Verifications=(List<Object[]>)request.getAttribute("Verifications");
			List<Object[]>productTreeList=(List<Object[]>)request.getAttribute("productTreeList");
			%>
			<div id="verificationDiv">
				<%if(Verifications!= null &&   !Verifications.isEmpty()) {
					int verificationCount=1;
					int j=0;
					for(Object[]obj:Verifications){
				%>
					<h3 class="heading-colors" style="font-size: 16px; ">
				   		<%="3"+"."+(verificationCount)%>.<%=++j %>
						<%=obj[1] %>
					</h3>
					<%if(obj[3]!=null){ %>
						<%=obj[3].toString()%>
					<%}else{ %>
						<p style="text-align: center;">-&nbsp;&nbsp;No details filled&nbsp;&nbsp;-</p>
					<%}%>
				<%}} %>
			</div>
			</div>
	<%
		List<Object[]> ParaDetails = (List<Object[]>)request.getAttribute("ParaDetails");
		List<Object[]> AcronymsList = (List<Object[]>)request.getAttribute("AcronymsList");
		List<Object[]> PerformanceList = (List<Object[]>)request.getAttribute("PerformanceList");
		String isPdf = (String)request.getAttribute("isPdf");
	%>		

<script>
    function generatePDF() {
       document.getElementById('loadingOverlay').style.display = 'flex';;
      
        	try {
	
        var chapterCount = 0;
        var mainContentCount = 0;
        var leftSideNote = '<%if(DocTempAtrr!=null && DocTempAtrr[12]!=null) {%><%=DocTempAtrr[12].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%} else{%>-<%}%>';
		
        var docDefinition = {
            content: [
                // Cover Page with Project Name and Logo
                {
                    text: htmlToPdfmake('<h4 class="heading-color ">SYSTEM REQUIREMENTS <br><br> FOR  <br><br>PROJECT <%=projectShortName %> </h4>'),
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
                
                /* ************************************** Distribution List *********************************** */ 
                {
                    text: 'Distribution List',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before',
                    alignment: 'center'
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['15%', '35%', '25%', '25%'],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader' },
                                { text: 'Name', style: 'tableHeader' },
                                { text: 'Designation', style: 'tableHeader' },
                                { text: 'Division/Lab', style: 'tableHeader' }
                            ],
                            // Populate table rows
                            <% if (MemberList != null && MemberList.size()>0) { %>
	                            <% int slno = 0; for (Object[] obj : MemberList) { %>
	                            [
	                                { text: '<%= ++slno %>', style: 'tableData',alignment: 'center' },
	                                { text: '<%= obj[1] %>', style: 'tableData' },
	                                { text: '<%= obj[2] %>', style: 'tableData' },
	                                { text: '<%= obj[3] %>', style: 'tableData',alignment: 'center' }
	                            ],
	                            <% } %>
                            <% } else{%>
                            	[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 4 },]
                            <%} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                /* ************************************** Distribution List End*********************************** */
                
                /* ************************************** Document Summary *********************************** */
                {
                    text: 'Document Summary',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['10%', '30%', '60%'],
                        body: [
                            <% int docsn = 0; %>
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Title', style: 'tableData' },
                                { text: 'System Requirements Document for <%=projectShortName %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Type of Document', style: 'tableData' },
                                { text: 'System Requirement Document', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Classification', style: 'tableData' },
                                { text: '<%=Classification %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Document Number', style: 'tableData' },
                                { text: '<%if(docnumber!=null) {%><%=docnumber %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Month Year', style: 'tableData' },
                                { text: '<%=month.toString().substring(0,3) %> <%= year %>', style: 'tableData' },
                            ],
                            
                            /* [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Number of Pages', style: 'tableData' },
                                { text: '', style: 'tableData' },
                            ], */
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Related Document', style: 'tableData' },
                                { text: '', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Additional Information', style: 'tableData' },
                                { text: '<% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[0] %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Project Name', style: 'tableData' },
                                { text: '<%=projectShortName %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Abstract', style: 'tableData' },
                                { text: '<% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[1] %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Keywords', style: 'tableData' },
                                { text: '<% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[2] %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Organization and address', style: 'tableData' },
                                { text: '<% if (LabList!=null && LabList[1] != null) {%> <%=LabList[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "").replaceAll("\r", "") + "(" + LabList[0].toString() + ")"%> <%} else {%> - <%}%>'
										+'Government of India, Ministry of Defence,Defence Research & Development Organization'
								+'<% if (LabList!=null && LabList[2] != null && LabList[3] != null && LabList[5] != null) { %>'
									+'<%=LabList[2] + " , " + LabList[3].toString() + ", PIN-" + LabList[5].toString()+"."%>'
								+'<%}else{ %> - <%} %>' , style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Distribution', style: 'tableData' },
                                { text: '<% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[3] %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Revision', style: 'tableData' },
                                { text: '<%=version!=null ?version:"-" %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Prepared by', style: 'tableData' },
                                { text: '<% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[10] %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Reviewed by', style: 'tableData' },
                                { text: '<% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[7] %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Approved by', style: 'tableData' },
                                { text: '<% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[6] %><%} %>', style: 'tableData' },
                            ],

                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
			
                /* htmlToPdfmake(docSummary), */
                /* ************************************** Document Summary End *********************************** */
                
                /* ************************************** Abbreviation *********************************** */
                {
                    text: 'Abbreviation',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before',
                    alignment: 'center'
                },
                {
                	text: 'Abbreviations used in the Manual to be listed and arranged in alphabetical order',	
                	style: 'chapterNote',
                    alignment: 'center'
                },
		
                {
                    table: {
                        headerRows: 1,
                        widths: ['20%', '30%', '50%'],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader' },
                                { text: 'Abbreviations', style: 'tableHeader' },
                                { text: 'Full Forms', style: 'tableHeader' },
                            ],
                            // Populate table rows
                            <% if (AbbreviationDetails != null && AbbreviationDetails.size()>0) { %>
		                        <% int slno = 0; for (Object[] obj : AbbreviationDetails) { %>
		                            [
		                                { text: '<%= ++slno %>', style: 'tableData',alignment: 'center' },
		                                { text: '<%= obj[1] %>', style: 'tableData',alignment: 'center' },
		                                { text: '<%= obj[2] %>', style: 'tableData' },
		                            ],
		                        <% } %>
                            <% } else{%>
                            	[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 3 },]
                            <%} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                /* htmlToPdfmake(abbreviationDiv), */
                /* ************************************** Abbreviation End *********************************** */
                
                /* ************************************** Scope *********************************** */
                {
                    text: (++mainContentCount)+'. Scope',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                
                {
                	text: (mainContentCount)+'.1. System Identification',	
                	style: 'chapterSubHeader',
                    tocItem: true,
                    id: 'chapter'+(chapterCount)+'.'+mainContentCount+'.1',
                    tocMargin: [10, 0, 0, 0],
                },
                {
                	stack: [htmlToPdfmake(setImagesWidth('<%if(ReqIntro!=null && ReqIntro[1]!=null) {%><%=ReqIntro[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "")%>'
                		  +'<%}else {%> Guidance: This paragraph should contain a full identification of the system to which this document applies. <%} %>', 600))],
                    margin: [10, 0, 0, 0],
                },
                {
                	text: (mainContentCount)+'.2. System Overview',	
                	style: 'chapterSubHeader',
                    tocItem: true,
                    id: 'chapter'+(chapterCount)+'.'+mainContentCount+'.2',
                    tocMargin: [10, 0, 0, 0],
                },
                {
                	stack: [htmlToPdfmake(setImagesWidth('<%if(ReqIntro!=null && ReqIntro[3]!=null) {%> <%=ReqIntro[3].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "")%>'
                		  +'<%}else {%> Guidance: This paragraph should briefly describe the general nature of the system required. It summarizes the objectives of the system from various perspectives (Operational, Maintenance, Deployment, Technological, Environmental and so on...), should give a brief description of the operating scenario and desired configuration of the system. It should also state the identified project sponsor, acquirer, developer, and support agencies; along with current and planned operating sites. <%} %>', 600))],
                    margin: [10, 0, 0, 0],
                },
                {
                	text: (mainContentCount)+'.3. Document Overview',	
                	style: 'chapterSubHeader',
                    tocItem: true,
                    id: 'chapter'+(chapterCount)+'.'+mainContentCount+'.3',
                    tocMargin: [10, 0, 0, 0],
                },
                {
                	stack: [htmlToPdfmake(setImagesWidth('<%if(ReqIntro!=null && ReqIntro[4]!=null) {%> <%=ReqIntro[4].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "")%>'
                		  +'<%}else {%> This document brings out the system requirements of the radar system. The document gives a brief overview of the system, states the modes of operation of the radar (operational, maintenance, training and so on..) along with types of operational modes. All requirements are classified under various categories and stated in a brief unambiguous manner after resolving all conflicts and identifying derived requirements. The various design and construction constraints imposed on the system either by the User or by the designer are clearly brought out. This document also brings out the precedence and criticality of the requirements. Verification methodologies such as Demonstration /Test / Analysis / Inspection / Special verification methods employed to validate the system requirements are clearly listed. This document also contains a tabularized verification matrix for every system requirement, Requirements Traceability matrix and states the key performance parameters/key system attributes. <%} %>', 600))],
                    margin: [10, 0, 0, 0],
                },
			
                /* htmlToPdfmake(scopeDiv), */
                /* ************************************** Scope End *********************************** */
                
                /* ************************************** Requirements *********************************** */
                {
                    text: (++mainContentCount)+'. Requirements',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                

   				<%if(!RequirementList.isEmpty()) {
   					List<Object[]> mainReqList = RequirementList.stream()
					   							.filter(e->e[15]!=null && e[15].toString().equalsIgnoreCase("0"))
					   							.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
					   							.collect(Collectors.toList());
   					int mainReqCount=0;
   					for(Object[]obj:mainReqList){
   				%>
	   				{
	                	text: (mainContentCount)+'.<%=++mainReqCount %>. <%=obj[3] %>',	
	                	style: 'chapterSubHeader',
	                    tocItem: true,
	                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.<%=mainReqCount %>',
	                    tocMargin: [10, 0, 0, 0],
	                },
					<%if(obj[4]!=null) {%>
						{
		                	stack: [htmlToPdfmake(setImagesWidth('<%if(obj[4]!=null){ %> <%=obj[4].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%}else{ %>-<%} %>', 500))],	
		                    margin: [10, 5, 5, 5],
		                },

					<%} %>
    				<% List<Object[]> subMainReqList =  RequirementList.stream()
									    				.filter(e->e[15]!=null&&e[15].toString().equalsIgnoreCase(obj[0].toString()))
									    				.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
									    				.collect(Collectors.toList());%>
    				<%
    				String ReqName="";
    				int subReqCount=0;
    				for(Object[]obj1:subMainReqList) {
    					int snCount=0;
    				%>
    					<%if(!ReqName.equalsIgnoreCase(obj1[3].toString()) && !obj1[3].toString().equalsIgnoreCase(obj[3].toString())) {%>
	    					{
			                	text: (mainContentCount)+'.<%=mainReqCount+"."+(++subReqCount)%>. <%=obj1[3].toString() %>',	
			                    tocItem: true,
			                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.<%=mainReqCount+"."+(subReqCount) %>',
			                    style: 'chapterSubSubHeader',
			                    tocMargin: [20, 0, 0, 0],
			                },
    					<%} %> 

    					{
    	                    table: {
    	                        headerRows: 1,
    	                        widths: ['20%', '30%', '50%'],
    	                        body: [
    	                            // Table header
    	                            [
    	                                { text: 'SN', style: 'tableHeader' },
    	                                { text: 'Attribute', style: 'tableHeader' },
    	                                { text: 'Content', style: 'tableHeader' },
    	                            ],
    	                            // Populate table rows

    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'ID', style: 'tableData' },
    	                                { text: '<%=obj1[1] %><%=obj1[25]!=null&&obj1[25].toString().equalsIgnoreCase("Y") ? "  (D)":"" %>', style: 'tableData' },
    	                            ],

    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'QR Para', style: 'tableData' },
    	                                { text: '<%if(obj1[12]!=null) { String [] a=obj1[12].toString().split(", "); for(String s:a){ %> <%=ProjectParaDetails.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[3].toString()).collect(Collectors.joining("")) %> \n <%}}else{ %> - <%} %>', style: 'tableData' },
    	                            ],
    	                            
    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Priority', style: 'tableData' },
    	                                { text: '<%if(obj1[5]!=null) {%> <%=obj1[5] %> <%}else{%>-<%} %>', style: 'tableData' },
    	                            ],
    	                            
    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Criticality', style: 'tableData' },
    	                                { text: '<%if(obj1[21]!=null) {%> <%=obj1[21] %> <%}else{%>-<%} %>', style: 'tableData' },
    	                            ],
    	                            
    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Type', style: 'tableData' },
    	                                { text: '<%if(obj1[6]!=null) {%> <%if(obj1[6].toString().equalsIgnoreCase("D")) {%>Desirable<%} %> <%if(obj1[6].toString().equalsIgnoreCase("E")) {%>Essential<%} %> <%}else {%>-<%} %>', style: 'tableData' },
    	                            ],

    	                            <%-- [
    	                                { text: htmlToPdfmake(setImagesWidth(document.getElementById('description<%=mainReqCount+"."+subReqCount %>').innerHTML, 500)), colSpan: 3 },
    	                            ], --%>
    	                            
    	                           	[
    	                                { stack: [htmlToPdfmake(setImagesWidth('<%=++snCount %>.Description: <%if(obj1[4]!=null){ %> <%=obj1[4].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%}else{ %>-<%} %>', 500))], colSpan: 3 }
    	                            ],
    	                            
    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Remarks', style: 'tableData' },
    	                                { text: '<%if(obj1[7]!=null) {%> <%=obj1[7] %> <%}else{%>-<%} %>', style: 'tableData' },
    	                            ],

    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Constraints', style: 'tableData' },
    	                                { text: '<%if(obj1[9]!=null) {%> <%=obj1[9] %> <%}else{%>-<%} %>', style: 'tableData' },
    	                            ],

    	                           [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Demonstration', style: 'tableData' },
    	                                { text: htmlToPdfmake('<% if(obj1[16] != null) { %>'
    	                                	    + '<% List<Object[]> DemonList = VerificationDataList.stream().filter(e -> e[1].toString().equalsIgnoreCase("1")).collect(Collectors.toList()); %>'
    	                                	    + '<% String[] a = obj1[16].toString().split(", "); %>'
    	                                	    + '<% for (int i = 0; i < a.length; i++) { %>'
    	                                	    + '<%= a[i] %> . <%= DemonList.get(Integer.parseInt(a[i].substring(1)) - 1)[3].toString() %><br>'
    	                                	    + '<% } %>'
    	                                	    + '<% } else { %>-<% } %>'), style: 'tableData' },
    	                            ],

    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Test', style: 'tableData' },
    	                                { text: htmlToPdfmake('<%if(obj1[17]!=null) { %>'
    	                                		+ '<% List<Object[]>TestList=VerificationDataList.stream().filter(e->e[1].toString().equalsIgnoreCase("2")).collect(Collectors.toList()); %>'
    	                                		+ '<%String [] a=obj1[17].toString().split(", "); %>'
    	                                		+ '<%for(int i=0;i<a.length;i++){ %>'
    												
    	                                		 + '<%=	a[i] +" . "+ TestList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
    	                                		+ '<%} %>'
    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
    	                            ],
    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Test Stage', style: 'tableData' },
    	                                { text: '<%if(obj1[24]!=null) {%> <%=obj1[24] %> <%}else{%>-<%} %>', style: 'tableData' },
    	                            ],
    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Design/Analysis', style: 'tableData' },
    	                                { text: htmlToPdfmake('<%if(obj1[18]!=null) { %>'
    	                                		+ '<% List<Object[]>AnalysisList=VerificationDataList.stream().filter(e->e[1].toString().equalsIgnoreCase("3")).collect(Collectors.toList()); %>'
    	                                		+ '<% String [] a=obj1[18].toString().split(", "); %>'
    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
    												
    	                                			+ '<%=	a[i] +" . "+ AnalysisList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
    	                                		+ '<%} %>'
    											+ '<%}else{%>-<%} %>'), style: 'tableData' },
    	                            ],

    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Inspection', style: 'tableData' },
    	                                { text: htmlToPdfmake('<%if(obj1[19]!=null) { %>'
    	                                		+ '<% List<Object[]>InspectionList=VerificationDataList.stream().filter(e->e[1].toString().equalsIgnoreCase("4")).collect(Collectors.toList()); %>'
    	                                		+ '<% String [] a=obj1[19].toString().split(", "); %>'
    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
    												
    	                                		+ '<%=	a[i] +" . "+ InspectionList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
    	                                		+ '<%} %>'
    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
    	                            ],

    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Special Methods', style: 'tableData' },
    	                                { text: htmlToPdfmake('<%if(obj1[20]!=null) { %>'
    	                                		+ '<% List<Object[]>specialList=VerificationDataList.stream().filter(e->e[1].toString().equalsIgnoreCase("5")).collect(Collectors.toList()); %>'
    	                                		+ '<% String [] a=obj1[20].toString().split(", "); %>'
    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
    												
    	                                		+ '<%=	a[i] +" . "+ specialList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
    	                                		+ '<%} %>'
    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
    	                            ],
    	                            
    	                         <%--    [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Link Sub-Systems', style: 'tableData' },
    	                                { text: '<%if(obj1[23]!=null) { String [] a=obj1[23].toString().split(", "); for(String s:a){ %> <%=productTreeList.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[2].toString()).collect(Collectors.joining("")) %> \n <%}}else{ %> - <%} %>', style: 'tableData' },
    	                            ], --%>
    	                            
    	                            

    	                        ]
    	                    },
    	                    layout: {

    	                        hLineWidth: function(i, node) {
    	                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
    	                        },
    	                        vLineWidth: function(i) {
    	                            return 0.5;
    	                        },
    	                        hLineColor: function(i) {
    	                            return '#aaaaaa';
    	                        },
    	                        vLineColor: function(i) {
    	                            return '#aaaaaa';
    	                        }
    	                    }
    	                },
    	                { text: '\n',},
    				<%
    				ReqName=obj1[3].toString();
    				} %>
    				<%}%>
    	
    				<%
    				List<Object[]> nonMainReqList = RequirementList.stream()
    												.filter(e->e[15]!=null&&!e[15].toString().equalsIgnoreCase("0"))
    												.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
    												.collect(Collectors.toList());
    				%>
    				<%if(nonMainReqList!=null && !nonMainReqList.isEmpty()) { %>
    				
    				{
	                	text: mainContentCount+'.<%=++mainReqCount %>. Precedence and Criticality of Requirements',	
	                	style: 'chapterSubSubHeader',
	                },
	    				{
	                        table: {
	                            headerRows: 1,
	                            widths: ['10%', '30%', '30%', '30%'],
	                            body: [
	                                // Table header
	                                [
	                                    { text: 'SN', style: 'tableHeader' },
	                                    { text: 'Requirement ID', style: 'tableHeader' },
	                                    { text: 'Priority', style: 'tableHeader' },
	                                    { text: 'Criticality', style: 'tableHeader' },
	                                ],
	                                // Populate table rows
	                                <% if (nonMainReqList != null) { %>
	                                <% int rcount = 0; for (Object[] obj : nonMainReqList) { if(obj[21]!=null){ %>
	                                [
	                                    { text: '<%= ++rcount %>', style: 'tableData',alignment: 'center' },
	                                    { text: '<%= obj[1] %>', style: 'tableData' },
	                                    { text: '<%if(obj[5]!=null) {%><%=obj[5].toString()%><%}else{ %>-<%} %> ', style: 'tableData',alignment: 'center' },
	                                    { text: '<%if(obj[21]!=null) {%><%=obj[21].toString()%><%}else{ %>-<%} %> ', style: 'tableData' },
	                                ],
	                                <% } }%>
	                                <% } %>
	                            ]
	                        },
	                        layout: {
	                            /* fillColor: function(rowIndex) {
	                                return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
	                            }, */
	                            hLineWidth: function(i, node) {
	                                return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
	                            },
	                            vLineWidth: function(i) {
	                                return 0.5;
	                            },
	                            hLineColor: function(i) {
	                                return '#aaaaaa';
	                            },
	                            vLineColor: function(i) {
	                                return '#aaaaaa';
	                            }
	                        }
	                    },
    					
    					<% } %>
    	
    				<%} %>

                /* htmlToPdfmake(reqDiv), */
                /* ************************************** Requirements End*********************************** */
                
                /* ************************************** Verification Provisions *********************************** */
                {
                    text: (++mainContentCount)+'. Verification Provisions',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                {
					text : (mainContentCount)+'.1. Verification Methods',
					style: 'chapterSubHeader',
					tocItem: true,
	                id: 'chapter'+chapterCount+'.'+mainContentCount+'.1',
	                tocMargin: [10, 0, 0, 0],
				},
                <%if(Verifications!= null &&   !Verifications.isEmpty()) {
					int verificationCount=1;
					int j=0;
					for(Object[]obj:Verifications){
				%>
					<%-- {
						text : htmlToPdfmake('<h3 class="heading-colors" style="font-size: 16px; "><%="3"+"."+(verificationCount)%>.<%=++j %> <%=obj[1].toString() %> </h3><br>'
								+'<%if(obj[3]!=null){ %><%=obj[3].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "")%><br>'
								+'<%}else{ %><p style="text-align: center;">-&nbsp;&nbsp;No details filled&nbsp;&nbsp;-</p><%}%>'),margin: [5, 5, 5, 5],
					}, --%>
						{
							text : (mainContentCount)+'.<%=verificationCount%>.<%=++j %>. <%=obj[1] %>',
							style: 'chapterSubSubHeader',
							tocItem: true,
			                id: 'chapter'+chapterCount+'.'+mainContentCount+'.<%=verificationCount%>.<%=j %>',
			                tocMargin: [20, 0, 0, 0],
						},
						<%if(obj[3]!=null) {%>
						{
							stack: [htmlToPdfmake(setImagesWidth('<%=obj[3].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "")%>', 500))],	
		                    margin: [15, 0, 0, 15],
		                },

					<%} %>
				<%}} %>
                /* htmlToPdfmake(verificationDiv), */
                /* ************************************** Verification Provisions End*********************************** */
                
                /* ************************************** Verification Provisions List*********************************** */
                {
                    table: {
                        headerRows: 1,
                        widths: ['10%', '30%', '30%', '30%'],
                        body: [
                        	[
                        		{text: 'SN', style:'tableHeader'},
                        		{text: 'Verification Name', style:'tableHeader'},
                        		{text: 'Type of Test', style:'tableHeader'},
                        		{text: 'Purpose', style:'tableHeader'},
                        	],
                            // Populate table rows
                            <% if (verificationDataListMap!=null && verificationDataListMap.size() > 0) {
									int slno = 0, subcount=0; String key="", data="";;
									for (Map.Entry<String, List<Object[]>> map : verificationDataListMap.entrySet()) {
                  							
               							List<Object[]> values = map.getValue();
               							int index =0;
               							for (Object[] obj : values) { %>
				                            [
				                                <%if(index ==0) {%>
				                                	{ text: '<%=++slno %>', style: 'tableData', rowSpan: <%=values.size() %>, alignment: 'center' },
									    			{ text: '<%=obj[2] %>', style: 'tableData', rowSpan: <%=values.size() %> },
       											<% } else { %>
       												{},
					                                {},
					                            <% } %>
				                                <%if(!data.equalsIgnoreCase(obj[2].toString())){ subcount=0; } %> 
				                                { text: '<%=obj[2].toString().substring(0,1)+(++subcount)+". "+obj[3] %>', style: 'tableData' },
				                                { text: '<%=obj[4]%>', style: 'tableData' },
				                            ],
                            <% data = obj[2].toString();  ++index;} %>
                            <% } }%>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                /* ************************************** Verification Provisions List End*********************************** */
                
                /* ************************************** Requirements Traceability*********************************** */
                {
                    text: (++mainContentCount)+'. Requirements Traceability',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                
                <% if(RequirementList!=null && ProjectParaDetails!=null && !ProjectParaDetails.isEmpty()&&!RequirementList.isEmpty()) {   
    				List<Object[]>subList	= RequirementList.stream().filter(e->e[15]!=null&&!e[15].toString().equalsIgnoreCase("0"))
					    						.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
					    						.collect(Collectors.toList());
    			%>
    			{
                	text: (mainContentCount)+'.1. Forward Traceability Matrix',	
                	style: 'chapterSubHeader',
                    tocItem: true,
                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.1',
                    tocMargin: [10, 0, 0, 0],
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['10%', '45%', '45%'],
                        body: [
                        	[
                        		{text: 'SN', style:'tableHeader'},
                        		{text: 'QR', style:'tableHeader'},
                        		{text: 'Requirement Id', style:'tableHeader'},
                        	],
                            // Populate table rows
                        	<%if(ParaDetails!=null && ParaDetails.size()>0) {
        						int slCount=0;
        						for(Object[] obj1:ParaDetails){
        							List<Object[]> ReqId = new ArrayList<>();
        						
        							if(subList.size()>0){
        								ReqId=subList.stream().filter(e->e[12]!=null && Arrays.asList(e[12].toString().split(", ")).contains(obj1[0].toString())).collect(Collectors.toList());
        							}
        					%>
	        					[
	        						{text: '<%=++slCount %>', style:'tableData', alignment: 'center'},
	        						{text: '<%=obj1[3] %>', style:'tableData',},
	        						{text: '<%if(ReqId.size()>0) { for(Object[]obj2:ReqId){ %> <%=obj2[1] %>\n <%}}else{ %> --- <%} %>', style:'tableData', alignment: 'center'},
	        					],
        					
        					<%}} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                {
                	text: (mainContentCount)+'.2. Backward Traceability Matrix',	
                	style: 'chapterSubHeader',
                    tocItem: true,
                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.2',
                    tocMargin: [10, 0, 0, 0],
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['10%', '45%', '45%'],
                        body: [
                        	[
                        		{text: 'SN', style:'tableHeader'},
                        		{text: 'Requirement Id', style:'tableHeader'},
                        		{text: 'QR', style:'tableHeader'},
                        	],
                            // Populate table rows
                        	<%int snCount=0; for(Object[] objs: subList) { if(objs[12]!=null) {%>
	        					[
	        						{text: '<%=++snCount %>', style:'tableData', alignment: 'center'},
	        						{text: '<%=objs[1].toString() %>', style:'tableData', alignment: 'center'},
	        						{text: htmlToPdfmake('<%if(objs[12]!=null) { String [] a=objs[12].toString().split(", "); List<String>paras= new ArrayList<>(); %>'
	        								+'<%for(String s:a){ for(Object[]obj:ProjectParaDetails){ if(obj[0].toString().equalsIgnoreCase(s)){ paras.add(obj[3].toString()); } } }%>'
		    								+'<% for(String s:paras){%><%=s %> <br><%} %>'
		    								+'<%}else{ %> - <%} %>'), style:'tableData'},
	        					],
        					
        					<%}} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
  
    			<%} %>
    			
                /* ************************************** Requirements Traceability End*********************************** */
                
                /* ************************************** Appendix Section*********************************** */
                {
                    text: (++mainContentCount)+'. Appendix Section',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                {
                	text: mainContentCount+'.1. Appendix A - Acronyms and Definitions',	
                	style: 'chapterSubHeader',
                    tocItem: true,
                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.1',
                    tocMargin: [10, 0, 0, 0],
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['10%', '45%', '45%'],
                        body: [
                        	[
                        		{text: 'SN', style:'tableHeader'},
                        		{text: 'Acronyms', style:'tableHeader'},
                        		{text: 'Definitions', style:'tableHeader'},
                        	],
                            // Populate table rows
                        	<% if (AcronymsList != null) { int slno = 0; for (Object[] obj : AcronymsList) { %>
	        					[
	        						{text: '<%=++slno %>', style:'tableData', alignment: 'center'},
	        						{text: '<%=obj[1] %>', style:'tableData', },
	        						{text: '<%=obj[2] %>', style:'tableData', },
	        					],
        					
        					<%}} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                {
                	text: htmlToPdfmake('<p>Guidance: This appendix contains acronyms and provides standard definitions for terminology used herein </p>'),	
                	style: 'subChapterNote',
                },
                {
                	text: mainContentCount+'.2. Appendix B -Key Performance Parameters / Key System Attributes',	
                	style: 'chapterSubHeader',
                    tocItem: true,
                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.2',
                    tocMargin: [10, 0, 0, 0],
                },
                {
                	text: 'The key Measures of Effectiveness (MOE) are given below :',	
                    margin: [15, 5, 0, 10],
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['10%', '45%', '45%'],
                        body: [
                        	[
                        		{text: 'SN', style:'tableHeader'},
                        		{text: 'Key MOEs', style:'tableHeader'},
                        		{text: 'Values', style:'tableHeader'},
                        	],
                            // Populate table rows
                        	<% if (PerformanceList != null) { int slno = 0; for (Object[] obj : PerformanceList) { %>
	        					[
	        						{text: '<%=++slno %>', style:'tableData', alignment: 'center'},
	        						{text: '<%=obj[1] %>', style:'tableData', },
	        						{text: '<%=obj[2]  %>', style:'tableData', },
	        					],
        					
        					<%}} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                {
                	text: htmlToPdfmake('<p>Guidance: This appendix contains tabularized KPPs, and KSAs, if applicable, listed in prioritized order.<br>Sample Key performance Parameters / Key System Attributes are shown above. Modify the Key performance Parameters / Key System Atributes based on your specific project constraints. </p>'),	
                	style: 'subChapterNote',
                },
                {
                	text: (mainContentCount)+'.3. Appendix D - Test Verification Matrices',	
                	style: 'chapterSubHeader',
                    tocItem: true,
                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.3',
                    tocMargin: [10, 0, 0, 0],
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['18%', '21%', '12%', '15%', '17%', '18%'],
                        body: [
                        	[
                        		{text: 'Verification method', style:'tableHeader'},
                        		{text: 'Demonstration', style:'tableHeader'},
                        		{text: 'Test', style:'tableHeader'},
                        		{text: 'Analysis', style:'tableHeader'},
                        		{text: 'Inspection', style:'tableHeader'},
                        		{text: 'Special Verification Method', style:'tableHeader'},
                        	],
                            // Populate table rows
        					<%
        			           if(!RequirementList.isEmpty()){
        			        	   List<Object[]> mainReqList = RequirementList.stream().filter(k->k[15]!=null&&k[15].toString().equalsIgnoreCase("0"))
						        			        			   .sorted(Comparator.comparing(k -> Integer.parseInt(k[14].toString())))
						        			        			   .collect(Collectors.toList());
        			        	   for(Object []obj:mainReqList){
        			        		   
        			        		   List<Object[]>submainReqList = RequirementList.stream().filter(k->k[15]!=null&&k[15].toString().equalsIgnoreCase(obj[0].toString()))
						        			        				   . sorted(Comparator.comparing(k -> Integer.parseInt(k[14].toString())))
						        			        				   .collect(Collectors.toList());
        			        %>
		        			        <%if(submainReqList.size()>0){%>
			        			        [
			        						{text: '<%=obj[3].toString() %>:-', style:'tableData', colSpan: 6},
			        					],
		        			          
		        			           <%String ReqName="";
		        			            	for(Object[]obj1:submainReqList){ %>
		        			           	<%if(!ReqName.equalsIgnoreCase(obj1[3].toString()) && !obj1[3].toString().equalsIgnoreCase(obj[3].toString())) {%>
			        			           	[
				        						{text: '<%=obj1[3].toString() %>', style:'tableData', colSpan: 6},
				        					],
		        						<%} %>
		        			           
		        						[
			        						{text: '<%=obj1[1] %>', style:'tableData',},
			        						{text: '<%if(obj1[16]!=null) {%><%=obj1[16] %> <%}else{ %>-<%} %>', style:'tableData',},
			        						{text: '<%if(obj1[17]!=null) {%><%=obj1[17] %> <%}else{ %>-<%} %>', style:'tableData',},
			        						{text: '<%if(obj1[18]!=null) {%><%=obj1[18] %> <%}else{ %>-<%} %>', style:'tableData',},
			        						{text: '<%if(obj1[19]!=null) {%><%=obj1[19] %> <%}else{ %>-<%} %>', style:'tableData',},
			        						{text: '<%if(obj1[20]!=null) {%><%=obj1[20] %> <%}else{ %>-<%} %>', style:'tableData',},
			        					],
		        			           <% ReqName=obj1[3].toString();
		        			           } %>
		        					<%} %>
        			    	<%}} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                /* ************************************** Appendix Section End*********************************** */
                
            ],
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
            },
            
            info: {
                title: 'Requirement_Document', // Set document title here
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
                                    { text: '<%if(docnumber!=null) {%><%=docnumber %><%} %>', alignment: 'left', margin: [30, 0, 0, 0], fontSize: 8 },
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
            
            background: function(currentPage) {
                return [
                    {
                        image: generateRotatedTextImage(leftSideNote),
                        width: 100, // Adjust as necessary for your content
                        absolutePosition: { x: -10, y: 50 }, // Position as needed
                    }
                ];
            },
            watermark: { text: 'DRAFT', opacity: 0.1, bold: true, italics: false, fontSize: 80,  },
            /* background: function(currentPage) {
                return [
                    {
                        text: htmlToPdfmake('<p style="transform: rotate(270deg) !important;">Left-Side Rotated Text</p>'), // Your text here
                        fontSize: 12,
                        color: 'gray',
                        bold: true,
                        absolutePosition: { x: 10, y: 400 }, 
                    }
                ];
            }, */
            defaultStyle: { fontSize: 12 }
        };
		
        pdfMake.createPdf(docDefinition).getBlob((blob) => {
            // Create a URL for the blob
            const url = URL.createObjectURL(blob);

            // Open the PDF in a new tab
            window.open(url, '_blank');

            // Hide the loading spinner
              document.getElementById('loadingOverlay').style.display='none';
            window.close();
        });
        }
        catch (error) {
        		  // Handle the error in the catch block
        		  console.log("An error occurred:", error);
        		}
    }
    
    const setImagesWidth = (htmlString, width) => {
        const container = document.createElement('div');
        container.innerHTML = htmlString;
      
        const images = container.querySelectorAll('img');
        images.forEach(img => {
          img.style.width = width + 'px';
          img.style.textAlign = 'center';
        });
      
        const textElements = container.querySelectorAll('p, h1, h2, h3, h4, h5, h6, span, div, td, th, table, figure, hr, ul, li, a');
        textElements.forEach(element => {
          if (element.style) {
            element.style.fontFamily = '';
            element.style.margin = '';
            element.style.marginTop = '';
            element.style.marginRight = '';
            element.style.marginBottom = '';
            element.style.marginLeft = '';
            element.style.lineHeight = '';
            element.style.height = '';
            element.style.width = '';
            element.style.padding = '';
            element.style.paddingTop = '';
            element.style.paddingRight = '';
            element.style.paddingBottom = '';
            element.style.paddingLeft = '';
            element.style.fontSize = '';
            element.id = '';
            
            const elementColor = element.style.color;
            if (elementColor && elementColor.startsWith("var")) {
                // Replace `var(...)` with a fallback or remove it
                element.style.color = 'black'; // Default color
            }
            
            const elementbackgroundColor = element.style.backgroundColor;
            if (elementbackgroundColor && elementbackgroundColor.startsWith("var")) {
                // Replace `var(...)` with a fallback or remove it
                element.style.backgroundColor = 'transparent'; // Set a default or fallback background color
            }
            
          }
        });
      
        const tables = container.querySelectorAll('table');
        tables.forEach(table => {
          if (table.style) {
            table.style.borderCollapse = 'collapse';
            table.style.width = '100%';
          }
      
          const cells = table.querySelectorAll('th, td');
          cells.forEach(cell => {
            if (cell.style) {
              cell.style.border = '1px solid black';
      
              if (cell.tagName.toLowerCase() === 'th') {
                cell.style.textAlign = 'center';
              }
            }
          });
        });
      
        return container.innerHTML;
    }; 
      
      function splitTextIntoLines(text, maxLength) {
    	  const lines = [];
    	  let currentLine = '';

    	  for (const word of text.split(' ')) {
    	    if ((currentLine + word).length > maxLength) {
    	      lines.push(currentLine.trim());
    	      currentLine = word + ' ';
    	    } else {
    	      currentLine += word + ' ';
    	    }
    	  }
    	  lines.push(currentLine.trim());
    	  return lines;
    	}

    	// Generate rotated text image with line-wrapped text
    	function generateRotatedTextImage(text) {
    	  const maxLength = 260;
    	  const lines = splitTextIntoLines(text, maxLength);

    	  const canvas = document.createElement('canvas');
    	  const ctx = canvas.getContext('2d');

    	  // Set canvas dimensions based on anticipated text size and rotation
    	  canvas.width = 200;
    	  canvas.height = 1560;

    	  // Set text styling
    	  ctx.font = '14px Roboto';
    	  ctx.fillStyle = 'rgba(128, 128, 128, 1)'; // Gray color for watermark

    	  // Position and rotate canvas
    	  ctx.translate(80, 1480); // Adjust position as needed
    	  ctx.rotate(-Math.PI / 2); // Rotate 270 degrees

    	  // Draw each line with a fixed vertical gap
    	  const lineHeight = 20; // Adjust line height if needed
    	  lines.forEach((line, index) => {
    	    ctx.fillText(line, 0, index * lineHeight); // Position each line below the previous
    	  });

    	  return canvas.toDataURL();
    	}

  
  
    	
    
    	
	    	$( document ).ready(function(){
	    		
	    			 generatePDF();
				
	    		
	    		
	    		/* window.close(); */
	    		
	    		// Hide the current JSP page immediately after opening the PDF
    		
    			  
	    		 // Adjust the delay time as needed
	    		   
	    	  
	    	});
    	
   
</script>
</body>
 
</html>