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
/* 	jQuery(document).ready(function($) {
		$("#btn-export").click(function(event) {
			$("#source-html").wordExport("System-Requirement");
		});
	}); */
 /* 	 $( document ).ready(function() {
		 download();
		}); */ 
		 function download(){
			$("#source-html").wordExport("System-Requirement");
			window.close();
	 }
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
String labImg=(String)request.getAttribute("LabImage");
List<Object[]>AbbreviationDetails=(List<Object[]>)request.getAttribute("AbbreviationDetails");
List<Object[]>AcronymsList=(List<Object[]>)request.getAttribute("AcronymsList");
List<Object[]>PerformanceList=(List<Object[]>)request.getAttribute("PerformanceList");
List<Object[]>MemberList=(List<Object[]>)request.getAttribute("MemberList");
List<Object[]> DocumentSummary=(List<Object[]>)request.getAttribute("DocumentSummary");
Object[] DocTempAtrr=(Object[])request.getAttribute("DocTempAttributes");
int maincount=0;
int port=new URL( request.getRequestURL().toString()).getPort();
String path=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()+"/";
String conPath=(String)request.getContextPath();
LocalDate d = LocalDate.now();
int contentCount=0;
Month month= d.getMonth();
int year=d.getYear();
String fontSize = "16";
String SubHeaderFontsize ="14";
String SuperHeaderFontsize="13";
String ParaFontSize ="12" ;
String ParaFontWeight="normal";
String HeaderFontWeight="Bold";
String SubHeaderFontweight="Bold";
String SuperHeaderFontWeight="Bold";
String FontFamily="Times New Roman";
%>
<style>
    /* Define header and footer styles */
 .static-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        text-align: center;
    }
.static-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        text-align: center;
    }
    .logo-container {
        width: 33.33%;
    }

    .logo {
        width: 80px;
        height: 80px;
        margin-bottom: 5px;
    }
    /* Your existing styles... */
</style>
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
<body >


	<div class="content-footer" align="center"> 
		<button id="btn-export" class="btn btn-lg bg-transparent" onclick="download()"
			style="padding: 10px;">
			<i class="fa fa-lg fa-download" aria-hidden="true"
				style="color: green;"></i>
		</button>
	</div>
	<div class="source-html-outer">
<%-- <div class="static-header">
    <div class="logo-container">
        <img class="logo" 
            <%if (lablogo != null) {%> src="data:image/png;base64,<%=lablogo%>" alt="Configuration" <%} else {%> alt="File Not Found" <%}%>>
    </div>
    <div class="logo-container">
        <img class="logo" 
            <%if (labImg != null) {%> src="data:image/png;base64,<%=labImg%>" alt="Configuration" <%} else {%> alt="File Not Found" <%}%>>
    </div>
</div> --%>
		<div id="source-html">
    <!-- Your existing HTML content goes here -->
    <!-- ... -->
     <%
   // Default font size
        if (DocTempAtrr != null && DocTempAtrr[0] != null) {
        	fontSize=DocTempAtrr[0].toString();
       }
  //  SubHeader font size
        if (DocTempAtrr != null && DocTempAtrr[2] != null) {
              SubHeaderFontsize = DocTempAtrr[2].toString(); 
        }
     //  Super Header font size
      	if(DocTempAtrr!=null && DocTempAtrr[9]!=null){
        		SuperHeaderFontsize=DocTempAtrr[9].toString();
    	    	}
    	 if(DocTempAtrr!=null && DocTempAtrr[4]!=null){
        		ParaFontSize= DocTempAtrr[4].toString();
    	    	}
    	 if(DocTempAtrr!=null && DocTempAtrr[5]!=null){
    	    	ParaFontWeight=DocTempAtrr[5].toString();
    	    	}
    	  if(DocTempAtrr!=null && DocTempAtrr[1]!=null){
    	    		HeaderFontWeight= DocTempAtrr[1].toString();
    	    	}
        if(DocTempAtrr!=null && DocTempAtrr[3]!=null){
        		SubHeaderFontweight= DocTempAtrr[3].toString();
    	    	}
                if(DocTempAtrr!=null && DocTempAtrr[10]!=null){
        	SuperHeaderFontWeight= DocTempAtrr[10].toString();
        }
                if(DocTempAtrr!=null && DocTempAtrr[11]!=null){
                	FontFamily= DocTempAtrr[11].toString();
                }
    	        %>
    <div class="heading-container" style="text-align: center; position: relative;">
  <h6 class="heading-color top-center" style="font-family: <%= FontFamily %>;font-size: 14px !important; text-decoration: underline; display: inline-block; padding-bottom: 5px; position: absolute; top: 0; left: 50%; transform: translateX(-50%); font-weight: normal;">RESTRICTED</h6>
</div>
  <table style="width: 98%;border-collapse: collapse;margin-left: 5px;">
	<tr>
		<td style="text-align: left;">
			<table style="width: 85%; border: 1px solid black; border-collapse: collapse;">
	            <tr>
	                <td style="text-align: center; padding: 5px;">
	                    <span style="text-decoration: underline;font-family: <%= FontFamily %>;">RESTRICTED</span>
	                </td>
	            </tr>
	            <tr>
	                <td style="padding: 5px;text-align: justify;font-family: <%= FontFamily %>;">
	                    <p>The information given in this document is not to be published or communicated, either directly or indirectly, to the press or to any personnel not authorized to receive it.</p>
	                </td>
	            </tr>
        	</table>
		</td>
		<td style="text-align: right;">
			<table style="width: 23%; border: none; border-collapse: collapse;">
            	<tr>
          			<td style="padding: 10px;">
    					<h4 style="margin: 0; padding: 0;font-family: <%= FontFamily %>;">
    				    				<%
				if(LabList[0] != null) {
				%>
				<%=LabList[0].toString()%>:SyRD:....................</h4>
  						<h6 style="margin: 0; padding: 0;font-family: <%= FontFamily %>;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copy No.01</h6>
						<%
				}else {
				%>-<%
				}
				%>
					</td>
            	</tr>
        	</table>
        	<br> <br> <br> <br> <br><br>
		</td>
	</tr>
</table>
			<div align="center"></div>
			<div style="text-align: center; margin-top: 75px;">
				<h4 style="font-size: 18pt;;font-family:<%= FontFamily %>; !important;" class="heading-color ">SYSTEM REQUIREMENTS</h4>
				<h4 style="font-size: 15pt;font-family: <%= FontFamily %>;">For</h4>
				<h4 style="font-size: 18pt;font-family: <%= FontFamily %>;">
					Project:
					<%=PfmsInitiationList[7].toString()%><br> <br>
					<%="(" + PfmsInitiationList[6].toString() + ")"%>
				</h4>
				<h4 style="font-size: 18px; text-decoration: underline;font-family: <%= FontFamily %>;">Requirement
					No.</h4>
				<h4 style="font-family: <%= FontFamily %>;">
					<%if (reqStatus!=null && reqStatus[3] != null) {%><%=reqStatus[3].toString()%>
					<%} else {%>-<%}%>
				</h4>
					<div align="center" >
						<img class="logo" style="width: 80px; height: 80px; margin-bottom: 5px"
							<%if (lablogo != null) {%> src="data:image/png;base64,<%=lablogo%>" alt="Configuration"
							<%} else {%> alt="File Not Found" <%}%>>
				</div>
				<br> <br>
				<div align="center">
					<h4 style="font-size: 20px;font-family: <%= FontFamily %>;">
				<%
				if(LabList[1] != null) {
				%>
				<%=LabList[1].toString()+"("+LabList[0].toString()+")"%>
				<%
				}else {
				%>-<%
				}
				%>
					</h4>
					<h4 style="font-family: <%= FontFamily %>;">
						Government of India, Ministry of Defence<br>Defence Research
						& Development Organization
					</h4>
				</div>
				<h4 style="font-family: <%= FontFamily %>;">
					<%if(LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %>
					<%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %>
					<%}else{ %>
					-
					<%} %>
				</h4>
<div style="text-align: right;">
    <span style="font-weight: bold;font-family: <%= FontFamily %>;"><%= month.toString().substring(0,3) %> <%= year %></span>
   </div>
			</div>
			<br>
		<!------------------------ page 2 -------Starts----------------------->
  <div class="heading-container" style="text-align: center; position: relative;">
    <h6 class="heading-color top-center" style="font-family: <%= FontFamily %>;font-size: 14px !important; text-decoration: underline; display: inline-block; padding-bottom: 5px; position: absolute; top: 0; left: 50%; transform: translateX(-50%); font-weight: normal;">RESTRICTED</h6>
</div>
  					<table style="width: 98%;border-collapse: collapse;margin-left: 10px;">
	<tr>
		<td style="text-align: left;">
			<table style="width: 85%; border: 1px solid black; border-collapse: collapse;">
	            <tr>
	                <td style="text-align: center; padding: 5px;">
	                    <span style="text-decoration: underline;font-family: <%= FontFamily %>;">RESTRICTED</span>
	                </td>
	            </tr>
	            <tr>
	                <td style="padding: 5px;text-align: justify;font-family: <%= FontFamily %>;">
	                    <p>The information given in this document is not to be published or communicated, either directly or indirectly, to the press or to any personnel not authorized to receive it.</p>
	                </td>
	            </tr>
        	</table>
		</td>
		<td style="text-align: right;">
			<table style="width: 23%; border: none; border-collapse: collapse;">
            	<tr>
          			<td style="padding: 10px;">
    					<h4 style="margin: 0; padding: 0;font-family: <%= FontFamily %>;">	<%
				if(LabList[0] != null) {
				%>
				<%=LabList[0].toString()%>:SyRD:....................</h4>
				<h6 style="margin: 0; padding: 0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copy No.01</h6>
				<%
				}else {
				%>-<%
				}
				%>
  							</td>
            	</tr>
        	</table>
        	<br> <br> <br> 
		</td>
	</tr>
</table>
<br>

<!-- 2nd page Starts --><br><br><br><br>
		<div align="center" >
						<img class="logo" style="width: 50px; height: 50px; margin-bottom: 5px margin-right: 10px;"
							<%if (lablogo != null) {%> src="data:image/png;base64,<%=lablogo%>" alt="Configuration"
							<%} else {%> alt="File Not Found" <%}%>>
				</div>
				<br><br><br><br><br><br>
			<%-- 		<div align="center" >
						<img class="logo" style="width: 100px; height: 100px; margin-bottom: 5px"
							<%if (labImg != null) {%> src="data:image/png;base64,<%=labImg%>" alt="Configuration"
							<%} else {%> alt="File Not Found" <%}%>>
				</div> --%>
				<div>
				</div>
					<div align="center"></div>
			<div style="text-align: center; margin-top: 75px;font-family: <%= FontFamily %>;">
				<h4 style="font-size: 18pt; !important;font-family: <%= FontFamily %>;" class="heading-color">SYSTEM
					REQUIREMENTS DOCUMENT</h4>
				<%-- <h4 style="font-size: 14px;">For</h4>
				<h4 style="">
					Project:
					<%=PfmsInitiationList[7].toString()%>
					<%="("+ PfmsInitiationList[6].toString() +")"%>
				</h4>
				<h4 style="font-size: 14px; ">
				<span style="text-decoration: underline;">Requirement No.:</span>
				<%if (reqStatus!=null && reqStatus[3] != null) {%><%=reqStatus[3].toString()%>
					<%} else {%>-<%}%>
				</h4> --%>
				<div align="center">
					<h5  style="font-size: 20px;font-family: <%= FontFamily %>;">
				<%
				if(LabList[1] != null) {
				%>
				<%=LabList[1].toString()+"("+LabList[0].toString()+")"%>
				<%
				}else {
				%>-<%
				}
				%>
					</h5>
					<h5 style="font-family: <%= FontFamily %>;">
						Government of India, Ministry of Defence<br>Defence Research
						& Development Organization
					</h5>

				</div>

				<h4 style="font-family: <%= FontFamily %>;">
					<%if(LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %>
					<%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %>
					<%}else{ %>
					-
					<%} %>
									<div style="text-align: right;">
    <span style="font-weight: bold;font-family: <%= FontFamily %>;"><%= month.toString().substring(0,3) %> <%= year %></span>
   </div>
				</h4>

			</div>
			<br>
			 <div class="heading-container" style="text-align: center; position: relative;">
    <h6 class="heading-color top-center" style="font-family: <%= FontFamily %>;font-size: 14px !important; text-decoration: underline; display: inline-block; padding-bottom: 5px; position: absolute; top: 0; left: 50%; transform: translateX(-50%);">RESTRICTED</h6>
  </div>
			<!-- Page to ends -->
	<p style="text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>	
	<div class="heading-container" style="text-align: center; position: relative;">
  <h6 class="heading-color top-center" style="font-family: <%= FontFamily %>;font-size: 14px !important; text-decoration: underline; display: inline-block; padding-bottom: 5px; position: absolute; top: 0; left: 50%; transform: translateX(-50%); font-weight: normal;">RESTRICTED</h6>
</div>
				
					<div style="text-align: center;font-family: <%= FontFamily %>;">
				<h5  class="heading-color">AMENDMENT / REVISION HISTORY PAGE
				</h5>
				
			</div>
			<table style="width: 650px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;border-collapse: collapse;">
				
					<tr >
					<td class="text-dark"  rowspan="2" style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;"><span class="text-dark">Amendment No.</span></td>
					<td class="text-dark"  rowspan="2" style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;"><span class="text-dark">Particulars of Amendment.</span></td>
					<td class="text-dark" rowspan="2" style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;"><span class="text-dark">Page No.</span></td>
					<td class="text-dark"  rowspan="2" style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;"><span class="text-dark">Para No.</span></td>
					<td class="text-dark"  rowspan="2"style="font-family: <%= FontFamily %>;border:1px solid black;width: 100px; text-align: center;"><span class="text-dark">Issue Date</span></td>
					<td class="text-dark"  colspan="2" style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;"><span class="text-dark">Incorporated by</span></td>
					</tr>
					<tr >
					<td class="text-dark" style="border:1px solid black; width: 100px; text-align: center;font-family: <%= FontFamily %>;">Name</td>
					<td class="text-dark" style="border:1px solid black; width: 80px; text-align: center;font-family: <%= FontFamily %>;">Date</td>
					</tr>
						<tbody id="blankRowsBody">
		    <tr>
          <td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;"><span class="text-dark">&nbsp;</span></td>
          <td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;"><span class="text-dark"></span></td>
          <td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;"><span class="text-dark"></span></td>
          <td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;"><span class="text-dark"></span></td>
          <td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;"><span class="text-dark"></span></td>
          <td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>; width: 100px;"><span class="text-dark"></span></td>
          <td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>; width: 100px;"><span class="text-dark"></span></td>
        </tr>
				</tbody>
<!--   <script>
    // JavaScript loop to generate 10 blank rows
    for (let i = 0; i < 15; i++) {
      document.getElementById('blankRowsBody').innerHTML += `
        <tr>
          <td class="text-dark" style="border:1px solid black;"><span class="text-dark"></span></td>
          <td class="text-dark" style="border:1px solid black;"><span class="text-dark"></span></td>
          <td class="text-dark" style="border:1px solid black;"><span class="text-dark"></span></td>
          <td class="text-dark" style="border:1px solid black;"><span class="text-dark"></span></td>
          <td class="text-dark" style="border:1px solid black;"><span class="text-dark"></span></td>
          <td class="text-dark" style="border:1px solid black; width: 100px;"><span class="text-dark"></span></td>
          <td class="text-dark" style="border:1px solid black; width: 100px;"><span class="text-dark"></span></td>
        </tr>
      `;
    }
  </script> -->
					</table>
						<p style="text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>
						<div class="heading-container" style="text-align: center; position: relative;">
  <h6 class="heading-color top-center" style="font-family: <%= FontFamily %>;font-size: 14px !important; text-decoration: underline; display: inline-block; padding-bottom: 5px; position: absolute; top: 0; left: 50%; transform: translateX(-50%); font-weight: normal;">RESTRICTED</h6>
</div>
				<div align="center">
					<div style="text-align: center;">
				<h5  class="heading-color; "style="font-family: <%= FontFamily %>;">DISTRIBUTION LIST
				</h5>
						</div>
						<table style="width: 650px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;border-collapse: collapse;">
					<tr >
					<td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black; width: 20px;text-align: center;"><span class="text-dark">S.No</span></td>
					<td class="text-dark"   style="font-family: <%= FontFamily %>;border:1px solid black; width: 150px;text-align: center;"><span class="text-dark">NAME</span></td>
					<td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;width: 100px;"><span class="text-dark">Designation</span></td>
					<td class="text-dark"   style="font-family: <%= FontFamily %>;border:1px solid black;width: 100px; text-align: center;"><span class="text-dark">Division/Lab</span></td>
					<td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;width: 80px;"><span class="text-dark">Remarks</span></td>
					</tr>
				<tbody id="blankRowsBody1"></tbody>
            <% 
    if (MemberList != null) {
        int i = 1;
        for (Object[] mlist : MemberList) {
%>
 <tr>
                <td style="font-family: <%= FontFamily %>;border: 1px solid black;padding-left: 10px;"><%=  i+++"."%></td>
                <td style="font-family: <%= FontFamily %>;border: 1px solid black;padding-left: 10px;"><%= mlist[1] %></td>
                <td style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;"><%= mlist[2] %></td>
                 <td style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;"><%= mlist[3] %></td>
                 <td style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;">copy for Record</td>
                             </tr>
 <% 
   }} 
%>
					</table>
				<p style="font-family: <%= FontFamily %>;text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>
				<div class="heading-container" style="text-align: center; position: relative;">
  <h6 class="heading-color top-center" style="font-family: <%= FontFamily %>;font-size: 14px !important; text-decoration: underline; display: inline-block; padding-bottom: 0px; position: absolute; top: 0; left: 50%; transform: translateX(-50%); font-weight: normal;">RESTRICTED</h6>
</div>
				<div style="text-align: center;">
				<h4 style="font-size: 20px !important;font-family: <%= FontFamily %>;" class="heading-color">DOCUMENT SUMMARY
				</h4>
							</div>
	<!-- 	<table class="border-black"
					style="width: 650px; margin-top: 10px; margin-bottom: 5px;">
			<tr>
			<td>1.Title: System Requirement Document Template</td>
			</tr>
			</table> -->
				<table style="width: 650px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;font-family: <%= FontFamily %>;border-collapse: collapse;">
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">1.&nbsp; Title: <span class="text-dark">System Requirements Document Template</span></td>
					</tr>
					<tr >
					<td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;">2.&nbsp; Type of Document:<span class="text-dark">System Requirements Document</span></td>
					<td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;">3.&nbsp; Classification: <span class="text-dark"><%=classification %></span></td>
					</tr>
				    <tr >
					<td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;">4.&nbsp; Document Number:</td>
					<td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;">5.&nbsp; Month Year:&nbsp;<span style="font-weight: 600"><%=month.toString().substring(0,3) %></span> <%= year %></td>
					</tr>
					<tr>
					<td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;">6.&nbsp; Number of Pages:</td>
					<td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;">7.&nbsp; Related Document:</td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">8.&nbsp; Additional Information:<span class="text-dark"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[0] %><%} %></span>
				</td>
					</tr>
				     <tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">9.&nbsp; Project Number and Project Name: <span class="text-dark"><%=projectName %> (<%= projectshortName %>) </span></td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">10.&nbsp; Abstract:<span class="text-dark"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[1] %><%} %></span>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">11.&nbsp; Keywords:<span class="text-dark"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[2] %><%} %></span> </td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">12.&nbsp; Organization and address:
						<span class="text-dark" style="font-family: <%= FontFamily %>;">		<%
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
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">13.&nbsp; Distribution:<span class="text-dark"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[3] %><%} %></span>
					</td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">14.&nbsp; Revision:</td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">15.&nbsp; Prepared by:</td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">16.&nbsp; Reviewed by: <span class="text-dark"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[7] %><%} %></span> </td>
					</tr>
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">17.&nbsp; Approved by: <span class="text-dark"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[6] %><%} %></span> </td>
					</tr>
										</table>
							<p style="text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>	
			<h4 style="margin-left: 20px;font-family: <%= FontFamily %>;"> Abbreviations used in the Manual to be listed and arranged in alphabetical order</h4>
		<%  if (AbbreviationDetails != null && !AbbreviationDetails.isEmpty()) { %>	
    <table style="width: 550px; margin-top: 10px; margin-bottom: 5px; border: 1px solid black; border-collapse: collapse; margin-left: auto; margin-right: auto;">
        <thead>
            <tr>
                 <th style="width: 10%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;"><span class="text-dark">S.No</span></th>
        <th style="width: 20%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;"><span class="text-dark">Abbreviations</span></th>
        <th style="width: 50%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;"><span class="text-dark">Full Forms</span></th>
           </tr>
        </thead>
        <tbody>
                <% 
          int i = 1;
        for (Object[] alist : AbbreviationDetails) {
%>
              <tr>
                <td style="text-align: center;border: 1px solid black;font-family: <%= FontFamily %>;"><%=  i+++"."%></td>
                <td style="text-align: center;border: 1px solid black;font-family: <%= FontFamily %>;"><%= alist[1] %></td>
                <td style="border: 1px solid black; padding-left: 10px;font-family: <%= FontFamily %>;"><%= alist[2] %></td>
            </tr>
            <% 
   }} 
%>
        </tbody>
    </table>
				<p style="text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>	
							<h4 style="font-size: 16pt;font-family: <%= FontFamily %>; !important; class="heading-color">CONTENTS</h4>
						</div>
						<p style="font-family: <%= FontFamily %>;">1.Click on the "References" Menu located at the top of the MS document.<br>
2.From the dropdown menu, choose "Table of Contents."<br>
3.Select "Automatic Table 1" from the options provided.<br>
4.After adding Contents remove this lines
</p>
									<%-- <%if(ReqIntro!=null) {%>
			<h4 style="margin-left: 10px"><%=++contentCount %>. &nbsp;SCOPE</h4>
			<h4 style="margin-left: 20px"><%=contentCount %>.1 Introduction</h4>
			<h4 style="margin-left: 20px"><%=contentCount %>.2 System Block Diagram</h4>
			<h4 style="margin-left: 20px"><%=contentCount %>.3 System Overview</h4>
			<h4 style="margin-left: 20px"><%=contentCount %>.4 Document Overview</h4>
			<h4 style="margin-left: 20px"><%=contentCount %>.5 Applicable Standards</h4>
			<%} %>
		
		<h4 style="margin-left: 10px"><%=++contentCount %>. &nbsp;APPLICABLE DOCUMENTS</h4>
		<h4 style="margin-left: 20px"><%=contentCount %>.1 General</h4>
		<h4 style="margin-left: 10px"><%=++contentCount %>. &nbsp;REQUIREMENTS</h4>
				<% 
	int i1=0;
	for(Object[]obj:OtherRequirements){ %>
				<div>
					<%if(obj[2].toString().equalsIgnoreCase("0")) { %><h3
						style="margin-left: 10px;"><%=contentCount+"."+(++i1)+" "+obj[3].toString()%></h3>
					<div>
					<%}
	int j=0;%>
					</div>
					<%for(Object[]obj1:OtherRequirements){ 
	if(obj[0].toString().equalsIgnoreCase(obj1[2].toString())) { %>
					<h4 style="margin-left: 20px;"><%="3."+i1+"."+ ++j +". "+obj1[3].toString() %></h4>
				
					<%} %>
					<%}}%>
				</div>
								
							<div><h4 style="margin-left: 10px;">
						<br><%=++contentCount %>. Verification Provisions
			</h4>
				</div>
				<%if(!Verifications.isEmpty()) {
				int verificationCount=0;
				for(Object[]obj:Verifications){
				%>
			<div ><h4  style="margin-left: 20px;">
		   <span><%=contentCount+"."+(++verificationCount)%>&nbsp;&nbsp;.
			<%=obj[1].toString() %></span></h4>
			</div>
								<%}} %>
			<h4 style="margin-left: 10px"><%=++contentCount %>. &nbsp;REQUIREMENTS TRACEABILITY</h4>
			<h4 style="margin-left: 20px"><%=contentCount %>.1 Traceability to Capability Document or System Specification</h4>
			<h4 style="margin-left: 20px"><%=contentCount %>.2 Traceability to Subsystems Requirements</h4>	
			<h4 style="margin-left: 10px"><%=++contentCount %>. &nbsp;APPENDIX SECTION</h4>
			<h4 style="margin-left: 20px"><%=contentCount %>.1 Appendix A - Acronyms and Definitions</h4>
			<h4 style="margin-left: 20px"><%=contentCount %>.2 Appendix B - Key Performance Parameters/Key System Attributes</h4>
			<h4 style="margin-left: 20px"><%=contentCount %>.2 Appendix C - Requirements Traceablity Matrices</h4>
			<h4 style="margin-left: 20px"><%=contentCount %>.2 Appendix B - Test Verification Matrices</h4> --%>
			<p style="text-align: center; page-break-before: always;font-family: <%= FontFamily %>;">&nbsp;</p>
						<%if(ReqIntro!=null) {%>
			<div style="page-break-before: always"></div>
						<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-color">
    <%= ++maincount %>.&nbsp;SCOPE
</h1>

				<hr style="width: 100%;">
					<%if(ReqIntro!=null){ %>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>; font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>1
					&nbsp;System Identification
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify;font-weight:<%=ParaFontWeight%>" >
				 
					<%if(ReqIntro[1]!=null) {%><%=ReqIntro[1]%>
					<%}else {%><div style="text-align: center;font-family: <%= FontFamily %>;">No Details Added!</div>
					<%} %>
					
				</div>
			</div>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>2
					&nbsp;System Block Diagram
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify; font-weight:<%=ParaFontWeight%>">
					<%if(ReqIntro[2]!=null) {%><%=ReqIntro[2]%>
					<%}else {%><div style="font-family: <%= FontFamily %>;text-align: center;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>3
					&nbsp;System Overview
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify; font-weight:<%=ParaFontWeight%>">
					<%if(ReqIntro[3]!=null) {%><%=ReqIntro[3]%>
					<%}else {%><div style="text-align: center;font-family: <%= FontFamily %>;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>4
					&nbsp;Document Overview
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify;  font-weight:<%=ParaFontWeight%>">
					<%if(ReqIntro[4]!=null) {%><%=ReqIntro[4]%>
					<%}else {%><div style="font-family: <%= FontFamily %>;text-align: center;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>5
					&nbsp;Applicable Standards
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify;  font-weight:<%=ParaFontWeight%>">
					<%if(ReqIntro[5]!=null) {%><%=ReqIntro[5]%>
					<%}else {%><div style="font-family: <%= FontFamily %>;text-align: center;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<%}else{ %>
			<div align="center" style="margin-top: 350px">
				<h4 style="font-family: <%= FontFamily %>;">No Data Available !</h4>
			</div>
			<%}} %>

			 <%if(!RequirementList.isEmpty()){ %>
			<div style="page-break-before: always;"></div>
			<div>
				<!-- <div align="center"> -->
			<h1 style="font-family: <%= FontFamily %>;font-size: <%= fontSize%>pt; font-weight:<%=HeaderFontWeight%>;color: black;" class="heading-color">
    <br><%=++maincount %>.&nbsp;&nbsp;System Requirements
</h1>
					<hr style="width: 100%;">
				<!-- </div> -->
				<%
	if(!RequirementList.isEmpty()){
		int reqcount=0;
	for(Object[]obj:RequirementList){ %>
				<div style="margin-left: 20px; margin-top: 15px; font-weight: 600;font-family: <%= FontFamily %>;">
					<h2 style="font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt"><%=maincount+"."+(++reqcount)%>&nbsp;&nbsp;Req ID
						&nbsp;::&nbsp;<%=obj[1].toString() %></h2>
				</div>
				<table class="border-black"
					style="margin-left: 20px;;width: 650px; margin-top: 10px; margin-bottom: 5px;font-family: <%= FontFamily %>;font-size: <%= ParaFontSize%>pt">
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
					<h4 style="font-family: <%= FontFamily %>;">No Data Available !</h4>
				</div>
				<%} }%> 
						<h1 style="font-family: <%= FontFamily %>;margin-left: 10px; font-size: <%= fontSize%>pt;font-weight:<%=HeaderFontWeight%>">
<br><%=++maincount %>.&nbsp;
APPLICABLE DOCUMENTS</h1>
	<hr style="width: 100%;">
	<h5 style="font-family: <%= FontFamily %>;margin-left: 10px; font-size: <%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>"> This section provides a list of reference documents upon which this document is either based, or to which this document refers.</h5>
										<h2 style="font-family: <%= FontFamily %>;margin-left: 20px ;font-weight:<%=SubHeaderFontweight%>;font-size:<%= SubHeaderFontsize%>pt"><%=maincount %>.1 General</h2>
							<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size: <%= ParaFontSize%>pt">No Document linked</div>
				
				<%if(!OtherRequirements.isEmpty()){ %>
				<div style="page-break-before: always;font-family: <%= FontFamily %>;"></div>
				<%-- <div >
					<h2 style="font-size: 20px !important; color:;"
						class="heading-color">
						<p style="text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>
						<br><%=++maincount %>.&nbsp;		
						Other System Requirements
					</h2>
				</div> --%>
				<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize%>pt;font-weight:<%=HeaderFontWeight%>"><%=++maincount %>. &nbsp;REQUIREMENTS</h1>
				<hr style="width: 100%;">
						<%int i=0;
	if(!OtherRequirements.isEmpty()){
	for(Object[]obj:OtherRequirements){ %>
				<div  style="font-size: <%= ParaFontSize%>pt;font-family: <%= FontFamily %>;">
					<%if(obj[2].toString().equalsIgnoreCase("0")) {%><h2
						style="font-family: <%= FontFamily %>;margin-left: 20px;font-weight:<%=SubHeaderFontweight%>;font-size:<%= SubHeaderFontsize%>pt"><%=maincount+"."+(++i)+". "+obj[3].toString()%></h2>
					<div style="margin-left: 20px;font-size: <%=ParaFontSize%>pt;text-align: justify; font-weight:<%=ParaFontWeight%>" >
						<%if(obj[4]!=null){ %><%=obj[4].toString()%>
						<%}else{ %><p style="text-align: center;">-&nbsp;&nbsp;No
							details filled &nbsp;&nbsp;-</p>
						<%} 
	int j=0;%>
					</div>
					<%for(Object[]obj1:OtherRequirements){ 
	if(obj[0].toString().equalsIgnoreCase(obj1[2].toString())){%>
					<h3 style="margin-left: 20px; font-weight:<%=SuperHeaderFontWeight%>; font-size:<%= SuperHeaderFontsize%>pt;"><%=maincount+"."+i+"."+ ++j +". "+obj1[3].toString() %></h3>
					<div style="font-size: <%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%> "><%if(obj1[4]!=null){ %> <%=obj1[4].toString()%></div>
					<%}else{ %>
					<p style="text-align: center;">-&nbsp;&nbsp;No details
						filled&nbsp;&nbsp;-</p>
					<%} %>
					<%} %>
					<%}}%>
				</div>
				<%}}else{ %>
				<div style="margin-top: 300px" align="center">
					<h4>No Data Available !</h4>
				</div>
				<%}} %>
				
			<%--	<% if(RequirementList!=null && ParaDetails!=null && !ParaDetails.isEmpty()&&!RequirementList.isEmpty()) { %>
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
				<%}%> --%>
				<div >
				<h1 style="font-family: <%= FontFamily %>;font-size: <%= fontSize%>pt; font-weight:<%=HeaderFontWeight%>;color: black !important;" class="heading-color">
    <br><%=++maincount %>. Verification Provisions
			</h1>
				<h2 style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.1	Verification Methods</h2>
				</div>
				<%if(!Verifications.isEmpty()) {
				int verificationCount=1;
				int j=0;
				for(Object[]obj:Verifications){
				%>
			<h3 style="font-family: <%= FontFamily %>;margin-left: 20px; font-weight:<%=SuperHeaderFontWeight%>;margin-top: 20px; font-size: <%= SuperHeaderFontsize%>pt;">
		   <span><%=maincount+"."+(verificationCount)%>.<%=++j %>
			<%=obj[1].toString() %></span>
				</h3>
				<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
				<%if(obj[3]!=null){ %><%=obj[3].toString()%>
				<%}else{ %><p style="text-align: center;">-&nbsp;&nbsp;No
					details filled&nbsp;&nbsp;-</p>
						<%}%>
					</div>
				<br>
				<% if(obj[1].toString().equalsIgnoreCase("Test")){%>
						<div style="text-align: center; padding-bottom: 30px;">
    <span style="font-size: 14px; font-weight: bold; text-decoration: underline;font-family: <%= FontFamily %>">Table A</span>
</div>
					<table class="border-black"
					style="width: 650px; margin-top: 20px; margin-bottom: 5px;font-family: <%= FontFamily %>;font-size: <%= ParaFontSize%>pt">
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
							<%} %>
									<%}} %>
				<h1 style="font-family: <%= FontFamily %>;font-size:<%= fontSize%>pt;font-weight:<%=HeaderFontWeight%>;margin-left: 5px;"><%=++maincount %>.	REQUIREMENTS TRACEABILITY</h1>	
		<!-- traceability -->			
						<% if(RequirementList!=null && ParaDetails!=null && !ParaDetails.isEmpty()&&!RequirementList.isEmpty()) { %>
				<div style="page-break-before: always"></div>
				<%-- <div align="center">
					<h3 style="font-size: 16px !important; margin-left: 50px;"
						class="heading-color">
						<br><%=++maincount %>. Traceability
					</h3>
				</div --%>
				<div align="left">
					<h2 style="font-family: <%= FontFamily %>;font-size: <%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>; color: black !important;margin-left: 20px" class="heading-color">
    <br><%= maincount %>.1 Forward Traceability Matrix
</h2>
				</div>
				<table class="border-black"
					style="width: 650px; margin-left: 20px; margin-top: 10px; margin-bottom: 5px;font-family: <%= FontFamily %>;font-size: <%= ParaFontSize%>pt">
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
					<h2
						style="font-family: <%= FontFamily %>;font-size:  <%= SubHeaderFontsize %>pt;font-weight:<%=SubHeaderFontweight%>; margin-left: 20px;"
						class="heading-color">
						<br><%=maincount %>.2 Reverse Traceability Matrix
					</h2>
				</div>
				<table class="border-black"
					style="width: 550px; margin-left: 20px; margin-top: 10px; margin-bottom: 5px;font-family: <%= FontFamily %>;">
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
					
					
									
									
				<h1 style="font-family: <%= FontFamily %>;font-weight:<%=HeaderFontWeight%>;font-size:<%= fontSize%>pt"><%=++maincount %>. APPEDNDIX SECTION</h1>
						<h2 style="font-family: <%= FontFamily %>;margin-left: 20px;font-weight:<%=SubHeaderFontweight%>;font-size:<%= SubHeaderFontsize%>pt"> <%=maincount %>.1	Appendix A - Acronyms and Definitions</h2>

			
    <table style="margin-left: 20px; font-family: <%= FontFamily %>;width: 550px; margin-top: 10px; margin-bottom: 5px; border: 1px solid black; border-collapse: collapse; margin-left: auto; margin-right: auto;font-size: <%= ParaFontSize%>pt">
        <thead>
            <tr>
                <th class="text-dark" style="border: 1px solid black; width: 20px; text-align: center;"><span class="text-dark">S.No</span></th>
                <th class="text-dark" style="border: 1px solid black; width: 60px;"><span class="text-dark">Acronyms</span></th>
                <th class="text-dark" style="border: 1px solid black; text-align: center; width: 90px;"><span class="text-dark">Definitions</span></th>
           </tr>
        </thead>
        <tbody>
        
        <% 
    if (AcronymsList != null) {
        int i = 1;
        for (Object[] alist : AcronymsList) {
%>
      <tr>
                <td style="text-align: center;border: 1px solid black;"><%=  i+++"."%></td>
                <td style="border: 1px solid black;padding-left: 10px;"><%= alist[1] %></td>
                <td style="border: 1px solid black; padding-left: 10px;"><%= alist[2] %></td>
            </tr>
            <% 
   }} 
%>
        </tbody>
    </table>
  <h4 style="font-family: <%= FontFamily %>;margin-left: 20px;font-weight:normal;font-size: <%= ParaFontSize%>pt">Guidance:
This appendix contains acronyms and provides standard definitions for terminology used herein
</h4>
	<h2 style="font-family:<%= FontFamily %>;margin-left: 20px;font-size: <%= SubHeaderFontsize %>pt;font-weight:<%=SubHeaderFontweight%>"> <%=maincount %>.2 Appendix B -Key Performance Parameters / Key System Attributes</h2>
		<h4 style="font-family:<%=FontFamily %>;margin-left: 20px; font-weight:normal; text-align: justify;font-size: <%= ParaFontSize%>pt"> The key Measures of Effectiveness (MOE) are given below :</h4>
    <table style="font-family: <%= FontFamily %>;width: 550px; margin-top: 10px; margin-bottom: 5px; border: 1px solid black; border-collapse: collapse; margin-left: 20px margin-right: auto;font-size: <%= ParaFontSize%>pt">
        <thead>
            <tr>
                <th class="text-dark" style="border: 1px solid black; width: 20px; text-align: center;"><span class="text-dark">S.No</span></th>
                <th class="text-dark" style="border: 1px solid black; width: 60px;padding: 5px; "><span class="text-dark">Key MOEs</span></th>
                <th class="text-dark" style="border: 1px solid black; text-align: center; width: 100px;"><span class="text-dark">Values</span></th>
           </tr>
        </thead>
        <tbody>
              <% 
    if (PerformanceList != null) {
        int i = 1;
        for (Object[] plist : PerformanceList) {
%>
             <tr>
                <td style="text-align: center;border: 1px solid black;"><%=  i+++"."%></td>
                <td style="border: 1px solid black;padding-left: 10px;"><%= plist[1] %></td>
                <td style="border: 1px solid black; padding-left: 10px;text-align:center"><%= "-"+plist[2] +"-"%></td>
            </tr>
            <% 
   }} 
%>
        </tbody>
    </table>
			<h4 style="font-family: <%= FontFamily %>;margin-left: 20px; font-weight: normal; text-align: justify;font-size: <%= ParaFontSize%>pt">Guidance:
    This appendix contains tabularized KPPs, and KSAs, if applicable, listed in prioritized order.<br>
    Sample Key performance Parameters / Key System Attributes are shown above. Modify the Key performance Parameters / Key System Atributes based on your specific project constraints. 
</h4>

			<h2 style="font-family: <%= FontFamily %>;margin-left: 20px;font-size: <%=SubHeaderFontsize%>pt; font-weight:<%=SubHeaderFontweight%>"><%=maincount %>.3	Appendix C - Requirements Traceability Matrices
</h2>	
			<h4 style="font-family: <%= FontFamily %>;margin-left: 20px ;font-weight:normal;font-size: <%= ParaFontSize%>pt">  The Traceability to next level should be provided in - SSS Type A. Traceability to OR already provided in Sec 5.1</h4>
	<h2 style="font-family: <%= FontFamily %>; margin-left: 20px; font-size: <%= SubHeaderFontsize%>pt; font-weight:<%=SubHeaderFontweight%>"><%=maincount %>.4	Appendix D - Test Verification Matrices</h2>			
			<div style="font-family: <%= FontFamily %>;">
			${htmlContent}
			</div>
		<h4 style="font-family: <%= FontFamily %>;margin-left: 20px ;font-weight:normal;text-align: justify;font-size: <%= ParaFontSize%>pt"> 	Guidance:
This appendix contains tabularized verification method for every system or subsystem requirement.  If not known, pre contract award, the verification method is to be included in the resultant system or subsystem specification.
Sample Test verification Matrix are shown above. Modify the Verification matrix based on your specific project constraints. 
			<%=SuperHeaderFontWeight%>
			</h4>
			</div>
		</div>
			</div>
			
</body>
 
</html>