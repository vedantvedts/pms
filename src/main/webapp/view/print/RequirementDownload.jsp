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
<%-- <%
List<Object[]>OtherRequirements=(List<Object[]>)request.getAttribute("OtherRequirements");
String lablogo=(String)request.getAttribute("lablogo");
/* Object[]PfmsInitiationList=(Object[])request.getAttribute("PfmsInitiationList"); */
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
/* String projectName=PfmsInitiationList[7].toString();
String classification=PfmsInitiationList[5].toString();
String projectshortName=PfmsInitiationList[6].toString(); */
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
List<Object[]>VerificationDataList=(List<Object[]>)request.getAttribute("VerificationDataList");
List<Object[]>ProjectParaDetails=(List<Object[]>)request.getAttribute("ProjectParaDetails");
List<Object[]>ApplicableTotalDocumentList=(List<Object[]>)request.getAttribute("ApplicableTotalDocumentList");
String projectShortName =(String)request.getAttribute("projectShortName");
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

	margin-top: 30px;
	margin-right: 10px;
}
@
top-left {
	margin-top: 30px;
	margin-left: 10px;
	content:
	
}
@
top-left {
	margin-top: 30px;
	margin-left: 10px; 
	content: "<%=Labcode%>";
	
}
@
top-center {
	font-size: 13px;
	margin-top: 30px;
	
}
@
bottom-center {
	font-size: 13px;
	margin-bottom: 30px;
	
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
		<button id="btn-export" class="btn btn-lg bg-transparent" 
			style="padding: 10px;">
			<i class="fa fa-lg fa-download" aria-hidden="true"
				style="color: green;"></i>
		</button>
	</div>
	<div class="source-html-outer">
<div class="static-header">
    <div class="logo-container">
        <img class="logo" 
            <%if (lablogo != null) {%> src="data:image/png;base64,<%=lablogo%>" alt="Configuration" <%} else {%> alt="File Not Found" <%}%>>
    </div>
    <div class="logo-container">
        <img class="logo" 
            <%if (labImg != null) {%> src="data:image/png;base64,<%=labImg%>" alt="Configuration" <%} else {%> alt="File Not Found" <%}%>>
    </div>
</div>
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
			<p style="text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>	
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
					<div align="center" >
						<img class="logo" style="width: 100px; height: 100px; margin-bottom: 5px"
							<%if (labImg != null) {%> src="data:image/png;base64,<%=labImg%>" alt="Configuration"
							<%} else {%> alt="File Not Found" <%}%>>
				</div>
				<div>
				</div>
					<div align="center"></div>
			<div style="text-align: center; margin-top: 75px;font-family: <%= FontFamily %>;">
				<h4 style="font-size: 18pt; !important;font-family: <%= FontFamily %>;" class="heading-color">SYSTEM
					REQUIREMENTS DOCUMENT</h4>
				<h4 style="font-size: 14px;">For</h4>
				<h4 style="">
					Project:
					<%=PfmsInitiationList[7].toString()%>
					<%="("+ PfmsInitiationList[6].toString() +")"%>
				</h4>
				<h4 style="font-size: 14px; ">
				<span style="text-decoration: underline;">Requirement No.:</span>
				<%if (reqStatus!=null && reqStatus[3] != null) {%><%=reqStatus[3].toString()%>
					<%} else {%>-<%}%>
				</h4>
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
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">1.&nbsp; Title: <span class="text-dark">System Requirements Document </span></td>
					</tr>
					<tr >
					<td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;">2.&nbsp; Type of Document:<span class="text-dark">System Requirements Document</span></td>
					<td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;">3.&nbsp; Classification: <span class="text-dark"></span></td>
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
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">9.&nbsp; Pro Project Name: <%=projectShortName %><span class="text-dark"> </span></td>
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
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">15.&nbsp; Prepared by:<span class="text-dark"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[10] %><%} %></span></td>
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
									<%if(ReqIntro!=null) {%>
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
			<h4 style="margin-left: 20px"><%=contentCount %>.2 Appendix B - Test Verification Matrices</h4>
			<p style="text-align: center; page-break-before: always;font-family: <%= FontFamily %>;">&nbsp;</p>
					
			<div style="page-break-before: always"></div>
						<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-color">
    <%= ++maincount %>.&nbsp;SCOPE
</h1>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>; font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>1
					&nbsp;System Identification
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify;font-weight:<%=ParaFontWeight%>" >
				 
					<%if(ReqIntro!=null && ReqIntro[1]!=null) {%><%=ReqIntro[1]%>
					<%}else {%><div style="text-align: justify;font-family: <%= FontFamily %>;font-weight:200;">
					Guidance: 
					This paragraph should contain a full identification of the system to which this document applies.  
					</div>
					<%} %>
					
				</div>
			</div>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>2
					&nbsp;System Block Diagram
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify; font-weight:<%=ParaFontWeight%>">
					<%if(ReqIntro!=null && ReqIntro[2]!=null) {%><%=ReqIntro[2]%>
					<%}else {%><div style="font-family: <%= FontFamily %>;text-align: center;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>2
					&nbsp;System Overview
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify; font-weight:<%=ParaFontWeight%>">
					<%if(ReqIntro!=null && ReqIntro[3]!=null) {%><%=ReqIntro[3]%>
					<%}else {%>
					<div style="text-align:justify;font-family: <%= FontFamily %>;font-weight:200;">
					Guidance:  
					This paragraph should briefly describe the general nature of the system required. It summarizes the objectives of the system from various perspectives (Operational, Maintenance, Deployment, Technological, Environmental and so on...), should give a brief description of the operating scenario and desired configuration of the system. It should also state the identified project sponsor, acquirer, developer, and support agencies; along with current and planned operating sites.
					</div>
					<%} %>
				</div>
			</div>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>3
					&nbsp;Document Overview
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify;  font-weight:<%=ParaFontWeight%>">
					<%if(ReqIntro!=null && ReqIntro[4]!=null) {%><%=ReqIntro[4]%>
					<%}else {%>
					<div style="font-family: <%= FontFamily %>;text-align: justify;ffont-weight:200;">
					This document brings out the system requirements of the radar system. The document gives a brief overview of the system, states the modes of operation of the radar (operational, maintenance, training and so on..) along with types of operational modes. All requirements are classified under various categories and stated in a brief unambiguous manner after resolving all conflicts and identifying derived requirements. The various design and construction constraints imposed on the system either by the User or by the designer are clearly brought out. This document also brings out the precedence and criticality of the requirements. Verification methodologies such as Demonstration /Test / Analysis / Inspection / Special verification methods employed to validate the system requirements are clearly listed. This document also contains a tabularized verification matrix for every system requirement, Requirements Traceability matrix and states the key performance parameters/key system attributes. 
					</div>
					<%} %>
				</div>
			</div>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>5
					&nbsp;Applicable Standards
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify;  font-weight:<%=ParaFontWeight%>">
					<%if(ReqIntro!=null && ReqIntro[5]!=null) {%><%=ReqIntro[5]%>
					<%}else {%><div style="font-family: <%= FontFamily %>;text-align: center;">No Details Added!</div>
					<%} %>
				</div>
			</div>
	<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-color">
    <%= ++maincount %>.&nbsp;Applicable Documents</h1>
	<%if(ApplicableTotalDocumentList!=null && ApplicableTotalDocumentList.size()>0) {
    int snCOunt=0;
    	for(Object[]obj:ApplicableTotalDocumentList){
    %>
    <div style="font-size: 12pt;"> <%=++snCOunt %>.<%=obj[1].toString() %></div>
    
    
    <%}} %>

<h1 style="font-family: <%= FontFamily %>;font-size: <%= fontSize%>pt; font-weight:<%=HeaderFontWeight%>;color: black;" class="heading-color">
<br><%=++maincount %>.&nbsp;&nbsp;Requirements
</h1>
<%if(!RequirementList.isEmpty()) {
List<Object[]>mainReqList=RequirementList.stream().filter(e->e[15]!=null && e[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
int mainReqCount=0;
for(Object[]obj:mainReqList){
%>
<div style="padding:none;"><h2 style="font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt"><%=maincount+"."+(++mainReqCount) %>  &nbsp;<%=obj[3].toString() %></h2></div>
<%if(obj[4]!=null) {%><div style="padding:0px;"><%=obj[4].toString()%></div><%}else{ %><span></span><%} %>
<%List<Object[]>subMainReqList =  RequirementList.stream().filter(e->e[15]!=null && e[15].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());%>
<%
String ReqName="";
int subReqCount=0;
for(Object[]obj1:subMainReqList) {
int snCount=0;
%>
<%if(!ReqName.equalsIgnoreCase(obj1[3].toString()) && !obj1[3].toString().equalsIgnoreCase(obj[3].toString())) {%>
<h3 style="padding:0px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt ;" ><%=maincount+"."+(mainReqCount)+"."+(++subReqCount)%>&nbsp;<%=obj1[3].toString() %></h3>
<%} %>

<br>
<table class=""
					style="margin-left: 20px;;width: 650px; margin-bottom: 5px;font-family: <%= FontFamily %>;font-size: <%= ParaFontSize%>pt">
					<thead>
						<tr>
							<th class="border-black"
								style="width: 20px;  border: 1px solid black; border-collapse: collapse;">SN</th>
							<th class="border-black"
								style="width: 130px;  text-align: center; border: 1px solid black; border-collapse: collapse;">Attribute</th>
							<th class="border-black"
								style=" border: 1px solid black; border-collapse: collapse;">Content</th>
						</tr>
						</thead>
						<tbody>
							<tr>
							<td class="border-black"
								style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %></td>
							<td class="border-black"
								style=" text-align: left; border: 1px solid black; border-collapse: collapse; font-weight: 600;">ID</td>
							<td class="border-black"
								style=" text-align: left; border: 1px solid black; border-collapse: collapse;"><%=obj1[1].toString() %></td>
						</tr>
						
						
							<tr>
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
						<tr>
							<td class="border-black"
								style="border: 1px solid black; border-collapse: collapse;  text-align: center; vertical-align: top;"><%=++snCount %>.</td>
							<td class="border-black"
								style="border: 1px solid black; border-collapse: collapse;  text-align: left; vertical-align: top;font-weight: 600;">Description</td>
							<td class="border-black"
								style="text-align: justify; border: 1px solid black; border-collapse: collapse; vertical-align: top;">
								<%if(obj1[4]!=null){ %> <%=obj1[4].toString() %> <%}else{ %>-<%} %>
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
List<Object[]>nonMainReqList=RequirementList.stream().filter(e->e[15]!=null && !e[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
%>
<%if(nonMainReqList!=null && !nonMainReqList.isEmpty()) { %>
<div style="padding:none;"><h2 style="font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt"><%=maincount+"."+(++mainReqCount) %>  &nbsp; Precedence and Criticality of Requirements</h2></div>
<table class=""style="margin-left: 20px;;width: 400px; margin-bottom: 5px;font-family: <%= FontFamily %>;font-size: <%= ParaFontSize%>pt">
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
							<td style="text-align:justify;border: 1px solid black; border-collapse: collapse;"><%=obj[1].toString() %></td>
							<td style="text-align:center;border: 1px solid black; border-collapse: collapse;"><%if(obj[5]!=null) {%><%=obj[5].toString()%><%}else{ %>-<%} %></td>
							<td style="text-align:center;border: 1px solid black; border-collapse: collapse;"><%if(obj[21]!=null) {%> <%=obj[21].toString() %>
								<%}else{%>-<%} %></td>
						</tr>
						<%}} %>
						</tbody>
						</table>
<% } %>
<%} %>



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
				<div >
					<h2 style="font-size: 20px !important; color:;"
						class="heading-color">
						<p style="text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>
						<br><%=++maincount %>.&nbsp;		
						Other System Requirements
					</h2>
				</div>
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
				
				<% if(RequirementList!=null && ParaDetails!=null && !ParaDetails.isEmpty()&&!RequirementList.isEmpty()) { %>
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
				<div >
				<h1 style="font-family: <%= FontFamily %>;font-size: <%= fontSize%>pt; font-weight:<%=HeaderFontWeight%>;color: black !important;" class="heading-color">
    			<br><%=++maincount %>. Verification Provisions
			</h1>
				<h2 style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.1	Verification Methods</h2>
				</div>
				<%if(Verifications!= null &&   !Verifications.isEmpty()) {
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

									<%}} %>
									
							<table class="border-black"
					style="width: 650px; margin-left: 20px; margin-top: 10px; margin-bottom: 5px;font-family: <%=FontFamily%>;font-size: <%=ParaFontSize%>pt">
					<thead>
						<tr>
							<th class="border-black"
								style="width: 20px; padding: 5px; border: 1px solid black; border-collapse: collapse;">SN</th>
							<th class="border-black"
								style="width: 130px; padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">Verification Method</th>
							<th class="border-black"
								style="width: 180px; padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">Type of Test</th>
							<th class="border-black"
								style="width: 150px; border: 1px solid black;text-align: center; border-collapse: collapse;">Purpose</th>
						</tr>
					</thead>
					<tbody>
				
					 <%
		
					 int countSN=0;
					 int SN=0;
					 String data="";
					 int subcount=0;
	                   	for(Object[]obj:VerificationDataList){
	                   	++SN;
	                   	%>
						<tr>
						<td class="border-black" 
						<%if(SN==VerificationDataList.size()) {%>style="padding: 5px; text-align: center; border: 1px solid black;border-top:none; border-collapse: collapse;"<%} %>
						  <%if(!data.equalsIgnoreCase(obj[2].toString())){ %> style="padding: 5px; text-align: center; border: 1px solid black; border-bottom:none; border-collapse: collapse;"<%}else{ %>
						    style="padding: 5px; text-align: center; border-right:1px solid black; border-left:1px solid black; border-collapse: collapse;" <%} %>>
							 <%if(!data.equalsIgnoreCase(obj[2].toString())){ %> <%=++countSN %><%} %>
							</td>
							<td class="border-black"   
							<%if(SN==VerificationDataList.size()) {%>style="padding: 5px; text-align: center; border: 1px solid black;border-top:none; border-collapse: collapse;"<%} %>
							  <%if(!data.equalsIgnoreCase(obj[2].toString())){ %> style="padding: 5px; text-align: center; border: 1px solid black;   border-bottom:none;    border-collapse: collapse;"<%}else{ %>
							    style="padding: 5px; text-align: center; border-right:1px solid black;   border-left:1px solid black;    border-collapse: collapse;" <%} %>>
							   <%if(!data.equalsIgnoreCase(obj[2].toString())){ %> <%=obj[2] %><%} %>
							 </td>
							<%if(!data.equalsIgnoreCase(obj[2].toString())){
								subcount=0;
							} %> 
							<td class="border-black"style="padding: 5px; text-align: justify; border: 1px solid black; border-collapse: collapse;">  <%=obj[2].toString().substring(0,1)+(++subcount)+". "+obj[3] %></td>
							<td class="border-black"style="padding: 5px; text-align: justify; border: 1px solid black; border-collapse: collapse;"><%=obj[4]%></td>
						</tr>
					 <%
					 data = obj[2].toString();
	                 } %>
					</tbody>
				</table>				
									
									
				<h1 style="font-family: <%= FontFamily %>;font-size:<%= fontSize%>pt;font-weight:<%=HeaderFontWeight%>;margin-left: 5px;"><%=++maincount %>.	REQUIREMENTS TRACEABILITY</h1>	
		<!-- traceability -->			
						<% if(RequirementList!=null && ParaDetails!=null && !ParaDetails.isEmpty()&&!RequirementList.isEmpty()) { %>
				<div style="page-break-before: always"></div>
				<div align="center">
					<h3 style="font-size: 16px !important; margin-left: 50px;"
						class="heading-color">
						<br><%=++maincount %>. Traceability
					</h3>
				</div
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
					
			<% if(RequirementList!=null && ProjectParaDetails!=null && !ProjectParaDetails.isEmpty()&&!RequirementList.isEmpty()) {   
				List<Object[]>subList= RequirementList.stream().filter(e->e[15]!=null && !e[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
			%>		
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
								style="width: 130px; padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">RequirementId</th>
							<th class="border-black"
								style="width: 180px; padding: 20px; text-align: center; border: 1px solid black; border-collapse: collapse;">QR
								 No</th>
						</tr>
					</thead>
					<tbody>
					<%int snCount=0;	
					for(Object[]objs:subList) {
					%>
					<%if(objs[12]!=null) {%>
					<tr>
					<td style="width: 20px; border: 1px solid black;text-align:center; border-collapse: collapse;" ><%=++snCount %></td>
					<td style="width: 20px; border: 1px solid black;text-align:center; border-collapse: collapse;"><%=objs[1].toString() %></td>
					<td style="width: 20px; border: 1px solid black;text-align:center; border-collapse: collapse;" >
					
					
								<%if(objs[12]!=null) {
									String [] a=objs[12].toString().split(", ");
									for(String s:a){
								%> 
								
								 <%=ProjectParaDetails.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[3].toString()).collect(Collectors.joining(",")) %><br> 
								<%}}else{ %>
								-
								<%} %>
					</td>
					</tr>
					<%} %>
					<%} %>					
					</tbody>
					</table>
					
				
				<%} %>
									
									
				<h1 style="font-family: <%= FontFamily %>;font-weight:<%=HeaderFontWeight%>;font-size:<%= fontSize%>pt"><%=++maincount %>. APPENDIX SECTION</h1>
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
   }}%> 
		
        </tbody>
    </table>
			<h4 style="font-family: <%= FontFamily %>;margin-left: 20px; font-weight: normal; text-align: justify;font-size: <%= ParaFontSize%>pt">Guidance:
    This appendix contains tabularized KPPs, and KSAs, if applicable, listed in prioritized order.<br>
    Sample Key performance Parameters / Key System Attributes are shown above. Modify the Key performance Parameters / Key System Atributes based on your specific project constraints. 
</h4>

			<h2 style="font-family: <%= FontFamily %>;margin-left: 20px;font-size: <%=SubHeaderFontsize%>pt; font-weight:<%=SubHeaderFontweight%>"><%=maincount %>.3	Appendix C - Requirements Traceability Matrices
</h2>	
			<h4 style="font-family: <%= FontFamily %>;margin-left: 20px ;font-weight:normal;font-size: <%= ParaFontSize%>pt">  The Traceability to next level should be provided in - SSS Type A. Traceability to OR already provided in Sec 5.1</h4>
	<h2 style="font-family: <%= FontFamily %>; margin-left: 20px; font-size: <%= SubHeaderFontsize%>pt; font-weight:<%=SubHeaderFontweight%>"><%=maincount %>.3	Appendix D - Test Verification Matrices</h2>			
			<div style="font-family: <%= FontFamily %>;">
			
			 <table style="font-family: <%= FontFamily %>;width: 650px; margin-top: 10px; margin-bottom: 5px; border: 1px solid black; border-collapse: collapse; margin-left: 20px margin-right: auto;font-size: <%= ParaFontSize%>pt">
			 <thead>
            <tr>
                <th class="text-dark" style="border: 1px solid black; width: 120px; text-align: center;"><span class="text-dark">Verification method</span></th>
                <th class="text-dark" style="border: 1px solid black; padding: 5px; width:120px;"><span class="text-dark">Demonstration</span></th>
                <th class="text-dark" style="border: 1px solid black; text-align: center; width: 120px;"><span class="text-dark">Test</span></th>
                <th class="text-dark" style="border: 1px solid black; text-align: center; width: 120px;"><span class="text-dark">Analysis</span></th>
                <th class="text-dark" style="border: 1px solid black; text-align: center; width: 120px;"><span class="text-dark">Inspection</span></th>
                <th class="text-dark" style="border: 1px solid black; text-align: center; width: 120px;"><span class="text-dark">Special Verification Method</span></th>
           </tr>
           
        </thead>
			<tbody>
        <%
           if(!RequirementList.isEmpty()){
        	   List<Object[]>mainReqList=RequirementList.stream().filter(k->k[15]!=null && k[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
        	   for(Object []obj:mainReqList){
        		   
        		   List<Object[]>submainReqList=RequirementList.stream().filter(k->k[15]!=null && k[15].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());
        %>
        <%if(submainReqList.size()>0){%>
           <tr>
           <td style="border: 1px solid black; width: 120px; text-align: left;" colspan="6"><%=obj[3].toString() %>:-</td>
           
           </tr>
           <%
           String ReqName="";
           for(Object[]obj1:submainReqList){ %>
           <%if(!ReqName.equalsIgnoreCase(obj1[3].toString()) && !obj1[3].toString().equalsIgnoreCase(obj[3].toString())) {%>
				<tr>
				<td style="border: 1px solid black; width: 120px; text-align: left;" colspan="6"><%=obj1[3].toString() %></td>			</tr>	
				<%} %>
           
           <tr>
           <td style="border: 1px solid black; width: 120px; text-align: left;" ><%=obj1[1].toString() %></td>
           <td style="border: 1px solid black; width: 120px; text-align: left;"><%if(obj1[16]!=null) {%><%=obj1[16].toString() %> <%}else{ %>-<%} %></td>
           <td style="border: 1px solid black; width: 120px; text-align: left;"> <%if(obj1[17]!=null) {%><%=obj1[17].toString() %> <%}else{ %>-<%} %></td>
           <td style="border: 1px solid black; width: 120px; text-align: left;"> <%if(obj1[18]!=null) {%><%=obj1[18].toString() %> <%}else{ %>-<%} %></td>
           <td style="border: 1px solid black; width: 120px; text-align: left;"> <%if(obj1[19]!=null) {%><%=obj1[19].toString() %> <%}else{ %>-<%} %></td>
           <td style="border: 1px solid black; width: 120px; text-align: left;"> <%if(obj1[20]!=null) {%><%=obj1[20].toString() %> <%}else{ %>-<%} %></td>
           </tr>
           <%
           ReqName=obj1[3].toString();
           } %>
           <%} %>
           <%}} %>
           </tbody>
			</table>
			</div>

			</div>
		</div>
			</div> --%>
	</head>		
	<body>
		<button onclick="generatePDF()" id="generatePDF">Download PDF</button>
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
			
	<%
		List<Object[]> ParaDetails = (List<Object[]>)request.getAttribute("ParaDetails");
		List<Object[]> AcronymsList = (List<Object[]>)request.getAttribute("AcronymsList");
		List<Object[]> PerformanceList = (List<Object[]>)request.getAttribute("PerformanceList");
		String isPdf = (String)request.getAttribute("isPdf");
	%>		

<script>
    function generatePDF() {
        // Capture HTML content from specified sections
        //var verification = document.getElementById('verification').innerHTML;
        //var MemberList = document.getElementById('MemberList').innerHTML;
        //var docSummary = document.getElementById('docSummary').innerHTML;
        //var abbreviationDiv = document.getElementById('abbreviationDiv').innerHTML;
        //var scopeDiv = document.getElementById('scopeDiv').innerHTML;
        //var reqDiv = document.getElementById('reqDiv').innerHTML;
        //var verificationDiv = document.getElementById('verificationDiv').innerHTML;
        
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
                                { text: '<% if (LabList!=null && LabList[1] != null) {%> <%=LabList[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + "(" + LabList[0].toString() + ")"%> <%} else {%> - <%}%>'
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
                		  +'<%}else {%> Guidance: This paragraph should contain a full identification of the system to which this document applies. <%} %>', 500))],
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
                		  +'<%}else {%> Guidance: This paragraph should briefly describe the general nature of the system required. It summarizes the objectives of the system from various perspectives (Operational, Maintenance, Deployment, Technological, Environmental and so on...), should give a brief description of the operating scenario and desired configuration of the system. It should also state the identified project sponsor, acquirer, developer, and support agencies; along with current and planned operating sites. <%} %>', 500))],
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
                		  +'<%}else {%> This document brings out the system requirements of the radar system. The document gives a brief overview of the system, states the modes of operation of the radar (operational, maintenance, training and so on..) along with types of operational modes. All requirements are classified under various categories and stated in a brief unambiguous manner after resolving all conflicts and identifying derived requirements. The various design and construction constraints imposed on the system either by the User or by the designer are clearly brought out. This document also brings out the precedence and criticality of the requirements. Verification methodologies such as Demonstration /Test / Analysis / Inspection / Special verification methods employed to validate the system requirements are clearly listed. This document also contains a tabularized verification matrix for every system requirement, Requirements Traceability matrix and states the key performance parameters/key system attributes. <%} %>', 500))],
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
    	                                { text: '<%=obj1[1] %>', style: 'tableData' },
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
    	                            
    	                            [
    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
    	                                { text: 'Link Sub-Systems', style: 'tableData' },
    	                                { text: '<%if(obj1[23]!=null) { String [] a=obj1[23].toString().split(", "); for(String s:a){ %> <%=productTreeList.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[2].toString()).collect(Collectors.joining("")) %> \n <%}}else{ %> - <%} %>', style: 'tableData' },
    	                            ],
    	                            
    	                            

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
		
        pdfMake.createPdf(docDefinition).open();
        
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

    	<%if(isPdf!=null && isPdf.equalsIgnoreCase("Y")) {%>
	    	$( document ).ready(function(){
	    		generatePDF();
	    		/* window.close(); */
	    		
	    		// Hide the current JSP page immediately after opening the PDF
    			document.body.style.display = "none";
	    		
	    		setTimeout(function () {
			        window.close();
			    }, 5000); // Adjust the delay time as needed
	    	});
    	<%} %>
</script>
</body>
 
</html>