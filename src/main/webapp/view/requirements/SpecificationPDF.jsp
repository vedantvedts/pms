<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.time.LocalDate"%>
 <%@page import="java.nio.file.Path"%>
 <%@page import="java.io.File"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.Format"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.util.Base64"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="com.vts.pfms.AESCryptor"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder"%>
<%@ page language="java" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.util.stream.Collectors"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Project Specification</title>
<%
Object[]LabList=(Object[])request.getAttribute("LabList");
String lablogo=(String)request.getAttribute("lablogo");
String version=(String)request.getAttribute("version");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf3=fc.getRegularDateFormat();
SimpleDateFormat sdf=fc.getRegularDateFormatshort();
SimpleDateFormat sdf1=fc.getSqlDateFormat();
String labImg=(String)request.getAttribute("LabImage");
Object[] DocTempAtrr=(Object[])request.getAttribute("DocTempAttributes");
LocalDate d = LocalDate.now();
int contentCount=0;
int maincount=0;
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
          	List<Object[]>MemberList=(List<Object[]>)request.getAttribute("MemberList");
          	List<Object[]> DocumentSummary=(List<Object[]>)request.getAttribute("DocumentSummary");
    		List<Object[]>AbbreviationDetails=(List<Object[]>)request.getAttribute("AbbreviationDetails");
    		List<Object[]>SpecsIntro=(List<Object[]>)request.getAttribute("SpecsIntro");
			String filePath=(String)request.getAttribute("filePath");
			String LabCode =(String ) session.getAttribute("labcode");
			List<Object[]>SpecProducTree=(List<Object[]>)request.getAttribute("SpecProducTree") ;
			List<Object[]>RequirementList = (List<Object[]>)request.getAttribute("RequirementList");
			List<Object[]>specsList = (List<Object[]>)request.getAttribute("specsList");
			List<Object[]>RequirementLists = new ArrayList<>();
			if(RequirementList!=null && RequirementList.size()>0){
				RequirementLists=RequirementList.stream().filter(e->e[15]!=null && !e[15].toString().equalsIgnoreCase("0"))
						.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
						.collect(Collectors.toList());
						
			}
			
			String Conclusion = null;
			String ConclusionContenId= null;
			List<Object[]>SpecContentsDetails =(List<Object[]>)request.getAttribute("SpecContentsDetails");

			for(Object[]obj:SpecContentsDetails){
				if(obj[1].toString().equalsIgnoreCase("Conclusion")){
					Conclusion=obj[2].toString();
					ConclusionContenId=obj[0].toString();
				}
			}
			String projectShortName =(String)request.getAttribute("projectShortName");
			String Classification=(String)request.getAttribute("Classification");
			String labcode = (String) session.getAttribute("labcode");
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
	
	 @ bottom-right { content : "Page " counter(page) " of " counter( pages);
	margin-bottom: 50px;
	width:100px;
	font-size: 10px;
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
	content:"<%if(Classification!=null){%> <%=Classification.toUpperCase()%> <%}else{%>RESTRICTED <%}%>"
}
@
bottom-center {
	font-size: 10px;
	/* margin-bottom: 30px; */
	margin-right:20px;
	content:"<%if(Classification!=null){%> <%=Classification.toUpperCase()%> <%}else{%>RESTRICTED <%}%>"
}
.border-black {
	border: 1px solid black !important;
	border-collapse: collapse !important;
}
.border-black td th {
	padding: 5px !important;
	margin: 0px !important;
}
p table tr, p table td {
    padding: 5px;
}

p,td,th
{
  word-wrap: break-word;
  word-break: normal ;
}

 .table-bordered td {
            padding: 5px;
        }
    p,img{
    width:100% !important;
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
#headerdiv {
  position: running(pageHeader); /* This will be used for paged media */
  justify-content: space-between; /* Distribute space between items */
  align-items: center; /* Align items vertically in the center */
  padding: 10px; /* Add some padding */
}
div table{
width:560px;
}

/* .specdiv table td p{
width:60px!important;
font-size:8px;
border:1px solid red;
margin-right:2px;
} */
.specdiv table{
margin-top:10px;
padding:10px;
width:600px!important;

}

.specdiv table td{

padding:10px;


}
.specdiv table td p{

width:50px!important;
margin-top:0px!important;
font-family: <%=FontFamily%>;
}
.specdiv table td p span{

padding:1px !important;
}
.specdiv p{
width:620px !important;
padding:5px!important;
}
.scopediv p{
width:620px !important;
padding:5px!important;
margin-rigth:5px;
}
</style>
</head>
<body>
<div id="headerdiv">
	<div style="position: absolute; top: 450px; left:-400px; transform: rotate(-90deg); font-size: 10px; color: #000; width:900px;opacity:0.5; ">
				  <!--   <b style="font-size: 12px;text-decoration: underline;">RESTRICTION ON USE, DUPLICATION OR DISCLOSURE OF PROPRIETARY INFORMATION</b><br>
				    <span style="text-decoration: none; font-size: 11px;">This document contains information, which is the sole property of LRDE, DRDO. The document is submitted to the recipient for his use only. The recipient undertakes not to duplicate the document or to disclosure in part of or the whole of any of the information contained herein to any third party without receiving beforehand, written permission from the submitter. If you are not the intended recipient please notify the sender at director <a href="@lrde.gov.in" target="_blank">@lrde.gov.in</a> immediately and destroy all copies of this document.</span> -->
				<%if(DocTempAtrr!=null && DocTempAtrr[12]!=null) {%><%=DocTempAtrr[12].toString() %> <%} %>
				
				</div>
   </div>
	<div class="heading-container"
		style="text-align: center; position: relative;"></div>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div align="center"></div>
	<div style="text-align: center; margin-top: 75px;">
		<h4
			style="font-size: 18pt;;font-family:<%=FontFamily%>; !important;"
			class="heading-color ">SYSTEM  SPECIFICATIONS
			<br><br>
			FOR
			<br><br>PROJECT <%=projectShortName!=null?projectShortName:"" %>
			</h4>
			

		<div align="center">
			<img class="logo"
				style="width: 80px !important; height: 80px !important; margin-bottom: 5px"
				<%if (lablogo != null) {%> src="data:image/png;base64,<%=lablogo%>"
				alt="Configuration" <%} else {%> alt="File Not Found" <%}%>>
		</div>
		<br> <br>
		<div align="center">
			<h4 style="font-size: 20px;font-family: <%=FontFamily%>;">
				<%
				if (LabList != null && LabList[1] != null) {
				%>
				<%=LabList[1].toString() + "(" + LabList[0].toString() + ")"%>
				<%
				} else {
				%>-<%
				}
				%>
			</h4>
			<h4 style="font-family: <%=FontFamily%>;">
				Government of India, Ministry of Defence<br>Defence Research &
				Development Organization
			</h4>
		</div>
		<h4 style="font-family: <%=FontFamily%>;">
			<%
			if (LabList != null && LabList[2] != null && LabList[3] != null && LabList[5] != null) {
			%>
			<%=LabList[2] + " , " + LabList[3].toString() + ", PIN-" + LabList[5].toString()%>
			<%
			} else {
			%>
			-
			<%
			}
			%>
		</h4>
		<div style="text-align: right; margin-right: 20px;">
			<span style="font-weight: bold;font-family: <%=FontFamily%>;"><%=month.toString().substring(0, 3)%>
				<%=year%></span>
		</div>
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
			<table style="width: 630px;margin-left:10px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;border-collapse: collapse;">
				
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
						<table style="width: 630px;margin-left:10px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;border-collapse: collapse;">
					<tr >
					<td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black; width: 20px;text-align: center;width:20px;"><span class="text-dark">SN</span></td>
					<td class="text-dark"   style="font-family: <%= FontFamily %>;border:1px solid black; width: 250px;text-align: left"><span class="text-dark">NAME</span></td>
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
                <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;"><%= mlist[2] %></td>
                <td class="text-dark"  style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;"><%= mlist[3] %></td>
                </tr>
 <% 
   }} 
%>
					</table>
			<p style="font-family: <%= FontFamily %>;text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>
		<div class="heading-container"
			style="text-align: center; position: relative;"></div>
		<div style="text-align: center;">
			<h4
				style="font-size: 20px !important;font-family: <%=FontFamily%>;"
				class="heading-color">DOCUMENT SUMMARY</h4>
		</div>
						<table style="width: 630px; margin-left:10px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;font-family: <%= FontFamily %>;border-collapse: collapse;">
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;text-align:left">1.&nbsp; Title: <span class="text-darks">System Segment Specification Document For Project <%=projectShortName!=null?projectShortName:"" %></span></td>
					</tr>
					<tr >
					<td class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">2.&nbsp; Type of Document:<span class="text-darks">System Segment Specification Document</span></td>
					</tr>
					<tr>
						<td class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">3.&nbsp; Classification: <span class="text-darks"><%if(Classification!=null){%> <%=Classification.toUpperCase()%> <%}else{%>RESTRICTED <%}%></span></td>
					
					</tr>
				    <tr >
					<td class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">4.&nbsp; Document Number:</td>
					</tr>
					<tr>
					<td class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">5.&nbsp; Month Year:&nbsp;<span style="font-weight: 600"><%=month.toString().substring(0,3) %></span> <%= year %></td>
					</tr>
					<tr>
					<td class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">6.&nbsp; Number of Pages:  ${totalPages}</td>
					</tr>
					<tr>
					<td class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">7.&nbsp; Related Document:</td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">8.&nbsp; Additional Information:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[0] %><%} %></span>
				</td>
					</tr>
				     <tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">9.&nbsp;  Project Name:<span class="text-darks"> <%=projectShortName!=null?projectShortName:"" %></span></td>
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
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">13.&nbsp; Distribution:<span class="text-darks"><% if(DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[3] %><%} %></span>
					</td>
					</tr>
					<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">14.&nbsp; Revision: <%=version!=null?version:"1.0" %></td>
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
                <td class="text-dark" style="text-align: left;border: 1px solid black;font-family: <%= FontFamily %>;"><%= alist[1] %></td>
                <td  class="text-dark" style="border: 1px solid black;text-align: left; padding-left: 10px;font-family: <%= FontFamily %>;"><%= alist[2] %></td>
            </tr>
            <% 
   }} 
%>
        </tbody>
    </table>
									
			
			<div style="page-break-before: always"></div>
			<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-colors">
    <%= ++maincount %>.&nbsp;Scope</h1>
<%if(SpecsIntro!=null) {%>
<%int introCount=0;
for(Object[]obj:SpecsIntro) {%>
				<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>; font-size: <%= SubHeaderFontsize%>pt;"class="heading-colors"><%= maincount+"." %><%=++introCount %>
					&nbsp;<%=obj[1].toString() %>
				</h2>
	<%if(obj[2]!=null) {%>	<div class="scopediv" style="text-align: justify;" >
	<%=obj[2]%>
	</div>	
					<%}else {%><div style="text-align: center;font-family: <%= FontFamily %>;">No Details Added!</div>
					<%} %>
			
<%} %>
<%}else{ %>
<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>; font-size: <%= SubHeaderFontsize%>pt;"><%=maincount+"." %>1  System Identification</h2>

<% }%>


	<div style="page-break-before: always"></div>
	<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-colors">
    <%= ++maincount %>.&nbsp;Applicable Document</h1>
    
    <h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>; font-size: <%= SubHeaderFontsize%>pt;"class="heading-colors">No Documents Applicable! </h2>
    
   <h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-colors">
    <%= ++maincount %>.&nbsp;Product Tree</h1>
	<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify;font-weight:<%=ParaFontWeight%>;margin-right:20px;" >
	<%if(SpecProducTree!=null && SpecProducTree.size()>0){ %> <%=SpecProducTree.get(0)[2].toString()%> <%} else{%> Guidance: 
The product Tree shall comprises the complete physical products / subsystems of the radar in the order of flow as a figure with unique ID 
<%} %>
	</div>
		<%if(SpecProducTree!=null && SpecProducTree.size()>0) {
			Path imagepath = Paths.get(filePath,labcode,"SpecificationProducTree",SpecProducTree.get(0)[3].toString());
			File imagepathFile = imagepath.toFile();
		%>
	<%if(imagepathFile.exists()){ %>
			<br>
						<img  style="margin-bottom: 5px;width:500px; height:500px;border:1px solid red;margin:2px;" src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(imagepathFile))%>" > 											
											<%}} %>
	<p style="text-align: center; page-break-before: always;font-family: <%= FontFamily %>;"></p>
	<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-colors">
    <%= ++maincount %>.&nbsp;Specifications
    </h1>
    
    <%if(specsList!=null && specsList.size()>0){ 
		int specCount=0;
		List<Object[]>specsListMain=specsList.stream().filter(e->e[7].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
		for(Object[]obj:specsListMain){
	
		%>
		<h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:600; font-size: <%= SubHeaderFontsize%>pt;"class="heading-colors"><%=maincount+"." %><%=++specCount %> <%=obj[1].toString() %></h2>
		<% List<Object[]>specsListSub = new ArrayList<>();
					specsListSub=specsList.stream().filter(e->e[7].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());
					%>
					<%if(specsListSub!=null && specsListSub.size()>0) {
					for(Object[]obj1:specsListSub){
						
						int snCount=0;
					%>
					
					<table class="" style="margin-left: 5px;width: 635px; margin-bottom: 5px;font-family: <%= FontFamily %>;font-size: <%= ParaFontSize%>pt;border-collapse: collapse;margin-top:10px;margin-right:5px;">
					<thead>
						<tr>
							<th class="border-black"
								style="width: 20px;  border: 1px solid black; border-collapse: collapse;">SN</th>
							<th class="border-black"
								style="width: 130px;  text-align: left; border: 1px solid black; border-collapse: collapse;">Attribute</th>
							<th class="border-black"
								style=" border: 1px solid black; border-collapse: collapse;">Content</th>
						</tr>
						
						</thead>
							<tbody>
							<tr>
							<td class="border-black"
								style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %></td>
							<td class="border-black"
								style=" text-align: left; border: 1px solid black; border-collapse: collapse; font-weight: 600;">Specification Id</td>
							<td class="border-black"
								style=" text-align: left; border: 1px solid black; border-collapse: collapse;"><%=obj1[1].toString() %></td>
						</tr>
						
							<tr>
							<td class="border-black"
								style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %></td>
							<td class="border-black"
								style=" text-align: left; border: 1px solid black; border-collapse: collapse; font-weight: 600;"> Linked Requirements</td>
							<td class="border-black"style=" text-align: left; border: 1px solid black; border-collapse: collapse;">
							<%
							List<String>linkedReq= new ArrayList<>();
							List<String>tempReq = new ArrayList<>();
							if(obj1[4]!=null){
								tempReq= Arrays.asList(obj1[4].toString().split(","));
							}
							if(RequirementLists!=null && RequirementLists.size()>0){
							for(Object[]obj2:RequirementLists){
								if(tempReq.contains(obj2[0].toString())){
									linkedReq.add(obj2[1].toString());
								}
							%>
							<%}} %>	
							<%if(linkedReq.size()>0) {%>
							<%=linkedReq.toString().replace("[", "").replace("]", "") %>
							<%}else{ %>
								-
							<%} %>
							</td>
						</tr>
						
							<tr>
							
							<td class="border-black" colspan="3"
								style=" text-align: left; border: 1px solid black; border-collapse: collapse; font-weight: 600;"> <%=++snCount %>.Description
								<hr>
								<br>
								<div style="font-weight: 400;text-align: justify;" class="specdiv">
								<%=obj1[2]!=null?obj1[2].toString():"No Details Found" %>
								</div>
								</td>
							</tr>
							
							<tr>
							<td class="border-black"
								style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %></td>
							<td class="border-black"
								style=" text-align: left; border: 1px solid black; border-collapse: collapse; font-weight: 600;"> Specification Parameter</td>
							<td class="border-black"
								style=" text-align: left; border: 1px solid black; border-collapse: collapse;"><%if(obj1[5]!=null){ %><%=obj1[5].toString() %> <%}else{ %> <%} %></td>
							</tr>
							
							<tr>
							<td class="border-black"
								style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %></td>
							<td class="border-black"
								style=" text-align: left; border: 1px solid black; border-collapse: collapse; font-weight: 600;"> Specification Unit</td>
							<td class="border-black"
								style=" text-align: left; border: 1px solid black; border-collapse: collapse;"><%if(obj1[6]!=null){ %><%=obj1[6].toString() %> <%}else{ %> <%} %></td>
							</tr>
								<tr>
							<td class="border-black"
								style=" text-align: center; border: 1px solid black; border-collapse: collapse;"><%=++snCount %></td>
							<td class="border-black"
								style=" text-align: left; border: 1px solid black; border-collapse: collapse; font-weight: 600;"> Specification Value</td>
							<td class="border-black"
								style=" text-align: left; border: 1px solid black; border-collapse: collapse;"><%if(obj1[9]!=null){ %><%=obj1[9].toString() %> <%}else{ %>- <%} %></td>
							</tr>
						</tbody>
						</table>
					
			<br>
		<%}}}} %>	
		
	<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-colors">
    <%= ++maincount %>.&nbsp; Forward Traceability 
    </h1>
			<table class=""style="margin-left: 20px;;width: 610px; margin-bottom: 5px;font-family: <%= FontFamily %>;font-size: <%= ParaFontSize%>pt;border-collapse:collapse">
				<thead>
						<tr>
							<th class="border-black"style="width:50px; border: 1px solid black; border-collapse: collapse;padding:5px;">SN</th>
							<th class="border-black" style="width:text-align: left; border: 1px solid black; border-collapse: collapse;padding:5px;">System SpecificationId</th>
							<th class="border-black" style=" border:1px solid black; border-collapse: collapse;padding:5px;">System RequirementId</th>
						</tr>
						</thead>
						<tbody>
						<%
						
						if(specsList!=null && specsList.size()>0){
							specsList=specsList.stream().filter(e->!e[7].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
						}
						if(specsList!=null && specsList.size()>0){
							int rowCOunt=0;
						for(Object[]obj:specsList) {%>
						<tr>
						<td class="border-black" style=" border: 1px solid black; border-collapse: collapse;text-align: center;"> <%=++rowCOunt %>. </td>
						<td class="border-black" style=" border: 1px solid black; border-collapse: collapse;text-align: center;"> <%=obj[1].toString() %> </td>
						<td class="border-black" style=" border: 1px solid black; border-collapse: collapse;text-align: center;"> 
							<%
							List<String>linkedReq= new ArrayList<>();
							List<String>tempReq = new ArrayList<>();
							if(obj[4]!=null){
								tempReq= Arrays.asList(obj[4].toString().split(","));
							}
							if(RequirementLists!=null && RequirementLists.size()>0){
							for(Object[]obj1:RequirementLists){
								if(tempReq.contains(obj1[0].toString())){
									linkedReq.add(obj1[1].toString());
								}
							%>
							<%}} %>	
							<%if(linkedReq.size()>0) {
							for(int i=0;i<linkedReq.size();i++){
							%>
							<%=(i+1)%>.<%=linkedReq.get(i) %><br>
							<%}}else{ %>
								-
							<%} %>
						
						 </td>
						</tr>
						<%}} %>
						</tbody>
						</table>
						<br>	
		<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-colors">
    <%= ++maincount %>.&nbsp; Backward Traceability 
    </h1>
				<table class=""style="margin-left: 20px;;width: 610px; margin-bottom: 5px;font-family: <%= FontFamily %>;font-size: <%= ParaFontSize%>pt;border-collapse:collapse">
				<thead>
						<tr>
							<th class="border-black"style="width:50px; border: 1px solid black; border-collapse: collapse;padding:5px;">SN</th>
							<th class="border-black" style=" border:1px solid black; border-collapse: collapse;padding:5px;">System RequirementId</th>
							<th class="border-black" style="width:text-align: left; border: 1px solid black; border-collapse: collapse;padding:5px;">System SpecificationId</th>
						</tr>
						</thead>
							<%
						
					
						if(RequirementLists!=null && RequirementLists.size()>0){
							int rowCOunt=0;
						for(Object[]obj:RequirementLists) {
							List<String>specid = new ArrayList<>();
						
							for(Object[]obj1:specsList) {
							String spec=obj1[4]!=null?obj1[4].toString():""; 
							if(Arrays.asList(spec.split(",")).contains(obj[0].toString())){
								specid.add(obj1[1].toString());
							}
							
							
							%>
							
							
							<%} %>
						
						
						<tr>
						<td class="border-black" style=" border: 1px solid black; border-collapse: collapse;text-align: center;"> <%=++rowCOunt %>. </td>
						<td class="border-black" style=" border: 1px solid black; border-collapse: collapse;text-align: center;"> <%=obj[1].toString() %> </td>
						<td class="border-black" style=" border: 1px solid black; border-collapse: collapse;text-align: center;"> 
					<%if(specid.size()>0) {
					for(String s:specid){
					%>
					<div><%=s %></div>
					<%}}else{ %>
							-
					<%} %>
						 </td>
						</tr>
						<%}} %> 
						</tbody>
						</table>
							
						
	<p style="text-align: center; page-break-before: always;font-family: <%= FontFamily %>;"></p>
	<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-colors">
    <%= ++maincount %>.&nbsp;Conclusion
    </h1>	
    
    <div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify;font-weight:<%=ParaFontWeight%>" >
	<div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify;font-weight:<%=ParaFontWeight%>" >
	<%if(Conclusion!=null){ %><div class="scopediv" style="text-align: justify;" > <%=Conclusion%></div> <%} else{%> No Data Available<%} %>
	</div>
	</div>	
		</body>
		
		
</html>