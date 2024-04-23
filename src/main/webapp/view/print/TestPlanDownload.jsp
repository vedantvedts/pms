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
 /* 	 $( document ).ready(function() {
		 download();
		});  */
		 function download(){
			$("#source-html").wordExport("System-Test Plan");
	 }
</script>
<spring:url value="/resources/js/FileSaver.min.js" var="FileSaver" />
<script src="${FileSaver}"></script>
<spring:url value="/resources/js/jquery.wordexport.js" var="wordexport" />
<script src="${wordexport}"></script>
<meta charset="ISO-8859-1">
<title>Test Plan Document</title>
<%
//List<Object[]>OtherRequirements=(List<Object[]>)request.getAttribute("OtherRequirements");
String lablogo=(String)request.getAttribute("lablogo");
//Object[]PfmsInitiationList=(Object[])request.getAttribute("PfmsInitiationList");
Object[]LabList=(Object[])request.getAttribute("LabList");
//List<Object[]>RequirementList=(List<Object[]>)request.getAttribute("RequirementList");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf3=fc.getRegularDateFormat();
SimpleDateFormat sdf=fc.getRegularDateFormatshort();
SimpleDateFormat sdf1=fc.getSqlDateFormat();
Object[]TestScopeIntro=(Object[])request.getAttribute("TestScopeIntro");
String uploadpath=(String)request.getAttribute("uploadpath");
String labImg=(String)request.getAttribute("LabImage");
List<Object[]>AbbreviationDetails=(List<Object[]>)request.getAttribute("AbbreviationDetails");
List<Object[]>MemberList=(List<Object[]>)request.getAttribute("MemberList");
List<Object[]> DocumentSummary=(List<Object[]>)request.getAttribute("DocumentSummary");
Object[] DocTempAtrr=(Object[])request.getAttribute("DocTempAttributes");
List<Object[]>TestContentList=(List<Object[]>)request.getAttribute("TestContent");
List<Object[]>AcceptanceTesting= (List<Object[]>)request.getAttribute("AcceptanceTesting");
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

String Schedule = null;
String Approach = null;
String Conclusion = null;
String Approachid=null;
String Scheduleid=null;
String Conclusionid=null;
if (TestContentList != null) {
    for (Object[] testClist : TestContentList) { 
        String Testtype = testClist[0].toString(); 
        if ("Approach".equalsIgnoreCase(Testtype)) {
            Approach = testClist[1].toString();
           // Approachid =testClist[2].toString();
        } else if ("Schedule".equalsIgnoreCase(Testtype)) {
            Schedule = testClist[1].toString();
            Scheduleid =testClist[2].toString();
        } else if ("Conclusion".equalsIgnoreCase(Testtype)) {
            Conclusion =testClist[1].toString();
            //Conclusionid =testClist[2].toString();
        }
    }
}
%>
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
		<div id="source-html">
    <!-- Your existing HTML content goes here -->
    <!-- ... -->
     <%
     /*  Doc Temp Starts */
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
                /*  Doc Temp end */
      
            	if (TestContentList != null) {
            	    for (Object[] testClist : TestContentList) { 
            	        String Testtype = testClist[0].toString(); 
            	        if ("Approach".equalsIgnoreCase(Testtype)) {
            	            Approach = testClist[1].toString();
            	            Approachid =testClist[2].toString();
            	        } else if ("Schedule".equalsIgnoreCase(Testtype)) {
            	            Schedule = testClist[1].toString();
            	            Scheduleid =testClist[2].toString();
            	        } else if ("Conclusion".equalsIgnoreCase(Testtype)) {
            	            Conclusion =testClist[1].toString();
            	            Conclusionid =testClist[2].toString();
            	        }
            	    }
            	}
            	String TestSetUp=(String)request.getAttribute("TestSetUp");
            	String TestSetUpDiagram=(String)request.getAttribute("TestSetUpDiagram");
            	String TestingTools=(String)request.getAttribute("Testingtools");
            	String TestVerification=(String)request.getAttribute("TestVerification");
            	String RoleResponsibility=(String)request.getAttribute("RoleResponsibility");
            	String projectShortName =(String)request.getAttribute("projectShortName");
            	String projectTitle =(String)request.getAttribute("projectTitle");
            	
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
				<%=LabList[0].toString()%>:SSTP:....................</h4>
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
				<h4 style="font-size: 18pt;;font-family:<%= FontFamily %>; !important;" class="heading-color ">SYSTEM SUB SYSTEM TEST PLAN</h4>
				<h4 style="font-size: 15pt;font-family: <%= FontFamily %>;">For</h4>
				<h4 style="font-size: 18pt;font-family: <%= FontFamily %>;">
					Project - <%=projectTitle %>(<%=projectShortName %>)
					<br> <br> <br>	<br> <br>
					
				</h4>
				
					<div align="center" >
						<img class="logo" style="width: 80px; height: 80px; margin-bottom: 5px"
							<%if (lablogo != null) {%> src="data:image/png;base64,<%=lablogo%>" alt="Configuration"
							<%} else {%> alt="File Not Found" <%}%>>
				</div>
				<br> <br>	<br> <br>	<br>
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
				<%=LabList[0].toString()%>:SSTP:....................</h4>
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
				<div>
				</div>
					<div align="center"></div>
			<div style="text-align: center; margin-top: 75px;font-family: <%= FontFamily %>;">
				<h4 style="font-size: 18pt; !important;font-family: <%= FontFamily %>;" class="heading-color">SYSTEM SUB SYSTEM TEST PLAN</h4>
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
				<table style="width: 650px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;font-family: <%= FontFamily %>;border-collapse: collapse;">
					<tr>
					<td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">1.&nbsp; Title: <span class="text-dark">System Sub System Test Plan Document Template</span></td>
					</tr>
					<tr >
					<td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;">2.&nbsp; Type of Document:<span class="text-dark">System Sub System Test Plan Document</span></td>
					<%-- <td class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;">3.&nbsp; Classification: <span class="text-dark"><%=classification %></span></td> --%>
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
				     <td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">9.&nbsp; Project Number and Project Name: <span class="text-dark">) </span></td>
					<%-- <td  class="text-dark" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">9.&nbsp; Project Number and Project Name: <span class="text-dark"><%=projectName %> (<%= projectshortName %>) </span></td> --%>
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
			<p style="text-align: center; page-break-before: always;font-family: <%= FontFamily %>;">&nbsp;</p>
						
						  <div class="landscape-content">
			<div style="page-break-before: always"></div>
						<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-color">
    <%= ++maincount %>.&nbsp;SCOPE
</h1>
				<hr style="width: 100%;">
					
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>; font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>1
					&nbsp;Introduction
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify;font-weight:<%=ParaFontWeight%>" >
				 
					<%if(TestScopeIntro!=null && TestScopeIntro[1]!=null) {%><%=TestScopeIntro[1]%>
					<%}else {%><div style="text-align: center;font-family: <%= FontFamily %>;">No Details Added!</div>
					<%} %>
					
				</div>
			</div>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>2
					&nbsp;System Identification
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify; font-weight:<%=ParaFontWeight%>">
					<%if(TestScopeIntro!=null && TestScopeIntro[2]!=null) {%><%=TestScopeIntro[2]%>
					<%}else {%><div style="font-family: <%= FontFamily %>;text-align: center;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>3
					&nbsp;System Overview
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify; font-weight:<%=ParaFontWeight%>">
					<%if(TestScopeIntro!=null &&  TestScopeIntro[3]!=null) {%><%=TestScopeIntro[3]%>
					<%}else {%><div style="text-align: center;font-family: <%= FontFamily %>;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<div>
			</div>
		
			
			
			
<!-- Applicable Documents -->
				
				<h1 style="font-family: <%= FontFamily %>;font-size: <%= fontSize%>pt; font-weight:<%=HeaderFontWeight%>;color: black !important;" class="heading-color">
    <br><%=++maincount %>. APPLICABLE DOCUMENTS
			</h1>
			<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<p>Click here to enter text </p><br>
			Guidance:<br>
			This section lists the number, title, revision, and date of all documents referenced herein.This section also identifies the sources for documents not available through normal Government stocking activities
			</div>
				<h2 style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.1	GENERAL</h2>
				<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<p>Click here to enter text </p><br>
			Guidance:<br>
			Provide an overview of documentation section. The following statement should be placed in all SSS documents and resulting specifications:"Documents listed in this section are specified in sections 3,4, or 5 of SSS document".This section does not include documents cited in other sections of this specification or recommended for additional information or as examples.
			</div>
				<%
				int Applicabledocuments=1;
				int j=0;
				%>
				<h2 style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.2 Government Documents </h2>
			
			<h3 style="font-family: <%= FontFamily %>;margin-left: 20px; font-weight:<%=SuperHeaderFontWeight%>;margin-top: 20px; font-size: <%= SuperHeaderFontsize%>pt;">
		   <span><%=maincount+"."+(Applicabledocuments)%>.<%=++j %> Specifications, Standards, and Handbooks
			</span>
				</h3>
				<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
	<p>Click on the Enter text	</p><br>
	Guidance:<br><br>
	List Government, Specifications, Standards, and handbooks(RAD,SyRD, FAD)
			</div>
		<h3 style="font-family: <%= FontFamily %>;margin-left: 20px; font-weight:<%=SuperHeaderFontWeight%>;margin-top: 20px; font-size: <%= SuperHeaderFontsize%>pt;">
		   <span><%=maincount+"."+(Applicabledocuments)%>.<%=++j %> Other Government Document, Drawings and Publications
			</span>
				</h3>
				<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
	<p>Click on the Enter text	</p><br>
	Guidance:<br><br>
	List other Government documents, drawings,and publications
			</div>
			
			<h3 style="font-family: <%= FontFamily %>;margin-left: 20px; font-weight:<%=SuperHeaderFontWeight%>;margin-top: 20px; font-size: <%= SuperHeaderFontsize%>pt;">
		   <span><%=maincount+"."+(Applicabledocuments)%>.<%=++j %> Non-Government Publications
			</span>
				</h3>
		<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
	<p>Click on the Enter text	</p><br>
	Guidance:<br><br>
Non-Government Publications
			</div>	
			
				<!--General Ends  -->
				<!-- Test Approach  Starts-->
					<h1 style="font-family: <%= FontFamily %>; margin-left: 10px; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;">
  <br><%= ++maincount %>.&nbsp;
TEST APPROACH
</h1>
<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
<%if(Approach!=null) {%><%=Approach%><%} %> 
</div>
				<!-- Test Approach  end-->
							<h1 style="font-family: <%= FontFamily %>; margin-left: 10px; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;">
  <br><%= ++maincount %>.&nbsp;
Role & RESPONSIBILITY FOR CARRYING OUT EACH LEVEL OF SYSTEM/ SUB-SYSTEM TESTING
</h1>
<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<%if(RoleResponsibility!=null) {%><%=RoleResponsibility%><%}else{ %>No Data Available! <%} %>
			</div>
			<div style="font-family: <%= FontFamily %>;">
			${htmlContentRoleResponsibility}
			</div>
				
			<!-- Acceptance Testing   Starts-->
		<h1 style="font-family: <%= FontFamily %>;font-size: <%= fontSize%>pt; font-weight:<%=HeaderFontWeight%>;color: black !important;" class="heading-color">
    <br><%=++maincount %>. ACCEPATNCE TESTING
			</h1>
			<h2 style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.1 Test Set Up</h2>
			<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<%if(TestSetUp!=null) {%><%=TestSetUp%><%}else{ %>No Data Available! <%} %>
			</div>
			<div style="font-family: <%= FontFamily %>;">
			${htmlContent}
			</div>
		
			
		<h2 style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.2 Test Set Up Diagram</h2>
		<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
		<%if(TestSetUpDiagram!=null) {%><%=TestSetUpDiagram%><%}else{ %>No Data Available! <%} %>
		</div>
		<div style="font-family: <%= FontFamily %>;">
			${htmlContentTestSetUpDiagram}
			</div>
		
				<h2 style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.3 Testing Tools</h2>
			<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<%if(TestingTools!=null) {%><%=TestingTools%><%}else{ %>No Data Available! <%} %>
				</div>
				<div style="font-family: <%= FontFamily %>;">
			${htmlContentTestingtools}
			</div>
			
					<h2 style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.4 Test Verification Table</h2>
			<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<%if(TestVerification!=null) {%><%=TestVerification%><%}else{ %>No Data Available! <%} %>
				</div>
				<div style="font-family: <%= FontFamily %>;">
			${htmlContentTestVerification}
			</div>
			
		
			
			
</div>
				<!-- Acceptance Testing   Ends-->	
				
				
				
				
				
				<!-- Test  Schedule Starts  -->
		<h1
			style="font-family: <%=FontFamily%>; margin-left: 10px; font-size: <%=fontSize%>pt; font-weight: <%=HeaderFontWeight%>;">
			<br><%=++maincount%>.&nbsp; TEST SCHEDULE
		</h1>
		<div
			style="margin-left: 20px;font-family: <%=FontFamily%>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<%
			if (Schedule != null) {
			%><%=Schedule%>
			<%
			}else{
			%>
			<p>No Data Availaable!</p>
			<%} %>
		</div>

		<!-- Test  Schedule  end-->
						
						
			
			
			
			<!-- Test  Conclusion Starts  -->
		<h1 style="font-family: <%= FontFamily %>; margin-left: 10px; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;">
  <br><%= ++maincount %>.&nbsp;
CONCLUSION
</h1>
<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
				<%if(Conclusion!=null) {%> 
				<%=Conclusion%><%} %> 
				</div>
				<!-- Test  Conclusion  end-->	
				


</body>
</html>