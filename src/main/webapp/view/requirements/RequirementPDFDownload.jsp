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
<title>Requirement Document</title>
<%
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

String projectShortName =(String)request.getAttribute("projectShortName");
String docnumber =(String)request.getAttribute("docnumber");

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
	margin-left: 70px;
	margin-right: 49px;
	margin-bottom: 69px;
	border: 2px solid black;
	
	@bottom-left{
		content :"<%=docnumber!=null?"1901-"+docnumber:(DocumentSummary!=null && DocumentSummary.get(0)[11]!=null?"1901-SRD-"+DocumentSummary.get(0)[11].toString().replaceAll("-", "")+"-"+session.getAttribute("labcode") +projectShortName+"-V.1.0":"" )%>";
		margin-bottom: 50px;
	width:200px;;
	font-size:10px;
	}
	
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
top-center {
	font-size: 10px;
	margin-top: 30px;
	content:"RESTRICTED"
}
@
bottom-center {
	font-size: 10px;
	margin-right:20px;
	content:"RESTRICTED";
	width:300px;;
}
}
#headerdiv {
  position: running(pageHeader); /* This will be used for paged media */
  justify-content: space-between; /* Distribute space between items */
  align-items: center; /* Align items vertically in the center */
  padding: 10px; /* Add some padding */
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

#table1{
margin-left:15x;
}
</style>
</head>
<body>

	<div id="headerdiv">
	<div style="position: absolute; top: 450px; left:-400px;  transform: rotate(-90deg); font-size: 10px; color: #000; width:900px;opacity:0.5; ">
				  <!--   <b style="font-size: 12px;text-decoration: underline;">RESTRICTION ON USE, DUPLICATION OR DISCLOSURE OF PROPRIETARY INFORMATION</b><br>
				    <span style="text-decoration: none; font-size: 11px;">This document contains information, which is the sole property of LRDE, DRDO. The document is submitted to the recipient for his use only. The recipient undertakes not to duplicate the document or to disclosure in part of or the whole of any of the information contained herein to any third party without receiving beforehand, written permission from the submitter. If you are not the intended recipient please notify the sender at director <a href="@lrde.gov.in" target="_blank">@lrde.gov.in</a> immediately and destroy all copies of this document.</span> -->
				<%if(DocTempAtrr!=null && DocTempAtrr[12]!=null) {%><%=DocTempAtrr[12].toString() %> <%} %>
				
				</div>
   </div>
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
</div>

<br><br><br><br><br><br><br><br><br><br><br><br>
			<div align="center"></div>
			<div style="text-align: center; margin-top: 75px;">
				<h4 style="font-size: 18pt;;font-family:<%= FontFamily %>; !important;" class="heading-color ">SYSTEM REQUREMENTS <br><br> FOR  <br><br>PROJECT <%=projectShortName %> </h4>
					<div align="center" >
						<img class="logo" style="width: 80px; height: 80px; margin-bottom: 5px"
							<%if (lablogo != null) {%> src="data:image/png;base64,<%=lablogo%>" alt="Configuration"
							<%} else {%> alt="File Not Found" <%}%>>
				</div>
				<br> <br>
				<div align="center">
					<h4 style="font-size: 20px;font-family: <%= FontFamily %>;">
				<%
				if(LabList!=null && LabList[1] != null) {
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
					<%if(LabList!=null && LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %>
					<%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %>
					<%}else{ %>
					-
					<%} %>
				</h4>
<%-- <div style="text-align: right;margin-right:20px;">
    <span style="font-weight: bold;font-family: <%= FontFamily %>;"><%= month.toString().substring(0,3) %> <%= year %></span>
   </div> --%>
   <br><br><br>

			</div>
			<br>
			<p style="text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>	
		<!------------------------ page 2 -------Starts----------------------->
 
	<div class="heading-container" style="text-align: center; position: relative;">
</div>
				
					<div style="text-align: center;font-family: <%= FontFamily %>;">
				<h5  class="heading-color">AMENDMENT / REVISION HISTORY PAGE
				</h5>
				
			</div>
			<table style="width: 635px;margin-left:10px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;border-collapse: collapse;">
				
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
				<h5  class="heading-color; "style="font-family: <%= FontFamily %>;">DISTRIBUTION LIST
				</h5>
						</div>
						<table style="width: 635px!important;margin-left:10px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;border-collapse: collapse;">
					<tr >
					<td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black; width: 20px;text-align: center;"><span class="text-dark">S.No</span></td>
					<td class="text-dark"   style="font-family: <%= FontFamily %>;border:1px solid black; width: 250px;text-align: center;"><span class="text-dark">NAME</span></td>
					<td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;width: 100px;"><span class="text-dark">Designation</span></td>
					<td class="text-dark"   style="font-family: <%= FontFamily %>;border:1px solid black;width: 200px; text-align: center;"><span class="text-dark">Division/Lab</span></td>
					</tr>
				<tbody id="blankRowsBody1"></tbody>
            <% 
    if (MemberList != null) {
        int i = 1;
        for (Object[] mlist : MemberList) {
%>
 <tr>
                <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black;padding-left: 10px;"><%=  i+++"."%></td>
                <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black;padding-left: 10px;text-align:left;"><%= mlist[1] %></td>
                <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;text-align:left;"><%= mlist[2] %></td>
                 <td class="text-dark"  style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;text-align:left;"><%= mlist[3] %></td>
                             </tr>
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
					style="width: 635px; margin-top: 10px; margin-bottom: 5px;">
			<tr>
			<td>1.Title: System Requirement Document Template</td>
			</tr>
			</table> -->
				<table style="width: 635px; margin-left:10px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;font-family: <%= FontFamily %>;border-collapse: collapse;padding:5px;">
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;text-align:left">1.&nbsp; Title: <span class="text-darks" style="padding:2px;">System Requirements Document for <%=projectShortName %></span></td>
					</tr>
					<tr >
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">2.&nbsp; Type of Document:<span class="text-darks" style="padding:2px;">System Requirement Document</span></td>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">3.&nbsp; Classification: <span class="text-darks" style="padding:2px;"></span></td>
					</tr>
				    <tr >
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">4.&nbsp; Document Number:
						<%if(docnumber!=null) {%>(<%=docnumber %>)<%} %>
					</td>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">5.&nbsp; Month Year:&nbsp;<span style="font-weight: 600"><%=month.toString().substring(0,3) %></span> <%= year %></td>
					</tr>
					<tr>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">6.&nbsp; Number of Pages:  ${totalPages}</td>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">7.&nbsp; Related Document:</td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">8.&nbsp; Additional Information:<span class="text-darks" style="padding:2px;"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[0] %><%} %></span>
				</td>
					</tr>
				     <tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">9.&nbsp; Pro Project Name: <%=projectShortName %><span class="text-darks" style="padding:2px;"> </span></td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">10.&nbsp; Abstract:<span class="text-darks" style="padding:2px;"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[1] %><%} %></span>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">11.&nbsp; Keywords:<span class="text-darks" style="padding:2px;"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[2] %><%} %></span> </td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">12.&nbsp; Organization and address:
						<span class="text-darks" style="font-family: <%= FontFamily %>;">		<%
										if (LabList!=null && LabList[1] != null) {
										%><%=LabList[1].toString() + "(" + LabList[0].toString() + ")"%>
										<%
										} else {
										%>-<%
										}
										%>
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
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">13.&nbsp; Distribution:<span class="text-darks" style="padding:2px;"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[3] %><%} %></span>
					</td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">14.&nbsp; Revision:</td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">15.&nbsp; Prepared by:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[10] %><%} %></span></td>
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
                 <th class="text-dark" style="width: 10%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;"><span class="text-dark">S.No</span></th>
        <th class="text-dark" style="width: 20%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;"><span class="text-dark">Abbreviations</span></th>
        <th class="text-dark" style="width: 50%; border: 1px solid black; text-align: center;font-family: <%= FontFamily %>;"><span class="text-dark">Full Forms</span></th>
           </tr>
        </thead>
        <tbody>
                <% 
          int i = 1;
        for (Object[] alist : AbbreviationDetails) {
%>
              <tr>
                <td class="text-dark" style="text-align: center;border: 1px solid black;font-family: <%= FontFamily %>;"><%=  i+++"."%></td>
                <td class="text-dark" style="text-align: center;border: 1px solid black;font-family: <%= FontFamily %>;"><%= alist[1] %></td>
                <td  class="text-dark" style="border: 1px solid black; padding-left: 10px;font-family: <%= FontFamily %>;"><%= alist[2] %></td>
            </tr>
            <% 
   }} 
%>
        </tbody>
    </table>
									
					
			<div style="page-break-before: always"></div>
						<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-colors">
    <%= ++maincount %>.&nbsp;SCOPE
</h1>
			<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>; font-size: <%= SubHeaderFontsize%>pt;"class="heading-colors"><%=maincount+"." %>1
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
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"class="heading-colors"><%=maincount+"." %>2
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
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"class="heading-colors"><%=maincount+"." %>3
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
		<%-- 	<div>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>5
					&nbsp;Applicable Standards
				</h2>
				<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size: <%=ParaFontSize%>pt;text-align: justify;  font-weight:<%=ParaFontWeight%>">
					<%if(ReqIntro!=null && ReqIntro[5]!=null) {%><%=ReqIntro[5]%>
					<%}else {%><div style="font-family: <%= FontFamily %>;text-align: center;">No Details Added!</div>
					<%} %>
				</div>
			</div> --%>
	<%List<Object[]>ApplicableTotalDocumentList=(List<Object[]>)request.getAttribute("ApplicableTotalDocumentList"); %>
	<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-colors">
    <%= ++maincount %>.&nbsp;Applicable Documents</h1>
	<%if(ApplicableTotalDocumentList!=null && ApplicableTotalDocumentList.size()>0) {
    int snCOunt=0;
    	for(Object[]obj:ApplicableTotalDocumentList){
    %>
    <div class="heading-colors" style="font-size: 12pt;"> <%=++snCOunt %>.<%=obj[1].toString() %></div>
    
    
    <%}} %>		

<h1 style="font-family: <%= FontFamily %>;font-size: <%= fontSize%>pt; font-weight:<%=HeaderFontWeight%>;color: black;" class="heading-colors">
<br><%=++maincount %>.&nbsp;&nbsp;Requirements
</h1>
<%if(!RequirementList.isEmpty()) {
List<Object[]>mainReqList=RequirementList.stream().filter(e->e[15]!=null && e[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
int mainReqCount=0;
for(Object[]obj:mainReqList){
%>
<div style="padding:none;"><h2 style="font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt" class="heading-colors"><%=maincount+"."+(++mainReqCount) %>  &nbsp;<%=obj[3].toString() %></h2></div>
<%if(obj[4]!=null) {%><div style="padding:0px;" class="heading-colors"><%=obj[4].toString()%></div><%}else{ %><span></span><%} %>
<%List<Object[]>subMainReqList =  RequirementList.stream().filter(e->e[15]!=null&&e[15].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());%>
<%
String ReqName="";
int subReqCount=0;
for(Object[]obj1:subMainReqList) {
int snCount=0;
%>
 <%if(!ReqName.equalsIgnoreCase(obj1[3].toString()) && !obj1[3].toString().equalsIgnoreCase(obj[3].toString())) {%>
<h3 class="heading-colors" style="font-weight:500;padding:0px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt ;" ><%=maincount+"."+(mainReqCount)+"."+(++subReqCount)%>&nbsp;<%=obj1[3].toString() %></h3>
<%} %> 

<table class="border-black"
					style="margin-left: 10px;margin-top:7px;width: 635px;margin-right:20px; margin-bottom: 5px;font-family: <%= FontFamily %>;font-size: <%= ParaFontSize%>pt">
					<thead>
						<tr class="border-black">
							<th class="border-black"
								style="width: 20px;  border: 1px solid black; border-collapse: collapse;">SN</th>
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
List<Object[]>nonMainReqList=RequirementList.stream().filter(e->e[15]!=null&&!e[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
%>
<%if(nonMainReqList!=null && !nonMainReqList.isEmpty()) { %>
<div style="padding:none;"><h2 class="heading-colors" style="font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt"><%=maincount+"."+(++mainReqCount) %>  &nbsp; Precedence and Criticality of Requirements</h2></div>
<table class="border-black"style="margin-left: 20px;;width: 400px; margin-bottom: 5px;font-family: <%= FontFamily %>;font-size: <%= ParaFontSize%>pt">
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
							<td class="border-black" style="text-align:justify;border: 1px solid black; border-collapse: collapse;"><%=obj[1].toString() %></td>
							<td class="border-black" style="text-align:center;border: 1px solid black; border-collapse: collapse;"><%if(obj[5]!=null) {%><%=obj[5].toString()%><%}else{ %>-<%} %></td>
							<td class="border-black" style="text-align:center;border: 1px solid black; border-collapse: collapse;"><%if(obj[21]!=null) {%> <%=obj[21].toString() %>
								<%}else{%>-<%} %></td>
						</tr>
						<%}} %>
						</tbody>
						</table>
<% } %>

<%} %>




				<div >
				<h1 class="heading-colors" style="font-family: <%= FontFamily %>;font-size: <%= fontSize%>pt; font-weight:<%=HeaderFontWeight%>;color: black !important;">
    			<br><%=++maincount %>. Verification Provisions
			</h1>
				<h2 class="heading-colors" style="font-family: <%= FontFamily %>;font-size:<%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>;margin-left: 20px;"><%=maincount %>.1	Verification Methods</h2>
				</div>
				<%if(Verifications!= null &&   !Verifications.isEmpty()) {
				int verificationCount=1;
				int j=0;
				for(Object[]obj:Verifications){
				%>
			<h3 class="heading-colors" style="font-family: <%= FontFamily %>;margin-left: 20px; font-weight:<%=SuperHeaderFontWeight%>;margin-top: 20px; font-size: <%= SuperHeaderFontsize%>pt;">
		   <span><%=maincount+"."+(verificationCount)%>.<%=++j %>
			<%=obj[1].toString() %></span>
				</h3>
				<div  style="margin-left: 20px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify; font-weight:<%=ParaFontWeight%>">
				<%if(obj[3]!=null){ %><%=obj[3].toString()%>
				<%}else{ %><p style="text-align: center;">-&nbsp;&nbsp;No
					details filled&nbsp;&nbsp;-</p>
						<%}%>
					</div>
				<br>
				<%}} %>
				<table class="border-black" style="width: 635px; margin-left: 10px; margin-right:20px; margin-top: 10px; margin-bottom: 5px;font-family: <%=FontFamily%>;font-size: <%=ParaFontSize%>pt">
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
						<td
						<%if(SN==VerificationDataList.size()) {%>style="padding: 5px; text-align: center; border: 1px solid black;border-top:none; border-collapse: collapse;"<%} %>
						  <%if(!data.equalsIgnoreCase(obj[2].toString())){ %> style="padding: 5px; text-align: center; border: 1px solid black; border-bottom:none; border-collapse: collapse;"<%}else{ %>
						    style="padding: 5px; text-align: center; border-right:1px solid black; border-left:1px solid black; border-collapse: collapse;" <%} %>>
							 <%if(!data.equalsIgnoreCase(obj[2].toString())){ %> <%=++countSN %><%} %>
							</td>
							<td   
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

					
			<% if(RequirementList!=null && ProjectParaDetails!=null && !ProjectParaDetails.isEmpty()&&!RequirementList.isEmpty()) {   
				List<Object[]>subList= RequirementList.stream().filter(e->e[15]!=null&&!e[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
			%>		
<div align="left">
<h2 class="heading-colors" style="font-family: <%= FontFamily %>;font-size: <%= SubHeaderFontsize%>pt;font-weight:<%=SubHeaderFontweight%>; color: black !important;margin-left: 20px" class="heading-color">
<br><%= maincount %>.1 Forward Traceability Matrix
</h2>
</div>
				<table class="border-black"
					style="width: 635px; margin-left: 10px; margin-top: 10px; margin-bottom: 5px;font-family: <%= FontFamily %>;font-size: <%= ParaFontSize%>pt">
					<thead>
						<tr>
							<th class="border-black"
								style="width: 20px; padding: 5px; border: 1px solid black; border-collapse: collapse;">SN</th>
							<th class="border-black"
								style="width: 130px; padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">RequirementId</th>
							<th class="border-black"
								style="width: 180px; padding: 5px; text-align: center; border: 1px solid black; border-collapse: collapse;">QR
								 No</th>
						</tr>
					</thead>
					<tbody>
					<%int snCount=0;	
					for(Object[]objs:subList) {
					%>
					<%if(objs[12]!=null) {%>
					<tr>
					<td  class="border-black"style="width: 20px; border: 1px solid black;text-align:center; border-collapse: collapse;" ><%=++snCount %></td>
					<td  class="border-black"style="width: 20px; border: 1px solid black;text-align:center; border-collapse: collapse;"><%=objs[1].toString() %></td>
					 <td style="width: 20px; border: 1px solid black;text-align:center; border-collapse: collapse;padding:10px;" >
					
					
								<%if(objs[12]!=null) {
									String [] a=objs[12].toString().split(", ");
									List<String>paras= new ArrayList<>();
									for(String s:a){
										
									for(Object[]obj:ProjectParaDetails){
										if(obj[0].toString().equalsIgnoreCase(s)){
											paras.add(obj[3].toString());
										}
									}
									}
								%>
								<%=paras.toString().replace("[","").replace("]", "")%>
								<%--  <%=ProjectParaDetails.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[3].toString()).collect(Collectors.joining(",")) %> <br> --%>
								<%}else{ %>
								-
								<%} %>
					</td> 
					</tr>
					<%} %>
					<%} %>					
					</tbody>
					</table>
					
				
				<%} %>
									
									
				<h1 class="heading-colors" style="font-family: <%= FontFamily %>;font-weight:<%=HeaderFontWeight%>;font-size:<%= fontSize%>pt"><%=++maincount %>. APPENDIX SECTION</h1>
				<h2 class="heading-colors" style="font-family: <%= FontFamily %>;margin-left: 20px;font-weight:<%=SubHeaderFontweight%>;font-size:<%= SubHeaderFontsize%>pt"> <%=maincount %>.1	Appendix A - Acronyms and Definitions</h2>

			
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
    <table class="border-black" style="font-family: <%= FontFamily %>;width: 550px; margin-top: 10px; margin-bottom: 5px; border: 1px solid black; border-collapse: collapse; margin-left: 20px ;font-size: <%= ParaFontSize%>pt">
        <thead>
            <tr>
                <th class="border-black" style="border: 1px solid black; width:10px;  text-align: center;"><span class="text-dark">S.No</span></th>
                <th class="border-black" style="border: 1px solid black;  padding: 5px; "><span class="text-dark">Key MOEs</span></th>
                <th class="border-black" style="border: 1px solid black; text-align: center;"><span class="text-dark">Values</span></th>
           </tr>
        </thead>
        <tbody>
              <% 
    if (PerformanceList != null) {
        int i = 1;
        for (Object[] plist : PerformanceList) {
%>
             <tr>
                <td class="border-black" style="width:10px;text-align: center;border: 1px solid black;"><%=  i+++"."%></td>
                <td class="border-black"style="border: 1px solid black;padding-left: 10px;"><%= plist[1] %></td>
                <td class="border-black" style="border: 1px solid black; padding-left: 10px;text-align:center"><%= "-"+plist[2] +"-"%></td>
            </tr>
            <% 
   }}%> 
		
        </tbody>
    </table>
			<h4 style="font-family: <%= FontFamily %>;margin-left: 20px; font-weight: normal; text-align: justify;font-size: <%= ParaFontSize%>pt">Guidance:
    This appendix contains tabularized KPPs, and KSAs, if applicable, listed in prioritized order.<br>
    Sample Key performance Parameters / Key System Attributes are shown above. Modify the Key performance Parameters / Key System Atributes based on your specific project constraints. 
</h4>

		<%-- 	<h2 style="font-family: <%= FontFamily %>;margin-left: 20px;font-size: <%=SubHeaderFontsize%>pt; font-weight:<%=SubHeaderFontweight%>"><%=maincount %>.3	Appendix C - Requirements Traceability Matrices
</h2>	
			<h4 style="font-family: <%= FontFamily %>;margin-left: 20px ;font-weight:normal;font-size: <%= ParaFontSize%>pt">  The Traceability to next level should be provided in - SSS Type A. Traceability to OR already provided in Sec 5.1</h4> --%>
	<h2 class="heading-colors" style="font-family: <%= FontFamily %>; margin-left: 20px; font-size: <%= SubHeaderFontsize%>pt; font-weight:<%=SubHeaderFontweight%>"><%=maincount %>.3	Appendix D - Test Verification Matrices</h2>			
	
			
			 <table id="table1" style="font-family: Times New Roman;width: 635px; margin-top: 10px; margin-bottom: 5px; border: 1px solid black; border-collapse: collapse; margin-left: 10px ;font-size: <%= ParaFontSize%>pt">
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
        	   List<Object[]>mainReqList=RequirementList.stream().filter(k->k[15]!=null&&k[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
        	   for(Object []obj:mainReqList){
        		   
        		   List<Object[]>submainReqList=RequirementList.stream().filter(k->k[15]!=null&&k[15].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());
        %>
        <%if(submainReqList.size()>0){%>
           <tr class="text-dark">
           <td class="text-dark" style="border: 1px solid black; width: 120px; text-align: left;" colspan="6"><%=obj[3].toString() %>:-</td>
           
           </tr>
           <%
           String ReqName="";
           for(Object[]obj1:submainReqList){ %>
           <%if(!ReqName.equalsIgnoreCase(obj1[3].toString()) && !obj1[3].toString().equalsIgnoreCase(obj[3].toString())) {%>
				<tr class="text-dark">
				<td class="text-dark"style="border: 1px solid black; width: 120px; text-align: left;" colspan="6"><%=obj1[3].toString() %></td>			</tr>	
				<%} %>
           
           <tr>
           <td class="text-dark" style="border: 1px solid black; width: 120px; text-align: left;" ><%=obj1[1].toString() %></td>
           <td class="text-dark" style="border: 1px solid black; width: 120px; text-align: left;"><%if(obj1[16]!=null) {%><%=obj1[16].toString() %> <%}else{ %>-<%} %></td>
           <td class="text-dark" style="border: 1px solid black; width: 120px; text-align: left;"> <%if(obj1[17]!=null) {%><%=obj1[17].toString() %> <%}else{ %>-<%} %></td>
           <td  class="text-dark" style="border: 1px solid black; width: 120px; text-align: left;"> <%if(obj1[18]!=null) {%><%=obj1[18].toString() %> <%}else{ %>-<%} %></td>
           <td class="text-dark" style="border: 1px solid black; width: 120px; text-align: left;"> <%if(obj1[19]!=null) {%><%=obj1[19].toString() %> <%}else{ %>-<%} %></td>
           <td class="text-dark" style="border: 1px solid black; width: 120px; text-align: left;"> <%if(obj1[20]!=null) {%><%=obj1[20].toString() %> <%}else{ %>-<%} %></td>
           </tr>
           <%
           ReqName=obj1[3].toString();
           } %>
           <%} %>
           <%}} %>
           </tbody>
			</table>
			</div>
</body>
</html>