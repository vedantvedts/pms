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
<html>
<head>
<meta charset="ISO-8859-1">
<title>Test Plan Document</title>
<%

String lablogo=(String)request.getAttribute("lablogo");
Object[]LabList=(Object[])request.getAttribute("LabList");
Object[]reqStatus=(Object[])request.getAttribute("reqStatus");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf3=fc.getRegularDateFormat();
SimpleDateFormat sdf=fc.getRegularDateFormatshort();
SimpleDateFormat sdf1=fc.getSqlDateFormat();
String labImg=(String)request.getAttribute("LabImage");
String projectShortName=(String)request.getAttribute("projectShortName");
List<Object[]>AcronymsList=(List<Object[]>)request.getAttribute("AcronymsList");
List<Object[]>PerformanceList=(List<Object[]>)request.getAttribute("PerformanceList");
Object[] DocTempAtrr=(Object[])request.getAttribute("DocTempAttributes");
Object[]TestScopeIntro=(Object[])request.getAttribute("TestScopeIntro");
String uploadpath=(String)request.getAttribute("uploadpath");
List<Object[]>AbbreviationDetails=(List<Object[]>)request.getAttribute("AbbreviationDetails");
List<Object[]>MemberList=(List<Object[]>)request.getAttribute("MemberList");
List<Object[]> DocumentSummary=(List<Object[]>)request.getAttribute("DocumentSummary");
List<Object[]>TestContentList=(List<Object[]>)request.getAttribute("TestContent");
List<Object[]>AcceptanceTesting= (List<Object[]>)request.getAttribute("AcceptanceTesting");
List<Object[]>TestTypeList=(List<Object[]>)request.getAttribute("TestTypeList");
List<Object[]>StagesApplicable=(List<Object[]>)request.getAttribute("StagesApplicable");
String TestSetUp=(String)request.getAttribute("TestSetUp");
String TestSetUpDiagram=(String)request.getAttribute("TestSetUpDiagram");
String TestingTools=(String)request.getAttribute("Testingtools");
String TestVerification=(String)request.getAttribute("TestVerification");
String RoleResponsibility=(String)request.getAttribute("RoleResponsibility");
List<Object[]>TestSuiteList= (List<Object[]>)request.getAttribute("TestSuite");
List<Object[]>TestDetailsList= (List<Object[]>)request.getAttribute("TestDetailsList");
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

List<Object[]> specificationList = (List<Object[]>)request.getAttribute("specificationList");

if(specificationList!=null && specificationList.size()>0){
	specificationList=specificationList.stream().filter(e->!e[7].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
}
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
	size: 770px 1050px;
	margin-top: 49px;
	margin-left: 49px;
	margin-right: 49px;
	margin-bottom: 69px;
	border: 2px solid black;
	
	 @ bottom-right { content : "Page " counter(page) " of " counter( pages);
	margin-bottom: 50px;
	width:100px;;
	font-size:10px;
}
@
top-right {

	margin-top: 30px;
	margin-right: 10px;
}
@left-top {
          	content: element(pageHeader);
            font-size: 13px;
            
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
	margin-left: 10px; <%--
	content: "<%=Labcode%>";
	--%>
}
@
top-center {
	font-size: 10px;
	margin-top: 30px;
	content:"RESTRICTED"
}
@
bottom-center {
	font-size: 10px;
	/* margin-bottom: 30px; */
	margin-right:20px;
	content:"RESTRICTED"
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
	padding:5px;
}

.text-dark{
padding:5px;
}
.text-darks{
padding:5px;
text-align: left;
}
.heading-colors{
text-align: left;
margin-left:8px;
}


#headerdiv {
  position: running(pageHeader); /* This will be used for paged media */
  justify-content: space-between; /* Distribute space between items */
  align-items: center; /* Align items vertically in the center */
  padding: 10px; /* Add some padding */
}
.editordiv table{

}

.editordiv table th, div table td {
    padding: 5px; /* Adjust as needed */
    border-collapse: collapse;
}
</style>
</head>
<body>
<div id="headerdiv">
	<div style="position: absolute; top: 450px; left:-422px; border:1px solid black; transform: rotate(-90deg); font-size: 10px; color: #000; width:900px;opacity:0.5; ">
				  <!--   <b style="font-size: 12px;text-decoration: underline;">RESTRICTION ON USE, DUPLICATION OR DISCLOSURE OF PROPRIETARY INFORMATION</b><br>
				    <span style="text-decoration: none; font-size: 11px;">This document contains information, which is the sole property of LRDE, DRDO. The document is submitted to the recipient for his use only. The recipient undertakes not to duplicate the document or to disclosure in part of or the whole of any of the information contained herein to any third party without receiving beforehand, written permission from the submitter. If you are not the intended recipient please notify the sender at director <a href="@lrde.gov.in" target="_blank">@lrde.gov.in</a> immediately and destroy all copies of this document.</span> -->
				<%if(DocTempAtrr!=null && DocTempAtrr[12]!=null) {%><%=DocTempAtrr[12].toString() %> <%} %>
				
				</div>
   </div>
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
                %>
   <div class="heading-container" style="text-align: center; position: relative;">
  
</div>
  <table style="width: 98%;border-collapse: collapse;margin-left: 450px; ">
	<tr>
		
		<td style="text-align: right;">
			<table style="width: 23%; border: none; border-collapse: collapse;">
            	<tr>
          			<td style="padding: 10px;">
    					<h4 style="margin: 0; padding: 0;font-family: <%= FontFamily %>;">
    				    				<%
				if(LabList[0] != null) {
				%>
			<%-- 	<%=LabList[0].toString()%>:SSTP:....................</h4>
  						<h6 style="margin: 0; padding: 0;font-family: <%= FontFamily %>;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copy No.01</h6> --%>
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
				<h4 style="font-size: 18pt;;font-family:<%= FontFamily %>; !important;" class="heading-color ">SYSTEM TEST PLAN  </h4>
				<h4 style="font-size: 15pt;font-family: <%= FontFamily %>;">For</h4>
				<h4 style="font-size: 18pt;font-family: <%= FontFamily %>;">
					Project: <%=projectShortName %>
					<br> <br>
				</h4>
			<%-- 	<h4 style="font-size: 18pt;font-family: <%= FontFamily %>;">
					Project:
					<%=PfmsInitiationList[7].toString()%><br> <br>
					<%="(" + PfmsInitiationList[6].toString() + ")"%>
				</h4> --%>
				
			<%-- 	<h4 style="font-size: 18px; text-decoration: underline;font-family: <%= FontFamily %>;">Test Plan 
					No.</h4> --%>
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
	<p style="text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>	
	<div class="heading-container" style="text-align: center; position: relative;">
  <%-- <h6 class="heading-color top-center" style="font-family: <%= FontFamily %>;font-size: 14px !important; text-decoration: underline; display: inline-block; padding-bottom: 5px; position: absolute; top: 0; left: 50%; transform: translateX(-50%); font-weight: normal;">RESTRICTED</h6> --%>
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
</div>
				<div align="center">
					<div style="text-align: center;">
				<h5 class="border-black" "style="font-family: <%= FontFamily %>;">DISTRIBUTION LIST
				</h5>
						</div>
				<table style="width: 550px; margin-top: 10px; margin-bottom: 5px; margin-left: 30px;  border:1px solid black;border-collapse: collapse;">
					<tr >
					<td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black; width: 20px;text-align: justify"><span class="text-dark">S.No</span></td>
					<td class="text-dark"    style="font-family: <%= FontFamily %>;border:1px solid black; width: 150px;text-align: justify"><span class="text-dark">NAME</span></td>
					<td class="text-dark"   style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;width: 100px;text-align: justify"><span class="text-dark">Designation</span></td>
					<td class="text-dark"    style="font-family: <%= FontFamily %>;border:1px solid black;width: 100px; text-align: justify"><span class="text-dark">Division/Lab</span></td>
<%-- 					<td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;width: 80px;text-align: justify"><span class="text-dark">Remarks</span></td>
 --%>					</tr>
				<tbody id="blankRowsBody1"></tbody>
            <% 
    if (MemberList != null) {
        int i = 1;
        for (Object[] mlist : MemberList) {
%>
 <tr>
                <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black;padding-left: 10px;text-align: justify"><%=  i+++"."%></td>
                <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black;padding-left: 10px;text-align: justify"><%= mlist[1] %></td>
                <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;text-align: justify"><%= mlist[2] %></td>
                 <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;text-align: justify"><%= mlist[3] %></td>
<%--                  <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;text-align: justify">copy for Record</td>
 --%>                             </tr>
 <% 
   }} 
%>
					</table>
				<p style="font-family: <%= FontFamily %>;text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>
				<div class="heading-container" style="text-align: center; position: relative;">
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
				<table style="width: 650px; margin-left:10px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;font-family: <%= FontFamily %>;border-collapse: collapse;">
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;text-align:left">1.&nbsp; Title: <span class="text-darks">System Test Plan For <%=projectShortName %></span></td>
					</tr>
					<tr >
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">2.&nbsp; Type of Document:<span class="text-darks">System Test Plan Document</span></td>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">3.&nbsp; Classification: <span class="text-darks">Restricted</span></td>
					</tr>
				    <tr >
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">4.&nbsp; Document Number:</td>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">5.&nbsp; Month Year:&nbsp;<span style="font-weight: 600"><%=month.toString().substring(0,3) %></span> <%= year %></td>
					</tr>
					<tr>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">6.&nbsp; Number of Pages: </td>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">7.&nbsp; Related Document:</td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">8.&nbsp; Additional Information:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[0] %><%} %></span>
				</td>
			
					</tr>
				<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">9.&nbsp; Project Name:<span class="text-darks"><%=projectShortName!=null?projectShortName:"" %></span>
				</td>
				</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">10.&nbsp; Abstract:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[1] %><%} %></span>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">11.&nbsp; Keywords:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[2] %><%} %></span> </td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">12.&nbsp; Organization and address:
						<span class="text-darks" style="font-family: <%= FontFamily %>;">		<%
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
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">13.&nbsp; Distribution:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[3] %><%} %></span>
					</td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">14.&nbsp; Revision:</td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">15.&nbsp; Prepared by:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[7] %><%} %></span></td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">16.&nbsp; Reviewed by: <span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[7] %><%} %></span> </td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">17.&nbsp; Approved by: <span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[6] %><%} %></span> </td>
					</tr>
										</table>
<p style="text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>	
<h4 style="margin-left: 20px;font-family: <%= FontFamily %>;"> Abbreviations used in the Manual to be listed and arranged in alphabetical order</h4>
		<%  if (AbbreviationDetails != null && !AbbreviationDetails.isEmpty()) { %>	
      <table style="width: 550px; margin-top: 10px; margin-bottom: 5px; border: 1px solid black; border-collapse: collapse; margin-left: auto; margin-right: auto;">
        <thead>
            <tr>
        <th class="text-dark" style="width: 10%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;text-align: justify"><span class="text-dark">S.No</span></th>
        <th class="text-dark" style="width: 20%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;text-align: justify"><span class="text-dark">Abbreviations</span></th>
        <th class="text-dark" style="width: 50%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;text-align: justify"><span class="text-dark">Full Forms</span></th>
           </tr>
        </thead>
        <tbody>
                <% 
          int i = 1;
        for (Object[] alist : AbbreviationDetails) {
%>
              <tr>
                <td class="text-dark" style="text-align: center;border: 1px solid black;font-family: <%= FontFamily %>;text-align: justify"><%=  i+++"."%></td>
                <td class="text-dark" style="text-align: center;border: 1px solid black;font-family: <%= FontFamily %>;text-align: justify"><%= alist[1] %></td>
                <td  class="text-dark" style="border: 1px solid black; padding-left: 10px;font-family: <%= FontFamily %>;text-align: justify"><%= alist[2] %></td>
            </tr>
            <% 
   }} 
%>
        </tbody>
    </table>
						</div>
						<%if(TestScopeIntro!=null) {%>
						  <div class="landscape-content">
			<div style="page-break-before: always"></div>
						<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-color">
    <%= ++maincount %>.&nbsp;SCOPE
</h1>
				<hr style="width: 100%;">
					<%if(TestScopeIntro!=null){ %>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>; font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>1
					&nbsp;Introduction
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify;font-weight:<%=ParaFontWeight%>" >
					<%if(TestScopeIntro[1]!=null) {%><%=TestScopeIntro[1]%>
					<%}else {%><div style="text-align: center;font-family: <%= FontFamily %>;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>2
					&nbsp;System Identification
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify; font-weight:<%=ParaFontWeight%>">
					<%if(TestScopeIntro[2]!=null) {%><%=TestScopeIntro[2]%>
					<%}else {%><div style="font-family: <%= FontFamily %>;text-align: center;">No Details Added!</div>
					<%} %>
				</div>
				
				
				
			</div>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>3
					&nbsp;System Overview
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify; font-weight:<%=ParaFontWeight%>">
					<%if(TestScopeIntro[3]!=null) {%><%=TestScopeIntro[3]%>
					<%}else {%><div style="text-align: center;font-family: <%= FontFamily %>;">No Details Added!</div>
					<%} %>
				</div>
			</div>
			<div>
			</div>
			<%}else{ %>
			<div align="center" style="margin-top: 350px">
				<h4 style="font-family: <%= FontFamily %>;">No Data Available !</h4>
			</div>
			</div>
			<%}} %>
			
			
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
				
				<!--  Role & Responsibility Starts-->
				<h1 style="font-family: <%= FontFamily %>; margin-left: 10px; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;">
  <br><%= ++maincount %>.&nbsp;
Role & RESPONSIBILITY FOR CARRYING OUT EACH LEVEL OF SYSTEM/ SUB-SYSTEM TESTING
</h1>
<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<%if(RoleResponsibility!=null) {%><%=RoleResponsibility%><%} %> 
			</div>
			<div style="font-family: <%= FontFamily %>;">
			${htmlContentRoleResponsibility}
			</div>
				<!-- Role & Responsibility Ends -->
				
				
				
				
				
			<!-- Acceptance Testing   Starts-->
		<h1 style="font-family: <%= FontFamily %>;font-size: <%= fontSize%>pt; font-weight:<%=HeaderFontWeight%>;color: black !important;" class="heading-color">
    <br><%=++maincount %>. ACCEPATNCE TESTING
			</h1>
			<h2 style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.1 Test Set Up</h2>
			<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<!--Test Set Up  Starts -->

			<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<%  if (TestSuiteList != null && !TestSuiteList.isEmpty()) { %>	
    <table class="border-black" style="width: 550px; margin-top: 10px; margin-bottom: 5px; border: 1px solid black; border-collapse: collapse; margin-left: auto; margin-right: auto;">
        <thead>
            <tr>
         <th class="border-black" style="width: 10%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;text-align: justify"><span class="text-dark">S.No</span></th>
        <th class="border-black" style="width: 20%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;text-align: justify"><span class="text-dark">Test Type</span></th>
        <th class="border-black" style="width: 50%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;text-align: justify"><span class="text-dark">Test Setup Name</span></th>
           </tr>
        </thead>
        <tbody>
                <% 
          int i = 1;
        for (Object[] tslist : TestSuiteList) {
%>
              <tr>
                <td class="border-black" style="text-align: center;border: 1px solid black;font-family: <%= FontFamily %>;text-align: justify"><%=  i+++"."%></td>
                <td class="border-black" style="text-align: center;border: 1px solid black;font-family: <%= FontFamily %>;text-align: justify"><% if(tslist[1]!=null){%>  <%= tslist[1] %> <% }else{%> <%} %></td>
                <td class="border-black" style="border: 1px solid black; padding-left: 10px;font-family: <%= FontFamily %>;text-align: justify"><%if(tslist[3]!=null){%> <%= tslist[3] %> <% }else{%><%} %>
                </td>
            </tr>
            <% 
   }} 
%>
        </tbody>
    </table>
	</div>
				
		<!--Test Set Up  Ends -->		
			
			</div>
		<h2 style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.2 Test Set Up Diagram</h2>
		<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
		<%if(TestSetUpDiagram!=null) {%><%=TestSetUpDiagram%><%} %> 
		</div>
		<div style="font-family: <%= FontFamily %>;">
			${htmlContentTestSetUpDiagram}
			</div>
		<!--Test Suits  Starts -->
				<h2 style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.3 Test Suite</h2>
			<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<%  if (TestSuiteList != null && !TestSuiteList.isEmpty()) { %>	
    <table class="border-black" style="width: 550px; margin-top: 10px; margin-bottom: 5px; border: 1px solid black; border-collapse: collapse; margin-left: auto; margin-right: auto;">
        <thead>
            <tr>
		        <th class="text-dark" style="width: 10%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;text-align: justify"><span class="text-dark">S.No</span></th>
		        <th class="text-dark" style="width: 20%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;text-align: justify"><span class="text-dark">Test Type</span></th>
		        <th class="text-dark" style="width: 35%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;text-align: justify"><span class="text-dark">Test Id S</span></th>
		        <th class="text-dark" style="width: 35%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;text-align: justify"><span class="text-dark">Test Tools</span></th>
           </tr>
        </thead>
        <tbody>
                <% 
          int i = 1;
        for (Object[] tlist : TestSuiteList) {
%>
              <tr>
                <td  class="text-dark" style="width: 120px;text-align: center;border: 1px solid black;font-family: <%= FontFamily %>;text-align: justify"> <%=  i+++"."%></td>
                <td  class="text-dark" style="width: 120px;text-align: center;border: 1px solid black;font-family: <%= FontFamily %>;text-align: justify">
                <% if(tlist[1]!=null){%> <%= tlist[1] %> <% }else{%> <% }%>
                </td>
                <td class="text-dark" style="width: 120px;border: 1px solid black; padding-left: 10px;font-family: <%= FontFamily %>;text-align: justify"> 
               <%
             List<String>list=new ArrayList<>();
               list=TestDetailsList.stream().filter(ix->ix[10]!=null && Arrays.asList(ix[10].toString().split(",")).contains(tlist[0].toString())).map(ix->ix[1].toString()).collect(Collectors.toList());
               %>
               <%if(list.size()!=0) {%>
               <%=list.toString().replace("[", "").replace("]", "") %>
               <%}else{ %>
               -
               <%} %>
                </td>
                 <td style="border: 1px solid black; padding-left: 10px;font-family: <%= FontFamily %>;">
                 	<% if(tlist[3]!=null){%>  <%= tlist[3] %> 	 <%}else{ %>   <%} %>
                 </td>
            </tr>
            <% 
   }} 
%>
        </tbody>
    </table>
				</div>
				
		<!--Test Suits  Ends -->		
					<h2 style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.4 Test Verification Table</h2>
			<div style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<%if(TestVerification!=null) {%><%=TestVerification%><%} %> 
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
			}
			%>
		</div>
		<!-- Test  Schedule  end-->
					<div style="page-break-before: always;"></div>
						<!-- Test Details   Starts-->
	<h1 style="font-family: <%= FontFamily %>;font-size: <%= fontSize%>pt; font-weight:<%=HeaderFontWeight%>;color: black !important;" class="heading-color">
    <br><%=++maincount %>. Test Details
			</h1>
			<!--Test Set Up  Starts -->
				
			<div style="margin-left:5px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
			<%  if (TestDetailsList != null && !TestDetailsList.isEmpty()) { 
				int testcount=0;
				List<Object[]>mainTestList= TestDetailsList.stream().filter(e->e[23]!=null && e[23].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
				
				
				 for (Object[] objs : mainTestList) {
					 
						List<Object[]>sublist= TestDetailsList.stream().filter(e->e[23]!=null && e[23].toString().equalsIgnoreCase(objs[0].toString())).collect(Collectors.toList());

			%>	
			<div style="margin-left: 20px; margin-top: 15px; font-weight: 600;font-family: <%= FontFamily %>;">
			<h2 style="font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt"><%=maincount+"."+(++testcount)%>&nbsp;&nbsp;Test Type : &nbsp;&nbsp;<%= objs[1] %></h2>
			</div>
			<%for(Object[]tDlist:sublist){%> 

			
			
		


		<table class="border-black" style="width: 655px; margin-top: 10px; margin-bottom: 5px;font-family: <%=FontFamily%>;font-size: <%=ParaFontSize%>pt">
			<thead>
				<tr>
					<th class="border-black"
						style="width: 20px; padding: 5px; border: 1px solid black; border-collapse: collapse;">SN</th>
					<th class="border-black"
						style="width: 130px; padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">Item</th>
					<th class="border-black"
						style="padding: 5px; border: 1px solid black; border-collapse: collapse;">Description</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">1.</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Spec ID</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<% if(tDlist[19]!=null){
						List<String>list = new ArrayList<>();
						
						if(specificationList.size()>0){
							list = specificationList.stream().filter(e->Arrays.asList(tDlist[19].toString().split(",")).contains(e[0].toString()))
									.map(e->e[1].toString())
									.collect(Collectors.toList());
						}
						%>
						
						
						 <%= list.size()>0?list.toString().replace("[", "").replace("]",""):"-" %>
						 
						  <% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">2.</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">ID</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<% if(tDlist[1]!=null){%> <%= tDlist[1] %> <% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">3.</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Name</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[2]!=null){%> <%= tDlist[2] %> <% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">4.</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Objective</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[3]!=null){%> <%= tDlist[3] %> <% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">5.</td>
					<th class="border-black" colspan="2"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Description</span></th>
					
				</tr>
				<tr>
				<td class="border-black" colspan="3"style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
				<%if(tDlist[4]!=null){%><div class="editordiv"> <%= tDlist[4] %> </div><% } %>
				</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">6.</td>
					<th class="border-black" colspan="2"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Pre-Conditions</span></th>
				
				</tr>
				<tr>
					<td class="border-black" colspan="3"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[5]!=null){%><div class="editordiv"> <%= tDlist[5] %>  </div><% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">7.</td>
					<th class="border-black" colspan="2"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Post-Conditions</span></th>
				
				</tr>
				
				<tr> 
					<td class="border-black" colspan="3"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[6]!=null){%><div class="editordiv"> <%= tDlist[6] %></div> <% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">8.</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Constraints</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[7]!=null){%> <%= tDlist[7] %> <% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">9.</td>
					<th class="border-black" colspan="2"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Safety Requirements</span></th>
					
				</tr>
				<tr>
				<td class="border-black"colspan="3"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[8]!=null){%><div class="editordiv">  <%= tDlist[8] %></div> <% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">10.</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Methodology</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[9]!=null){%> <%= tDlist[9] %> <% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">11.</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Test Set Up</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%
                 
             		String[]TempArray=tDlist[10]!=null? tDlist[10].toString().split(","):new String[]{"", "", "", "", ""}; 
         List<String>tempList=Arrays.asList(TempArray);
         List<String>temp= new ArrayList<>();
 		for(Object[] obj:TestSuiteList){
			if(tempList.contains(obj[0].toString())){
				temp.add(obj[3].toString());
			}}
%> <%if(temp.size()>0) {%> <%= String.join(", ", temp) + "" %> <%-- <%=temp.toString()+"," %> --%>
						<%}else{ %> - <%} %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="text-align: justify;padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">12.</td>
					<th class="border-black" colspan="2"
						style="text-align: justify;padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Personnel Resources</span></th>
					
				</tr>
				<tr>
				<td class="border-black" colspan="3"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[11]!=null){%> <div class="editordiv"><%= tDlist[11] %></div> <% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">13.</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Estimated Time/Iteration</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[12]!=null){%> <%= tDlist[12] %> <% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">14.</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Iterations</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[13]!=null){%> <%= tDlist[13] %> <% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">15.</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Schedule</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[14]!=null){%> <%= tDlist[14] %> <% } %>
					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">16.</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Pass/Fail Criteria</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[15]!=null){%> <%= tDlist[15] %> <% } %>
					</td>
				</tr>


				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">17.&nbsp;</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark"> StageApplicable</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%
            String[]TempArray1=tDlist[22]!=null ?tDlist[22].toString().split(","): new String[5];
            List<String>tempList1=Arrays.asList(TempArray1);
            List<String>tempsa=new ArrayList<>();
            for(Object[] obj1:StagesApplicable){
            	if(tempList1.contains(obj1[0].toString())){
            		tempsa.add(obj1[3].toString());
            	}
            }
            %> <% if(tempsa.size() > 0) { %> <%= String.join(", ", temp) + "" %>
						<% } else { %> - <% } %>

					</td>
				</tr>
				<tr>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">18.&nbsp;&nbsp;&nbsp;</td>
					<th class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;"><span
						class="text-dark">Remarks</span></th>
					<td class="border-black"
						style="padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;font-family: <%= FontFamily %>;text-align: justify;">
						<%if(tDlist[15]!=null){%> <%= tDlist[15] %> <% } %>
					</td>
				</tr>

			</tbody>
		</table> 
		<% 
  }}} else {
   %>
<div align="center" style="margin-top: 350px">
					<h4 style="font-family: <%= FontFamily %>;">No Data Available !</h4>
				</div>
				<%} %> 
				</div>
		<!--Test Details Ends -->		
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